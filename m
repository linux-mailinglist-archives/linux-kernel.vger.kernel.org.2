Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C96513F586E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 08:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbhHXGqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 02:46:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:44312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230497AbhHXGqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 02:46:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D87F61101;
        Tue, 24 Aug 2021 06:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629787529;
        bh=Kubh2nvvp1Q6uolaYfDooSop8qoFrJBPwS451q3QqQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xGWMER6q+ZDV6Hm4DxrGKvKsHkFDy8BDt6PNPXTysOZDKEdnwernVRLzn7TS/3Evl
         GUhFInVIHNNsVxBZSDZ0VmXBTNgiiT2TJiC2djbzXkYTqJoXGLDf2G57b6ZSyxLmK9
         P+TCRogG1zFDExrBgJV1rbTjS3lR406ezv9jq510=
Date:   Tue, 24 Aug 2021 08:45:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Dahl <ada@thorsis.com>
Cc:     linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] USB: host: ehci-atmel: Allow enabling HSIC on SAMA5D2
Message-ID: <YSSVhblgt/45TvzF@kroah.com>
References: <20210823140052.GA120849@rowland.harvard.edu>
 <20210824063702.24586-1-ada@thorsis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824063702.24586-1-ada@thorsis.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 08:37:02AM +0200, Alexander Dahl wrote:
> Unlike other SoC series featuring the 'atmel,at91sam9g45-ehci' USB EHCI
> controller, which have embedded USB high-speed transceivers for each
> port, the third port on the SAMA5D2 series is HSIC only.  That HSIC
> interface is not enabled after a power-on reset, but can be enabled by
> setting a flag in a vendor specific EHCI register.
> 
> The register offsets added to the new header file were compared with
> those for the SAM9G45, SAM9X25, SAMA5D3, SAMA5D4, and SAM9X60 series and
> there are no differences in the offsets or contents of those registers.
> Which of those additional vendor specific registers are supported,
> differs by SoC family.  So while the HSIC enable feature is currently
> only present for SAMA5D2, it probably does not hurt to set it on the
> other families, hence no additional check for SoC family here.
> 
> Tested on a custom board featuring a SAMA5D27C-D5M SiP connected to an
> USB3503 hub with an upstream HSIC interface.
> 
> Link: https://community.atmel.com/forum/sama5d2-using-hsic-under-linux
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> ---
> 
> Notes:
>     - for introducing new dt binding, would be nice to convert old one
>       first, probably needs split up and multiple iteration review?
>     - name of that new dt property?
>     - register definitions put to a separate file, like
>       'drivers/usb/host/ehci-fsl.h'
>     - unsure where exactly in the probe process that register write should
>       happen, datasheet gives no hint
>     - should suspend/resume be considered?
> 
>  drivers/usb/host/ehci-atmel.c | 17 +++++++++++++++++
>  drivers/usb/host/ehci-atmel.h | 19 +++++++++++++++++++

No need for a new .h file that is only used in a single .c file.  Just
put those few lines in the .c file please.

thanks,

greg k-h
