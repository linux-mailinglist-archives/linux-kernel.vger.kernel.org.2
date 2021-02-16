Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E92431CA1D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 12:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhBPLsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 06:48:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:42672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230520AbhBPLqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 06:46:00 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 163BD64E04;
        Tue, 16 Feb 2021 11:45:13 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lBymz-00EQ0O-Rt; Tue, 16 Feb 2021 11:45:09 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 16 Feb 2021 11:45:09 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>, Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/25] dt-bindings: interrupt-controller: Add DT
 bindings for apple-aic
In-Reply-To: <CAK8P3a3rGurSQBubZ8i4+OHpDgM8mOfXiC6UhDYmL0MSQK4BRA@mail.gmail.com>
References: <20210215121713.57687-1-marcan@marcan.st>
 <20210215121713.57687-15-marcan@marcan.st>
 <CAK8P3a3rGurSQBubZ8i4+OHpDgM8mOfXiC6UhDYmL0MSQK4BRA@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <bba8e6790f4fc24fc2e9ecaa5d9eeabe@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: arnd@kernel.org, marcan@marcan.st, linux-arm-kernel@lists.infradead.org, robh@kernel.org, olof@lixom.net, krzk@kernel.org, mark.kettenis@xs4all.nl, tony@atomide.com, mohamed.mediouni@caramail.com, stan@corellium.com, graf@amazon.com, will@kernel.org, linus.walleij@linaro.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-16 09:41, Arnd Bergmann wrote:
> On Mon, Feb 15, 2021 at 1:17 PM Hector Martin <marcan@marcan.st> wrote:
>> +
>> +      The 2nd cell contains the interrupt number.
>> +        - HW IRQs: interrupt number
>> +        - FIQs:
>> +          - 0: physical HV timer
>> +          - 1: virtual HV timer
>> +          - 2: physical guest timer
>> +          - 3: virtual guest timer
> 
> I wonder if you could just model the FIQ as a single shared level 
> interrupt
> (which is essentially what it is), and have every driver that uses it 
> do a
> request_irq() on the same IRQ number.

And every driver would simply fail, because we don't allow sharing of
per-CPU interrupts.

         M.
-- 
Jazz is not dead. It just smells funny...
