Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3583445BF9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 23:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbhKDWGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 18:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbhKDWGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 18:06:30 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EAFC061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 15:03:52 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id h17so3253609qtx.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 15:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KNYXs3xofIWr/n4uvu7HATHQ9F6yoONlFhMGAxuRQ3I=;
        b=PWKl2kBL5Tl29ZxXsl9mUoreSxvUbe+atVYc8CmRBrgQnKhwaWZokyaqUdC/EkEPeM
         8r84XNBPuNEcfdwzE4G4Q/HDRj5QgyY6qnnlFnN+QWlZQ8ts3CJ0B2zSqEF+AouFe1XR
         slCcxgMKvlKo7H7vwjlsY03mKqlwcqbgLNyUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KNYXs3xofIWr/n4uvu7HATHQ9F6yoONlFhMGAxuRQ3I=;
        b=BIuvHSgm4gxnwE0CGGTbMnAJOqGXBn0+sajJbqkymARFMHYFbwE09Rmx/PRwgz+H/U
         BNO0wV4VBWgYWavMq+s2OjhKpIpn3YwltDm5FU7HBcI/Tepdj0LByQP2UtDaKD9jipWb
         qm8ML0f1D5LyGTprsiGgPTHyY/Pm/pBtfLy1JJtnpFUgi1Rn6k28+b94XO4yyycvKTIS
         3h4Tpf+Q5jqpdmoljc6oZtBL1Qm0hcJfiLp+4xHO4jy+VF/vo/82dEVhHd+xZVVJUN5F
         0zhnDwp48S/EZAMglwWWVKpUmdzsrwZcBcF6Wc1d3m2Y+1qNm2LN+Oo2PEH/9sl9JvWB
         Feow==
X-Gm-Message-State: AOAM5327CKMIA9/jUPtZGFst3oVEb9BcOEqHLvPgcMXYwPl6LOCvqyic
        e6N5k5E/vv1xbAmTqGcNO37NVvG1IDiDlkYNe9U=
X-Google-Smtp-Source: ABdhPJxJvYt5Sl8+H/gw91CKZ4Snqr35ZHf2GBtcwpS+mvMXqZaezIcTEFCeNYsnXrh/fVaVupCJcPkrLo8gmd1MWeA=
X-Received: by 2002:a05:622a:1450:: with SMTP id v16mr46628365qtx.25.1636063429981;
 Thu, 04 Nov 2021 15:03:49 -0700 (PDT)
MIME-Version: 1.0
References: <20211104210914.4160448-1-osk@google.com>
In-Reply-To: <20211104210914.4160448-1-osk@google.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 4 Nov 2021 22:03:37 +0000
Message-ID: <CACPK8XfXuU4i4khbpo8rxqxT9zz021N_m=s8uinoT+nHbCa_Yg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed: tyan-s7106: Update nct7802 config
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

On Thu, 4 Nov 2021 at 21:09, Oskar Senft <osk@google.com> wrote:
>
> This change updates the configuration for the nct7802 hardware
> monitor to correctly configure its temperature sensors.
>
> Signed-off-by: Oskar Senft <osk@google.com>
> ---
>  arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts | 23 +++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts b/arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts
> index 68f332ee1886..fc1585f34a57 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts
> @@ -213,6 +213,29 @@ &i2c0 {
>         nct7802@28 {
>                 compatible = "nuvoton,nct7802";
>                 reg = <0x28>;
> +               channel@0 { /* LTD */
> +                       reg = <0>;
> +                       status = "okay";

The status = "okay" should be redundant; as long as  you don't specify
a status, a node is assumed to be enabled.

> +               };
> +               channel@1 { /* RTD1 */
> +                       reg = <1>;
> +                       status = "okay";
> +                       sensor-type = "temperature";
> +                       temperature-mode = "thermistor";
> +               };
> +
> +               channel@2 { /* RTD2 */
> +                       reg = <2>;
> +                       status = "okay";
> +                       sensor-type = "temperature";
> +                       temperature-mode = "thermistor";
> +               };
> +
> +               channel@3 { /* RTD3 */
> +                       reg = <3>;
> +                       status = "okay";
> +                       sensor-type = "temperature";
> +               };
>         };
>
>         /* Also connected to:
> --
> 2.34.0.rc0.344.g81b53c2807-goog
>
