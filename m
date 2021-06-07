Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1C839D8AD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 11:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbhFGJ07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 05:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbhFGJ06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 05:26:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEC9C061766;
        Mon,  7 Jun 2021 02:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mJFWyvVpJyGj+OAcSDuHr0rmetUi1/qBDaXb3QbiA1c=; b=joJUtBIfolUhyPQvaZZcvm4Dmk
        KssSIVJNHCr5rt2OmIXXnTwgzxiTWDrat0S9MgQXQhsWGpX+l5yh1wCMOSjPUZXC77rLNCoXrYg9M
        8hDHlMcyH7/jQknJAsHC3BLwBYzs9KSu7qCTbHxAF2EOiJuP1WK1XlaRUG62OaCZuRZcAF5fFKRKE
        f8Vd5SUaZJmiUM8HfNmlsp8LMI/3hgRz7T71UweN/Z/4uNMwAI9xbqjvgUd1/39tt/Ois1if51zyY
        re6SehpCObiovNuLhJerIYzajTNKW11MGi70OFhMrTQNiptFrZE8aZI+4rF7a1L2/SfJJS4d45dWl
        9jmCy88w==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lqBUs-00FZrq-NB; Mon, 07 Jun 2021 09:24:48 +0000
Date:   Mon, 7 Jun 2021 10:24:38 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] usb: dwc3: support 64 bit DMA in platform driver
Message-ID: <YL3l1upzyU83+iL/@infradead.org>
References: <20210606093629.69786-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210606093629.69786-1-sven@svenpeter.dev>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 06, 2021 at 11:36:29AM +0200, Sven Peter wrote:
> +	/* Try to set 64-bit DMA first */
> +	if (WARN_ON(!dwc->sysdev->dma_mask))
> +		/* Platform did not initialize dma_mask */
> +		ret = dma_coerce_mask_and_coherent(dwc->sysdev,
> +						   DMA_BIT_MASK(64));
> +	else
> +		ret = dma_set_mask_and_coherent(dwc->sysdev, DMA_BIT_MASK(64));

WARN_ON + fallback seems weird.  I'd suggest to just error out for the
warn case.

> +	/* If seting 64-bit DMA mask fails, fall back to 32-bit DMA mask */
> +	if (ret) {
> +		ret = dma_set_mask_and_coherent(dwc->sysdev, DMA_BIT_MASK(32));
> +		if (ret)
> +			return ret;
> +	}

Setting a 64-bit mask will not fail.  No need for the fallback.
