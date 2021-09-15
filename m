Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69D1240BCF9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 03:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbhIOBPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 21:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbhIOBPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 21:15:14 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6A1C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 18:13:56 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id v20-20020a4a2554000000b0028f8cc17378so341574ooe.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 18:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=fye5BxPOrlWKYYLZtsMn4MC6bBGJt02zFY1/zJ5TMGY=;
        b=MZQHMBIYPJkDu38cafY9egRxkkGrq4MLPBCaGkD+OAZbzsyJ+myDA6eNNaxnxFbLNK
         e2EEuRbKcsPnZhkfQStJtSPdAiI/TRJ74MQaIABJ66M3r0b0jHTWMOLNsdxI3ZjaJkDj
         GLW4Mgju2/a2bbyeUetWD1ZtD6kLbB/Ia5VSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=fye5BxPOrlWKYYLZtsMn4MC6bBGJt02zFY1/zJ5TMGY=;
        b=RpxtIZ1wUVFGsMxAtxONTN3n7xKnCrZjLAY3Fnm+VTPNM7nhBokTjTNJ6wQZ2pTE+r
         +3H4KoLZIuT/YSnR1fZ5v9zrChQSd7oYQduf2uc0ffN9fwxgl8caHDaRs6YBEgcUmpdy
         7StXKeJ+evA1k4ZwehQ1GZx5NmwfNhpbLYJaydAX/QlhDHNBLGePiYV+hW7ZFModpcDF
         GLq06lacCsCzpc9Ay+fweRdArrAjcpqyiDDNo5C/qk+J5O9zquDBK5jtocHKq2l5yKpy
         kzlME/gbqaE6ND80vKtOH43QcBxbVCbu78URUvq5XEJ3P+TfXSahfqBoh12QEOd6JN0c
         1IMA==
X-Gm-Message-State: AOAM531KckPQDN9dpaql4OoxmjhxLfr+XZDct/VxKOkKMKAYtoNWvokT
        EIjnjFJMH3HFcsP21fyGtHxT/PfhKNkSXERVB3GTfw==
X-Google-Smtp-Source: ABdhPJyldbFleOsQkMUKsmWFviYenDiXUNcW52RTf+GR1ym674J9EKp24jVyBGbGyY6HVNG9Gnf0nQ9Nuzr5Xl9pln8=
X-Received: by 2002:a4a:919e:: with SMTP id d30mr16454443ooh.8.1631668435971;
 Tue, 14 Sep 2021 18:13:55 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Sep 2021 18:13:55 -0700
MIME-Version: 1.0
In-Reply-To: <1631643550-29960-4-git-send-email-pmaliset@codeaurora.org>
References: <1631643550-29960-1-git-send-email-pmaliset@codeaurora.org> <1631643550-29960-4-git-send-email-pmaliset@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 14 Sep 2021 18:13:55 -0700
Message-ID: <CAE-0n52p+5rabienYNG_OQfiaLLCgaRj9vfeKR6s3-bCdzHDQA@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] arm64: dts: qcom: sc7280: Add PCIe nodes for IDP board
To:     Prasad Malisetty <pmaliset@codeaurora.org>, agross@kernel.org,
        bhelgaas@google.com, bjorn.andersson@linaro.org,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org, svarbanov@mm-sol.com
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, mka@chromium.org, vbadigan@codeaurora.org,
        sallenki@codeaurora.org, manivannan.sadhasivam@linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Prasad Malisetty (2021-09-14 11:19:09)
> Enable PCIe controller and PHY for sc7280 IDP board.
> Add specific NVMe GPIO entries for SKU1 and SKU2 support.
>
> Signed-off-by: Prasad Malisetty <pmaliset@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-idp.dts  |  9 +++++++++
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 32 ++++++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sc7280-idp2.dts |  9 +++++++++
>  3 files changed, 50 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dts b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> index 64fc22a..2cc6b0a 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> @@ -61,6 +61,15 @@
>         modem-init;
>  };
>
> +&pcie1_default_state {
> +       nvme-n {
> +               pins = "gpio19";
> +               function = "gpio";
> +
> +               bias-pull-up;
> +       };

I don't think the style is to have a single container node anymore.
Instead, each pin gets a different node and then pinctrl-0 has a list of
phandles to the different nodes. qcom maintainers may have more input
here.

Also, this should really go into a different section than here. I
thought the style was to have a 'board specific' pinctrl section.

> +};
> +
>  &pmk8350_vadc {
>         pmr735a_die_temp {
>                 reg = <PMR735A_ADC7_DIE_TEMP>;
