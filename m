Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 557BC4252C7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 14:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241203AbhJGMPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 08:15:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41390 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241186AbhJGMPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 08:15:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633608798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lYg3DKnYjpKLFoiMv++O6QIhF4RIhnoeDD7AJ3wTVUk=;
        b=WlJ9iZK5AR3ogTSnmFaG0ti1/ACCOpEyfHPv6xqAznVer0APJuNx+cItE2vUeLQ5i3jOXC
        HSQF9z67hmsOdBEh21l/bkyjSyXb5AjM8NwIE831s5nzx66qg+hD6bDI4oob+sCV6JkA/N
        vAFTR2yNJ13ivzZO8TXpp+Y5cT0mFpk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-REGPK3QXMc6tPuurgf8Rrg-1; Thu, 07 Oct 2021 08:13:03 -0400
X-MC-Unique: REGPK3QXMc6tPuurgf8Rrg-1
Received: by mail-wr1-f70.google.com with SMTP id l6-20020adfa386000000b00160c4c1866eso4525856wrb.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 05:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=lYg3DKnYjpKLFoiMv++O6QIhF4RIhnoeDD7AJ3wTVUk=;
        b=UhtJAaozlNgQm5lQVl8MS/peOJ/xKHsvkQnFCfiiB3WoUZ/Us1FoZUv9PiNoCYQ4ot
         6DKYB15yA5Lw8VKc9LRe5j06g9JzerwCWXWfQLAhg2uucZcF/EOvb3GOuF2MecVsq3Wc
         u0la3V6PfplxqNRdyK3epjgF10pFIUBS7rHikIWNgbY2aRUiP9601laV/dIRySk5NN7p
         KllANGrKgsfmN0xXQokbhMuW7FMZam1Y7UoDs7DKSzm6o4YKQsF0Wd3SnYao36BgCoSx
         i9Ho4pV1pneXdWD2zEoy0UiDJGm9f9JHWPOKBzZMVyy7xM9x7yMdcm/6sxx4OVjiqyb2
         mA0w==
X-Gm-Message-State: AOAM531AZZ6uPUroEvzczkx0PZzKSCTlNAeWQnxBXlsawmIZSWU59QlH
        FjD2NOURNyXQ4woxH0h4+g7CBG2zO5CQts971CnCgbNY9RRXbdVzDwf4676Rzjh9gf8zuZDea/c
        kcQLR9EWXCR8HzWtvdcVb/hsA
X-Received: by 2002:a5d:64a6:: with SMTP id m6mr5005161wrp.282.1633608781865;
        Thu, 07 Oct 2021 05:13:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1+G511oTofFcZIavyp24Pc9rD74REUvRo1Zz07AsPo9+OrEizszsrDH3N7xzVcvvCViKnSQ==
X-Received: by 2002:a5d:64a6:: with SMTP id m6mr5005133wrp.282.1633608781695;
        Thu, 07 Oct 2021 05:13:01 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6886.dip0.t-ipconnect.de. [91.12.104.134])
        by smtp.gmail.com with ESMTPSA id v16sm2403012wrq.39.2021.10.07.05.13.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Oct 2021 05:13:01 -0700 (PDT)
Subject: Re: [PATCH 2/2] mm/mprotect: do not flush on permission promotion
To:     Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Peter Xu <peterx@redhat.com>, Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
References: <20210925205423.168858-1-namit@vmware.com>
 <20210925205423.168858-3-namit@vmware.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <5485fae5-3cd6-9dc3-0579-dc8aab8a3de1@redhat.com>
Date:   Thu, 7 Oct 2021 14:13:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210925205423.168858-3-namit@vmware.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.09.21 22:54, Nadav Amit wrote:
> From: Nadav Amit <namit@vmware.com>
> 
> Currently, using mprotect() to unprotect a memory region or uffd to
> unprotect a memory region causes a TLB flush. At least on x86, as
> protection is promoted, no TLB flush is needed.
> 
> Add an arch-specific pte_may_need_flush() which tells whether a TLB
> flush is needed based on the old PTE and the new one. Implement an x86
> pte_may_need_flush().
> 
> For x86, PTE protection promotion or changes of software bits does
> require a flush, also add logic that considers the dirty-bit. Changes to
> the access-bit do not trigger a TLB flush, although architecturally they
> should, as Linux considers the access-bit as a hint.

Is the added LOC worth the benefit? IOW, do we have some benchmark that 
really benefits from that?


-- 
Thanks,

David / dhildenb

