Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3BD41917A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 11:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbhI0J0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 05:26:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59689 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233638AbhI0JZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 05:25:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632734653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jp02F8QsbdFJf3j7YUtw+WzbWBUYKqtVXobt73sBmVU=;
        b=e7M6ml89Xpoq2Bk4kcJfPrWXt9LFZeRMWu8ldslSjrLnN2p50ra0zHCXXQ9kbL+o7wJ8WI
        urWYsUeSP9244oDyUVi6TujAHKGLwLxRFJghe7ZgNy6MlifCY12CKKCv/yaz+pDDLyLTp/
        62+8d1jkzwNOGPFLEOHkVPOeLFwHyaw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-ASwCXpcuMvOhFvMx43YiOg-1; Mon, 27 Sep 2021 05:24:12 -0400
X-MC-Unique: ASwCXpcuMvOhFvMx43YiOg-1
Received: by mail-wr1-f70.google.com with SMTP id a17-20020adfed11000000b00160525e875aso6248202wro.23
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 02:24:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Jp02F8QsbdFJf3j7YUtw+WzbWBUYKqtVXobt73sBmVU=;
        b=J1xlurBlMaqJT/2pc34T8FjzUS8Uq3AfKbxSRp7YQGttwrIIKfwXtMmy4WTLi8XvQj
         SdZNvq6VCQ5llE6QqcqrPk3RqrE+EP9nZDjSmiw7o9FFy4LbxdoNYtWy0N0lZD+inZQO
         AYulNTeMxGl/CLv1stS7sOFNj5MPR/DNYLhTpEp2hzhT9EC3ewbbXRZzjAg43H4NDm0+
         2fTPezpTbig3oAlVd12XYOMc6pF9XnoKQN3NsVvAYzrjGU7jkHf1FtjrZz0uwyw6TS68
         JKuufpbwQ+uBZXV2Gf4B4ub8KUOg2yiMdOAc2oMUSad3zN3K7IIprQ+aQXCqr3PVDGVR
         GgVg==
X-Gm-Message-State: AOAM5320yMzVmK4vQqpUz4yfH3roRoWYrym3Wi8Iyx7w7qTsTbQEHart
        QX5P193RStODyYMpOVxovgNDGs70SrScWD7E2ld/BrQdLuih2DZ9qLAnJNNXLb4UzL7G0JmMwZ5
        p8MMcnKkJsdAvaFuog0YfYP0G
X-Received: by 2002:a5d:6c6e:: with SMTP id r14mr25885627wrz.319.1632734651150;
        Mon, 27 Sep 2021 02:24:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygT4hurYn4CrYnSURJEf3gzm1/6pBYoxY+DcI2dUbDLFXRFlGkxtYsqSUAIJKK4I3S6u0tsw==
X-Received: by 2002:a5d:6c6e:: with SMTP id r14mr25885610wrz.319.1632734650963;
        Mon, 27 Sep 2021 02:24:10 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c654d.dip0.t-ipconnect.de. [91.12.101.77])
        by smtp.gmail.com with ESMTPSA id g21sm622229wmk.10.2021.09.27.02.24.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 02:24:10 -0700 (PDT)
Subject: Re: [RFC PATCH 0/8] mm/madvise: support
 process_madvise(MADV_DONTNEED)
To:     Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Peter Xu <peterx@redhat.com>, Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Colin Cross <ccross@google.com>,
        Suren Baghdasarya <surenb@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
References: <20210926161259.238054-1-namit@vmware.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <7ce823c8-cfbf-cc59-9fc7-9aa3a79740c3@redhat.com>
Date:   Mon, 27 Sep 2021 11:24:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210926161259.238054-1-namit@vmware.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.09.21 18:12, Nadav Amit wrote:
> From: Nadav Amit <namit@vmware.com>
> 
> The goal of these patches is to add support for
> process_madvise(MADV_DONTNEED). Yet, in the process some (arguably)
> useful cleanups, a bug fix and performance enhancements are performed.
> 
> The patches try to consolidate the logic across different behaviors, and
> to a certain extent overlap/conflict with an outstanding patch that does
> something similar [1]. This consolidation however is mostly orthogonal
> to the aforementioned one and done in order to clarify what is done in
> respect to locks and TLB for each behavior and to batch these operations
> more efficiently on process_madvise().
> 
> process_madvise(MADV_DONTNEED) is useful for two reasons: (a) it allows
> userfaultfd monitors to unmap memory from monitored processes; and (b)
> it is more efficient than madvise() since it is vectored and batches TLB
> flushes more aggressively.

MADV_DONTNEED on MAP_PRIVATE memory is a target-visible operation; this 
is very different to all the other process_madvise() calls we allow, 
which are merely hints, but the target cannot be broken . I don't think 
this is acceptable.

-- 
Thanks,

David / dhildenb

