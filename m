Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5300C3206DB
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 20:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbhBTTSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 14:18:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:48358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229808AbhBTTS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 14:18:28 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 416FE61481;
        Sat, 20 Feb 2021 19:17:47 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lDXlB-00F6Qi-4p; Sat, 20 Feb 2021 19:17:45 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 20 Feb 2021 19:17:44 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 20/25] tty: serial: samsung_tty: Use
 devm_ioremap_resource
In-Reply-To: <20210220191323.ugmzrtkvcxyqqolj@kozik-lap>
References: <20210215121713.57687-1-marcan@marcan.st>
 <20210215121713.57687-21-marcan@marcan.st>
 <20210215185135.onivzktfscv5myh2@kozik-lap>
 <20274436-7275-9734-5a07-d6da46b45c5f@marcan.st>
 <20210220191323.ugmzrtkvcxyqqolj@kozik-lap>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <5a4b3d7095d1ec4be97ec154109632dc@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: krzk@kernel.org, marcan@marcan.st, linux-arm-kernel@lists.infradead.org, robh@kernel.org, arnd@kernel.org, olof@lixom.net, mark.kettenis@xs4all.nl, tony@atomide.com, mohamed.mediouni@caramail.com, stan@corellium.com, graf@amazon.com, will@kernel.org, linus.walleij@linaro.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-20 19:13, Krzysztof Kozlowski wrote:
> On Thu, Feb 18, 2021 at 11:01:21PM +0900, Hector Martin wrote:
>> On 16/02/2021 03.51, Krzysztof Kozlowski wrote:
>> > > Also fix a bug checking the return value, which should use IS_ERR().
>> >
>> > No, no, no. We never, never combine fixing bugs with some rework.
>> > However devm_ioremap() returns NULL so where is the error?
>> 
>> Sorry, this was a commit message mistake. The code is correct and so 
>> is the
>> patch: just the NULL check is correct for the previous variant and 
>> IS_ERR is
>> correct for devm_ioremap_resource. I confused myself while writing the
>> commit message after the fact.
>> 
>> > Did you test your patches on existing platforms? If not, please mark all
>> > of them as RFT on next submission, so Greg does not pick them too fast.
>> 
>> I unfortunately don't have any Exynos devices where I could test the 
>> code (I
>> have a couple but no serial connections, and I have no idea if mailine 
>> would
>> run on them). I'll mark v3 as RFT.
> 
> If you have one of Odroid boards with Exynos, then you can nicely test
> Exynos. Others - depends, on board.
> Anyway I can test them for you. I just want to be sure that Greg waits
> for this testing.

Worse case, QEMU has some Exynos4210 emulation that is usable.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
