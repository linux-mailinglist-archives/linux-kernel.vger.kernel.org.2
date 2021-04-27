Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A0336C628
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 14:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237061AbhD0Mh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 08:37:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:53256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235426AbhD0MhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 08:37:25 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B6176101D;
        Tue, 27 Apr 2021 12:36:42 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lbMxE-009g7G-7V; Tue, 27 Apr 2021 13:36:40 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 27 Apr 2021 13:36:40 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqchip: APPLE_AIC should depend on ARCH_APPLE
In-Reply-To: <26a1ca39-5c60-b54c-d3fc-df1a7cc38818@marcan.st>
References: <f37e8daea37d50651d2164b0b3dad90780188548.1618316398.git.geert+renesas@glider.be>
 <26a1ca39-5c60-b54c-d3fc-df1a7cc38818@marcan.st>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <b40459d5e88f9735b3370184106f3cc0@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: marcan@marcan.st, geert+renesas@glider.be, tglx@linutronix.de, will@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-04-27 12:07, Hector Martin wrote:
> On 13/04/2021 21.21, Geert Uytterhoeven wrote:
>> The Apple Interrupt Controller is only present on Apple Silicon SoCs.
>> Hence add a dependency on ARCH_APPLE, to prevent asking the user about
>> this driver when configuring a kernel without Apple Silicon SoC 
>> support.
>> 
>> Drop the default, as ARCH_APPLE already selects APPLE_AIC.
>> 
>> Fixes: 76cde26394114f6a ("irqchip/apple-aic: Add support for the Apple 
>> Interrupt Controller")
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>>   drivers/irqchip/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> 
> 
> Makes sense. Thanks!
> 
> Acked-by: Hector Martin <marcan@marcan.st>

I'll pick this up post -rc1.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
