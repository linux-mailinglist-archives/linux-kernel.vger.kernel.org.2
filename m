Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B69313E96
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 20:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236110AbhBHTMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 14:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235036AbhBHRvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 12:51:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B949BC061786
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 09:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vidqzNM6LHEiqGq9XxJTqIlShemMdM/td8LbkD0squQ=; b=o3Rxjl8uLD5Ssq9HUJ1Ldk46z+
        Ibl1ha9MY0lkcu5GprUICsUhf1BLawHBBWPzD6sfK9euURgJryG0qC6ad4PJtzDKG6F/Xkhnt4MmD
        4GBNZiBoMyhvVify8XdY7CJWPw1vWBLbcw8RHtQPDY5hhf3lGwfz78ZVHj81rPPauggRvXealH/Nm
        W5jPqOmrcUL4opUFK4/CxrNPmCVHxL1uWzySJ7n3OhJX0oFnSejzAr40xzx5/ejuqIaTHqR0QO3Li
        hl2MMCKZlzyDJE4vf+5SDtcvIIov9d3r8pgQerVtYkKqv9Guzbxoa3+k/qY76d/kkgtaW141Th+Sq
        l3rXWbPw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l9AYh-006IPI-NU; Mon, 08 Feb 2021 17:42:48 +0000
Date:   Mon, 8 Feb 2021 17:42:47 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/12] arm64: kasan: export MTE symbols for KASAN tests
Message-ID: <20210208174247.GA1500382@infradead.org>
References: <cover.1612538932.git.andreyknvl@google.com>
 <068ab897dc5e73d4a8d7c919b84339216c2f99da.1612538932.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <068ab897dc5e73d4a8d7c919b84339216c2f99da.1612538932.git.andreyknvl@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 04:39:13PM +0100, Andrey Konovalov wrote:
> Export mte_enable_kernel_sync() and mte_set_report_once() to fix:
> 
> ERROR: modpost: "mte_enable_kernel_sync" [lib/test_kasan.ko] undefined!
> ERROR: modpost: "mte_set_report_once" [lib/test_kasan.ko] undefined!

Please put this under an ifdef for the testing option that pull the
symbols in.
