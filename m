Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B7C3617E6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 04:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235340AbhDPC5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 22:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235096AbhDPC5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 22:57:00 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CB8C061574;
        Thu, 15 Apr 2021 19:56:34 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d6so1575098qtx.13;
        Thu, 15 Apr 2021 19:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jnkm67rG/2HcFfj+lsSeDL4hn/hfKuiZIPnLkwTSDlk=;
        b=O+Z3IpOWsKS5ISWSN18gt5XrPXPcHuFe+UtxG5eFnqYsgu5ngJ7gGJTk0UaiAQ0F/e
         OOPRR51hflQzxcuYTf3wOLFCvV8coI0aQjLapQBWS2ADxk622pl+lRdRc26rAF5lT3MY
         v0oC522LX1NDpOOxLY5aO3QAZXv1KC8uWla3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jnkm67rG/2HcFfj+lsSeDL4hn/hfKuiZIPnLkwTSDlk=;
        b=r3Ytu8mg9FBb0TFWspMVwx48ScoJctpv/swwkdXNdsLphgpsmRXK/PDgwMAXBOII8B
         u4zy7Ct3/GY0BbJfeoYUvsoVbxRJNSSVMT98Kuf0hCfjtJAIgPXzFsEe9ocE1n00UAqK
         hnINPaRjQTU0m5qnAY4X6FAJswWtxsSplZE2NY3+wBfgrHG7hPx4HGpsEzmAkNbegM42
         6JZI6v+J2P7VtI5Nz4/ftPe3TXeKnRmNOMkudXQBFg80VI24BTJewZBAYhCpHl0UaZMq
         9A0Kihs17PnAHb1LCsVjxCtQecSZhTk2Sk63aC+G8N1nRFtqJwt6maa7B5Emqcm0uz+C
         KnbQ==
X-Gm-Message-State: AOAM533JE8L2W/VOgujNQgm9qacqbuZeg83IY/BAFuPWBahYrTAMeQE4
        0E/s5caBqeOxMMhnyLeLyiKMuFVHafX0a8QtUvbYeZze
X-Google-Smtp-Source: ABdhPJwFIt3wjYFboTIvXYmV9ErYew+4zrMSmwJwwWeusCEXWE8ryNdMaN8pfdSl/vhlCW6ZUgTbG1XGmasTQrvwkdg=
X-Received: by 2002:a05:622a:d3:: with SMTP id p19mr5901374qtw.385.1618541793208;
 Thu, 15 Apr 2021 19:56:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210415140521.11352-1-fercerpav@gmail.com>
In-Reply-To: <20210415140521.11352-1-fercerpav@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 16 Apr 2021 02:56:21 +0000
Message-ID: <CACPK8Xft_59tCyYnMqx10ZcSnMFZjd1MWCEEr1XYcfX-zMcV=w@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: aspeed: tiogapass: add hotplug controller
To:     Paul Fertser <fercerpav@gmail.com>
Cc:     linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Apr 2021 at 14:05, Paul Fertser <fercerpav@gmail.com> wrote:
>
> The ADM1278 IC is accessible on I2C bus and on both Wiwynn and Quanta
> Tioga Pass implementations a pair of parallel 0.5 mOhm resistors is used
> for current measurement.
>
> Signed-off-by: Paul Fertser <fercerpav@gmail.com>

Thanks, applied.

> ---
>  arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
> index 3cc2004fa2f2..500661956dea 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
> @@ -591,6 +591,11 @@
>  &i2c7 {
>         status = "okay";
>         //HSC, AirMax Conn A
> +       adm1278@0x45 {
> +               compatible = "adm1275";
> +               reg = <0x45>;
> +               shunt-resistor-micro-ohms = <250>;
> +       };
>  };
>
>  &i2c8 {
> --
> 2.17.1
>
