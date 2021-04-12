Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21FB335D0D0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 21:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245165AbhDLTIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 15:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236951AbhDLTIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 15:08:16 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADD7C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 12:07:58 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id t23so7158309pjy.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 12:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=CebE5qyQpll4V79rPwWriZ7YR0CHEOZQO7SaD3bm2sE=;
        b=Arpet9dZM9/Q0PmiTS8YtsDgk/dCwiFFl6zlJQobHz8P0+4tgNY7Dp/6AHSo18wXfd
         +mCZzdnAMkpfcRLgMJ7gWNsqlvFgqrUCDdNUOOqr1f/g7x74KsOcl6X+egMniSd+qVHB
         F6kt1/A3UCxSeMVx3raNkY2PixEtK0qO/vk/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=CebE5qyQpll4V79rPwWriZ7YR0CHEOZQO7SaD3bm2sE=;
        b=RCZbXp2bAHyCDe4Cz6Z9Af5YiWdVI6Pffaq7Iss4LGrXoLhnYpo9BUG+sPu64N2Rlv
         21bF3FRn5MpanQchXyXDJiZsqllRyLar4r+gRpXkZ831VdoHBj3/DOH8Y8BlyAekBKt1
         DX0Vp5PThGoIoOBP6APDeB4wlhsRbm0ClQj8F1t/BERy874BQw6e/oz2eygUxrsts4RG
         wOdHMLBTug4iqjLlTc2wKqefgB6lnTmKf0GSHSSnSO4uKhf+g0yr6zDX6HANd8DdCEUJ
         Ngg3QMizjxLRNl+nH/+0XT+XTDIbgmPdFMBIu3k0vk1q/CH4UYN8mZflqcx9clCZTtCL
         EX9A==
X-Gm-Message-State: AOAM533n+3oqOZMi0HPBe8XJ5wVGYY8mnXNKeC51sP8deVbmiHSTTY8h
        YyU4a93IDKjfGCK/+2vi8tKCHw==
X-Google-Smtp-Source: ABdhPJziE71JAVTa1fIPDlkylfiLGrPI5e3Gar3JlZm6Rfwqz8Rg4/xf8FER0LY/+EHp2/qDeILfQQ==
X-Received: by 2002:a17:90b:3613:: with SMTP id ml19mr716305pjb.38.1618254478085;
        Mon, 12 Apr 2021 12:07:58 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:1d18:a339:7993:e548])
        by smtp.gmail.com with ESMTPSA id f187sm10437595pfa.104.2021.04.12.12.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 12:07:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <b955dcbb-48b6-f236-ccbd-bc7d0de1df60@codeaurora.org>
References: <20210406163330.11996-1-srivasam@codeaurora.org> <161798766423.3790633.3895809656191757415@swboyd.mtv.corp.google.com> <b955dcbb-48b6-f236-ccbd-bc7d0de1df60@codeaurora.org>
Subject: Re: [PATCH v2] arm64: dts: qcom: Update iommu property for simultaneous playback
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     V Sujith Kumar Reddy <vsujithk@codeaurora.org>
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, dianders@chromium.org,
        judyhsiao@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        rohitkr@codeaurora.org, srinivas.kandagatla@linaro.org
Date:   Mon, 12 Apr 2021 12:07:56 -0700
Message-ID: <161825447608.3764895.10280020916196054814@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2021-04-09 22:17:07)
> Hi Stephen.
>=20
> Thanks for your time!!!
>=20
>=20
> On 4/9/2021 10:31 PM, Stephen Boyd wrote:
> > Quoting Srinivasa Rao Mandadapu (2021-04-06 09:33:30)
> >> From: V Sujith Kumar Reddy <vsujithk@codeaurora.org>
> >>
> >> Update iommu property in lpass cpu node for supporting
> >> simultaneous playback on headset and speaker.
> >>
> >> Signed-off-by: V Sujith Kumar Reddy <vsujithk@codeaurora.org>
> >> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> >> ---
> >> Changes since v1:
> >>     -- Commit messge header change
> >>
> >>   arch/arm64/boot/dts/qcom/sc7180.dtsi | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dt=
s/qcom/sc7180.dtsi
> >> index a6da78d31fdd..6228ba2d8513 100644
> >> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> >> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> >> @@ -3566,7 +3566,8 @@ lpass_cpu: lpass@62f00000 {
> >>                          reg =3D <0 0x62f00000 0 0x29000>;
> >>                          reg-names =3D "lpass-lpaif";
> >>  =20
> >> -                       iommus =3D <&apps_smmu 0x1020 0>;
> >> +                       iommus =3D <&apps_smmu 0x1020 0>,
> >> +                               <&apps_smmu 0x1021 0>;
> > The stream ID 0x1032 was also dropped in this version but there's no
> > mention of that in the changelog. Why?
> That is ID is for HDMI Stream, so as part of DP patches that will be adde=
d.

Ok, got it.
