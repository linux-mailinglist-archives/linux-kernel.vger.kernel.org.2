Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA37632AE40
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575033AbhCBWnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 17:43:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24495 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1838013AbhCBWOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 17:14:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614723199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RgrkBLWaczOeqQTff2g/95Kfq5YOvV0sqxm2G8mQr4A=;
        b=XbAlsDBKcFQ0ZLOP/zPV55MWKTB8LMdECDAU65aAwyZ23gywfs9+WaaNGQq+ZM1uB1HASO
        oYyFnHzRg8A9I1PnN3Hl6jjxXeITpkQ0NDpBnu0G/x2YylVNyQOujRJdF/Wz5mxpubgPDg
        QVFcWQYdRZB+I4IJv5tYc3dVju+Mb3A=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-EFmInfSUOciDCZKHPkzkOg-1; Tue, 02 Mar 2021 17:13:18 -0500
X-MC-Unique: EFmInfSUOciDCZKHPkzkOg-1
Received: by mail-qk1-f199.google.com with SMTP id b78so14756533qkg.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 14:13:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RgrkBLWaczOeqQTff2g/95Kfq5YOvV0sqxm2G8mQr4A=;
        b=smLJosiQA9MRwsvZ96u6tkWe7vKH5ziyOyl7Nrhb1wD4+aF/oSq3oP1go65GALmLVF
         VH6FHG+puFIZtkgCg7ftiTW7HO943L94J0hOpvmIALN+HCazwHCzeeoQRUKthiXHSWjr
         hcI8tdJuGlThBRuwah+M9Zrj7UdJ8KqwJJAzIq898z2aGNLaU4bUYaM1QAHrHKFWMcT9
         5//UF5fE3yPMnLP+K0u/zhWdFLn81dT2SJbTquywa4VptEKz0Rexmu0ajXVCXjyw0PKy
         2JiebICYQV7pTGV2kE8+xCH+mDmDiXdeUtlJCQ7h917TMNH2kzMx2g/x8TDKK9y04ohk
         HvCA==
X-Gm-Message-State: AOAM531X1GuCEy4B4SFNZ8dExvHQW4Lamir0yV4KfzC6PeR3ArIlpH2o
        4BVNQTk92V2gRiTmdvMZrY/RX7AuQLVWm6e8p0SX0Ij7UUmUbdwUBgKhy2dSM3LSKWAVQjVm3p5
        SQmwHc4p5SXUFSroLh2wwvtZ2
X-Received: by 2002:a05:620a:7d5:: with SMTP id 21mr21527707qkb.152.1614723197526;
        Tue, 02 Mar 2021 14:13:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx7N8Q3yZs7J3+r8/sk5Pk7MA/Ko5kqHnTnwLeq6CHm2n6WsMtve016icqtR8gj9uxg9PCdWQ==
X-Received: by 2002:a05:620a:7d5:: with SMTP id 21mr21527688qkb.152.1614723197290;
        Tue, 02 Mar 2021 14:13:17 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-25-174-95-95-253.dsl.bell.ca. [174.95.95.253])
        by smtp.gmail.com with ESMTPSA id l65sm16042905qkf.113.2021.03.02.14.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 14:13:16 -0800 (PST)
Date:   Tue, 2 Mar 2021 17:13:14 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v2 0/2] mm: fix races due to deferred TLB flushes
Message-ID: <20210302221314.GR397383@xz-x1>
References: <20201225092529.3228466-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201225092529.3228466-1-namit@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 25, 2020 at 01:25:27AM -0800, Nadav Amit wrote:
> From: Nadav Amit <namit@vmware.com>
> 
> This patch-set went from v1 to RFCv2, as there is still an ongoing
> discussion regarding the way of solving the recently found races due to
> deferred TLB flushes. These patches are only sent for reference for now,
> and can be applied later if no better solution is taken.
> 
> In a nutshell, write-protecting PTEs with deferred TLB flushes was mostly
> performed while holding mmap_lock for write. This prevented concurrent
> page-fault handler invocations from mistakenly assuming that a page is
> write-protected when in fact, due to the deferred TLB flush, other CPU
> could still write to the page. Such a write can cause a memory
> corruption if it takes place after the page was copied (in
> cow_user_page()), and before the PTE was flushed (by wp_page_copy()).
> 
> However, the userfaultfd and soft-dirty mechanisms did not take
> mmap_lock for write, but only for read, which made such races possible.
> Since commit 09854ba94c6a ("mm: do_wp_page() simplification") these
> races became more likely to take place as non-COW'd pages are more
> likely to be COW'd instead of being reused. Both of the races that
> these patches are intended to resolve were produced on v5.10.
> 
> To avoid the performance overhead some alternative solutions that do not
> require to acquire mmap_lock for write were proposed, specifically for
> userfaultfd. So far no better solution that can be backported was
> proposed for the soft-dirty case.
> 
> v1->RFCv2:
> - Better (i.e., correct) description of the userfaultfd buggy case [Yu]
> - Patch for the soft-dirty case

Nadav,

Do you plan to post a new version to fix the tlb corrupt issue that this series
wanted to solve?

Thanks,

-- 
Peter Xu

