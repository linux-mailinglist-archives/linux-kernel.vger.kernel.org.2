Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B33743452D6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 00:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhCVXMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 19:12:53 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:45912 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbhCVXMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 19:12:20 -0400
Received: by mail-oi1-f174.google.com with SMTP id d12so14951401oiw.12;
        Mon, 22 Mar 2021 16:12:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=McQT4s4j4Lcn3Ti7MbeKUQbdrUGlmk29d7hOHsI/ts0=;
        b=lhwKYsR/eKSewzvsyqNWVxsnAYgo3Ado9f2V1yqTzn6aDwYrglvIPVxmDb9ydh6gQm
         2c7rDQAK8pA1Sh1D0/WVVZCQQjHZZ7nutTl82bZZCbx7Z1tF/CtGLEVkl3CludJ2iyYi
         1kGPwQlIJGCt8DOYAjyYOPw7rOHNRRVdqpLA5vhi9CWl4L8tTqq0Z5jE7pzUa3z1pdQf
         LM03iorCaWnQ5VH2g4HQ3yz1Rk36xt7umW6z/KXZjDQdPUzphnpTXBWnlRT9Utajuhhd
         EgijnD0+eAQektSmT7prTg6Liv1YM6r+3kb6F8QBS6Bo+20M96O7gwLS506EAS0A/vOm
         yJBQ==
X-Gm-Message-State: AOAM532Fo+6iHamJRnBIU3L2BKicdL7M5ZeJ/eXAGGUfMyoCkSGehNrh
        cXB5XzT+xTmb+EKFtyygwABBlfDdovg=
X-Google-Smtp-Source: ABdhPJxPt5TwswTrvlJO6XxM4Tpe3zdnqW/9eFPTjO90E4sAAuGkVTWYB7wZck6o23Zvb5PAMTe5EA==
X-Received: by 2002:aca:ab86:: with SMTP id u128mr1040692oie.47.1616454739781;
        Mon, 22 Mar 2021 16:12:19 -0700 (PDT)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com. [209.85.210.43])
        by smtp.gmail.com with ESMTPSA id h59sm3818999otb.29.2021.03.22.16.12.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 16:12:19 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id 31-20020a9d00220000b02901b64b9b50b1so17660372ota.9;
        Mon, 22 Mar 2021 16:12:18 -0700 (PDT)
X-Received: by 2002:a05:6830:2043:: with SMTP id f3mr1853763otp.63.1616454738360;
 Mon, 22 Mar 2021 16:12:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210318083438.26536-1-michael@walle.cc>
In-Reply-To: <20210318083438.26536-1-michael@walle.cc>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Mon, 22 Mar 2021 18:12:06 -0500
X-Gmail-Original-Message-ID: <CADRPPNR=xy_oBZFS+hmO1k+uu2ckFyrK9EUP77N3buU5XpuHrw@mail.gmail.com>
Message-ID: <CADRPPNR=xy_oBZFS+hmO1k+uu2ckFyrK9EUP77N3buU5XpuHrw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: ls1028a: fix optee node
To:     Michael Walle <michael@walle.cc>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sahil Malhotra <sahil.malhotra@nxp.com>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        "kernelci.org bot" <bot@kernelci.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 3:36 AM Michael Walle <michael@walle.cc> wrote:
>
> Don't enable the optee node in the SoC include. It is an optional
> component and actually, if enabled, breaks boards which doesn't have it.

Hi Shawn,

Shall we make this a general rule?  I see quite a few SoC dtsi files
are having the optee node enabled by default.

Regards,
Leo

>
> This reverts commit 48787485f8de ("arm64: dts: ls1028a: enable optee
> node") and enables the node per board, assuming the intend of the
> original author was to enable OPTEE for the LS1028A-RDB and the
> LS1028A-QDS.
>
> Fixes: 48787485f8de ("arm64: dts: ls1028a: enable optee node")
> Reported-by: Guillaume Tucker <guillaume.tucker@collabora.com>
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Tested-by: Michael Walle <michael@walle.cc>
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts | 4 ++++
>  arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 4 ++++
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi    | 3 ++-
>  3 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> index fbcba9cb8503..060d3c79244d 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> @@ -327,6 +327,10 @@
>         status = "okay";
>  };
>
> +&optee {
> +       status = "okay";
> +};
> +
>  &sai1 {
>         status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> index 41ae6e7675ba..1bdf0104d492 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> @@ -274,6 +274,10 @@
>         status = "okay";
>  };
>
> +&optee {
> +       status = "okay";
> +};
> +
>  &sai4 {
>         status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index 50d277eb2a54..e2007ebacd69 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -92,9 +92,10 @@
>         };
>
>         firmware {
> -               optee {
> +               optee: optee {
>                         compatible = "linaro,optee-tz";
>                         method = "smc";
> +                       status = "disabled";
>                 };
>         };
>
> --
> 2.20.1
>
