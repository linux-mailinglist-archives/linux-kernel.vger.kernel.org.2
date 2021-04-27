Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2898436C49D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 13:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235515AbhD0LIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 07:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235611AbhD0LIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 07:08:19 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A942BC061756
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 04:07:17 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 77BFB4199E;
        Tue, 27 Apr 2021 11:07:13 +0000 (UTC)
Subject: Re: [PATCH] irqchip: APPLE_AIC should depend on ARCH_APPLE
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <f37e8daea37d50651d2164b0b3dad90780188548.1618316398.git.geert+renesas@glider.be>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <26a1ca39-5c60-b54c-d3fc-df1a7cc38818@marcan.st>
Date:   Tue, 27 Apr 2021 20:07:10 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <f37e8daea37d50651d2164b0b3dad90780188548.1618316398.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2021 21.21, Geert Uytterhoeven wrote:
> The Apple Interrupt Controller is only present on Apple Silicon SoCs.
> Hence add a dependency on ARCH_APPLE, to prevent asking the user about
> this driver when configuring a kernel without Apple Silicon SoC support.
> 
> Drop the default, as ARCH_APPLE already selects APPLE_AIC.
> 
> Fixes: 76cde26394114f6a ("irqchip/apple-aic: Add support for the Apple Interrupt Controller")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>   drivers/irqchip/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Makes sense. Thanks!

Acked-by: Hector Martin <marcan@marcan.st>

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
