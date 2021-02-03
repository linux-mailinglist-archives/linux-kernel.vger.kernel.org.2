Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA0930DE91
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 16:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbhBCPqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:46:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:59414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234185AbhBCPpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:45:38 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E17D64F5D;
        Wed,  3 Feb 2021 15:44:57 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l7KKt-00Bn8e-1e; Wed, 03 Feb 2021 15:44:55 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 03 Feb 2021 15:44:54 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     guoren@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH 1/2] drivers/irqchip: Fixup csky,mpintc compile error with
 CPU_CK610
In-Reply-To: <20210203134834.2367593-1-guoren@kernel.org>
References: <20210203134834.2367593-1-guoren@kernel.org>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <652791212cbf9c05a9d83b6da5a83520@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: guoren@kernel.org, linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, guoren@linux.alibaba.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-03 13:48, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> The irq-csky-mpintc.c only could support CPU_CK860 and it will
> compile error with CPU_CK610.
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/irqchip/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index b147f22a78f4..9be2dd5c6380 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -433,7 +433,7 @@ config QCOM_PDC
> 
>  config CSKY_MPINTC
>  	bool "C-SKY Multi Processor Interrupt Controller"
> -	depends on CSKY
> +	depends on CSKY && CPU_CK860
>  	help
>  	  Say yes here to enable C-SKY SMP interrupt controller driver used
>  	  for C-SKY SMP system.

I'm not convinced this is the right fix.

You already select CSKY_MPINTC only when CPU_CK860 is selected,
so preventing the user from selecting it should simply be a matter
of dropping the string after bool.

Thanks,

         M.

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 94920a51c628..2e7b562bbaac 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -432,7 +432,7 @@ config QCOM_PDC
  	  IRQs for Qualcomm Technologies Inc (QTI) mobile chips.

  config CSKY_MPINTC
-	bool "C-SKY Multi Processor Interrupt Controller"
+	bool
  	depends on CSKY
  	help
  	  Say yes here to enable C-SKY SMP interrupt controller driver used

-- 
Jazz is not dead. It just smells funny...
