Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5150A3321F2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 10:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhCIJ2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 04:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhCIJ2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 04:28:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6183C06174A;
        Tue,  9 Mar 2021 01:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TeDLK0Rk12FTIyPCKoKkTCZzXQMFNcyT1sCUu+HO6mk=; b=qHmYZkKfCsSMxdycWOwzAXy3kE
        Q4QMaiUl/PWS+7L4QK21Yc4arVaYHDQostGzfzsHT7uB8ZdhbBuECBshuUarsoWWVMb4ddg4g4XIj
        hCIKeKPlw3QtLU8Vi8bzeiv8R13HCO2UVABDEQOqUW5ouw5IYHs2VLoWiNBfw6Wy3xxMiZrd2wfQd
        T1OJfQaqECs3hfY/ClHKuc577scgY8+CprWSqJokVe/NWFrxXSxi0TNTVz9s28h2DJsjsiaQQoRud
        USdQKNWqFzIwBKJSPMdUqw0COAUr1ijMUNiiGOUEC4AnO+01J1rU8yArnQzb3wDZZrGs/k1D+K/TL
        XefqhlRA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lJYeq-000Lnv-Bl; Tue, 09 Mar 2021 09:28:04 +0000
Date:   Tue, 9 Mar 2021 09:28:04 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Sanket Parmar <sparmar@cadence.com>
Cc:     peter.chen@kernel.org, pawell@cadence.com, a-govindraju@ti.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kurahul@cadence.com, gregkh@linuxfoundation.org, kishon@ti.com
Subject: Re: [PATCH 2/2] usb: cdns3: Optimize DMA request buffer allocation
Message-ID: <20210309092804.GA76839@infradead.org>
References: <1615267180-9289-1-git-send-email-sparmar@cadence.com>
 <1615267180-9289-2-git-send-email-sparmar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615267180-9289-2-git-send-email-sparmar@cadence.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 06:19:40AM +0100, Sanket Parmar wrote:
> dma_alloc_coherent() might fail on the platform with a small DMA region.
> 
> To avoid such failure in cdns3_prepare_aligned_request_buf(),
> dma_alloc_coherent() is replaced with kmalloc and dma_map API to
> allocate aligned request buffer of dynamic length.

dma_alloc_noncoherent is the proper API instead of using kmalloc, which
can lead to unaddressable memory that might require bounce buffering.
