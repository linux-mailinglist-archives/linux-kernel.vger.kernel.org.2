Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46524309FE4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 02:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhBABQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 20:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhBABQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 20:16:38 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD51C061573;
        Sun, 31 Jan 2021 17:15:58 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id a6so3577647vkb.8;
        Sun, 31 Jan 2021 17:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MXqi7RWg583NTT5f0rgbVSyToBhnJlq1eY84ZndpFyI=;
        b=T6KNUKebxfvEccYgPBK9Dpz6YVvEpYfR4gb4ZCRjrZiPUgX5VdF58tvsv1vu6rOK/S
         /X4OtoFXV22ZscnfCtX1ZFv4u0Q4zWGFuw/9h2B1W2CUxh1E7rsyMkjGsU6VYTFkmg/Z
         u/XTfYVADLpb6GSHSEnmqPg2jTfkVzAKDc607YC0mRZJXLCNUrMWClbV3B49FmmvihGy
         0jW913aDUScV3KVUlpX+NGefBaqwKdIKNr1I4kbLApPyYt2jSM1/bnR+9n5ksUfvwCTq
         KOPiEDbbNte05M147qBj+J0UoPh34EPRNl94Ak+KYU54p37MLWtll4kAjfeRbr+bIVYz
         Y8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MXqi7RWg583NTT5f0rgbVSyToBhnJlq1eY84ZndpFyI=;
        b=lXigYoCoyaMp0E5doOFn1ATQkdhqSY5wAY8fvhj6haTmDYWSwPEm28Z4JBt3I5jISZ
         6JXUCpz3EzDQ+ZnftZmM5eNKDNq1BUtkqfmF+hLGkPo5Wt9LzKhqMPyHfMkBpx/jUEHB
         1fKRFoKhKcHL6RLSkOW1RQYgVGsTlWMWRARFYZb5o6iD7psf0ebamxklTENajBDETvs4
         FANsvrpt1neQO8S9rQ3GpwmY+70mT2B3U2FS92m29NBrCbI0Cp+7zwKrUcCNpErCM01M
         +P8P2L7qnR8TbmHGPqtHbkn619MVg0cqR+595KtTPtRMj1DRSsJyuB0gFhw91ELn/H8E
         uOkA==
X-Gm-Message-State: AOAM530xzq7hf0cjd6nVd5kE0Z7NZ7/F2cgj/VJOtgVOayPkKYgQ+foG
        Gxh1w8QRfW8gCm7rVDaAW7CpjMZTTV0Csvg6JQhYABZH174=
X-Google-Smtp-Source: ABdhPJz3w+HvZ2eDyNiWJZbsiVXIGRoNKk73QgL8EwWZHNoSD1Y5HLjPGXAFDCt2xYnTtl+4PMFc7yZek8rOfZwBDag=
X-Received: by 2002:a1f:2651:: with SMTP id m78mr8157594vkm.18.1612142157635;
 Sun, 31 Jan 2021 17:15:57 -0800 (PST)
MIME-Version: 1.0
References: <AM5PR0802MB2498F95537E1FF0E5DEB36BEA9B79@AM5PR0802MB2498.eurprd08.prod.outlook.com>
In-Reply-To: <AM5PR0802MB2498F95537E1FF0E5DEB36BEA9B79@AM5PR0802MB2498.eurprd08.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sun, 31 Jan 2021 22:15:46 -0300
Message-ID: <CAOMZO5D59FvmSuHVM0Xq092eF+D0jYK477ZFecA2apnT5zLj3Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6qdl-wandboard: add scl/sda gpios
 definitions for i2c bus recovery
To:     Dima Azarkin <azdmg@outlook.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Christian Hewitt <christianshewitt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 31, 2021 at 12:55 PM Dima Azarkin <azdmg@outlook.com> wrote:
>
> The i2c bus on imx6qdl-wandboard has intermittent issues where SDA can freeze
> on low level at the end of transaction so the bus can no longer work. This
> impacts reading of EDID data leading to incorrect TV resolution and no audio.
>
> This scenario is improved by adding scl/sda gpios definitions to implement the
> i2c bus recovery mechanism.
>
> Signed-off-by: Dima Azarkin <azdmg@outlook.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
