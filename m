Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87164388894
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 09:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243246AbhESHvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 03:51:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:42934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242539AbhESHvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 03:51:15 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CD0361244;
        Wed, 19 May 2021 07:49:56 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1ljGxm-002ErN-3b; Wed, 19 May 2021 08:49:54 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 19 May 2021 08:49:54 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [PATCH -next] irqchip/mbigen: fix compile warning when
 CONFIG_ACPI is disabled
In-Reply-To: <20210519050455.1693953-1-yangyingliang@huawei.com>
References: <20210519050455.1693953-1-yangyingliang@huawei.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <c9e2dee2a7bb11d3327bbe55f4f7cf05@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: yangyingliang@huawei.com, linux-kernel@vger.kernel.org, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-05-19 06:04, Yang Yingliang wrote:
> Fix the following compile warning:
> 
>   drivers/irqchip/irq-mbigen.c:372:36: warning: ‘mbigen_acpi_match’
> defined but not used [-Wunused-const-variable=]
>    static const struct acpi_device_id mbigen_acpi_match[] = {
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/irqchip/irq-mbigen.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-mbigen.c 
> b/drivers/irqchip/irq-mbigen.c
> index 2cb45c6b8501..f565317a3da3 100644
> --- a/drivers/irqchip/irq-mbigen.c
> +++ b/drivers/irqchip/irq-mbigen.c
> @@ -273,6 +273,12 @@ static int mbigen_of_create_domain(struct
> platform_device *pdev,
>  }
> 
>  #ifdef CONFIG_ACPI
> +static const struct acpi_device_id mbigen_acpi_match[] = {
> +	{ "HISI0152", 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(acpi, mbigen_acpi_match);
> +
>  static int mbigen_acpi_create_domain(struct platform_device *pdev,
>  				     struct mbigen_device *mgn_chip)
>  {
> @@ -369,12 +375,6 @@ static const struct of_device_id mbigen_of_match[] 
> = {
>  };
>  MODULE_DEVICE_TABLE(of, mbigen_of_match);
> 
> -static const struct acpi_device_id mbigen_acpi_match[] = {
> -	{ "HISI0152", 0 },
> -	{}
> -};
> -MODULE_DEVICE_TABLE(acpi, mbigen_acpi_match);
> -
>  static struct platform_driver mbigen_platform_driver = {
>  	.driver = {
>  		.name		= "Hisilicon MBIGEN-V2",

Is it actually a thing to have mbigen without ACPI? As far as I can
tell, all the mbigen-equipped machines in existence use ACPI.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
