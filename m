Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A59245B405
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 06:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbhKXFpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 00:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbhKXFp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 00:45:29 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F8BC061574;
        Tue, 23 Nov 2021 21:42:19 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 5D4774268D;
        Wed, 24 Nov 2021 05:42:15 +0000 (UTC)
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Janne Grunau <j@jannau.net>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211122225807.8105-1-j@jannau.net>
 <20211122225807.8105-4-j@jannau.net>
 <5f16c962-72a1-21ec-9651-744053f74365@marcan.st>
 <d48d2e85-42f1-570a-bd8f-e3834147c8b8@marcan.st>
 <CACRpkdZghfRvox4aY4ROXYwFqiV6mnXZgw+42ZWYisXXgQ5+jQ@mail.gmail.com>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v3 3/4] arm64: dts: apple: t8103: Add i2c nodes
Message-ID: <f13b54bd-d776-0d06-113a-5ca2bcbccfcd@marcan.st>
Date:   Wed, 24 Nov 2021 14:42:12 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdZghfRvox4aY4ROXYwFqiV6mnXZgw+42ZWYisXXgQ5+jQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/2021 08.26, Linus Walleij wrote:
> On Tue, Nov 23, 2021 at 3:43 PM Hector Martin <marcan@marcan.st> wrote:
> 
>> For those following along in the list: the reason why i2c3 was getting
>> stuck is because it seems the unused bus is weakly pulled low on these
>> machines, which jams it.
> 
> That looks like some power saving attempt.
> 
> I suppose that means that even i2c buses that are in use
> could be weakly pulled low when suspending the system
> and maybe even inbetween transactions to save some
> leak current.

Pulled up vs. down dosn't really result in better power savings; neither 
state will necessarily have more leakage. I think it's just that the 
pins are completely disconnected, and there's some very minor leakage to 
ground (megaohms will do) that ends up pulling them down.

Pulling down an I2C bus between transactions is not legal; the idle 
state has to be high.

Apple are actually not very good at configuring GPIOs for power saving; 
e.g. the I/Os for that unused i2c bus still have their input buffers 
turned on, which is a waste of power. If they wanted to save the 
smallest drop of power they'd turn that off. But the effect of this is 
so trivial it probably makes no difference in the context of a laptop, 
nevermind a desktop like the Mac Mini.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
