Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45BBB44A56D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 05:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241480AbhKIECs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 23:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239667AbhKIECq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 23:02:46 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F03CC061764
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 20:00:01 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id g91-20020a9d12e4000000b0055ae68cfc3dso26220158otg.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 20:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eukiySQcktnrCgOs1xDT7v0DSF/3D+JwoCXCinBpii8=;
        b=gSWIbfoKiBJg0LOKG01sJ4sPbPVyubMqUKHRLk4Tp+ZtpVhT7P8nYeQ4sw4Hfq9zMU
         8L6qItibnw49BOIrIhVKjkw6R8uTDgeAgUxy+iEVu5OVj7RUbijhlJYtyY4aZSICSLz/
         VAp3+/r+HRYJ2lzJNDVVZmpXwC14GZjnKovfWUBhWgd96ViSZpcNZAJ36HPrOrYfeONj
         L5ugc6nQ1bJBIRXeybYrwCX7fOo/jzdELhJn9omL5T62TiXE26i3WH9C5sNpS9SWndOi
         p7hQAHMPYtu1YRyUVgcxMbt6nsEpUiNkD+skrln7PeFqtg4O2Bjv4YyxkfpiOlc/J+V2
         sQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eukiySQcktnrCgOs1xDT7v0DSF/3D+JwoCXCinBpii8=;
        b=uIF4fR1AyPe7zV+v0opLDtQoW6IRt5RFDVrZYYSMn+2YBgtomIkJp1s1gl4W2hstRj
         0ksl/GU35MWauKJBaDJp8k780OtwmZvDaN/PiDDX3Ua5WXHWS/qk7rv3kWwXO0GdNU57
         H3B8FDXLW4BBtp820ObRgAAj+22WKftPi3/Gxge2J7prCUMRrdMOOekMw+cMI6hLP3jF
         De2+mlHRvlIHE1O9917sybvOqag89j9w1AImZLmr/759Qwo8oABzHxMfa+omUmIA1aXY
         dZD/W7lbpWOT47sdYvQ94u7A3qFcVTuOPnhX4o+m4wWUVdd6f46hWxFmMmZk+SdA5SGN
         cKhA==
X-Gm-Message-State: AOAM5321YV1WQb3+fQFiHxKpcst1SYYnxWlRaQkYWJk8acXK+OVXwAPP
        CqKVPBCD2yWU2ysnH7zBBkM+QLKsUQoBvlIqkCIbjQ==
X-Google-Smtp-Source: ABdhPJylbstTrfbzBS3XeO4qBW1r5kHdhaSGvCxdMCtJf3Q5h1gVclMDEWUuzgC+APiSWQ5qCmq2IfFSufVNsHBmB14=
X-Received: by 2002:a9d:ed6:: with SMTP id 80mr3352500otj.35.1636430400332;
 Mon, 08 Nov 2021 20:00:00 -0800 (PST)
MIME-Version: 1.0
References: <1635324926-22319-1-git-send-email-wells.lu@sunplus.com> <1635324926-22319-4-git-send-email-wells.lu@sunplus.com>
In-Reply-To: <1635324926-22319-4-git-send-email-wells.lu@sunplus.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Nov 2021 04:59:48 +0100
Message-ID: <CACRpkdaqAtP0rykP2Q25wc+t1Uk2xXYFvcrCdBXyWVRnHNGtGA@mail.gmail.com>
Subject: Re: [PATCH 3/3] devicetree: bindings: pinctrl: Add bindings doc for
 Sunplus SP7021.
To:     Wells Lu <wellslutw@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        qinjian@cqplus1.com, dvorkin@tibbo.com,
        Wells Lu <wells.lu@sunplus.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wells Lu,

thanks for your patch!

On Wed, Oct 27, 2021 at 10:55 AM Wells Lu <wellslutw@gmail.com> wrote:

> +      properties:
> +        pins:
> +          description: |
> +            Define pins which are used by pinctrl node's client device.
> +
> +            It consists of one or more integers which represents the config
> +            setting for corresponding pin. Please use macro SPPCTL_IOPAD to
> +            define the integers for pins.
> +
> +            The first argument of the macro is pin number, the second is pin
> +            type, the third is type of GPIO, the last is default output state
> +            of GPIO.
> +          $ref: /schemas/types.yaml#/definitions/uint32-array
> +
> +        function:
> +          description: |
> +            Define pin-function which is used by pinctrl node's client device.
> +            The name should be one of string in the following enumeration.
> +          $ref: "/schemas/types.yaml#/definitions/string"
> +          enum: [ SPI_FLASH, SPI_FLASH_4BIT, SPI_NAND, CARD0_EMMC, SD_CARD,
> +                  UA0, FPGA_IFX, HDMI_TX, LCDIF, USB0_OTG, USB1_OTG ]
> +
> +        groups:
> +          description: |
> +            Define pin-group in a specified pin-function.
> +            The name should be one of string in the following enumeration.
> +          $ref: "/schemas/types.yaml#/definitions/string"
> +          enum: [ SPI_FLASH1, SPI_FLASH2, SPI_FLASH_4BIT1, SPI_FLASH_4BIT2,
> +                  SPI_NAND, CARD0_EMMC, SD_CARD, UA0, FPGA_IFX, HDMI_TX1,
> +                  HDMI_TX2, HDMI_TX3, LCDIF, USB0_OTG, USB1_OTG ]

Is it possible to use
Documentation/devicetree/bindings/pinctrl/pinmux-node.yaml
for this like other drivers do?

> +        zero_func:
> +          description: |
> +            Disabled pins which are not used by pinctrl node's client device.
> +          $ref: /schemas/types.yaml#/definitions/uint32-array

I have never seen this before. Can't you just use pin control hogs
for this so the pin controller just take care of these pins?

> +      allOf:
> +        - if:
> +            properties:
> +              function:
> +                enum:
> +                  - SPI_FLASH
> +          then:
> +            properties:
> +              groups:
> +                enum:
> +                  - SPI_FLASH1
> +                  - SPI_FLASH2
> +        - if:
> +            properties:
> +              function:
> +                enum:
> +                  - SPI_FLASH_4BIT
> +          then:
> +            properties:
> +              groups:
> +                enum:
> +                  - SPI_FLASH_4BIT1
> +                  - SPI_FLASH_4BIT2
> +        - if:
> +            properties:
> +              function:
> +                enum:
> +                  - SPI_NAND
> +          then:
> +            properties:
> +              groups:
> +                enum:
> +                  - SPI_NAND
> +        - if:
> +            properties:
> +              function:
> +                enum:
> +                  - CARD0_EMMC
> +          then:
> +            properties:
> +              groups:
> +                enum:
> +                  - CARD0_EMMC
> +        - if:
> +            properties:
> +              function:
> +                enum:
> +                  - SD_CARD
> +          then:
> +            properties:
> +              groups:
> +                enum:
> +                  - SD_CARD
> +        - if:
> +            properties:
> +              function:
> +                enum:
> +                  - UA0
> +          then:
> +            properties:
> +              groups:
> +                enum:
> +                  - UA0
> +        - if:
> +            properties:
> +              function:
> +                enum:
> +                  - FPGA_IFX
> +          then:
> +            properties:
> +              groups:
> +                enum:
> +                  - FPGA_IFX
> +        - if:
> +            properties:
> +              function:
> +                enum:
> +                  - HDMI_TX
> +          then:
> +            properties:
> +              groups:
> +                enum:
> +                  - HDMI_TX1
> +                  - HDMI_TX2
> +                  - HDMI_TX3
> +        - if:
> +            properties:
> +              function:
> +                enum:
> +                  - LCDIF
> +          then:
> +            properties:
> +              groups:
> +                enum:
> +                  - LCDIF
> +        - if:
> +            properties:
> +              function:
> +                enum:
> +                  - USB0_OTG
> +          then:
> +            properties:
> +              groups:
> +                enum:
> +                  - USB0_OTG
> +        - if:
> +            properties:
> +              function:
> +                enum:
> +                  - USB1_OTG
> +          then:
> +            properties:
> +              groups:
> +                enum:
> +                  - USB1_OTG

This looks complex to me, I need feedback from bindings people
on this.

> +        pins_uart0: pins_uart0 {
> +            function = "UA0";
> +            groups = "UA0";
> +        };
> +
> +        pins_uart1: pins_uart1 {
> +            pins = <
> +                SPPCTL_IOPAD(11,SPPCTL_PCTL_G_PMUX,MUXF_UA1_TX,0)
> +                SPPCTL_IOPAD(10,SPPCTL_PCTL_G_PMUX,MUXF_UA1_RX,0)
> +                SPPCTL_IOPAD(7,SPPCTL_PCTL_G_GPIO,0,SPPCTL_PCTL_L_OUT)
> +            >;
> +        };

This first looks like two ways to do the same thing?
UART0 uses strings for group + function and uart1 control
individual pins.

Is it possible to just do it one way?

I think the pins = <...> scheme includes also multiplexing settings
and then it should be named pinmux = <...>:

Please read
Documentation/devicetree/bindings/pinctrl/pinmux-node.yaml
closely.

Yours,
Linus Walleij
