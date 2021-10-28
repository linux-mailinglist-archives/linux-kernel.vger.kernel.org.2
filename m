Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C574243E892
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 20:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhJ1Spt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 14:45:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:51160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231224AbhJ1Spp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 14:45:45 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B402E61040;
        Thu, 28 Oct 2021 18:43:18 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mgAMu-002Hf3-Du; Thu, 28 Oct 2021 19:43:16 +0100
MIME-Version: 1.0
Date:   Thu, 28 Oct 2021 19:43:16 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] irqchip: Provide stronger type checking for
 IRQCHIP_MATCH/IRQCHIP_DECLARE
In-Reply-To: <20211028172849.GA701812@roeck-us.net>
References: <20211020104527.3066268-1-maz@kernel.org>
 <20211028172849.GA701812@roeck-us.net>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <f1d9a7681e7bc83790782ef3e4197a82@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: linux@roeck-us.net, linux-kernel@vger.kernel.org, kernel-team@android.com, f.fainelli@gmail.com, robh@kernel.org, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-10-28 18:28, Guenter Roeck wrote:
> On Wed, Oct 20, 2021 at 11:45:27AM +0100, Marc Zyngier wrote:
>> Both IRQCHIP_DECLARE() and IRQCHIP_MATCH() use an underlying 
>> of_device_id()
>> structure to encode the matching property and the init callback.
>> However, this callback is stored in as a void * pointer, which 
>> obviously
>> defeat any attempt at stronger type checking.
>> 
>> Work around this by providing a new macro that builds on top of the
>> __typecheck() primitive, and that can be used to warn when there is
>> a discrepency between the drivers and core code.
>> 
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
> 
> This patch results in:
> 
> In file included from include/linux/irq.h:589,
>                  from include/linux/of_irq.h:7,
>                  from include/linux/irqchip.h:17,
>                  from arch/h8300/include/asm/irq.h:5,
>                  from arch/h8300/kernel/traps.c:27:
> include/linux/irqdesc.h:113:33: error: 'NR_IRQS' undeclared here (not
> in a function)
>   113 | extern struct irq_desc irq_desc[NR_IRQS];
> 
> and many similar errors when trying to build h8300 images.

Sigh... Please give this [1] a go.

         M.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/commit/?h=irq/misc-5.16&id=0646880e517c06f0e0746665ca1e0e6dd36c406e

-- 
Jazz is not dead. It just smells funny...
