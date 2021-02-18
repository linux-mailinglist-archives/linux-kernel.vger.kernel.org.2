Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 302AD31E330
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 00:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbhBQXpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 18:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbhBQXpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 18:45:05 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7279C0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 15:44:24 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id w18so28375pfu.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 15:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=PqTK2asE5Pm0G1XwTNldGeSNxyz+U3YMDodiNkSaEFM=;
        b=lrepYEvD+DGdM9L3CQikCjNFhA6vT3lgF22RN5cNbY1Jurn6s1Zjnwl5zrfzei/IZx
         oHan1v0OZl1gy3wQ0q53vHTzakuGIlWNsvYM8u6gKrbk8vMVbzavu5tU4VViONTGCYVu
         pehRNsGa/AUwhxFmWWboE7IggKpkKbqIEN7xo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=PqTK2asE5Pm0G1XwTNldGeSNxyz+U3YMDodiNkSaEFM=;
        b=qd0Yo3lxdcUvp9UG/wa6ywZ7Zg27lqI0m02Ivy43pulhpkTgdB8dZhoDSGgpApStjL
         lGV5JMXZtoD8jYF6p2pnArWmY6EsgOXwsZL7fD+jhkpWDe3RMpzz/4UCVb65t0mjnA0a
         fRTBqJca2KLXYKKjypwI6VwEpIQDWfau67K30G4Dp4g5ws1iBrSt4gth4Rr3FZAEnx7r
         ERbX84Q+Q03snXQNjxxi3cggPTWZ2St9cqNWp5MbbaOJhGFAFDSeohJjKW1d0DQw2RWr
         jRag+/qhFq0dClvzIfnPehuLjb8OYFGOSPNetn/36UmsnepX53lT3JHabYnOaPdgoavu
         I26A==
X-Gm-Message-State: AOAM5318AM+1Dr4+T0BAAu/58bOwUFaFmt5kZziROq5dW6G2bILPX4cY
        1eIru4KvFfLBQcaBOZsm8DZGlRjKYfkQng==
X-Google-Smtp-Source: ABdhPJxCD7mhiaN4h0nKY9qB4dTxH7maWpkjGIJyIc7l8y/Twj++X2M3xwrtywbDup2VgSc5IvPErw==
X-Received: by 2002:a63:5301:: with SMTP id h1mr1618756pgb.180.1613605438147;
        Wed, 17 Feb 2021 15:43:58 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:ec84:ed2b:a796:b756])
        by smtp.gmail.com with ESMTPSA id d12sm3342971pgm.83.2021.02.17.15.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 15:43:56 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1613604031-27798-1-git-send-email-khsieh@codeaurora.org>
References: <1613604031-27798-1-git-send-email-khsieh@codeaurora.org>
Subject: Re: [PATCH 1/2] phy/qualcomm: add hbr3_hbr2 voltage and premphasis swing table
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     tanmay@codeaurora.org, abhinavk@codeaurora.org,
        aravindh@codeaurora.org, khsieh@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Kuogee Hsieh <khsieh@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, robdclark@gmail.com, sean@poorly.run,
        vkoul@kernel.org
Date:   Wed, 17 Feb 2021 15:43:55 -0800
Message-ID: <161360543514.1254594.14314447256582277276@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2021-02-17 15:20:31)
> Add hbr3_hbr2 voltage and premphasis swing table to support
> HBR3 link rate.
>=20
> Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/p=
hy-qcom-qmp.c
> index 0939a9e..c920143 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> @@ -2965,6 +2965,20 @@ static void qcom_qmp_phy_dp_aux_init(struct qmp_ph=
y *qphy)
>                qphy->pcs + QSERDES_V3_DP_PHY_AUX_INTERRUPT_MASK);
>  }
> =20
> +static const u8 qmp_dp_v3_pre_emphasis_hbr3_hbr2[4][4] =3D {
> +        { 0x00, 0x0C, 0x15, 0x1A },
> +        { 0x02, 0x0E, 0x16, 0xFF },
> +        { 0x02, 0x11, 0xFF, 0xFF },
> +        { 0x04, 0xFF, 0xFF, 0xFF }

Lowercase hex please.

> +};
> +
> +static const u8 qmp_dp_v3_voltage_swing_hbr3_hbr2[4][4] =3D {
> +        { 0x02, 0x12, 0x16, 0x1A },
> +        { 0x09, 0x19, 0x1F, 0xFF },
> +        { 0x10, 0x1F, 0xFF, 0xFF },
> +        { 0x1F, 0xFF, 0xFF, 0xFF }
> +};

Lowercase hex please.

> +
>  static const u8 qmp_dp_v3_pre_emphasis_hbr_rbr[4][4] =3D {
>         { 0x00, 0x0c, 0x14, 0x19 },
>         { 0x00, 0x0b, 0x12, 0xff },
> @@ -3000,8 +3014,13 @@ static void qcom_qmp_phy_configure_dp_tx(struct qm=
p_phy *qphy)
>                 drvr_en =3D 0x10;
>         }
> =20
> -       voltage_swing_cfg =3D qmp_dp_v3_voltage_swing_hbr_rbr[v_level][p_=
level];
> -       pre_emphasis_cfg =3D qmp_dp_v3_pre_emphasis_hbr_rbr[v_level][p_le=
vel];
> +       if (dp_opts->link_rate <=3D 2700) {
> +               voltage_swing_cfg =3D qmp_dp_v3_voltage_swing_hbr_rbr[v_l=
evel][p_level];
> +               pre_emphasis_cfg =3D qmp_dp_v3_pre_emphasis_hbr_rbr[v_lev=
el][p_level];
> +       } else {
> +               voltage_swing_cfg =3D qmp_dp_v3_voltage_swing_hbr3_hbr2[v=
_level][p_level];
> +               pre_emphasis_cfg =3D qmp_dp_v3_pre_emphasis_hbr3_hbr2[v_l=
evel][p_level];
> +       }
>
