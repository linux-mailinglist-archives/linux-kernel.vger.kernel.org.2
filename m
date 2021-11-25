Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8FC245DE3F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 17:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356236AbhKYQHG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 25 Nov 2021 11:07:06 -0500
Received: from marcansoft.com ([212.63.210.85]:51236 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356279AbhKYQFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 11:05:05 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id A8FF13FA5E;
        Thu, 25 Nov 2021 16:01:50 +0000 (UTC)
Date:   Fri, 26 Nov 2021 01:01:44 +0900
From:   "Hector Martin \"marcan\"" <marcan@marcan.st>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Janne Grunau <j@jannau.net>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] arm64: dts: apple: t8103: Add i2c nodes
User-Agent: K-9 Mail for Android
In-Reply-To: <CACRpkdZ4==HvMYrJe2jQMzeYqh65OKLEo9WEWDGZAZ8u7jkxFw@mail.gmail.com>
References: <20211122225807.8105-1-j@jannau.net> <20211122225807.8105-4-j@jannau.net> <5f16c962-72a1-21ec-9651-744053f74365@marcan.st> <d48d2e85-42f1-570a-bd8f-e3834147c8b8@marcan.st> <CACRpkdZghfRvox4aY4ROXYwFqiV6mnXZgw+42ZWYisXXgQ5+jQ@mail.gmail.com> <f13b54bd-d776-0d06-113a-5ca2bcbccfcd@marcan.st> <CACRpkdZ4==HvMYrJe2jQMzeYqh65OKLEo9WEWDGZAZ8u7jkxFw@mail.gmail.com>
Message-ID: <1779B10B-C54A-4A65-ABEB-FD1CEADF080C@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021年11月26日 0:50:28 JST, Linus Walleij <linus.walleij@linaro.org> wrote:
>On Wed, Nov 24, 2021 at 6:42 AM Hector Martin <marcan@marcan.st> wrote:
>
>> Pulling down an I2C bus between transactions is not legal; the idle
>> state has to be high.
>
>Oh right.
>
>> Apple are actually not very good at configuring GPIOs for power saving;
>> e.g. the I/Os for that unused i2c bus still have their input buffers
>> turned on, which is a waste of power. If they wanted to save the
>> smallest drop of power they'd turn that off. But the effect of this is
>> so trivial it probably makes no difference in the context of a laptop,
>> nevermind a desktop like the Mac Mini.
>
>Hm that's true. The saying is that 99% is the backlight, the remaining 1% isn't
>so significant after that.

From watching a USB power meter plugged into the MacBook Air, I can say the backlight is about 70% :-)

Then again, the new MBPs have LED matrix backlit screens... so suddenly dark themes are more efficient again! I should measure that one, see how much power changing themes saves.

-- 
Hector Martin "marcan" (marcan@marcan.st)
Public key: https://mrcn.st/pub
