Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4920332310
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 11:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhCIKbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 05:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhCIKbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 05:31:34 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0D1C06174A;
        Tue,  9 Mar 2021 02:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3R967uwidd/6VhdSIvpZtsspm89w9JUKZtWswzsHzl8=; b=pKl79QOU1YVyMRaN3H7W3/Yjgj
        3I0oTdKN8QiLNm2/EQe6fJHBAMiiY6qHhyPJp+iAcnxINwyG+O6/P7TByCD/Pe9EFDzYj5FE+cZ+Z
        socLpMnMLE6iXrWxd0h0WRBb5N6aMn936hmLhZOXlMGyjTrJWPqJQzsEe6GhgfQXo2nNAzGXWFai0
        TwYDErqBrXP25rCf2peUmdYEtAH4EOgmLCgNI9P1jZEbS02w+V6TcI4D3tUge0mUXr1OMqszyZAV/
        7nl18ww36nCxC7y0eF9WVuHm2/jnSitomQpYwgoU+dFceORY6EJ/idV94zVV5Vvw1Q249iu6cJ38p
        NMpbnfAg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lJZe0-000Sip-W4; Tue, 09 Mar 2021 10:31:22 +0000
Date:   Tue, 9 Mar 2021 10:31:16 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Sanket Parmar <sparmar@cadence.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "peter.chen@kernel.org" <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        "a-govindraju@ti.com" <a-govindraju@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rahul Kumar <kurahul@cadence.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kishon@ti.com" <kishon@ti.com>
Subject: Re: [PATCH 2/2] usb: cdns3: Optimize DMA request buffer allocation
Message-ID: <20210309103116.GA110148@infradead.org>
References: <1615267180-9289-1-git-send-email-sparmar@cadence.com>
 <1615267180-9289-2-git-send-email-sparmar@cadence.com>
 <20210309092804.GA76839@infradead.org>
 <BY5PR07MB81197BAC5B801816D2B2566CB0929@BY5PR07MB8119.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR07MB81197BAC5B801816D2B2566CB0929@BY5PR07MB8119.namprd07.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 10:18:43AM +0000, Sanket Parmar wrote:
> > On Tue, Mar 09, 2021 at 06:19:40AM +0100, Sanket Parmar wrote:
> > > dma_alloc_coherent() might fail on the platform with a small DMA region.
> > >
> > > To avoid such failure in cdns3_prepare_aligned_request_buf(),
> > > dma_alloc_coherent() is replaced with kmalloc and dma_map API to
> > > allocate aligned request buffer of dynamic length.
> > 
> > dma_alloc_noncoherent is the proper API instead of using kmalloc, which
> > can lead to unaddressable memory that might require bounce buffering.
> 
> cdns3 device required DMA coherent buffer to perform operations. So 
> dma_alloc_noncoherent will not help here.
> 
> Also all gadget classes(except g_ether) use kmalloc to allocated request buffer,
> and device driver uses usb_gadget_map_request_by_dev to map the request
> buffer. Similar approach is used to allocate aligned buffer. 

If you can use kmalloc and dma_map_single you can use
dma_alloc_noncoherent per definition.
