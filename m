Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90421445F03
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 05:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhKEEHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 00:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhKEEHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 00:07:45 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BC9C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 21:05:06 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id i13so6681047qvm.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 21:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hOpqec9HAj9jc/h7EYjL2E/xFemoSEaVzq55rh5h1G0=;
        b=b2i5CsEmawrSp4+08EqRBkecvPNVR4RFKQpGU+0Xf9aHlg/iULVccpTMYT3/fxZUdO
         RYbQ+GQ/SzrwAAd5mNxwzunTf5QJBAclDgGGX6Yjemfz3hgwpoyIR+Ak6bqa9jWZI/w8
         6N0fSSQqaB5Wbkfn9TmARxFrBBiWszl/2RmNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hOpqec9HAj9jc/h7EYjL2E/xFemoSEaVzq55rh5h1G0=;
        b=3IY8w8zUmQ1nTOA2+5smV0uE1+j3thp9quCCNlGm5syAL3UdSFr2hTc0s5AbBtiPHD
         PCZtliZ8T3ELR3k3/diYVKDrzi0I+C7IFHNd8OiYxlwU7Z8dEk9Zoqw6m+CFE+5txEn9
         SPx2Xymg1uPi4jY3HkNDgjmoFWsXbkXYurEjvs2i4FRoOB6kSbHyaLLCet14kN/lcaiQ
         QaArh5APt/rzRC9yRapg7bo61TuqO+rD2HMeTCt5Bf4DYY1uUHkh99SDEIXtpgCgPwXe
         NIrLkCdxwlNzRleUKhZsUvQOUK5Ae1n0X67ld50x9AeIrneo/hCsrwD/DJFrLFVwyTIA
         qbmg==
X-Gm-Message-State: AOAM530cci4PxS+g9ULnR6sJwJyrqZHeZnb4uX124yWNugIei+BCVQsL
        GZpgvVDKJa/Vo1NRqD6/mh6Wsmhm8NTkTXI/zSs=
X-Google-Smtp-Source: ABdhPJwnces3XhrDwJCHcodu8Tn5LZ7tc0hq7XiLObCwHwZeJEuNgABrBIX1YSlCefqP2MTsmdykYniAn3Xcchnm9bk=
X-Received: by 2002:a05:6214:f2d:: with SMTP id iw13mr4449053qvb.13.1636085105549;
 Thu, 04 Nov 2021 21:05:05 -0700 (PDT)
MIME-Version: 1.0
References: <20211105032910.446492-1-osk@google.com>
In-Reply-To: <20211105032910.446492-1-osk@google.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 5 Nov 2021 04:04:53 +0000
Message-ID: <CACPK8Xc7SAVamBrCgptiWgV7r52ysrWjtRCkOmgKu_5AWPrG9w@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: dts: aspeed: tyan-s7106: Update nct7802 config
To:     Oskar Senft <osk@google.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Nov 2021 at 03:29, Oskar Senft <osk@google.com> wrote:
>
> This change updates the configuration for the nct7802 hardware
> monitor to correctly configure its temperature sensors.
>
> Signed-off-by: Oskar Senft <osk@google.com>

Thanks, applied.


> ---
> Changes from PATCH v2:
> - Add missing address-cells, size-cells configuration.
> - Add missing new line between channel 0 and 1.
>
> Changes from PATCH v1:
> - Removed superfluous "status" from channels.
> ---
>  arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts | 24 +++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts b/arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts
> index 68f332ee1886..60ac6d3f03b5 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts
> @@ -213,6 +213,30 @@ &i2c0 {
>         nct7802@28 {
>                 compatible = "nuvoton,nct7802";
>                 reg = <0x28>;
> +
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               channel@0 { /* LTD */
> +                       reg = <0>;
> +               };
> +
> +               channel@1 { /* RTD1 */
> +                       reg = <1>;
> +                       sensor-type = "temperature";
> +                       temperature-mode = "thermistor";
> +               };
> +
> +               channel@2 { /* RTD2 */
> +                       reg = <2>;
> +                       sensor-type = "temperature";
> +                       temperature-mode = "thermistor";
> +               };
> +
> +               channel@3 { /* RTD3 */
> +                       reg = <3>;
> +                       sensor-type = "temperature";
> +               };
>         };
>
>         /* Also connected to:
> --
> 2.34.0.rc0.344.g81b53c2807-goog
>
