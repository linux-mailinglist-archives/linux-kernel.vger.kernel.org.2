Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1884322790
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 10:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbhBWJM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 04:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbhBWJMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 04:12:43 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6D0C061574;
        Tue, 23 Feb 2021 01:12:03 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 2AB3B419B4;
        Tue, 23 Feb 2021 09:11:55 +0000 (UTC)
Subject: Re: [PATCH v2 00/25] Apple M1 SoC platform bring-up
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Alexander Graf <graf@amazon.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Olof Johansson <olof@lixom.net>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Stan Skowronek <stan@corellium.com>
References: <20210215121713.57687-1-marcan@marcan.st>
 <CAK8P3a1bXiWcieqTSZARN+to=J5RjC2cwbn_8ZOCYw2hhyyBYw@mail.gmail.com>
 <YCp1p1tRHF6OyR0C@kroah.com> <7c8bcf79-233b-7ea8-4fea-2fb29ca430ef@marcan.st>
 <YCqdi/5TSlbt0w/2@kroah.com> <e77a02eb-8493-14f0-f71c-a15646324d19@marcan.st>
 <20210215174359.hrqlz2je54qggvf7@kozik-lap>
 <CAHp75Vd2ObiUJFn-kVWBx+E30my9zXVX5iUtsyRb_c4FcZEDOA@mail.gmail.com>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <3873e91c-f54e-1eb7-2872-768fd926a775@marcan.st>
Date:   Tue, 23 Feb 2021 18:11:53 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vd2ObiUJFn-kVWBx+E30my9zXVX5iUtsyRb_c4FcZEDOA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2021 05.41, Andy Shevchenko wrote:
> Hector, I would like to be cc’ed in the next version

Noted, thanks!

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
