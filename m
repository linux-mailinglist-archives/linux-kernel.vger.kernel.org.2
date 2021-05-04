Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C447372BDF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 16:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbhEDOUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 10:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbhEDOUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 10:20:08 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9454CC061574;
        Tue,  4 May 2021 07:19:13 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id k127so8623066qkc.6;
        Tue, 04 May 2021 07:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:from:to:cc
         :subject:references:in-reply-to;
        bh=2v+PY/DAMA8vmNn3TQ91BPzBhWhF+ZptksoCplGwUkY=;
        b=k9yxjde5Zhy2Nx3fhzIfcXJrAJRjBKOY2SNJrfAmVkrteFQmEPmbtZOo3CiYFglUu2
         PGRxpAAOeslqTIcMOwvaEu0xBg9Icmfo8D/eI/01LUHoz+npy/NDfEaU3lvi3lQEVkJm
         BWabGq6/a7h6AALjWlISalSRlpQEW5+aqGxLD/nNqM8qxgimWJ7I42G6AJ+x0YKtAs2p
         mhxU4l+1f/12KV1ZnuCqX7zoSoZfHDsNxH3hr9bM/XRSy8bl1apKlM6cVdFtqBuqo/2z
         RNrhl5LyLUqLPqsl79B+PzlMHXoLVaKHUL8jow/GuMuEpgTox+MCsFHgkHPNiiB0dAby
         glqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:from:to:cc:subject:references:in-reply-to;
        bh=2v+PY/DAMA8vmNn3TQ91BPzBhWhF+ZptksoCplGwUkY=;
        b=lFvjvVsUxxI41bqCafXpHHJHUcI1Z46uou86z84Q5NYHhE83gGMXXnSlgVocn7wtMi
         E0CQVwr6VYtxI95kJfjH/maQZD64WL8FwmyvVJaVEeGkXWV/0/lt6sGjtsmw5hqMU9mv
         GyW9I+HWMi8uMWiQQf3aK4dzlPSqpV68ejZFl2jfuPbiwH+bnIyOxhHzQE5fW6QAwv9T
         Lxi2C4/Woz/TtcwzAZL864OW/af0JE6b1vjmwRuaqvhe7Op7eOhaqN5Sl0NABdjkCWFY
         vVrxyGcEofAi62BDsmkqEq700kZkfIPqNiTvf57vBCDhYfAJ8WwI0OhkxWrH8IMohLcZ
         1ohQ==
X-Gm-Message-State: AOAM532sB0IEHxbw/PuMX4lfUVNVoJu/S3/eBhXmzAPtC3RxwBU/pJty
        lEmhP3v0AWmtuqFvGGeembY=
X-Google-Smtp-Source: ABdhPJw2wUPWLyMxgXKRCzMrKl4BPGyIYq8EVs3xGCwGIJZhOpOmI7bc24cvpu6lBFMTZqUSTEXrug==
X-Received: by 2002:a37:e94:: with SMTP id 142mr24864109qko.49.1620137952871;
        Tue, 04 May 2021 07:19:12 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id s25sm10574790qkj.34.2021.05.04.07.19.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 07:19:11 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 04 May 2021 10:19:10 -0400
Message-Id: <CB4IYZR8TSJ5.3UUOMXJHTHYD4@shaak>
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Liam Beguin" <liambeguin@gmail.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>
Cc:     <julia.lawall@inria.fr>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>
Subject: Re: [PATCH v5 0/3] add support for the lmk04832
References: <20210423004057.283926-1-liambeguin@gmail.com>
In-Reply-To: <20210423004057.283926-1-liambeguin@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Apr 22, 2021 at 8:40 PM EDT, Liam Beguin wrote:
> From: Liam Beguin <lvb@xiphos.com>
>
> Hi,
>
> The LMK04832 is an ultra-high performance clock conditioner with JEDEC
> JESD204B support and is also pin compatible with the LMK0482x family of
> devices.
>
> This driver adds initial support to configure the LMK04832 clocks using
> the clock framework.
>
> This has been tested on a system using JESD204B subclass 1.
>
> At the moment, the VCO rate has to be set manually from the devicetree
> and a dclk (or sclk) rate change isn't propagated to the VCO
> automatically.
>
> Changes since v1:
> - add yaml devicetree documentation,
> - add links to datasheet,
> - use {u8,u16,u32} instead of Uint_ variants,
> - drop redundant debugfs code,
> - use a pointer to device_info instead of struct copy,
> - add of_device_id table,
> - add support for SYSREF digital delay and JESD204B subclass 1
>
> Changes since v2:
> - fix dt-bindings documentation, apologies for the broken build
> - fix property vendor prefixes
> - split dt-bindings into a separate patch
>
> Changes since v3:
> - add missing properties in dt-bindings
>
> Changes since v3:
> - address coccicheck comments
> - update dt-bindings
>

Hi Stephen,

Did you get a chance to have another look at this?

Thanks,
Liam

>
> Thanks for your time,
> Liam
>
> Liam Beguin (3):
> clk: add support for the lmk04832
> clk: lmk04832: add support for digital delay
> dt-bindings: clock: add ti,lmk04832 bindings
>
> .../bindings/clock/ti,lmk04832.yaml | 209 +++
> drivers/clk/Kconfig | 7 +
> drivers/clk/Makefile | 1 +
> drivers/clk/clk-lmk04832.c | 1596 +++++++++++++++++
> 4 files changed, 1813 insertions(+)
> create mode 100644
> Documentation/devicetree/bindings/clock/ti,lmk04832.yaml
> create mode 100644 drivers/clk/clk-lmk04832.c
>
> Range-diff against v4:
> 1: cb6a8ea514d8 ! 1: 11461912b3c4 clk: add support for the lmk04832
> @@ drivers/clk/clk-lmk04832.c (new)
> + if (ret) {
> + dev_err(lmk->dev, "missing reg property in child: %s\n",
> + child->full_name);
> ++ of_node_put(child);
> + goto err_disable_oscin;
> + }
> +
> @@ drivers/clk/clk-lmk04832.c (new)
> +
> + lmk->clkout[reg].sysref =3D
> + of_property_read_bool(child, "ti,clkout-sysref");
> -+ };
> ++ }
> +
> + lmk->regmap =3D devm_regmap_init_spi(spi, &regmap_config);
> + if (IS_ERR(lmk->regmap)) {
> 2: 8464eac02aab =3D 2: 01b64b5af4ed clk: lmk04832: add support for digita=
l
> delay
> 3: a2c4e8d53d1c ! 3: 96b514765de0 dt-bindings: clock: add ti,lmk04832
> bindings
> @@ Documentation/devicetree/bindings/clock/ti,lmk04832.yaml (new)
> + const: 1
> +
> + spi-max-frequency:
> -+ $ref: /schemas/types.yaml#/definitions/uint32
> -+ description:
> -+ Maximum SPI clocking speed of the device in Hz.
> ++ maximum: 5000000
> +
> + clocks:
> + items:
> @@ Documentation/devicetree/bindings/clock/ti,lmk04832.yaml (new)
> + required:
> + - reg
> +
> ++ additionalProperties: false
> ++
> +required:
> + - compatible
> + - reg
>
> base-commit: f40ddce88593482919761f74910f42f4b84c004b
> --
> 2.30.1.489.g328c10930387

