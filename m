Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8739340047
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 08:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhCRHd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 03:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhCRHdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 03:33:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A43C06174A;
        Thu, 18 Mar 2021 00:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zypyosUtrV6QzTvXoX23o+mMWUQBWuhFbCWQYbPQecU=; b=IcFknYObn9SYN4UaRscH8XVCLt
        mOcixKnDJ0Km6/FoFKFPr9sACQxyOLm13wDPgFwTC/CnN6tYy5qSQ5m+lcDTn0Ds0ihw2SmvCCj5Z
        mph2kCx4/nGLWbYAuZrL9iTc6MkMXtx8vg9c2tSpqB7/orCYmvCNbGVlmwtpBa1TlBt8frrww5VZo
        Gz9uEc8baAZ0IVHnVTq/USGsNvR0eg6qEmdfq97265EL5hWIwC7sBJHOqrIAhdI4TPGXyEnvHt2WB
        e97MgjUxI25zN18HjidW8hnAyeGrayDnryZGH2TvFrfL0yNYUqGKnmWyqqNKKBbyn3t7yqsI6iHND
        wS4wY3pg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lMn9B-002hqf-LJ; Thu, 18 Mar 2021 07:32:48 +0000
Date:   Thu, 18 Mar 2021 07:32:45 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Sanket Parmar <sparmar@cadence.com>
Cc:     peter.chen@kernel.org, pawell@cadence.com, a-govindraju@ti.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kurahul@cadence.com, gregkh@linuxfoundation.org, kishon@ti.com,
        hch@infradead.org
Subject: Re: [PATCH v2] usb: cdns3: Optimize DMA request buffer allocation
Message-ID: <20210318073245.GA645121@infradead.org>
References: <1616008439-15494-1-git-send-email-sparmar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616008439-15494-1-git-send-email-sparmar@cadence.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 08:13:59PM +0100, Sanket Parmar wrote:
> dma_alloc_coherent() might fail on the platform with a small
> DMA region.
> 
> To avoid such failure in cdns3_prepare_aligned_request_buf(),
> dma_alloc_coherent() is replaced with dma_alloc_noncoherent()
> to allocate aligned request buffer of dynamic length.
> 
> Reported-by: Aswath Govindraju <a-govindraju@ti.com>
> Signed-off-by: Sanket Parmar <sparmar@cadence.com>

Looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
