Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6FD32671A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 19:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbhBZSrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 13:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbhBZSrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 13:47:25 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2D2C061786
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 10:46:45 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id z7so5759523plk.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 10:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=WTRxkaBkVRFH3msZClfA4ctqASFuiuF4nHoUGuxUFRw=;
        b=DULndB44xMpW5FmQr3j59vwHz+xCcshyplfC2lmH8WZ+AYnQBJA7lB9Nc4TH6X/ZMe
         dCQRelabv2/yLUu2HJdGB9kaLTk3NS2IvWdK0DuJ7bEh6FmwuLq8Jn+ZcXUxf2ng/qTG
         flv0yORCbhtSGWxmFKwofCZk2f0i44JA4sLZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=WTRxkaBkVRFH3msZClfA4ctqASFuiuF4nHoUGuxUFRw=;
        b=IFYwP34rWG0RKMAHhgp/Gdm02VGd288RNHrzC/PtAflacc+L0/spm4bBeJtmtGrBSr
         6/7bVMVF3QRuSyCs0BZiunnKhbmQYmcjy2yy5mBOYceWw1AteL+HMzY/aSmiTEn1tTO7
         3RBHsuTSsFjJLmcl0wd9x6zWohscUUWNiZlaIp/84rpAxgNkEBcpsFOtMeip4LfMVqcV
         SlC64CbXxveJQIxbU4kWaDpnfl6nsDID2QHkSFik9KNuaAUaYd0TePvPlsPID9i9UOF6
         0fR6sW3VhawaBjaWxn5Qgbw8z9hvrgopcHTtxzUUuf0bW2XQZPCGYL8UK1wNuZ1KxCj0
         SOsQ==
X-Gm-Message-State: AOAM533ERKziC3o+LKHxi8mS70IHg2TCOPrEgl4UAYe/T6o6Rs3H4zhf
        1ogPQMfAmvPfwXKY9V0cC7X6Zg==
X-Google-Smtp-Source: ABdhPJzjopObfqH49jbYa7PNj+ATiajhT4+w27fwpeYPVDXYz5jx3hEOIuldAgKaqba4R/bx4vzyMA==
X-Received: by 2002:a17:902:b089:b029:e3:28:b8ee with SMTP id p9-20020a170902b089b02900e30028b8eemr4547538plr.84.1614365204929;
        Fri, 26 Feb 2021 10:46:44 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:e8bb:5726:f58b:4e37])
        by smtp.gmail.com with ESMTPSA id j125sm11024188pfd.27.2021.02.26.10.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 10:46:44 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <dc3be32a3f8197d3138fe1ef6c24316a@codeaurora.org>
References: <cover.1614244789.git.saiprakash.ranjan@codeaurora.org> <463a45f2c3e4a91430c006fa1637c7f4f124185e.1614244789.git.saiprakash.ranjan@codeaurora.org> <161428210272.1254594.16034240343090747878@swboyd.mtv.corp.google.com> <dc3be32a3f8197d3138fe1ef6c24316a@codeaurora.org>
Subject: Re: [PATCH 8/9] arm64: dts: qcom: sc7280: Add AOSS QMP node
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Date:   Fri, 26 Feb 2021 10:46:42 -0800
Message-ID: <161436520297.1254594.4348845199981053890@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sai Prakash Ranjan (2021-02-25 23:51:00)
> On 2021-02-26 01:11, Stephen Boyd wrote:
> > Quoting Sai Prakash Ranjan (2021-02-25 01:30:24)
> >> Add a DT node for the AOSS QMP on SC7280 SoC.
> >>=20
> >> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> >> ---
> >>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 14 ++++++++++++++
> >>  1 file changed, 14 insertions(+)
> >>=20
> >> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi=20
> >> b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> >> index 65c1e0f2fb56..cbd567ccc04e 100644
> >> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> >> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> >> @@ -9,6 +9,7 @@
> >>  #include <dt-bindings/clock/qcom,rpmh.h>
> >>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> >>  #include <dt-bindings/mailbox/qcom-ipcc.h>
> >> +#include <dt-bindings/power/qcom-aoss-qmp.h>
> >>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> >>=20
> >>  / {
> >> @@ -368,6 +369,19 @@ pdc: interrupt-controller@b220000 {
> >>                         interrupt-controller;
> >>                 };
> >>=20
> >> +               aoss_qmp: qmp@c300000 {
> >=20
> > power-domain-controller@c300000? power-controller@c300000?
> >=20
>=20
> Its an AOSS message RAM and all other SM* SoCs have as qmp@
> and the dt binding as well, I see only SM8150 with power-controller,
> that should probably be fixed?

Node name should be generic while still being meaningful. Nobody knows
what qmp is, but power-controller makes sense. Can you fix this and the
others to be power-controller?
