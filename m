Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C9C3F05A3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 16:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238604AbhHROFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 10:05:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:52244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238531AbhHROFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 10:05:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EED5861076;
        Wed, 18 Aug 2021 14:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629295515;
        bh=/g9jlcYbBNlkfpqyuK7GTFt7XBuhX4Lcs2nELfNmEEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mrcFFI/8DENxT2EoJblBqcuw2bt/iZ+tCeaaN9A1yab2alBXsFHln7HeS+iXWYBNh
         QE/tF1wfkzkJqP7eNnUTeozO3ZIQhi+NqolVQMR+NibVTji3c0Aib9/p8Dylmls/Cm
         0jtmwB1HLdIinFzi+z4VsF0mXOHGHXXmj1kVca1Y=
Date:   Wed, 18 Aug 2021 16:05:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH] tty: serial: fsl_lpuart: fix the wrong mapbase value
Message-ID: <YR0TmJJ/WkfE2zkR@kroah.com>
References: <20210817063058.4718-1-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817063058.4718-1-sherry.sun@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 02:30:58PM +0800, Sherry Sun wrote:
> From: Andy Duan <fugang.duan@nxp.com>
> 
> Register offset needs to be applied on mapbase also.
> dma_tx/rx_request use the physical address of UARTDATA.
> Register offset is currently only applied to membase (the
> corresponding virtual addr) but not on mapbase.
> 
> Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>
> Acked-by: Fugang Duan <fugang.duan@nxp.com>
> Signed-off-by: Adriana Reus <adriana.reus@nxp.com>
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---

Why is there no signed-off-by from the author?

Please fix up.

thanks,

greg k-h
