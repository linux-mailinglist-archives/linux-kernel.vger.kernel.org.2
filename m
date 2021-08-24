Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397FC3F579E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 07:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbhHXFfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 01:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbhHXFf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 01:35:29 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03262C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 22:34:46 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id b9so7169410plx.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 22:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UfCl+JVoy2R6wx1DytMRudnKiR+tf7eTN7VTJ9Bq3Do=;
        b=iJ6vYi02LKmh06hrXbT039cxyLX8yY1I6/pHi1hIhvNnlB0iJjISto9DzYva66j7F6
         e5Mldrh5f4E3u8683DUqv4l9i2zgRgStG7aR0Xan7+diGdFbEpeR2KikG19BcoOModaz
         6dCD1OxXO3VzkgBPs2r/9aepDrXthlGSKhJHZaIfoKGiJMPiDyMs+UKG1aFu2tpftFel
         XjvQcDpDvgCqczHc07qT7wz7fqyAnBWJFvZHwb2odJeB/7DfxGIhk3U8e/E+HSMDr765
         wY8L554qfVDe3lsjmRZKaznT4yulCMOcvTBb7oN4Q0Myn93Gq994EmOTDjhRjfIyxgUF
         uiqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UfCl+JVoy2R6wx1DytMRudnKiR+tf7eTN7VTJ9Bq3Do=;
        b=GhPbvOzZ4HbxPulQmKInZCqQR4nUEHubPlEXeBWymiSFs1isNDlgWOz93TFru4/xkf
         LDGpEUgbWfjxmt7zssoI0NtYsceRNWsL4VVIqR6LYp9oCTiQI1OulYHBznp87dLGMd/0
         aPdMweicABxHlUPpUD0PNH7woNDszEsQrYfOHO0ZoSK7xI5s/lDS2Eup63ey40VZwO/+
         NnhhEx6GF3xdzisqHB9wprXFwD7c3x0TNvvE2ZNggKrDVXim5nzeCPEAG3f21MITA0HW
         k/L4cJ0tImpPbOX5nYL3rhEY6AWGHmlZsjVdbUImSAHMJWtI3CQhdFmWghBmB46Mrg48
         1Oxg==
X-Gm-Message-State: AOAM533s+RkosnxNLbULGtNDAKU4BNKDB0gO5Adjpx5v95r1x/ANEmKi
        F3OqBVpaZZqRBPG4/XvVjNA=
X-Google-Smtp-Source: ABdhPJzmDxN8J6jzAIHSTWlXsMIUhb55IAwJ2U+T9H0uYoYb59CioKQX+cD2G9gTb1ASI5d1+4YscA==
X-Received: by 2002:a17:90a:ba93:: with SMTP id t19mr2610287pjr.4.1629783285412;
        Mon, 23 Aug 2021 22:34:45 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id p24sm2546774pfh.136.2021.08.23.22.34.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Aug 2021 22:34:44 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [RFC PATCH 4/4] x86/mm: write protect (most) page tables
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <FB6C09CD-9CEA-4FE8-B179-98DB63EBDD68@gmail.com>
Date:   Mon, 23 Aug 2021 22:34:42 -0700
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <05242256-4B5F-4AD6-B7DA-46A583335E5C@gmail.com>
References: <20210823132513.15836-1-rppt@kernel.org>
 <20210823132513.15836-5-rppt@kernel.org>
 <FB6C09CD-9CEA-4FE8-B179-98DB63EBDD68@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for sending twice. The mail app decided to use HTML for some
reason.

On Aug 23, 2021, at 10:32 PM, Nadav Amit <nadav.amit@gmail.com> wrote:

> 
> On Aug 23, 2021, at 6:25 AM, Mike Rapoport <rppt@kernel.org> wrote:
> 
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Allocate page table using __GFP_PTE_MAPPED so that they will have 4K PTEs
> in the direct map. This allows to switch _PAGE_RW bit each time a page
> table page needs to be made writable or read-only.
> 
> The writability of the page tables is toggled only in the lowest level page
> table modifiction functions and immediately switched off.
> 
> The page tables created early in the boot (including the direct map page
> table) are not write protected.
> 
> 

[ snip ]

> +static void pgtable_write_set(void *pg_table, bool set)
> +{
> +	int level = 0;
> +	pte_t *pte;
> +
> +	/*
> +	 * Skip the page tables allocated from pgt_buf break area and from
> +	 * memblock
> +	 */
> +	if (!after_bootmem)
> +		return;
> +	if (!PageTable(virt_to_page(pg_table)))
> +		return;
> +
> +	pte = lookup_address((unsigned long)pg_table, &level);
> +	if (!pte || level != PG_LEVEL_4K)
> +		return;
> +
> +	if (set) {
> +		if (pte_write(*pte))
> +			return;
> +
> +		WRITE_ONCE(*pte, pte_mkwrite(*pte));

I think that the pte_write() test (and the following one) might hide
latent bugs. Either you know whether the PTE is write-protected or you
need to protect against nested/concurrent calls to pgtable_write_set()
by disabling preemption/IRQs.

Otherwise, you risk in having someone else write-protecting the PTE
after it is write-unprotected and before it is written - causing a crash,
or write-unprotecting it after it is protected - which circumvents the
protection.

Therefore, I would think that instead you should have:

	VM_BUG_ON(pte_write(*pte));  // (or WARN_ON_ONCE())

In addition, if there are assumptions on the preemptability of the code,
it would be nice to have some assertions. I think that the code assumes
that all calls to pgtable_write_set() are done while holding the
page-table lock. If that is the case, perhaps adding some lockdep
assertion would also help to confirm the correctness.

[ I put aside the lack of TLB flushes, which make the whole matter of
delivered protection questionable. I presume that once PKS is used, 
this is not an issue. ]



