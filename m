Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9295537B3A1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 03:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhELBld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 21:41:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:51144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230035AbhELBl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 21:41:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B27461927;
        Wed, 12 May 2021 01:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620783619;
        bh=lyTflVjlBUsUGySsDuYZUKOXhPHqBbrugIKMaeKXOFU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZTnexORFwF1trlAs4eT/SjQVZbbYISU2xAQguvHo6vmJlAXrpGKZI2GscqsEvxQjo
         XjRWelkHDA7I2tUYBTDLbMWOOrzfHeq7xWLLIF/xLoLM2zHBDLXVPJWfM3avivB86e
         RHnpjniz70ndTOFRf5iR3r72LsK+5QkJ47D84aOBhii+60YUkLfTgIZQEI8cqIaK+o
         lqEGkoZ7klfp3l/HxAGCwwZ30b9aSFF1rcd3+ltr5yVwI6ffh8IEw4E/XyFOO1k5/L
         T2+7s4WyNn8a8ZgtvKNZbnRRE8CgHNUL3SgmxV64YzySZlh0Hv4/7vZ+MX4qSBTW6l
         1GHEo2W+hWEdg==
Date:   Wed, 12 May 2021 10:40:15 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <hayashi.kunihiko@socionext.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH -next] regulator: uniphier: Add missing
 MODULE_DEVICE_TABLE
Message-Id: <20210512104015.e6536460f9b584d7bd3c7284@kernel.org>
In-Reply-To: <1620705198-104566-1-git-send-email-zou_wei@huawei.com>
References: <1620705198-104566-1-git-send-email-zou_wei@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2021 11:53:18 +0800
Zou Wei <zou_wei@huawei.com> wrote:

> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>

Looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> ---
>  drivers/regulator/uniphier-regulator.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/regulator/uniphier-regulator.c b/drivers/regulator/uniphier-regulator.c
> index 2e02e26..e75b097 100644
> --- a/drivers/regulator/uniphier-regulator.c
> +++ b/drivers/regulator/uniphier-regulator.c
> @@ -201,6 +201,7 @@ static const struct of_device_id uniphier_regulator_match[] = {
>  	},
>  	{ /* Sentinel */ },
>  };
> +MODULE_DEVICE_TABLE(of, uniphier_regulator_match);
>  
>  static struct platform_driver uniphier_regulator_driver = {
>  	.probe = uniphier_regulator_probe,
> -- 
> 2.6.2
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
