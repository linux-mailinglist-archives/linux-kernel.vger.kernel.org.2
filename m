Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC684529F3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 06:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235893AbhKPFoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 00:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235814AbhKPFof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 00:44:35 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D90C0432DC;
        Mon, 15 Nov 2021 19:08:00 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id j9so12777276qvm.10;
        Mon, 15 Nov 2021 19:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p+3tuhUNj0IibcDWormquB6v06wUV9mYHE56GduUS2M=;
        b=HX+WlerYmiz45dfnhbTRz6BP49luNrI3xPfvXAYTA5J893Cp1bgpgD2R5O7ilpXhW2
         Ztmg7mlqRhJkIkuQm++MMxicg1qvpkbTGvPIau+qkbupjPVIfVYoLwIHU9tvFf/5pFBG
         WgEPgLF0Bhivdt+M0+t9VJ0AkIctplBmfJFqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p+3tuhUNj0IibcDWormquB6v06wUV9mYHE56GduUS2M=;
        b=7dtxP5vuKu59JSm6ya1MfYPZqHFPyi6DLYUKqB532eM578jJyqda5f8TRlc55spldx
         HFw/Er0VDuIhzE2Z88u5BD0AbIX4goyAE54WrDL5cjmCZNPuwpyeoy45bHJ8rlaVMb9Y
         uyOLHR0IBbwtBQWBBp9FCzkapKvGSp73JDwGNF4NpWT05SB1NosIoR6ab1HrmzVdGBtd
         WJkCAgo97h6rIr1+rMYM5BWI1kV0rIINAwt89gXftIy/tyOpWFECHrwhXFfMWW/ndwah
         f4kGcCJ+Un5+o5BrI3Vk4WUdRXfFfn+iErRLNMyiV8fPOTe2iPyGJuue5qDM/a5QHZkt
         EDfg==
X-Gm-Message-State: AOAM533MVJsd0gHA/2TUh36DUClaQaooJEf+B27XFq6q2YdkUIDc24HJ
        wqt2XSrY8t6ci9Wbx5QYcxH2ayQ8TsjV7xcRmrs=
X-Google-Smtp-Source: ABdhPJxVHar3OL/4LwNLEgzkuKc1H5RS71UlqygRtUVrY8OEkV+Kz3DE/kgpDDzrS8wn8JXdXAJ7KIukSIeqLNgOs0g=
X-Received: by 2002:a05:6214:e41:: with SMTP id o1mr42634802qvc.43.1637032080033;
 Mon, 15 Nov 2021 19:08:00 -0800 (PST)
MIME-Version: 1.0
References: <20211110062656.3041994-1-howard.chiu@quantatw.com>
In-Reply-To: <20211110062656.3041994-1-howard.chiu@quantatw.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 16 Nov 2021 03:07:48 +0000
Message-ID: <CACPK8Xc6wV4KbMAT_ekyMTTbfNqx2ox_d7mEFGVT4OvBDDadBQ@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: aspeed: Adding Facebook Bletchley BMC
To:     Howard Chiu <howard10703049@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Howard Chiu <howard.chiu@quantatw.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Howard,

On Wed, 10 Nov 2021 at 06:29, Howard Chiu <howard10703049@gmail.com> wrote:
>
> Initial introduction of Facebook Bletchley equipped with
> Aspeed 2600 BMC SoC.
>
> Signed-off-by: Howard Chiu <howard.chiu@quantatw.com>
> ---

Please use this area to document the differences between versions of
your patch. Let us know what you've fixed, and what you've decided not
to change based on review.

> +&uart5 {
> +       // Workaround for A0
> +       compatible = "snps,dw-apb-uart";
> +};

Are you still using a0 boards?

> +
> +&i2c0 {
> +       status = "okay";
> +       /* TODO: Add HSC MP5023 */
> +       /* TODO: Add ADC INA230 */
> +
> +       tmp421@4f {
> +               compatible = "ti,tmp421";
> +               reg = <0x4f>;
> +       };
> +
> +       sled0_ioexp: pca9539@76 {
> +               compatible = "nxp,pca9539";
> +               reg = <0x76>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               gpio-line-names =
> +               "","SLED0_BMC_CCG5_INT","SLED0_INA230_ALERT","SLED0_P12V_STBY_ALERT",
> +               "SLED0_SSD_ALERT","SLED0_MS_DETECT","SLED0_MD_REF_PWM","",
> +               "SLED0_MD_STBY_RESET","SLED0_MD_IOEXP_EN_FAULT","SLED0_MD_DIR","SLED0_MD_DECAY",
> +               "SLED0_MD_MODE1","SLED0_MD_MODE2","SLED0_MD_MODE3","SLED0_AC_PWR_EN";

I'll wait for Patrick's review on these. I would prefer you follow the
openbmc naming scheme that he mentioned in v1 of your patch.

> +
> +               gpio@0 {
> +                       reg = <0>;
> +               };

I think this is incorrect, you would need to specify:

type = <PCA955X_TYPE_GPIO>

However with this change, there's no need to specify the individual gpio nodes:

https://lore.kernel.org/all/20210921043936.468001-2-andrew@aj.id.au/


> +
> +&i2c4 {
> +       status = "okay";
> +       /* TODO: Add HSC MP5023 */
> +       /* TODO: Add ADC INA230 */
> +
> +       tmp421@4f {
> +               compatible = "ti,tmp421";
> +               reg = <0x4f>;
> +       };
> +
> +       sled4_ioexp: pca9539@76 {
> +               compatible = "nxp,pca9539";
> +               reg = <0x76>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               gpio-line-names =
> +               "","SLED4_BMC_CCG5_INT","SLED4_INA230_ALERT","SLED4_P12V_STBY_ALERT",
> +               "SLED4_SSD_ALERT","SLED4_MS_DETECT","SLED4_MD_REF_PWM","",
> +               "SLED4_MD_STBY_RESET","SLED4_MD_IOEXP_EN_FAULT","SLED4_MD_DIR","SLED4_MD_DECAY",
> +               "SLED4_MD_MODE1","SLED4_MD_MODE2","SLED4_MD_MODE3","SLED4_AC_PWR_EN";

As Patrick mentioned, I think we want to have a convention for
multi-node machines in the GPIO naming.
