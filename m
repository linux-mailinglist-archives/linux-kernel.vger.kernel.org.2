Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8420645E81B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 07:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352676AbhKZG47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 01:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358871AbhKZGy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 01:54:57 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1723C06173E;
        Thu, 25 Nov 2021 22:50:26 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 69BFE4255D;
        Fri, 26 Nov 2021 06:50:22 +0000 (UTC)
To:     Janne Grunau <j@jannau.net>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211122225807.8105-1-j@jannau.net>
 <b38bb236-d739-4514-e79a-d7666ae23337@marcan.st>
 <20211126063324.GB28130@jannau.net>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v3 0/4] Add DTs for all Apple M1 (t8103) devices
Message-ID: <929be601-6fb4-c680-16ac-b7e42d0a90af@marcan.st>
Date:   Fri, 26 Nov 2021 15:50:19 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211126063324.GB28130@jannau.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/11/2021 15.33, Janne Grunau wrote:
> Hej,
> 
> On 2021-11-26 14:39:16 +0900, Hector Martin wrote:
>> On 23/11/2021 07.58, Janne Grunau wrote:
>>>
>>> Janne Grunau (4):
>>>     dt-bindings: arm: apple: Add iMac (24-inch 2021) to Apple bindings
>>>     arm64: dts: apple: Add missing M1 (t8103) devices
>>>     arm64: dts: apple: t8103: Add i2c nodes
>>>     arm64: dts: apple: t8103: Add cd321x nodes
>>>
>>>    .../devicetree/bindings/arm/apple.yaml        |  6 +-
>>>    arch/arm64/boot/dts/apple/Makefile            |  4 +
>>>    arch/arm64/boot/dts/apple/t8103-j274.dts      | 33 +------
>>>    arch/arm64/boot/dts/apple/t8103-j293.dts      | 41 +++++++++
>>>    arch/arm64/boot/dts/apple/t8103-j313.dts      | 33 +++++++
>>>    arch/arm64/boot/dts/apple/t8103-j456.dts      | 59 ++++++++++++
>>>    arch/arm64/boot/dts/apple/t8103-j457.dts      | 47 ++++++++++
>>>    arch/arm64/boot/dts/apple/t8103-jxxx.dtsi     | 67 ++++++++++++++
>>>    arch/arm64/boot/dts/apple/t8103.dtsi          | 92 +++++++++++++++++++
>>>    9 files changed, 352 insertions(+), 30 deletions(-)
>>>    create mode 100644 arch/arm64/boot/dts/apple/t8103-j293.dts
>>>    create mode 100644 arch/arm64/boot/dts/apple/t8103-j313.dts
>>>    create mode 100644 arch/arm64/boot/dts/apple/t8103-j456.dts
>>>    create mode 100644 arch/arm64/boot/dts/apple/t8103-j457.dts
>>>    create mode 100644 arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
>>>
>>
>> Whole series is:
>>
>> Tested-by: Hector Martin <marcan@marcan.st>
>>
>> on j274, j313, j456.
>>
>> Thanks! If you spin up a v4 with the minor comments addressed, I'll be happy
>> to merge it :)
> 
> there is already a v4 with Sven's comments addressed at
> 
> https://lore.kernel.org/linux-arm-kernel/20211123224926.7722-1-j@jannau.net/
> 
> Jean-Marc Ranger notified me off-list of a typo in "arm64: dts: apple:
> t8103: Add cd321x nodes" commit messages: 'addiotional'.
> 
> I don't think it's worth spinning up a v5 for fixing that typo.

Oh whoops, I think I mixed that one up with this one when scrolling 
through email and thought they were the same series. Was just catching 
up on email and it hadn't hit me yet... thanks for pointing it out.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
