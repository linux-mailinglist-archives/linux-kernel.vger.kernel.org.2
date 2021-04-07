Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 587BE357074
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 17:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbhDGPgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 11:36:50 -0400
Received: from mail-pj1-f48.google.com ([209.85.216.48]:56289 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbhDGPgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 11:36:46 -0400
Received: by mail-pj1-f48.google.com with SMTP id nh5so7781141pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 08:36:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o/2zfrGIfr2WuDjiaGGlJLgOkerEw8dys41o+yaEHFo=;
        b=XNRoNd5ffnUbqc6wSS2Ck9wUD2LKqvBHTMy0jy+pGyxa0yFWxsKPV9NvjW5olY6WyP
         gz4ZYmkmVDIpxvEr11ST2iYj65OqY0eUKloAOFUiPVA2Qccr0Z4yMAkMKrS/1OinjcQ1
         u9zf18qJsD+tWwlCJa+kVgmVxx6EX0ZVWuT3vjafK7dlRqDdnLx8MLPmk4jrbDKeJxKj
         N1waPzweIKp5DvwE2xhHKMQIPlWFhqd0v76SQ0FZVHy8+HdjxfX3mQ9JSobsUyCOBxMO
         omqIgx2pvgcmkCLr7lQejOCA3jMSYirci97qt+jZlsfgsMGJzXRl/CY5P3p63vJbvdTK
         V1vA==
X-Gm-Message-State: AOAM533/wWZY4uP5iGvrmYZ3bBFx5epF6W6Ah8Fz1JMOhlC2zEZeFWVk
        oVlBCFrPJ1wc93Oo56PjECayNA==
X-Google-Smtp-Source: ABdhPJxAm5VRu1azG8bdwhzoCuoZnWgkzGuQZn+pSWa6NvsaTNY8AOkDybzpeoC5PYZ1Dyqay8mQ2Q==
X-Received: by 2002:a17:90a:9b0a:: with SMTP id f10mr3868148pjp.213.1617809795022;
        Wed, 07 Apr 2021 08:36:35 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:3602:86ff:fef6:e86b? ([2601:646:c200:1ef2:3602:86ff:fef6:e86b])
        by smtp.googlemail.com with ESMTPSA id t65sm1801935pfd.5.2021.04.07.08.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 08:36:34 -0700 (PDT)
Subject: Re: [RFC PATCH 13/37] mm: implement speculative handling in
 __handle_mm_fault().
To:     Michel Lespinasse <michel@lespinasse.org>,
        Linux-MM <linux-mm@kvack.org>
Cc:     Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
 <20210407014502.24091-14-michel@lespinasse.org>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <eee7431c-3dc8-ca3c-02fb-9e059d30e951@kernel.org>
Date:   Wed, 7 Apr 2021 08:36:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210407014502.24091-14-michel@lespinasse.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/21 6:44 PM, Michel Lespinasse wrote:
> The page table tree is walked with local irqs disabled, which prevents
> page table reclamation (similarly to what fast GUP does). The logic is
> otherwise similar to the non-speculative path, but with additional
> restrictions: in the speculative path, we do not handle huge pages or
> wiring new pages tables.

Not on most architectures.  Quoting the actual comment in mm/gup.c:

>  * Before activating this code, please be aware that the following assumptions
>  * are currently made:
>  *
>  *  *) Either MMU_GATHER_RCU_TABLE_FREE is enabled, and tlb_remove_table() is used to
>  *  free pages containing page tables or TLB flushing requires IPI broadcast.

On MMU_GATHER_RCU_TABLE_FREE architectures, you cannot make the
assumption that it is safe to dereference a pointer in a page table just
because irqs are off.  You need RCU protection, too.

You have the same error in the cover letter.

--Andy
