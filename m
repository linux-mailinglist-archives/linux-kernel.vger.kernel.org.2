Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0533241B7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 17:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235285AbhBXQIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 11:08:14 -0500
Received: from marcansoft.com ([212.63.210.85]:58396 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235182AbhBXP42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 10:56:28 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 8DD9442463;
        Wed, 24 Feb 2021 15:55:06 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210215121713.57687-1-marcan@marcan.st>
 <20210218143644.GC89209@C02TD0UTHF1T.local>
 <add1937b-183b-17a9-94db-f384801a079e@marcan.st>
Subject: Re: [PATCH v2 00/25] Apple M1 SoC platform bring-up
Message-ID: <7d878de7-cfe8-ed32-ff7c-d1c3e61aa54f@marcan.st>
Date:   Thu, 25 Feb 2021 00:55:04 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <add1937b-183b-17a9-94db-f384801a079e@marcan.st>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2021 00.20, Hector Martin wrote:
> I haven't tested things at EL0 yet, but it looks like the stateful
> instructions known to be usable in EL0 (AMX) already default to trap on
> this platform, so we should be safe there. Everything else looks like it
> probably either shouldn't work in EL0 (I sure hope the address
> translation one doesn't...) or is probably stateless. I'll dig deeper
> and test EL0 in the future, but so far things look OK (for some
> questionable values of OK :) ).

Follow-up: I have EL0 testing scaffolding now, and I found some more 
mutable state (an IMP-DEF, pre-standard version of FEAT_AFP, using a 
separate status register for the bits), but thankfully it traps at EL0 
by default.

And then I found some other mutable IMP-DEF state that does not trap at 
EL0. And which is a 0-day CVE in macOS, because it doesn't 
save/restore/clear it either, nor does it trap there.

E-mailing security@apple.com...

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
