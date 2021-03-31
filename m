Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7F7345657
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 04:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhCWDid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 23:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhCWDiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 23:38:05 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAF6C061756
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 20:38:05 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y5so12869437pfn.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 20:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=til1v4SH/TtmLKm35mHk+XE9IxkpsVFKSNvaMqYYu14=;
        b=Xdu7khG7OrvQmYH7UZEB2jC8kCjyE46zrTCWcHBHksw60fcJNDOkjzHT/Z5mAQ+gaY
         kpxRkgGVWjSFG3hdyO8h5ggyqiPSQeY8Lbef8ODvDVYBFGdLMTVreXtTGdwZqjf3TR3r
         PCCOfCT4ad07EKhXY4kFu4I9MznOA5xL/YkP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=til1v4SH/TtmLKm35mHk+XE9IxkpsVFKSNvaMqYYu14=;
        b=h6M0kqLPCXFBsOqnwsw6Y8VADxLoCoOxQJGdw5z+vbZww50abNHOA01bqLqHetVbst
         MkGsLjTxfJ2QN1pwwY8CqdyT3OtmtSQgI/SQx7lR2PizJGPF8ChMzjhmN/S2doI2gFsz
         h1A6jbuzgmVaFqp/VShZiyX9sw74iDU5itPvsPTGiKrZhPdz+uh3p6jVvGh8IcDasoeC
         Ycg6SneBDb9p/hDPpRpg2CoR2y0wlmu0YCOtkd3jn9sIkfGb6cC5QuLsEwYjaDQc1EXj
         1ExT9Rmgsoo3TxKiXJekmqGoQVTENleyEBEl/9nhG0mdJyMfVP0yQk0RdhecH2fGMncr
         BXsg==
X-Gm-Message-State: AOAM531sf0hdw9OIzykchBbM1I63jGOSBE30pyUSDZpoJaKD5aDJ3ktq
        t0ROTKm1uqVNfNzXzBtj/966ww==
X-Google-Smtp-Source: ABdhPJz9TDRQtbtypmCWRo4JsjThyKds0XJ5xWAnkZjLZbvs6WxJKLo2fB78nRAtrAsldM+thjM+fA==
X-Received: by 2002:a65:5a0a:: with SMTP id y10mr2232648pgs.285.1616470685184;
        Mon, 22 Mar 2021 20:38:05 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:e90d:d453:87ae:2e10])
        by smtp.gmail.com with ESMTPSA id i20sm13156817pgg.65.2021.03.22.20.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 20:38:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d19fbcc91b4ef045014b225e7fdf9780@codeaurora.org>
References: <cover.1614244789.git.saiprakash.ranjan@codeaurora.org> <463a45f2c3e4a91430c006fa1637c7f4f124185e.1614244789.git.saiprakash.ranjan@codeaurora.org> <161428210272.1254594.16034240343090747878@swboyd.mtv.corp.google.com> <dc3be32a3f8197d3138fe1ef6c24316a@codeaurora.org> <161436520297.1254594.4348845199981053890@swboyd.mtv.corp.google.com> <5cf5692ef7d348ec361081d0341f1254@codeaurora.org> <d19fbcc91b4ef045014b225e7fdf9780@codeaurora.org>
Subject: Re: [PATCH 8/9] arm64: dts: qcom: sc7280: Add AOSS QMP node
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     devicetree@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        linux-arm-kernel@lists.infradead.org
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>
Date:   Mon, 22 Mar 2021 20:38:03 -0700
Message-ID: <161647068330.3012082.2910442813045392403@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sibi Sankar (2021-03-08 21:58:21)
> On 2021-02-27 19:26, Sai Prakash Ranjan wrote:
> > On 2021-02-27 00:16, Stephen Boyd wrote:
> >> Quoting Sai Prakash Ranjan (2021-02-25 23:51:00)
> >>> On 2021-02-26 01:11, Stephen Boyd wrote:
> >>> > Quoting Sai Prakash Ranjan (2021-02-25 01:30:24)
> >>> >> Add a DT node for the AOSS QMP on SC7280 SoC.
> >>> >>
> >>> >> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.or=
g>
> >>> >> ---
> >>> >>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 14 ++++++++++++++
> >>> >>  1 file changed, 14 insertions(+)
> >>> >>
> >>> >> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> >>> >> b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> >>> >> index 65c1e0f2fb56..cbd567ccc04e 100644
> >>> >> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> >>> >> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> >>> >> @@ -9,6 +9,7 @@
> >>> >>  #include <dt-bindings/clock/qcom,rpmh.h>
> >>> >>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> >>> >>  #include <dt-bindings/mailbox/qcom-ipcc.h>
> >>> >> +#include <dt-bindings/power/qcom-aoss-qmp.h>
> >>> >>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> >>> >>
> >>> >>  / {
> >>> >> @@ -368,6 +369,19 @@ pdc: interrupt-controller@b220000 {
> >>> >>                         interrupt-controller;
> >>> >>                 };
> >>> >>
> >>> >> +               aoss_qmp: qmp@c300000 {
> >>> >
> >>> > power-domain-controller@c300000? power-controller@c300000?
> >>> >
> >>>=20
> >>> Its an AOSS message RAM and all other SM* SoCs have as qmp@
> >>> and the dt binding as well, I see only SM8150 with power-controller,
> >>> that should probably be fixed?
> >>=20
> >> Node name should be generic while still being meaningful. Nobody knows
> >> what qmp is, but power-controller makes sense. Can you fix this and=20
> >> the
> >> others to be power-controller?
> >>=20
>=20
> we probably would be changing them back
> to qmp or something more generic soon
> since the consensus was qmp wasn't a
> power-controller. So not sure if its
> worth the effort here.
>=20

Hmm alright. Maybe mailbox? qmp is not generic. What does it stand for?
qualcomm messaging protocol?
