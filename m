Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF114502CF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 11:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbhKOKx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 05:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbhKOKxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 05:53:53 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B2BC061767
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 02:50:58 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id g14so69871671edz.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 02:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uby7LO9dL88mrbNcNOuehqU8c8tZrroU3ttW6LQ5FA4=;
        b=pgWl6ipxSbsjyFtgANj5lwVnsFOLDk87zFIoP42y5MSD5OPRJqQ2MW6VSfYeWolGS7
         +r9wvE/OowwWha9JQKUPRDWZ+ahv+V1F57CI9DVSKvwMPed2kx5sT8GoV2ST/VlcWQsm
         bqDl+Erl+zKADgiDgnYIIFocudmTNfiCJ+ZMlAJhLZk7CCFiAnWFClvSiIGNo6Eya2hY
         nRuRTMWIN0OgqeZDSOQFEIwn3k05+q8LAzoqz0ng+4PfqQ5SUXxj+x9VCMoesh3W1++1
         zwXAeCgWj2pDAg/7Q9YbsWvObJPP9ntphK/+j/bdeknijuhDIQrRHWuijhSodG5tvGiw
         dpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uby7LO9dL88mrbNcNOuehqU8c8tZrroU3ttW6LQ5FA4=;
        b=wq71iPpVDokQI3q700w6NmXwlihNTM7srj7kXQZBscF9xlEz+02MjmbYQCDSBEDvWb
         lXUdplTwVUMwvmyYdQx03LJblwEzD0sX+/s+5ugciOJlDSssIRzggwMSry8zwdXTxNT7
         WWNq3mAB46fyq6b3GrZzZjGeH3D6TvsRvF3q9vUas3xEMDsdDoVgW1hDd6goYzqx1t9q
         X6tAQWo0sGBcf7BJbQS3KJkvWEEF9Sb+ltge82ih3SZMCmP+YpJlP6/6aa1Ogxi8TNJM
         kM2KmsIBaleWk7k44KF3NZdRz+gQhOehtRqHI+ziIh9Be6PEHxXQjjILSq5xCksv0VTV
         07wg==
X-Gm-Message-State: AOAM531vM/s4ZIUlYTewvQT9MWB8JiPggRTKpxLDkOlKO0WcLVvwjHLt
        0FFTtIvd7lKWeX/0xCNDG1B56hnL+UHsnCjgK+RjfQ==
X-Google-Smtp-Source: ABdhPJyVHSR9lRk3LOcNxNeMeyuyUFb/qift9UIm/qJKFrFEmzZIOKhLRAIkkmIlJQmaX668BadzUikFj4Veoa4DoEE=
X-Received: by 2002:a17:907:3e9a:: with SMTP id hs26mr49241448ejc.433.1636973456861;
 Mon, 15 Nov 2021 02:50:56 -0800 (PST)
MIME-Version: 1.0
References: <20211112071858.3641788-1-peng.fan@oss.nxp.com>
In-Reply-To: <20211112071858.3641788-1-peng.fan@oss.nxp.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 15 Nov 2021 11:50:45 +0100
Message-ID: <CAMRc=McEBD5K+btkNHLn1yA9XecTGk5_B1q=MhHVCXcqEX47pA@mail.gmail.com>
Subject: Re: [PATCH V4] dt-bindings: gpio: gpio-vf610: Add imx8ulp compatible string
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, stefan@agner.ch,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Rob Herring <robh@kernel.org>, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 8:20 AM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Jacky Bai <ping.bai@nxp.com>
>
> Add the compatible string for i.MX8ULP.
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>
>  - v4 changes:
>    no, just resend this patch as a single one
>
>  - v3 changes:
>    no
>
>  - v2 changes:
>    no
>
>  Documentation/devicetree/bindings/gpio/gpio-vf610.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml b/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
> index 19738a457a58..e1359391d3a4 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
> +++ b/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
> @@ -24,6 +24,9 @@ properties:
>        - items:
>            - const: fsl,imx7ulp-gpio
>            - const: fsl,vf610-gpio
> +      - items:
> +          - const: fsl,imx8ulp-gpio
> +          - const: fsl,imx7ulp-gpio
>
>    reg:
>      description: The first reg tuple represents the PORT module, the second tuple
> --
> 2.25.1
>

Applied, thanks!

Bart
