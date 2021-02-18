Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A5A31E8FE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 12:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbhBRLKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 06:10:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:53402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230299AbhBRKBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 05:01:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA79464E68;
        Thu, 18 Feb 2021 10:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613642424;
        bh=XtaWVk6LZOMPPkzxCsPoYz5qDqx9N6wTxJ+PS9WAb1o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pvWoRPYA7m7DoxCvmGcIIDjlADkz8YeR9WzZGskoaWAVySg06HAJwYpb/eBhL/zjX
         /VH5/E+wx3QtgsMCFieLgZtNfSseH0eEm2iRhV9SceQFKGVn9FO0Xe1gZ28RL3Mqyf
         xG2I0PSdnN4HZxPalV/YpqFeYJFZ3OAC4pg/9Dqo=
Date:   Thu, 18 Feb 2021 11:00:21 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Shile Zhang <shile.zhang@linux.alibaba.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc/pvpanic: Export module FDT device table
Message-ID: <YC46tZLAesfSNg40@kroah.com>
References: <20210218094024.69354-1-shile.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218094024.69354-1-shile.zhang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 05:40:24PM +0800, Shile Zhang wrote:
> Export the module FDT device table to ensure the FDT compatible strings
> are listed in the module alias. This help the pvpanic driver can be
> loaded on boot automatically not only the ACPI device, but also the FDT
> device.
> 
> Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>
> ---
>  drivers/misc/pvpanic.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
> index 41cab297d66e..2356d621967e 100644
> --- a/drivers/misc/pvpanic.c
> +++ b/drivers/misc/pvpanic.c
> @@ -92,6 +92,7 @@ static const struct of_device_id pvpanic_mmio_match[] = {
>  	{ .compatible = "qemu,pvpanic-mmio", },
>  	{}
>  };
> +MODULE_DEVICE_TABLE(of, pvpanic_mmio_match);

What caused this to not work properly?  I.e. should there be a "Fixes:"
tag in the commit changelog as well?

thanks,

greg k-h
