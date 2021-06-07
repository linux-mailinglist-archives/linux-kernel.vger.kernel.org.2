Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCD539D6E8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 10:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbhFGISb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 04:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhFGISa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 04:18:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76FBC061766
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 01:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Wpsm446VyaKPzhp5TMpr9XEEcJZ06UFuqrM7pz71NoY=; b=vMChmujZeDPt614cftbApytsqe
        48Ti5sSTUqJZ3rUjuuzB3/IOzlHiqEU5FTIzvlyl+M2Tz49ftyXSumJYVjO/CUsLQvjy1pQieL//v
        AVlUDEiVfeNzIMP/4swU920El6RPKMSMGOrZKNsryBYJrjhB9tI1AwSEYYQM3TneDwAxWccFkJgkO
        pcPVnpFlrCszm7GZUm8fOLURVWBDAApZJjZdC6PEx2WNkiMKhV9z/G5Sm60E4vUNNlAt1nXR2mIeg
        6NfJro6H5xfUdz2XVyUBSKWt8wB5xcxhbbtWBAsmVvUZme7YoyeJ2g5AzwnkoCLmdSCXVonCnjwV/
        LioFt8nQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lqAQL-00FWKe-DM; Mon, 07 Jun 2021 08:15:56 +0000
Date:   Mon, 7 Jun 2021 09:15:53 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/kprobes: remove free_insn_page since it is same with
 the common weak function
Message-ID: <YL3VuU/GQl6HWGq7@infradead.org>
References: <20210601040856.22080-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601040856.22080-1-song.bao.hua@hisilicon.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 04:08:56PM +1200, Barry Song wrote:
> free_insn_page() in x86 is same with the common weak function in
> kernel/kprobes.c. Plus, its comment "Recover page to RW mode before
> releasing it" seems insensible to be there since resetting mapping
> is done by common code in vfree() of module_memfree().
> So drop the strong function and its comment in x86 totally.
> 
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>

It also is the same for s390, so please remove that as well and remove
the __weak.
