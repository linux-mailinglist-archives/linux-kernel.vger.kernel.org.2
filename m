Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1133D3617DD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 04:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbhDPC4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 22:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234764AbhDPCz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 22:55:59 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E622C061574;
        Thu, 15 Apr 2021 19:55:34 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id o2so6449719qtr.4;
        Thu, 15 Apr 2021 19:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=suL1dnZ+yJPZCMAJ4Juw2WYLXt8ud7bqHuYeTFy760Y=;
        b=F1jVfXS7MPMczBX9Ht5uH8AxLh6pAd5Su23muuHP3C9tVk7MRtPXI147skyXKIFckd
         HgeAOTGile7OpFTWPexrb7eB5snaT1qtUJ+gMaxkGr21L+WGYWxzZgJX4eZY2evI0o5W
         aOC6o8X4Cva6IL3DucjUIGuXdKTiSz0qLWd5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=suL1dnZ+yJPZCMAJ4Juw2WYLXt8ud7bqHuYeTFy760Y=;
        b=LE7JaVjmc+55afEyYTOKp8wFlbsZE38NnbirKB0LrTp1y3KQlzEhLQhNlcdhm68lDO
         LKS/rxay2GLYDVGUVATF8fxWfwj4AbpGtGEebZHHAPIhB/AcWNX1MJQ59kQzyMWSTFRg
         hfw5rngB5vzmpHLTytKQ2STcoNUSjEV66LbwR7VGhoU4Xe/1fyuj+dABlmUWxX0CwGpe
         p1XQQwZtltZqLbJEYm0zuH+xH56rbEKHbGRZQkcQoFLRdQloiY0SatAoFjLa/T4wqZ4B
         /6lVBCY1QQIcvf0gmsUNfVNnFFWWUj87NxJ7CwzOQzU092HkPrVJd3PHwKRjILdfRIKl
         muDg==
X-Gm-Message-State: AOAM5336yYc+gWLZjeATHl/bm6LKRfqgpc3EqFFpmxEAfPyJfvbWM+1j
        yns9xdmnyImlpJG68qSxFItkgMWq7DTI/Ot5WPk=
X-Google-Smtp-Source: ABdhPJwBl5oTwfqjVBgI2UrXXXs/eahKVwoG8bPYGUxhDqljBmSbkoivKoCvbd1/Rw62YcXC9b2FklRA4+mF8+pB6fI=
X-Received: by 2002:a05:622a:589:: with SMTP id c9mr5979265qtb.363.1618541733396;
 Thu, 15 Apr 2021 19:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210415155300.1135-1-aladyshev22@gmail.com>
In-Reply-To: <20210415155300.1135-1-aladyshev22@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 16 Apr 2021 02:55:17 +0000
Message-ID: <CACPK8XedxKUpgtXCzsmdHw7-U+ySzHmvvb8mGE8QJcxQrEMayg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed: amd-ethanolx: Enable all used I2C busses
To:     Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     Supreeth Venkatesh <supreeth.venkatesh@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Apr 2021 at 15:53, Konstantin Aladyshev
<aladyshev22@gmail.com> wrote:
>
> Enable all I2C busses that are used in AMD EthanolX CRB:
>  i2c0 - APML P0
>  i2c1 - APML P1
>  i2c2 - FPGA
>  i2c3 - 24LC128 EEPROM
>  i2c4 - P0 Power regulators
>  i2c5 - P1 Power regulators
>  i2c6 - P0/P1 Thermal diode
>  i2c7 - Thermal Sensors
>  i2c8 - BMC I2C
>
> Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>

Thanks, applied.

> ---
>  arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> index ac2d04cfaf2f..6aeb47c44eba 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> @@ -151,6 +151,31 @@ &i2c1 {
>         status = "okay";
>  };
>
> +//FPGA
> +&i2c2 {
> +       status = "okay";
> +};
> +
> +//24LC128 EEPROM
> +&i2c3 {
> +       status = "okay";
> +};
> +
> +//P0 Power regulators
> +&i2c4 {
> +       status = "okay";
> +};
> +
> +//P1 Power regulators
> +&i2c5 {
> +       status = "okay";
> +};
> +
> +//P0/P1 Thermal diode
> +&i2c6 {
> +       status = "okay";
> +};
> +
>  // Thermal Sensors
>  &i2c7 {
>         status = "okay";
> @@ -196,6 +221,11 @@ lm75a@4f {
>         };
>  };
>
> +//BMC I2C
> +&i2c8 {
> +       status = "okay";
> +};
> +
>  &kcs1 {
>         status = "okay";
>         aspeed,lpc-io-reg = <0x60>;
> --
> 2.25.1
>
