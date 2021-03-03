Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5101932BBEF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358969AbhCCNTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 08:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357088AbhCCIRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 03:17:48 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D03C061222
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 00:16:49 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id c19so3677626pjq.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 00:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=Ive6eNucBHIhvqUM+2V1aUkJ4q+fvS0d/eGIj0JQKdQ=;
        b=Ye1/O8uS83gN/d4J4x+97v9AwnyKBM4o1t+pUeWOKgp7Gw4doOnlRbpWpl2aufrG0i
         K5uxXFxX4C5e8Ld32GI7QWIXfgEyaUI73RAzLvV3cNE7QZKEmFQS08TwLaWSVNZGVCnQ
         pmpy/am4xavzpRGeb9zOL3MK230BClbIwRYR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=Ive6eNucBHIhvqUM+2V1aUkJ4q+fvS0d/eGIj0JQKdQ=;
        b=pYqGUOy+FmV9BRLQQrBjThIyCNPtQAYGbifmKy4JRvLOojbI7Cw4BFYpLWT7fhwy7s
         nNe6zPJF3rDDtiunqr/rA6ZF4GxbNE9vgjmuVmmkoeHBUXldJ5pcs+Y8iGhbK3l5CjE+
         b94hc0QyDKK+cwEkEzTzLd112Cwpr6/9IrNUwroznZ/H0qJkmYo+lMwzDhLR8FGZ+KHk
         fyypKwbP/yn70d+Lw+BpBoAk0Q4KgP2Pw4086D/SqcvxEIfpM6V3cVDuhpBjPWOGtZyi
         6c1SQvT/g5yG9gAm1DwSiSj+IZM2PkX5dD8/cxxqajzlMhE703ShIwOkxnDl06PjP2Jy
         RFQw==
X-Gm-Message-State: AOAM533srZs2+cm2hpxNXCWir4CEGs9ERPd/9V200CGkdOb5bqiAZaWa
        NuhHI3UI8w3Lg+IqziTbnOIKTw==
X-Google-Smtp-Source: ABdhPJzKoq6JbUPoKO146By1DudwwWEZ4yRjh1CiHL9MGSOMUbxqiddoHyP2rXARTxZSWJxIA8YVbg==
X-Received: by 2002:a17:902:f242:b029:e4:6dfc:8c1f with SMTP id j2-20020a170902f242b02900e46dfc8c1fmr1891334plc.0.1614759409018;
        Wed, 03 Mar 2021 00:16:49 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:2510:ab07:78a:7d78])
        by smtp.gmail.com with ESMTPSA id e1sm5865727pjt.10.2021.03.03.00.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 00:16:48 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210301133318.v2.10.Ia3795e192f5bbe17e6714e45fcb0bf5acdbd4c17@changeid>
References: <20210301213437.4165775-1-dianders@chromium.org> <20210301133318.v2.10.Ia3795e192f5bbe17e6714e45fcb0bf5acdbd4c17@changeid>
Subject: Re: [PATCH v2 10/13] arm64: dts: qcom: sc7180: Set up lazor r3+ as sc7180-lite SKUs
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Rob Clark <robdclark@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Date:   Wed, 03 Mar 2021 00:16:46 -0800
Message-ID: <161475940685.1478170.2315767506969423960@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2021-03-01 13:34:34)
> From: Matthias Kaehlcke <mka@chromium.org>
>=20
> Lazor rev3 and later use the 'lite' version of the SC7180 SoC.
>=20
> Cc: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> [dianders: Adjust commit message which referred to downstream history]
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
