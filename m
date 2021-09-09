Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B54B40457A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 08:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352340AbhIIGON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 02:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352491AbhIIGOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 02:14:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AD1C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 23:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=L3wM+n0HjcXR+5rq2TCpv3fE1OymWFI2TAvgga/hDCE=; b=Xw39TMHR90bPyTmyfzGtLeJg4i
        bh/x1Er9+r0bzRBmBB1HU65DAzY2lUua3FHaklD3yGF4aaDlPrtsR0E2dJozvuvUCBSPhaiitAxv2
        ZbZBAmu1Cg/nbmQ8jCTOqbaBjfH8vetiV6gOcrGJZFb9ZDNSzyis9ufH9f1uMGxRcjllKqH8DpwNr
        pPYtBR3QC57ieJZDjd818pN//eV4ixXDMAGR/zlgqsqGma+6PVyEEXTu2Woutqm2IYol4tTj3nx8w
        7HrGcsxeOn7DwXU61khTL0xuwhvORlsW+Jscx7l23/Ma9/BIej0J0sYUuga6jJBRgQP23tt1I0p0A
        GViGrung==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mODIH-009XC3-Sz; Thu, 09 Sep 2021 06:12:27 +0000
Date:   Thu, 9 Sep 2021 07:12:17 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Greentime Hu <greentime.hu@sifive.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, palmer@dabbelt.com,
        paul.walmsley@sifive.com, vincent.chen@sifive.com
Subject: Re: [RFC PATCH v8 15/21] riscv: Add vector extension XOR
 implementation
Message-ID: <YTmlwTlSX94tltyV@infradead.org>
References: <cover.1631121222.git.greentime.hu@sifive.com>
 <33c485ee595aff1e19a0e43074da59779f58d105.1631121222.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33c485ee595aff1e19a0e43074da59779f58d105.1631121222.git.greentime.hu@sifive.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 01:45:27AM +0800, Greentime Hu wrote:
> +extern void xor_regs_2_(unsigned long bytes, unsigned long *p1,
> +			unsigned long *p2);
> +extern void xor_regs_3_(unsigned long bytes, unsigned long *p1,
> +			unsigned long *p2, unsigned long *p3);
> +extern void xor_regs_4_(unsigned long bytes, unsigned long *p1,
> +			unsigned long *p2, unsigned long *p3,
> +			unsigned long *p4);
> +extern void xor_regs_5_(unsigned long bytes, unsigned long *p1,
> +			unsigned long *p2, unsigned long *p3, unsigned long *p4,
> +			unsigned long *p5);

There is no need for externs on function declarations ever.

> +static void xor_rvv_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
> +{
> +	kernel_rvv_begin();
> +	xor_regs_2_(bytes, p1, p2);
> +	kernel_rvv_end();
> +}

This looks strange.  Why these wrappers?
