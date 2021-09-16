Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E261540D7E8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 12:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237251AbhIPKyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 06:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236951AbhIPKyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 06:54:19 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F723C061764
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 03:52:59 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id g9so7312445ioq.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 03:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QX3J+lUtcHl1rFrYQo/2vL7jGEFZy+rKbVwUEHeLE5g=;
        b=uFkMWiw8rD+C7Ybev6NMLWHn46waK1pPREFY3onqFoy9CkZB48DRqxcHild+8mefp8
         /I9G2qh8rQoaBCDLgPrrbsFzXboiJJkUBDH7bHb2MaX3jMq59CFoX4jNIbtb8u+VcbZO
         MZrq4sBximDL6QSgmuXKvXiPY7nhop0TxBz9Gs6Y74r758sfFwGxq7V67aBaRU5f6Ew1
         0QIyyZT/VYo4e29QcEHEKYcuURbLqXCmvzjy/tIGSpGe7EGBtDsr8TtwSYGOnUxsK5zw
         UFmmTyN8If9/8sTn3rLzSpY1Y0ohDphw6n0CNAYlz1Bcl7gMatxVNCSAbIoDsTpe0a2t
         lbgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QX3J+lUtcHl1rFrYQo/2vL7jGEFZy+rKbVwUEHeLE5g=;
        b=5yCaXaz0lRzZBsy3hl1Gj39ew3Xpvh4zKTzD8DXx+YQHOSqFKG2Sg1GnYNRRssTqkp
         /R/CZgDQw6Kky/CiROI2Jjl4nIxtUbYYMa5pk9vDbDkdi1pvrvtbsj/FqPqbmvP/+SU4
         bh+wuL0tkZL0+rgxeFd/gNpYyuX9UKFeP+Nip8fCCCTghUze54A9WihL9Ye9pGvHL+HC
         7BmCH8TzKgxPaHzkck2dlHr57RYg8hWhMicoqUC1v5iaraR8opkXDThCXZVKOpSUjabt
         6cQl/bsQ28ZpmoUljvGp1JSzUAMRDZbn5q+OcnZR6c3KRIT0m9AXynzWib+K4eCYQCmA
         mScw==
X-Gm-Message-State: AOAM5320fDGNXYRmtSXfDK3N4Zs06r4gNLEzrkdgWI2a2PmG+5VeQgLT
        7CR2aHoszPSmMqMn7OsUKfzsMSYLXbslDEL8K1A2ww==
X-Google-Smtp-Source: ABdhPJwwO1fzUnd0LKwvGXlwo3VYCx9ksmdwcyVRTMibUbqtB5b8P/Pz200i37SEP0roG060ZzCC0sLqwiXGG+WO+ec=
X-Received: by 2002:a6b:3f02:: with SMTP id m2mr3751213ioa.136.1631789578807;
 Thu, 16 Sep 2021 03:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210615232816.835325-1-bjorn.andersson@linaro.org>
In-Reply-To: <20210615232816.835325-1-bjorn.andersson@linaro.org>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Thu, 16 Sep 2021 16:22:22 +0530
Message-ID: <CAMi1Hd0hZV7antTa7ShKvfS5CRxRei4TNycM9EJ9NR5qEBJV7g@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sdm850-yoga: Enable IPA
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Alex Elder <elder@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On Wed, 16 Jun 2021 at 04:58, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> Shuffle memory regions to make firmware loading succeed and then enable
> the ipa device.

Just a heads-up, this reserved memory region shuffling in sdm845.dtsi
broke PocoF1 and may be other devices too(?) which do not override
these regions.

IIRC you once had a patch to move the reserved memory regions to board
specific dts files, is it still on the cards so that we don't run into
breakages like this?

Meanwhile I'll go and add these regions in sdm845-xiaomi-beryllium.dts.

Regards,
Amit Pundir



>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi          | 21 +++++++------------
>  .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts |  5 +++++
>  2 files changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 1796ae8372be..49624eadce84 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -128,28 +128,23 @@ camera_mem: memory@8bf00000 {
>                         no-map;
>                 };
>
> -               ipa_fw_mem: memory@8c400000 {
> -                       reg = <0 0x8c400000 0 0x10000>;
> +               wlan_msa_mem: memory@8c400000 {
> +                       reg = <0 0x8c400000 0 0x100000>;
>                         no-map;
>                 };
>
> -               ipa_gsi_mem: memory@8c410000 {
> -                       reg = <0 0x8c410000 0 0x5000>;
> +               gpu_mem: memory@8c515000 {
> +                       reg = <0 0x8c515000 0 0x2000>;
>                         no-map;
>                 };
>
> -               gpu_mem: memory@8c415000 {
> -                       reg = <0 0x8c415000 0 0x2000>;
> +               ipa_fw_mem: memory@8c517000 {
> +                       reg = <0 0x8c517000 0 0x5a000>;
>                         no-map;
>                 };
>
> -               adsp_mem: memory@8c500000 {
> -                       reg = <0 0x8c500000 0 0x1a00000>;
> -                       no-map;
> -               };
> -
> -               wlan_msa_mem: memory@8df00000 {
> -                       reg = <0 0x8df00000 0 0x100000>;
> +               adsp_mem: memory@8c600000 {
> +                       reg = <0 0x8c600000 0 0x1a00000>;
>                         no-map;
>                 };
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> index c2a709a384e9..3eaa42dc3794 100644
> --- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> @@ -415,6 +415,11 @@ ecsh: hid@5c {
>         };
>  };
>
> +&ipa {
> +       status = "okay";
> +       memory-region = <&ipa_fw_mem>;
> +};
> +
>  &mdss {
>         status = "okay";
>  };
> --
> 2.31.0
>
