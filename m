Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B287320A5C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 14:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbhBUNDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 08:03:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:46628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229588AbhBUNDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 08:03:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F028F64F06;
        Sun, 21 Feb 2021 13:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613912559;
        bh=PqaCurbTk7C7PNgYa86YlnmbN9I/E96rikO0Wib/WY8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PyHB26EkP3rIRXTKptOk+uxlSFsP4XnNBH5dIXSFe+OtHZOVU0BYB95jIr+iJLr2Q
         lbuhKWuniwfBkzXZRLWE/IuirpoC+PCtPcq1xKoJDadGA1zYX3uHuWrxV0xL8OgHXp
         r9DCrXuDSXTSQnge75VH/nyNCXG6bW979+EhZkPU=
Date:   Sun, 21 Feb 2021 14:02:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lee Gibson <leegib@gmail.com>
Cc:     mchehab+huawei@kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: hikey9xx: Fix space tab style warnings
Message-ID: <YDJZ7GTF/8tmJg4x@kroah.com>
References: <20210219143851.83672-1-leegib@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219143851.83672-1-leegib@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 02:38:51PM +0000, Lee Gibson wrote:
> This patch fixes the checkpatch warnings such as:
> 
> hi6421-spmi-pmic.c:51: WARNING: please, no space before tabs
> 
> Signed-off-by: Lee Gibson <leegib@gmail.com>
> ---
>  drivers/staging/hikey9xx/hi6421-spmi-pmic.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
> index 4ebcfea9f3bf..626140cb96f2 100644
> --- a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
> +++ b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
> @@ -48,9 +48,9 @@ enum hi6421_spmi_pmic_irq_list {
>  /*
>   * The IRQs are mapped as:
>   *
> - * 	======================  =============   ============	=====
> - *	IRQ			MASK REGISTER 	IRQ REGISTER	BIT
> - * 	======================  =============   ============	=====
> + *	======================  =============   ============	=====
> + *	IRQ			MASK REGISTER	IRQ REGISTER	BIT
> + *	======================  =============   ============	=====
>   *	OTMP			0x0202		0x212		bit 0
>   *	VBUS_CONNECT		0x0202		0x212		bit 1
>   *	VBUS_DISCONNECT		0x0202		0x212		bit 2
> @@ -66,7 +66,7 @@ enum hi6421_spmi_pmic_irq_list {
>   *	SIM0_HPD_F		0x0203		0x213		bit 3
>   *	SIM1_HPD_R		0x0203		0x213		bit 4
>   *	SIM1_HPD_F		0x0203		0x213		bit 5
> - * 	======================  =============   ============	=====
> + *	======================  =============   ============	=====
>   */
>  #define SOC_PMIC_IRQ_MASK_0_ADDR	0x0202
>  #define SOC_PMIC_IRQ0_ADDR		0x0212
> -- 
> 2.25.1

This patch doesn't apply to my staging-testing branch of staging.git
right now, did someone else already make this change recently?

thanks,

greg k-h
