Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 005DF432E84
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 08:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234279AbhJSGsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 02:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhJSGsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 02:48:41 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CB7C06161C;
        Mon, 18 Oct 2021 23:46:28 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id j12so11669957qvk.12;
        Mon, 18 Oct 2021 23:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kPpGQ/usuIv6r0JFjkYFCgDGOkeWZxHqy3uYPgIqN/E=;
        b=IzzuT+2lP0r9gPF/tnCzyet81txYZEuBr5EoUfq65UCXmd97IUKjxfSDYaFTsb9dRi
         ERBJQbcImNnmeYDOMJKGvrYchDdOaqywyLjfHETEP1kLLHJHrOcHXrPh4bWXZRan4azb
         SzzXJ2xjgvZjZ/2rHlRvEpVJUWtGBwDSF/94U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kPpGQ/usuIv6r0JFjkYFCgDGOkeWZxHqy3uYPgIqN/E=;
        b=l321O1gvgiPpvvnMeHa06iv33ac7aRarp5NXEXS/Zpwm19Mfpk1TZ1IR2sU0V4GKbQ
         Vu3dZ4GwUrwnUHGfkiqEH6VpbVmHrXOpgrgqLRquMkha1DdNrWRp/Y7lnsQLcQ+e4Gf7
         RXEjdDIW7v72fMs+VggW+zZ3k875x1N3dKZxYI83G6RgfMJeYNrNWCc0Yawf9lWsGfvc
         6skCek3JDa4AlS1zU7B6WWHICte3oV3ymmAPUWGUJ25BApvscC146Dqappll4itjSpvz
         sU7FFp0o+7u6l6LOwlP27dsFM9rhDivCXT7Nxyw3LrCAjI51c64Se/DD+WMT6qgHWOsi
         6bpw==
X-Gm-Message-State: AOAM533prx3ESKsql0GXLX7cqwoMfhi8zkdmJiCGDKTFRLnOK1RZTlEA
        +WXlpU1Mw/421i0HDuCeDpFMNfbT3iPSbMhTrBU=
X-Google-Smtp-Source: ABdhPJwVUsADq1mo1BO5nQp+62iE2cz6mNTV9MKZGvspzkW1xufQZsSlNx1FUVk9bHcWeRidndx81yd4a16pLT2Ymo0=
X-Received: by 2002:ad4:5de9:: with SMTP id jn9mr30214330qvb.41.1634625986385;
 Mon, 18 Oct 2021 23:46:26 -0700 (PDT)
MIME-Version: 1.0
References: <20211019060155.945-1-quan@os.amperecomputing.com> <20211019060155.945-2-quan@os.amperecomputing.com>
In-Reply-To: <20211019060155.945-2-quan@os.amperecomputing.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 19 Oct 2021 06:46:14 +0000
Message-ID: <CACPK8Xcp0ruL-7p3AA+yvba3Drrwm-=-hMnMpd=a1aHwQHnE1A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ARM: dts: aspeed: mtjade: Add some gpios
To:     Quan Nguyen <quan@os.amperecomputing.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Open Source Submission <patches@amperecomputing.com>,
        Phong Vo <phong@os.amperecomputing.com>,
        "Thang Q . Nguyen" <thang@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Oct 2021 at 06:02, Quan Nguyen <quan@os.amperecomputing.com> wrote:
>
> Add S0_SCP_AUTH_FAIL, S1_SCP_AUTH_FAIL gpios to indicates firmware
> authentication fail on each socket.

These use the gpio-keys API to expose the GPIOs. I think OpenBMC is
moving away from this abstraction, and instead reading the GPIOs with
the gpio chardev interface.

>
> Add gpio RTC_BAT_SEN_EN to enable RTC battery adc sensor.
>
> Add BMC_I2C4_O_EN gpio to go high at boot to enable access to I2C4 bus.

OpenBMC has started a process to document GPIOs that are exposed to
userspace, initially so a common userspace can be used across
machines. I like doing it for the additional reason that it provides
consistency in the naming.

https://github.com/openbmc/docs/blob/master/designs/device-tree-gpio-naming.md

If you could take a look at that document and add your GPIOs where
possible, and then update the device tree.

>
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> Signed-off-by: Thang Nguyen <thang@os.amperecomputing.com>
> ---
> v2:
>   - None
>
>  .../arm/boot/dts/aspeed-bmc-ampere-mtjade.dts | 21 ++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
> index 57b0c45a2298..3515d55bd312 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
> @@ -86,6 +86,18 @@ S0_cpu_fault {
>                         linux,code = <ASPEED_GPIO(J, 1)>;
>                 };
>
> +               S0_scp_auth_fail {
> +                       label = "S0_SCP_AUTH_FAIL";
> +                       gpios = <&gpio ASPEED_GPIO(J, 2) GPIO_ACTIVE_LOW>;
> +                       linux,code = <ASPEED_GPIO(J, 2)>;
> +               };
> +
> +               S1_scp_auth_fail {
> +                       label = "S1_SCP_AUTH_FAIL";
> +                       gpios = <&gpio ASPEED_GPIO(Z, 5) GPIO_ACTIVE_LOW>;
> +                       linux,code = <ASPEED_GPIO(Z, 5)>;
> +               };
> +
>                 S1_overtemp {
>                         label = "S1_OVERTEMP";
>                         gpios = <&gpio ASPEED_GPIO(Z, 6) GPIO_ACTIVE_LOW>;
> @@ -590,7 +602,7 @@ &gpio {
>         /*Q0-Q7*/       "","","","","","UID_BUTTON","","",
>         /*R0-R7*/       "","","BMC_EXT_HIGHTEMP_L","OCP_AUX_PWREN",
>                         "OCP_MAIN_PWREN","RESET_BUTTON","","",
> -       /*S0-S7*/       "","","","","","","","",
> +       /*S0-S7*/       "","","","","RTC_BAT_SEN_EN","","","",

I suggest you create a proposal to call this one
battery-voltage-read-enable. I know that some of the IBM machines
intend to have this same GPIO.

>         /*T0-T7*/       "","","","","","","","",
>         /*U0-U7*/       "","","","","","","","",
>         /*V0-V7*/       "","","","","","","","",
> @@ -604,4 +616,11 @@ &gpio {
>                         "S1_BMC_DDR_ADR","","","","",
>         /*AC0-AC7*/     "SYS_PWR_GD","","","","","BMC_READY","SLAVE_PRESENT_L",
>                         "BMC_OCP_PG";
> +
> +       i2c4_o_en {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(Y, 2) GPIO_ACTIVE_HIGH>;
> +               output-high;
> +               line-name = "BMC_I2C4_O_EN";
> +       };
>  };
> --
> 2.28.0
>
