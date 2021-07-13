Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93773C7674
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 20:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbhGMSao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 14:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhGMSan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 14:30:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87583C0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 11:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RTUla6zuFUPTqseVsWpYBgdTAv5+R8DOR77tEmNTqKs=; b=gee7Z4kePFhquxLog2Ms2JhHTX
        EFTsV83Tb4S8OdBWxReB8Qc9UjRE2DJ5YVzFWeZGerVMdMKhpSbbdSEzzUnevN4RCUbgkGZy1YN1G
        ea2RbxppohlaOceUAyxTyOno3C6abgD2izJczoEtQe4CvTqjE7rmJjw9jX1DuQr/eSiSx+raC9f+M
        kQKDclk/WuIc67U8UJQt2NLo0+PXr0/3E6vgEXT125S5vIt+oUzh82f+02pD7/dvSDBksZg7h27aS
        wFYJbYhQRoxueW1683uOg/+wsXoNBwcgT7FRgNvvu6MedThYoCIs1BaJNuRwVG0jE9UgLu/V8pSK6
        W2e6RQOw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3N7N-001NAo-74; Tue, 13 Jul 2021 18:26:59 +0000
Date:   Tue, 13 Jul 2021 19:26:53 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Mel Gorman <mgorman@suse.de>, Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [mm/vmalloc] 5c1f4e690e:
 BUG:sleeping_function_called_from_invalid_context_at_mm/page_alloc.c
Message-ID: <YO3a7erVd2yXdaAK@casper.infradead.org>
References: <20210713142414.GA28943@xsang-OptiPlex-9020>
 <CAHk-=wiDif7SvA5DOWj9ssDuYHC4ujUFPd7ad-ydhY-WMLb-kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiDif7SvA5DOWj9ssDuYHC4ujUFPd7ad-ydhY-WMLb-kQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 11:19:29AM -0700, Linus Torvalds wrote:
> Does anybody see what the problem is there?
> 
> There's an odd report _after_ the warning:
> 
> [  131.345319] raw_local_irq_restore() called with IRQs enabled
> [  131.366561] RIP: 0010:warn_bogus_irq_restore+0x1d/0x20
> [  131.433334]  __alloc_pages_bulk+0xbb8/0xf20

That's the key -- __alloc_pages_bulk has interrupts disabled and then
page_owner allocates memory for the stack dump.  Mel has a fix; I think
we're just waiting for it to hit your tree.

