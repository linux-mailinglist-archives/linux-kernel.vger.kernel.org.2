Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 553DD409DE0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 22:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241594AbhIMUHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 16:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242902AbhIMUHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 16:07:48 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A92C0613A8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:06:10 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id k12-20020a056830150c00b0051abe7f680bso15019149otp.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=8JlT5JO0f8nryHiaEll8oiHPpQCulxYXgviYtcuhVxo=;
        b=kQK19oR/tRPgDwwinGrctqV/cjYE/BHCVlg9i1sPNtvaHnhPTv6PufYg07FCpwujoz
         NPHcty65gIJY/rRoQASOYq4YAXjCzO8ruiwMNV9kLIGZIFClyOyZiPPiOchUbudJeN9e
         yM2gf18ELsJwMfLsUTHPc0WMwjAOJoTjBK2zk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=8JlT5JO0f8nryHiaEll8oiHPpQCulxYXgviYtcuhVxo=;
        b=hlBaO5VfZ8Lx0QICdJifirVdSijfK1mtY9bLRI7R7GUuEsV3fVsWlZssrnTVf8atQF
         JZKVTCSg1Zp0UPoPF4Z9zk950+ATzmhNXleXklDKgwXqDDthXNDy5m0FsgpZuqZ3jHKB
         69uwZlq5h9yGFFror8qvNkcpheChuUkxRk6BNeIf8EYtnI1CPoynQdHs1fw73Z11552R
         IqOezZoxvYx08k/BzvMqVjuKd8N7f3Qs8Ps9mxHlMKqL6YDY0vAAXK0txZQgH80ZCPE4
         0aogUSG9x46vBnCUybydvnX70QoBM6E+SHFNeziaNLB4g3xqNgIj+ktV19zlaXQwWE1w
         vjig==
X-Gm-Message-State: AOAM530VLPzSndgVZvcyvFlDuwmZj9KzdEqqr993iRNfBP2rMoyWqsbe
        PW9onRBagqEeiA2gzuntCpU9Z+mucu3p3EAmfkcjFA==
X-Google-Smtp-Source: ABdhPJxgxKme3xoUGCx5xyhrZPhc+XqJ9apKSj199UxcUSc8rkyCSP5ymrGxutXE0sY+CvdylfwFOBKRbqVanKrarNw=
X-Received: by 2002:a05:6830:719:: with SMTP id y25mr11195587ots.77.1631563569866;
 Mon, 13 Sep 2021 13:06:09 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Sep 2021 13:06:09 -0700
MIME-Version: 1.0
In-Reply-To: <1631223065-12607-1-git-send-email-khsieh@codeaurora.org>
References: <1631223065-12607-1-git-send-email-khsieh@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 13 Sep 2021 13:06:09 -0700
Message-ID: <CAE-0n50P2OR9CPku3qq7+xR56fpg2Y7JDinikkY+uX6y9XtcRA@mail.gmail.com>
Subject: Re: [PATCH v3] phy: qcom-qmp: add support for display port voltage
 and pre-emphasis swing
To:     Kuogee Hsieh <khsieh@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        robdclark@gmail.com, robh+dt@kernel.org, sean@poorly.run,
        vkoul@kernel.org
Cc:     abhinavk@codeaurora.org, aravindh@codeaurora.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kishon@ti.com, p.zabel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2021-09-09 14:31:05)
> @@ -3757,16 +3796,14 @@ static void qcom_qmp_v4_phy_dp_aux_init(struct qmp_phy *qphy)
>
>  static void qcom_qmp_v4_phy_configure_dp_tx(struct qmp_phy *qphy)
>  {
> -       /* Program default values before writing proper values */
> -       writel(0x27, qphy->tx + QSERDES_V4_TX_TX_DRV_LVL);
> -       writel(0x27, qphy->tx2 + QSERDES_V4_TX_TX_DRV_LVL);
> -
> -       writel(0x20, qphy->tx + QSERDES_V4_TX_TX_EMP_POST1_LVL);
> -       writel(0x20, qphy->tx2 + QSERDES_V4_TX_TX_EMP_POST1_LVL);
> -
> -       qcom_qmp_phy_configure_dp_swing(qphy,
> +       if (__qcom_qmp_phy_configure_dp_swing(qphy,
>                         QSERDES_V4_TX_TX_DRV_LVL,
> -                       QSERDES_V4_TX_TX_EMP_POST1_LVL);
> +                       QSERDES_V4_TX_TX_EMP_POST1_LVL,
> +                       (const u8 *)qmp_dp_v4_voltage_swing_hbr_rbr,

Surely we can pass a 2d-array to a function in C? We know the size of
the array is always a 4x4 so we could enforce that in the type so the
compiler complains if we try to pass something else.

> +                       (const u8 *)qmp_dp_v4_pre_emphasis_hbr_rbr,
> +                       (const u8 *)qmp_dp_v4_voltage_swing_hbr3_hbr2,
> +                       (const u8 *)qmp_dp_v4_pre_emphasis_hbr3_hbr2) < 0)
> +               return;

It's void and this is the end of the function. Why is there an if
condition and a return?

>  }
>
>  static int qcom_qmp_v4_phy_configure_dp_phy(struct qmp_phy *qphy)
