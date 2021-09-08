Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7171640347D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 08:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347839AbhIHGuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 02:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345785AbhIHGuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 02:50:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B779DC061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 23:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OrzGM9PLHfbyfeiU5N8A74VHnUlyeQDz1745rBQSmpE=; b=JvLbZFDB8IlVYMmqnbPjeH0zpT
        RS6TMNs3DqCPi4wnv+3RN+BAWH5wMMsH5OIbUJGjC9c+FFCSx0qVUnY9l1pDwbtkGF0v1rdZSeqkv
        8XX7xKR06ZiLWC8KJX9Wc5cBfed6lBQRH62JfWIeV4NJjQStpPIefHWmFJFFjudwengFWX7O9+UKm
        JnPsIv35qqOOxV/brv/0P5TTjFwkO3aGrqtXxjiSYg3zvBlHIJhqDusKynHPkF+9LwnkgJSAZfb8p
        N72r4r40Aj7RwC/fkxH0CgbUafSPL2d56ee5y/Rj+rPHP+4/dH3Ce027JiYI5/vdK/Awy8PLopLbN
        sv0vmElA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mNrNu-008ZoP-Gv; Wed, 08 Sep 2021 06:48:55 +0000
Date:   Wed, 8 Sep 2021 07:48:38 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Beulich <jbeulich@suse.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 01/12] swiotlb-xen: avoid double free
Message-ID: <YThcxvBhQqOVX2X4@infradead.org>
References: <588b3e6d-2682-160c-468e-44ca4867a570@suse.com>
 <ce9c2adb-8a52-6293-982a-0d6ece943ac6@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce9c2adb-8a52-6293-982a-0d6ece943ac6@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2021 at 02:04:25PM +0200, Jan Beulich wrote:
> Of the two paths leading to the "error" label in xen_swiotlb_init() one
> didn't allocate anything, while the other did already free what was
> allocated.
> 
> Fixes: b82776005369 ("xen/swiotlb: Use the swiotlb_late_init_with_tbl to init Xen-SWIOTLB late when PV PCI is used")
> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> Cc: stable@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
