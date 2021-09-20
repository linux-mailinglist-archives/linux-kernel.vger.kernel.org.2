Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5D7412A79
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 03:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbhIUBmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 21:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbhIUBjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 21:39:17 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D328C01AE76
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 12:42:31 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id l16-20020a9d6a90000000b0053b71f7dc83so25125339otq.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 12:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=31Y8RGDRM54GvZccxUjy7D640zCG3GJz/MsvFpq1sGk=;
        b=T+bhdSx+fkQrx0wmoqwLXoHORCofMgMY4j64Qg0OvSOJDYdg65p1F5Aj3o/0W5TeAC
         BAPnBINSj6sCgzjMZe7b5hQXLIL7xjheHawntxuXD55Dba1d0aNx+pcYbkKre5PD3J6o
         ynsdKou6pRWbrpDxbdd+PbTL59RwNEwGws4aQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=31Y8RGDRM54GvZccxUjy7D640zCG3GJz/MsvFpq1sGk=;
        b=6w4iheUX+tv0/w3qhq6r5GsKGSWcR3fnoh/8bxbiXY15gr06CoDiatdXp4Rjbz+5hC
         G0EZj1ec1iQUS4Zltg9mpQTgVMPXTkbA7TakeyrQYdrIBHNX5O9NcakWOBHFYkZfq1ed
         +1TEDCkIfT/Z9dxnrxpqNPA5RhaHN55qPsdSasve68DnuFCzErGtqD0/bbZm1jTL2U6W
         MpigKid7ItK+RuSECbwLcKuEcrXqt4u4ysjVtMkC9XzvYFOdyIYuWdmC5ep6XMdUY/FW
         KIpohp+OcOxaVNo/lrVJLHxgVDKBA5HVwH5NdZFD9efAAjZV+GrhKlLPDrnJyb2lrnot
         SRmQ==
X-Gm-Message-State: AOAM531M/p0nJWbXZLFqEg3B8aamPDntBagjgfaTUFFVZ+mkcK65TpYK
        1fxd+/j5PhE/f5NdLCiFmuh6392hb4JhXOa7V/nbcg==
X-Google-Smtp-Source: ABdhPJz9TSeFzGkaAs4U9Kc4IDE18llt1nIpqyPgF64HULcW28wGXTY8xoaB3pB7loYYD8w8mV0h0LxJ+Q1zjGks8IY=
X-Received: by 2002:a05:6830:708:: with SMTP id y8mr2303306ots.77.1632166950435;
 Mon, 20 Sep 2021 12:42:30 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 20 Sep 2021 12:42:30 -0700
MIME-Version: 1.0
In-Reply-To: <1631872087-24416-5-git-send-email-rajpat@codeaurora.org>
References: <1631872087-24416-1-git-send-email-rajpat@codeaurora.org> <1631872087-24416-5-git-send-email-rajpat@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 20 Sep 2021 12:42:30 -0700
Message-ID: <CAE-0n51JdKDSDKhbhQSbF5w=cn5iQ_uRDG0-NMR+FPdGkuX4UA@mail.gmail.com>
Subject: Re: [PATCH V8 4/8] arm64: dts: sc7280: Add QUPv3 wrapper_0 nodes
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rajesh Patil <rajpat@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, rnayak@codeaurora.org,
        saiprakash.ranjan@codeaurora.org, msavaliy@qti.qualcomm.com,
        skakit@codeaurora.org, mka@chromium.org, dianders@chromium.org,
        Roja Rani Yarubandi <rojay@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajesh Patil (2021-09-17 02:48:03)
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 2fbcb0a..a2a4d7e 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -536,24 +536,444 @@
>                 qupv3_id_0: geniqup@9c0000 {
>                         compatible = "qcom,geni-se-qup";
>                         reg = <0 0x009c0000 0 0x2000>;
> -                       clock-names = "m-ahb", "s-ahb";
>                         clocks = <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
>                                  <&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
> +                       clock-names = "m-ahb", "s-ahb";
>                         #address-cells = <2>;
>                         #size-cells = <2>;
>                         ranges;
> +                       iommus = <&apps_smmu 0x123 0x0>;
>                         status = "disabled";
>
> +                       qup_opp_table: qup-opp-table {

Sorry to mislead you. I see now why it can't be here. qeniqup has
address cells and size cells not equal to zero, which means that every
child node of qeniqup should have a reg property. So this OPP table
needs to be moved to the root again (ugh).

> +                               compatible = "operating-points-v2";
> +
> +                               opp-75000000 {
> +                                       opp-hz = /bits/ 64 <75000000>;
> +                                       required-opps = <&rpmhpd_opp_low_svs>;
> +                               };
> +
> +                               opp-100000000 {
> +                                       opp-hz = /bits/ 64 <100000000>;
> +                                       required-opps = <&rpmhpd_opp_svs>;
> +                               };
> +
> +                               opp-128000000 {
> +                                       opp-hz = /bits/ 64 <128000000>;
> +                                       required-opps = <&rpmhpd_opp_nom>;
> +                               };
> +                       };
> +
> +                       i2c0: i2c@980000 {
> +                               compatible = "qcom,geni-i2c";
> +                               reg = <0 0x00980000 0 0x4000>;
> +                               clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
> +                               clock-names = "se";
> +                               pinctrl-names = "default";
[...]
>
>                 cnoc2: interconnect@1500000 {
> @@ -1574,11 +1994,311 @@
>                                 function = "qspi_data";
[...]
> +
> +                       qup_spi0_cs_gpio: qup-spi0-cs_gpio {

Please make it "qup_spi0_cs_gpio: qup-spi0-cs-gpio" as node names should
have dashes instead of underscores.

> +                               pins = "gpio3";
