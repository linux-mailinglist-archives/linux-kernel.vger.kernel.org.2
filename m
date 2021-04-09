Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1809035A446
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 19:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbhDIRB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 13:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbhDIRBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 13:01:19 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1813C061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 10:01:06 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id l123so4622333pfl.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 10:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=Y+dtVUQQoKBT4QD8w22iCkdT2lXFXX96rY1QL4XBEhk=;
        b=Bj10EXFFti3jwrOObuKak/5UWWbOw1R+c5AYo7DIKOeibu1rV7jHUpBVMj6qft2LFm
         AQfJE0xX0wLjCk404YBcawfGv81kIVqoZpvKGAcxmtSXjLPFadyG3/mqTU8/+vZ7IDw5
         sTK4q33hDtHXEG6Mhw2K9NNml0ztOnLSvUhLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=Y+dtVUQQoKBT4QD8w22iCkdT2lXFXX96rY1QL4XBEhk=;
        b=RL8T205bQ3pX+VH2xadVedyCyipQPIUTa0rHPFcdljh2bcANDYmIpXIMO1sBFtdsQ/
         ZWHF9yaNlzg+NQWxC1aWhTR30HC2gWGYaUrmwWZW2JvgainM8sbcVz2zBIAdcoGZLXse
         rW5Y3iEBihDmXmrcI89hH+bykwKIY5B52AX3IHAt4jbmsLNfteAhEB8epUuqIwA8/QFj
         uPrQPhpECvSiF2BRSxbrIDUXyFl40atEb1UGUJfDKRPy02o/vXiRISmhBBhpIh/UVRwb
         j+QjcXbi+xn9vSUfl+/6jGqbzerKQlvuWoyi7xgWRwbHoq7BLGQLpasJaY50p8BtKr6F
         jQgw==
X-Gm-Message-State: AOAM532jbvCrlbT/IZJITcQWiSjMAtul+cfDWLNQ8vDsdyKDQvLCtAxD
        zXxnpg9yDwMDcrfIQWzWhoUQTA==
X-Google-Smtp-Source: ABdhPJyomjBj+/2DEtc/Q+SEr95sFJMVE8yo0USbDJj9yVPAfCRpXjjlOM0LFvT1nBq2QPjp6a/5Eg==
X-Received: by 2002:a63:fc07:: with SMTP id j7mr14383423pgi.401.1617987666112;
        Fri, 09 Apr 2021 10:01:06 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:44c3:3248:e7f5:1bbd])
        by smtp.gmail.com with ESMTPSA id q5sm2621786pfj.131.2021.04.09.10.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 10:01:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210406163330.11996-1-srivasam@codeaurora.org>
References: <20210406163330.11996-1-srivasam@codeaurora.org>
Subject: Re: [PATCH v2] arm64: dts: qcom: Update iommu property for simultaneous playback
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     V Sujith Kumar Reddy <vsujithk@codeaurora.org>,
        Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, dianders@chromium.org,
        judyhsiao@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        rohitkr@codeaurora.org, srinivas.kandagatla@linaro.org
Date:   Fri, 09 Apr 2021 10:01:04 -0700
Message-ID: <161798766423.3790633.3895809656191757415@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2021-04-06 09:33:30)
> From: V Sujith Kumar Reddy <vsujithk@codeaurora.org>
>=20
> Update iommu property in lpass cpu node for supporting
> simultaneous playback on headset and speaker.
>=20
> Signed-off-by: V Sujith Kumar Reddy <vsujithk@codeaurora.org>
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> ---
> Changes since v1:
>    -- Commit messge header change
>=20
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/q=
com/sc7180.dtsi
> index a6da78d31fdd..6228ba2d8513 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -3566,7 +3566,8 @@ lpass_cpu: lpass@62f00000 {
>                         reg =3D <0 0x62f00000 0 0x29000>;
>                         reg-names =3D "lpass-lpaif";
> =20
> -                       iommus =3D <&apps_smmu 0x1020 0>;
> +                       iommus =3D <&apps_smmu 0x1020 0>,
> +                               <&apps_smmu 0x1021 0>;

The stream ID 0x1032 was also dropped in this version but there's no
mention of that in the changelog. Why?

> =20
>                         power-domains =3D <&lpass_hm LPASS_CORE_HM_GDSCR>;
>
