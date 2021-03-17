Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86E733FA15
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 21:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbhCQUoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 16:44:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:41854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233406AbhCQUnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 16:43:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 12A8964E74;
        Wed, 17 Mar 2021 20:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616013819;
        bh=Xhg9V5fMmQ8KIqFkMh8ZnMAx7gJObwaelNe/rq5waUA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UUXp1a5aiYkKR2Ollt0KPCTdxWlhBcTjPNvpTjNYOjlxynUNt9A4kgcPNsRKnOI0f
         3g8zOcyTz6R5h5ad4dlOZomZNUrtGXxVis5I73ZXnLqXyVea8U8Sw0ffNrT2FzokYu
         kDqFYccCllAb3fx9nTBmcKcY0ygtjtMpP3P/6z3A=
Date:   Wed, 17 Mar 2021 21:43:36 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: udc: amd5536udc_pci fix crash if dma is used
Message-ID: <YFJp+It0/f7O9YId@kroah.com>
References: <20210313192033.2611349-1-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210313192033.2611349-1-ztong0001@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2021 at 02:20:32PM -0500, Tong Zhang wrote:
> init_dma_pools() calls dma_pool_create(...dev->dev) to create dma pool.
> however, dev->dev is actually set after calling init_dma_pools(), which
> effectively makes dma_pool_create(..NULL) and cause crash.
> To fix this issue, init dma only after dev->dev is set.
> 
> [    1.317993] RIP: 0010:dma_pool_create+0x83/0x290
> [    1.323257] Call Trace:
> [    1.323390]  ? pci_write_config_word+0x27/0x30
> [    1.323626]  init_dma_pools+0x41/0x1a0 [snps_udc_core]
> [    1.323899]  udc_pci_probe+0x202/0x2b1 [amd5536udc_pci]
> 
> Signed-off-by: Tong Zhang <ztong0001@gmail.com>

What commit caused this problem?

Can you resend this with a "Fixes:" tag added showing that?

thanks,

greg k-h
