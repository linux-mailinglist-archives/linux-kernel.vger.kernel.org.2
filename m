Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD187320AA5
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 14:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhBUNo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 08:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbhBUNo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 08:44:28 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA51C061574;
        Sun, 21 Feb 2021 05:43:47 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id B315E425BE;
        Sun, 21 Feb 2021 13:43:40 +0000 (UTC)
Subject: Re: [PATCH v2 19/25] tty: serial: samsung_tty: IRQ rework
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
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
References: <20210215121713.57687-1-marcan@marcan.st>
 <20210215121713.57687-20-marcan@marcan.st>
 <20210215184012.sf6p6dbk5c25phdm@kozik-lap>
 <31068a51-736b-08f6-6c00-1779734465ea@marcan.st>
 <20210220191124.wjkkqz2boxsdkf2b@kozik-lap>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <07135a74-bd94-0c23-786e-7c073229fb32@marcan.st>
Date:   Sun, 21 Feb 2021 22:43:38 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210220191124.wjkkqz2boxsdkf2b@kozik-lap>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/2021 04.11, Krzysztof Kozlowski wrote:
> On Thu, Feb 18, 2021 at 10:53:10PM +0900, Hector Martin wrote:
>> This should've gone in the next patch. A previous reviewer told me to put
>> declarations at the top of the file, so I put it there and moved this one
>> along with it, but I'll keep it to the additon only for v3.
> 
> Maybe I missed something in the context but it looked like
> forward declaration s3c24xx_serial_tx_chars() was not needed? In such
> case no need to move it.

It's needed in patch #22 in this series; having it in this patch was a 
mistake I made while splitting up the changes. I have moved that line to 
the Apple support patch for v3.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
