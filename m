Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CACE63469D2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 21:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbhCWU3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 16:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbhCWU3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 16:29:05 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531FCC061574;
        Tue, 23 Mar 2021 13:29:05 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id c13so7117820uao.10;
        Tue, 23 Mar 2021 13:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+Mz6aI8C8OxAPti7lYO//zMAdk8ShP29DZiThND01bo=;
        b=OblwTUD4kfwNMkmwRT7oymB0AOHXuV9YOx79V6pLQm7qA9D7F2XbG8zApLcEPMNnV7
         eI2zzHeTA61X1W6i6IRJNbQciLGU0BJ2BELAbUoBiLVp/1RduEfAWMVXur3XKjErMR3A
         VEMVIqEEC4f1iIsBg+sNSESXZf/mh8R/FOygW60vJJWE97K+RYvgKpftEgRqWMOQz02H
         jG6i9tBNSIN2VJt1Jd5fuPNz5GFbffxQsrHZ2uzyB0WJCDlSmUKTLdb7zIPJQ9O7NZpJ
         c1MMDbxnN2SSqno+x95AhR/PeWiBkiHjhQ48BN2todrpnE0yPnibZMGTydlP86e0h+ZF
         eHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+Mz6aI8C8OxAPti7lYO//zMAdk8ShP29DZiThND01bo=;
        b=CAMb69wePhszgfIYx8jdUMDjGN29yKPav8/3NKUezEyPGDPQQQJtY1FZlmeQbUH9zv
         IxUWKUcbEg6C64Q5XFpf6XkUbwnSnQdQHZpfqCTuxaPflJfAnVPZApyczTZQVTvs+DvI
         D0wfYGLFJlj39m5rUyz6BLI9nOp1xLxrNkr2XC4wBP4pYWlRhIPtZInAXDM91BmaUMZP
         Q/OyAsRyJLR/wGHFcAQzw0qI/xNLZhlukGCPIhafPwzAy0n9vouUF2OCa42SwYB4Hf+J
         9dXfi/5Xpwn/kmOmZZozEnhO9UThrpYW3eqDjh1Sj/7JqdZlFTm8xC4KII0uDHoiSGNA
         vdLg==
X-Gm-Message-State: AOAM533ImgL4UwmMJFVnuL6EmFV7s5JM0EHAVtS/81PfTxmi0oGWwmP4
        jz7I2YLbf1vgqpgMhY4dq+TGGetZIKV2RTjqMxQ=
X-Google-Smtp-Source: ABdhPJzatNSOJmQ3VXEB9oByXn2fJ56aO3+f9kHsMZ5Xxpvi7azPu+vkugrOOD6X/I3+52PkHwgDYlNwkjK6Ks795hE=
X-Received: by 2002:ab0:6397:: with SMTP id y23mr4782867uao.115.1616531344468;
 Tue, 23 Mar 2021 13:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210323201450.12060-1-oliver.staebler@bytesatwork.ch>
In-Reply-To: <20210323201450.12060-1-oliver.staebler@bytesatwork.ch>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 23 Mar 2021 17:28:53 -0300
Message-ID: <CAOMZO5B_uHS_Z2LuMwHDmn9erORrsrNBMHMjkW-hW+pnfHZThQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mm: Fix pad control of SD1_DATA0
To:     =?UTF-8?Q?Oliver_St=C3=A4bler?= <oliver.staebler@bytesatwork.ch>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

On Tue, Mar 23, 2021 at 5:15 PM Oliver St=C3=A4bler
<oliver.staebler@bytesatwork.ch> wrote:
>
> Fix address of the pad control register
> (IOMUXC_SW_PAD_CTL_PAD_SD1_DATA0) for SD1_DATA0_GPIO2_IO2.  This seems
> to be a typo but it leads to an exception when pinctrl is applied due to
> wrong memory address access.
>
> Signed-off-by: Oliver St=C3=A4bler <oliver.staebler@bytesatwork.ch>

I checked in the RM and your patch is correct, thanks:

Reviewed-by: Fabio Estevam <festevam@gmail.com>

I will send a patch fixing imx8mq-pinfunc.h as it has the same error.
