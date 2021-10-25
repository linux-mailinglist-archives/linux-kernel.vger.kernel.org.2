Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA43439BE5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 18:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbhJYQoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 12:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbhJYQoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 12:44:44 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25DFC061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 09:42:22 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id n36-20020a17090a5aa700b0019fa884ab85so11888236pji.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 09:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=iPzF+A6NoX41v6pK//WT1W0ZPIsuHXZBTwEsrnM3MlU=;
        b=Y0U1eOkDCwJTXM/GrxZTHoIbmclC0xAZSkUyKSyso9O6uaeaS3PJGkFnxElICX0Gdo
         2yOeu9tljUkdEJcFxPTvr8bTQ6+ryd4xgJIOwlXToiggRyY5oq6iKAOUeekLrURu9bUJ
         MRMajRCZ4IRQfB5zoD4du6b6+vAXrXCKG1ToPicPuE7b+ajoGSmTAIuzgJMN1mOV7ACu
         BE08vrDRBl1avmEreQ/hdCD3gxLBT2tiomgsxuSFIUKkBSiK5BpWDZQS9CW7NCyYSLou
         yV4X6GNrcowp0a3uHuG60rHZ9IX3T58HZ/D9XOW2eMJ9MPMFJ56Kz01wwydfSIO0Q8S3
         yxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=iPzF+A6NoX41v6pK//WT1W0ZPIsuHXZBTwEsrnM3MlU=;
        b=baVQeFhV5hhRROVhqZ3bO7zzezN+tX7UUSrP3FN5d0ubpIZmRzcFNBEco/ywAeQQnG
         bsKdRTxPOBh0c9EL7IEJVaZK+zYlU9fXjGLU9eRfrVTDkhvODlIHDpS2zLVYjewmgRll
         Yd5Ts0BJKaF7xXn4kG4a10fHwHUaNdfAX5qJ6kuMj/MxteHe03Lap8/2zXwdiG/cOqz7
         ArZR/ToWsS+8Yv0SdsT5oC+udaNJ6xOIjnQDSzwtYKH6PVeY5rWRzIfTo+5ZvlV+6gDp
         ks+i0tQbQa7QGscrrl4OjvNtDTPAJJfTmRI0ZqGNXlrYUVSmSj20+k0yPvtd9/ztZ81U
         JxYw==
X-Gm-Message-State: AOAM531WzoNXKhcMn/lG2ccmilXRBzikI+J0Fb7LYMBZK0nxMe6CBWnm
        MxF5tsGzYvBeXP3FL9EuOSo=
X-Google-Smtp-Source: ABdhPJxdkVpu75I/cabI5BY3n/50hbKO50PUzlcUHyjrTmm+sOEQpFzsrVOBlOrcnGs69Bfe0tfkGA==
X-Received: by 2002:a17:90b:17c9:: with SMTP id me9mr22110765pjb.197.1635180141420;
        Mon, 25 Oct 2021 09:42:21 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id b6sm22238132pfv.171.2021.10.25.09.42.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Oct 2021 09:42:20 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v2 0/5] mm/mprotect: avoid unnecessary TLB flushes
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <YXaL2Cq7XI/gQNCZ@hirez.programming.kicks-ass.net>
Date:   Mon, 25 Oct 2021 09:42:19 -0700
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B197B99D-14BA-4ED4-A5ED-91A48A403735@gmail.com>
References: <20211021122112.592634-1-namit@vmware.com>
 <20211021200450.b13499c379a27dbfefe9f5e3@linux-foundation.org>
 <YXaL2Cq7XI/gQNCZ@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 25, 2021, at 3:50 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Thu, Oct 21, 2021 at 08:04:50PM -0700, Andrew Morton wrote:
>> On Thu, 21 Oct 2021 05:21:07 -0700 Nadav Amit <nadav.amit@gmail.com> =
wrote:
>>=20
>>> This patch-set is intended to remove unnecessary TLB flushes. It is
>>> based on feedback from v1 and several bugs I found in v1 myself.
>>>=20
>>> Basically, there are 3 optimizations in this patch-set:
>>> 1. Avoiding TLB flushes on change_huge_pmd() that are only needed to
>>>   prevent the A/D bits from changing.
>>> 2. Use TLB batching infrastructure to batch flushes across VMAs and
>>>   do better/fewer flushes.
>>> 3. Avoid TLB flushes on permission demotion.
>>>=20
>>> Andrea asked for the aforementioned (2) to come after (3), but this
>>> is not simple (specifically since change_prot_numa() needs the =
number
>>> of pages affected).
>>=20
>> [1/5] appears to be a significant fix which should probably be
>> backported into -stable kernels.  If you agree with this then I =
suggest
>> it be prepared as a standalone patch, separate from the other four
>> patches.  With a cc:stable.
>=20
> I am confused, 1/5 doesn't actually do *anything*. I also cannot find
> any further usage of the introduced X86_BUG_PTE_LEAK.
>=20
> I'm thinking patch #2 means to have something like:
>=20
> 	if (cpu_feature_enabled(X86_BUG_PTE_LEAK))
> 		flush_pmd_tlb_range(vma, address, address + =
HPAGE_PMD_SIZE);
>=20
> In the newly minted: pmdp_invalidate_ad(), but alas, nothing there.

This change was only intended for pmdp_invalidate_ad() but somehow
got lost. I will add it there.

I eventually did not add the optimization to avoid TLB flushes on
(!dirty|write)->!write so I did not use it for the first case that
you mentioned. I am too afraid, although I think this is correct.
Perhaps I will add it as a separate patch.

