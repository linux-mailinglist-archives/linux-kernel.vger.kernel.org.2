Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22AD84034E3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 09:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348512AbhIHHL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 03:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348375AbhIHHLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 03:11:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CABC061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 00:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BIE/LIdFO8jY5B6XQFOTWQMi8dbTNeZ9iRgAJzUQFJU=; b=sj3hwvVEXJG7RXFgHJKiWrl2DW
        PSMKQHTTMqu0a23Z7httVaAjEPT4AM/xssoAfAMFxEVJ6rBlvytzg+s4FehCm7M2Zxirf64YczMY7
        12aopbnZx89CwC6n3lwGa5O0523gUpp+NyNoIRD2nC/aGJ3FvqwZHevdybiDOFcOFgaGILaXKVRNe
        Guo/1qOs4FIXJKtxXEZwQhH4ONEiYUG6xp7qxMxYlUPnI8paKE4dBt5vDzj/NFUNVslm6Yp2u200T
        CuTrCqt17eJo9fP2yxyZHTHqo9QXfN+KhClS4uoWVTEBVxSLfZlemZN6pP2UsIeLh8g8G0WXBkRNM
        kRaojG4w==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mNrha-008aj6-H4; Wed, 08 Sep 2021 07:09:14 +0000
Date:   Wed, 8 Sep 2021 08:08:58 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Beulich <jbeulich@suse.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 11/12] xen/pci-swiotlb: reduce visibility of symbols
Message-ID: <YThhih963WfY/3/W@infradead.org>
References: <588b3e6d-2682-160c-468e-44ca4867a570@suse.com>
 <75591cef-95e8-c694-fd11-283800499e4e@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75591cef-95e8-c694-fd11-283800499e4e@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2021 at 02:11:14PM +0200, Jan Beulich wrote:
> xen_swiotlb and pci_xen_swiotlb_init() are only used within the file
> defining them, so make them static and remove the stubs. Otoh
> pci_xen_swiotlb_detect() has a use (as function pointer) from the main
> pci-swiotlb.c file - convert its stub to a #define to NULL.
> 
> Signed-off-by: Jan Beulich <jbeulich@suse.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
