Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90053B8CB1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 05:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbhGADnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 23:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhGADnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 23:43:16 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAFCC061756;
        Wed, 30 Jun 2021 20:40:45 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id v17so2271343qvw.12;
        Wed, 30 Jun 2021 20:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4KzjvxraLHkUL6R1pcfOnqYkrW7Z0FdLZP/xq4dd/Y0=;
        b=dlYhx9E99duCm0NaB/kWcOwhqCGzKn4RnKcOmg6LnkaTrQSWwnh5hiGs7AeTlYDmQY
         Wu95jIzmVAqLiJ5EeuQdeURZCO7kRkO2xYvhyKtB/yUQ0lQyZejvw/hsguY8L+umYxI+
         rK1KKE4emsqDUAu1hDycmWiTja/lMiLEwgtcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4KzjvxraLHkUL6R1pcfOnqYkrW7Z0FdLZP/xq4dd/Y0=;
        b=Wkldgs/p0LwNj/cziB82HGsknmx21g5rkWp5Tz3AVvQC7VukD/1DzfUN+75H8p/ii/
         sAiCdvN3rNI0pDJ5AoqFof8k9RBoR8nV+WPWzW1KlueOysiP6dwg2DVQWdU+2qpNNkr+
         OcFBdjI2iJO8sZoMpkRda1qMG81O+6plxKa0WkVHdHWOltxNVSw2c5NjHManx9ftT693
         kjGAXR+PUHdBz96G2Pnw2avEhn/sI8YS6sNwrxJcH1wOL7WBmuCa5jNB/+9koMHvCIiK
         k/3x7RBeRRqRLDalMQVlyhmvzlbgpihsmSS6Up7bhffeJqvdWZreuUnuLmgD032MLQtZ
         t61g==
X-Gm-Message-State: AOAM531Hjr0MZYAyEorKhDave2TG/ORAG9AK598C73lso9njCW55jp5n
        94Wb2P317/NSyb37G9Ua1zFwk35ZMTHcfuj2vzw=
X-Google-Smtp-Source: ABdhPJxlwHAuvRqiX7FJucBQnUlJorGW5k5hBXv34Umx0R+6lHLkQ/CjjMPAF7JNAttwGM1syLRKCAOFGvlh3gI4ybk=
X-Received: by 2002:ad4:48d1:: with SMTP id v17mr40319626qvx.16.1625110844609;
 Wed, 30 Jun 2021 20:40:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210625061017.1149942-1-andrew@aj.id.au>
In-Reply-To: <20210625061017.1149942-1-andrew@aj.id.au>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 1 Jul 2021 03:40:32 +0000
Message-ID: <CACPK8Xd9tsMJaQ9BQSGL0Vfi4UpJ1iuOtMVmfKneydd-zYBhsw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: tacoma: Add phase corrections for eMMC
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Rob Herring <robh+dt@kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jun 2021 at 06:10, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> The degree values were reversed out from the magic tap values of 7 (in)
> and 15 + inversion (out) initially suggested by Aspeed.
>
> With the patch tacoma survives several gigabytes of reads and writes
> using dd while without it locks up randomly during the boot process.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Thanks for the fix. Is this required due to "mmc: sdhci-of-aspeed: Add
AST2600 bus clock support" or "mmc: sdhci-of-aspeed: Expose clock
phase controls"?

On the topic of those patches, it would be good if we could operate
the devices (with the slower speed?) when the device tree does not
provide the phase values. Think about system bringup, or where you
need the system booting in order to determine the phase calculations.

What changes would be required to the host driver for it to work out of the box?


> ---
>  arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
> index c1478d2db602..670080bb80eb 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
> @@ -189,6 +189,7 @@ &emmc_controller {
>
>  &emmc {
>         status = "okay";
> +       clk-phase-mmc-hs200 = <36>, <270>;
>  };
>
>  &fsim0 {
> --
> 2.30.2
>
