Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296AC45E81D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 07:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359021AbhKZG5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 01:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbhKZGy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 01:54:58 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD712C061756;
        Thu, 25 Nov 2021 22:51:08 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id A800C4255D;
        Fri, 26 Nov 2021 06:51:04 +0000 (UTC)
Subject: Re: [PATCH v4 0/4] Add DTs for all Apple M1 (t8103) devices
To:     Janne Grunau <j@jannau.net>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Mark Kettenis <mark.kettenis@xs4all.nl>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211123224926.7722-1-j@jannau.net>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <277222bd-e3b5-3140-b18f-acd93399c97e@marcan.st>
Date:   Fri, 26 Nov 2021 15:51:02 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211123224926.7722-1-j@jannau.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/2021 07.49, Janne Grunau wrote:
> Hej all,
> 
> hopefully the last iteration of this series. Thanks for the reviews.
> 
> Changes since v3:
>   - fixed typo in "arm64: dts: apple: t8103: Add cd321x nodes" commit
>     message
>   - fixed node order by address in t8103.dtsi
>   - removed clock-names property from i2c nodes
>   - renamed cd321x nodes to "usb-pd"
>   - added Reviewed-by and Acked-by tags
> 
> This series is available as branch at
>      https://github.com/jannau/linux/tree/apple_m1/dt-for-5.17_v4
> 
> For reference the message from v3:
> 
> this series extends the device tree files and bindings to all current
> Apple M1 devices. Specifically it adds DTs for following devices:
> - MacBook Air (M1, 2020)
> - Macbook Pro (13-inch, M1, 2020)
> - iMac (24-inch, M1, 2021)
> 
> It also adds i2c and cd321x devices nodes. Bindings and code changes for
> those were merged for 5.16 without adding devices to the device tree.
> Patches are include in a single series for dependencies
> 
> Series depends for functionality and dtbs verification on
> "[PATCH 0/3] Apple Arm patform device tree and bindings fixes".
> 
> 
> Janne Grunau (4):
>    dt-bindings: arm: apple: Add iMac (24-inch 2021) to Apple bindings
>    arm64: dts: apple: Add missing M1 (t8103) devices
>    arm64: dts: apple: t8103: Add i2c nodes
>    arm64: dts: apple: t8103: Add cd321x nodes
> 
>   .../devicetree/bindings/arm/apple.yaml        |  6 +-
>   arch/arm64/boot/dts/apple/Makefile            |  4 +
>   arch/arm64/boot/dts/apple/t8103-j274.dts      | 33 ++-----
>   arch/arm64/boot/dts/apple/t8103-j293.dts      | 41 +++++++++
>   arch/arm64/boot/dts/apple/t8103-j313.dts      | 33 +++++++
>   arch/arm64/boot/dts/apple/t8103-j456.dts      | 59 +++++++++++++
>   arch/arm64/boot/dts/apple/t8103-j457.dts      | 47 ++++++++++
>   arch/arm64/boot/dts/apple/t8103-jxxx.dtsi     | 67 ++++++++++++++
>   arch/arm64/boot/dts/apple/t8103.dtsi          | 87 +++++++++++++++++++
>   9 files changed, 347 insertions(+), 30 deletions(-)
>   create mode 100644 arch/arm64/boot/dts/apple/t8103-j293.dts
>   create mode 100644 arch/arm64/boot/dts/apple/t8103-j313.dts
>   create mode 100644 arch/arm64/boot/dts/apple/t8103-j456.dts
>   create mode 100644 arch/arm64/boot/dts/apple/t8103-j457.dts
>   create mode 100644 arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
> 
> 
> base-commit: fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf
> prerequisite-patch-id: 6827208d4389960d14555ee96768586179f9e8a7
> prerequisite-patch-id: d5f23530f8cb99fbd9355f4bf0ccbaaca0cd6d7c
> prerequisite-patch-id: 40ab5e8cc6dc6b5d44f075d8409f39966452bfb3
> 

Acked-by: Hector Martin <marcan@marcan.st>


Applied locally to asahi-soc/dt (with the #4 commit message fixed); that 
needs to be on top of the fixes branch, so I'll wait for Rob's ack on 
the binding change there before sending out the pulls. Thanks!

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
