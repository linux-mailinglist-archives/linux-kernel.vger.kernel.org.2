Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAC239D941
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 12:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbhFGKHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 06:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhFGKHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 06:07:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F05CC061766;
        Mon,  7 Jun 2021 03:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MZ7HfAxUNA4sYdVsS00Xo7tdZCEzY0DVG7Cn33xC8v8=; b=NHhzUqvjE/88wRep0AfweXDHHq
        vnYYAd++myvzOWjWTD1II1Bu9A3TB74TCcw06wWRbySdDulZm0r3BC5HRHh5FwVnYHLO4z9+wHL6i
        p/fa3AEMDHFi0f/uADdb2db4WU0b/tVYdZkvuJVV2jzlPEmTG12zqHCUCGed3eIE1/mvODLVu00T0
        QI+8vDW7g89u5JHsF0bUh84188OOlx6o6NwAxbhdwX9xYRFzvLo+lbash0Cc+J4J8yDtenNzRhvig
        vKVSjTmZzDd2ps08y5vtKXnfo2AF7TwVW/m697YlTu61FYuLh/9A6HAEkZJwceEi7F0NrzyAMXDeU
        qBachZ0Q==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lqC7s-00FbrF-Tg; Mon, 07 Jun 2021 10:05:01 +0000
Date:   Mon, 7 Jun 2021 11:04:56 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Sven Peter <sven@svenpeter.dev>,
        USB list <linux-usb@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] usb: dwc3: support 64 bit DMA in platform driver
Message-ID: <YL3vSPK5DXTNvgdx@infradead.org>
References: <20210607061751.89752-1-sven@svenpeter.dev>
 <CAK8P3a0vbyq-90pUQ6-0Ed=DadR3Pnf0juupLQ70psQSuu_1nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0vbyq-90pUQ6-0Ed=DadR3Pnf0juupLQ70psQSuu_1nw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 09:25:43AM +0200, Arnd Bergmann wrote:
> This will now  fail on machines with dwc3 connected to a 32-bit bus (or a
> bus that is accidentally not annotated as supporting 64-bit) when there is
> some memory that is not addressable through that bus.

No, it won't.  dma_set_mask_and_coherent with a 64-bit mask will never
fail if dev->dma_mask is non-NULL.
