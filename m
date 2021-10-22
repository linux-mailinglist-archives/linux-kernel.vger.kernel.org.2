Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECBF043800B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 23:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbhJVWBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 18:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbhJVWA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 18:00:59 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0233BC061764
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 14:58:41 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id m14so4806910pfc.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 14:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=46+z3KX/Bw5iK9i97ch1szfrniwqQXL3ZMhrfUJYmJ4=;
        b=GSC3K9lzPP51HWJwei47eKc+OBCVdcdVlBoyks9BJEcC8OIXr9fWeGJ50E1/Uvgz7m
         8akD6yaJZb9fZ38FHuc82VZNIQ0D2MsSiYGcn7TaS241qd61moEDti59lCe+owWZLRQ8
         nPYaUt4pFIfBgIThkonwMQv0uwtB77jkLDDIcBwc6C3wLjLimOxd3tmTBaymohvaL5gU
         JukOxKcLL9Eam56rNufU1/EtqKjV8AxbzCSXkoraci6Imam/QrNEK7EZOPGrvVXXBmBj
         Omv7AeJ2g/UoKbLgQzO1k0tqd5G/dFBE+fjPF58P+D7/d/Tp6xrZnPtL7HpoKverAwrH
         gLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=46+z3KX/Bw5iK9i97ch1szfrniwqQXL3ZMhrfUJYmJ4=;
        b=Rgs5UX7JsS5e41E/fdNfN3HQZaDrEyZvT43XMVPtadtRMzJJ9WP/okKTrk85MwACPj
         YPrCcTeGw0SafidJ6v6m/g6LiEpTU77+X4LZhqhKGl9Ew4/A5k+Q7xrIoJjN137NFjDU
         FLoOJXHRPkcxHqXy0abT5Ns46WtYdjWclDwZjFT5Dti0l3jA5CNpemx92b9inSm3S2WN
         ORF0FTUivLxQH02WH8w9EsNuW1EED2egLoYqfVv3IZL6AWH0BUthyviMvkOSL2Ti2hbn
         WVHthZIV1l7xhl+hFdseiGk3jlxM657iHEHZqywjeCKrqm0SbDhCiX9iyikEAi1msTvd
         PHGQ==
X-Gm-Message-State: AOAM532gMrqj/F93mGWdFXuwGoylinniWRvLWop+RT1hYzfffNYiODlg
        jFFVQEfEEu1Tc4YpiZJOSrc=
X-Google-Smtp-Source: ABdhPJyKRqV6NreYrq0O0o2ilKwZvjQQpb2270LjJgj01yHsXs4Z+AIQyyklUagcK8sLt6DpD0TmuQ==
X-Received: by 2002:a63:77c4:: with SMTP id s187mr1785536pgc.50.1634939921221;
        Fri, 22 Oct 2021 14:58:41 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id h2sm9921385pjk.44.2021.10.22.14.58.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Oct 2021 14:58:40 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v2 0/5] mm/mprotect: avoid unnecessary TLB flushes
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20211021200450.b13499c379a27dbfefe9f5e3@linux-foundation.org>
Date:   Fri, 22 Oct 2021 14:58:39 -0700
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9E576E79-E4FD-4CB9-8BE5-142230C12E63@gmail.com>
References: <20211021122112.592634-1-namit@vmware.com>
 <20211021200450.b13499c379a27dbfefe9f5e3@linux-foundation.org>
To:     Andrew Morton <akpm@linux-foundation.org>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 21, 2021, at 8:04 PM, Andrew Morton <akpm@linux-foundation.org> =
wrote:
>=20
> On Thu, 21 Oct 2021 05:21:07 -0700 Nadav Amit <nadav.amit@gmail.com> =
wrote:
>=20
>> This patch-set is intended to remove unnecessary TLB flushes. It is
>> based on feedback from v1 and several bugs I found in v1 myself.
>>=20
>> Basically, there are 3 optimizations in this patch-set:
>> 1. Avoiding TLB flushes on change_huge_pmd() that are only needed to
>>   prevent the A/D bits from changing.
>> 2. Use TLB batching infrastructure to batch flushes across VMAs and
>>   do better/fewer flushes.
>> 3. Avoid TLB flushes on permission demotion.
>>=20
>> Andrea asked for the aforementioned (2) to come after (3), but this
>> is not simple (specifically since change_prot_numa() needs the number
>> of pages affected).
>=20
> [1/5] appears to be a significant fix which should probably be
> backported into -stable kernels.  If you agree with this then I =
suggest
> it be prepared as a standalone patch, separate from the other four
> patches.  With a cc:stable.


There is no functionality bug in the kernel. The Knights Landing bug
was circumvented eventually by changing the swap entry structure so
the access/dirty bits would not overlap with the swap entry data.

>=20
> And the remaining patches are a performance optimization.  Has any
> attempt been made to quantify the benefits?

I included some data before [1]. In general the cost that is saved
is the cost of a TLB flush/shootdown.

I will modify my benchmark to test huge-pages (which were not
included in the previous patch-set) and send results later. I would
also try nodejs to see if there is a significant enough benefit.
Nodejs crashed before (hence the 3rd patch added here), as it
exec-protects/unprotects pages - I will see if the benefit shows in
the benchmarks.

[ The motivation behind the patches is to later introduce userfaultfd
writeprotectv interface, and for my use-case that is under=20
development this proved to improve performance considerably. ]



[1] =
https://lore.kernel.org/linux-mm/DA49DBBB-FFEE-4ACC-BB6C-364D07533C5E@vmwa=
re.com/=
