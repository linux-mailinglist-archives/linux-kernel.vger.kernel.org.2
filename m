Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBEB831ED3A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 18:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbhBRRX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 12:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbhBROna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 09:43:30 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F978C0613D6;
        Thu, 18 Feb 2021 06:42:13 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 1559741E96;
        Thu, 18 Feb 2021 14:42:03 +0000 (UTC)
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Arnd Bergmann <arnd@kernel.org>, Rob Herring <robh@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, Alexander Graf <graf@amazon.com>,
        Olof Johansson <olof@lixom.net>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Mark Kettenis <mark.kettenis@xs4all.nl>
References: <20210215121713.57687-1-marcan@marcan.st>
 <20210215121713.57687-9-marcan@marcan.st>
 <20210217122200.GC5556@C02TD0UTHF1T.local>
 <e88fa913-e2ae-35d0-056f-2a5079babbc2@marcan.st>
 <20210218142205.GB89209@C02TD0UTHF1T.local>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v2 08/25] arm64: Always keep DAIF.[IF] in sync
Message-ID: <e66a9d0d-1127-c755-8bd7-7deedca1f3f3@marcan.st>
Date:   Thu, 18 Feb 2021 23:42:01 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210218142205.GB89209@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/02/2021 23.22, Mark Rutland wrote:
> I think that for consistency we always want to keep IRQ and FIQ in-sync,
> even when using GIC priorities. So when handling a pseudo-NMI we should
> unmask DAIF.DA and leave DAIF.IF masked.

In that case there's one more, in daifflags.h:local_daif_restore():

			/*
			 * If interrupts are disabled but we can take
			 * asynchronous errors, we can take NMIs
			 */
			flags &= PSR_I_BIT;
			pmr = GIC_PRIO_IRQOFF;

>> And a minor related one: should init_gic_priority_masking() WARN if FIQ is
>> masked too? This probably goes with the above.
> 
> I think it should, yes.

Done for v3 then. Thanks!

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
