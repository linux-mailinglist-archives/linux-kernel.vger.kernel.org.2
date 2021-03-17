Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A18B33E5D3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 02:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbhCQBHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 21:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbhCQBBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 21:01:15 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B99C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 18:01:14 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id cl21-20020a17090af695b02900c61ac0f0e9so4446892pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 18:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=KJCmnpc2/C4XeDva7kjuk3JPosO+NPqReP5hP00Z3JE=;
        b=GA9tnHlNZNzAjc3rVYBKtBdyTjZHMI5UDGsTb00NWsqV+t9jgbi4kdhpcFA67tCL0e
         27IgQGr9MU+0/jcMzWtbtDdvJ0GolF/cUfqurCg3cQIIxYeZI0LIKutJ0rlPM/C7tZQc
         gnrqE1GjmSC2diBdiYLh5j6j5T8jVIxsIuHz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=KJCmnpc2/C4XeDva7kjuk3JPosO+NPqReP5hP00Z3JE=;
        b=Q7XgVLQDBkVXbCA21OAvDELNRTvLL98dDdlAsxd5RYKYrzbwNKEBlaRxyqaraJx3W8
         z+JieH4+wjw02hJiel8it5CCiM/Wt9TSXgvrlEdQeiAwTKhD3aAGtcCzzY7xYf/nd3Bx
         xcEAJjVQqyQjmbB50jS2nLmhv5zkKATSMGxgNlAxaP3ymdTWRbZgvcoih7LoS4wFaDpW
         OHPrMeS8BotLquCduE36dxRP24RC7lWQ+eA1dCk8VSxJy1IDWOKlfHAPUXfLBbuyaZfv
         r5b1SLkLttyR6jvI8aX6PyJWCR/O/X5sstO9/kG1s6MbhjWHDIxCo5Jn88q1Uq/zdx1u
         vbPA==
X-Gm-Message-State: AOAM53179JWephpBADLm7H3kwID63n5F8g15WLPTTiR4GcVjtmU4vBdD
        crPwhbUf+jKiLsw19WpGq6bKZA==
X-Google-Smtp-Source: ABdhPJw5dqGNJi9f/m+faGVvr4ee/ieLilqXPEtXhbebP0VFa0sRXw5uNy4+tK9xUFP8F0DScTicOQ==
X-Received: by 2002:a17:902:8306:b029:e6:125c:1a3a with SMTP id bd6-20020a1709028306b02900e6125c1a3amr2055612plb.65.1615942874061;
        Tue, 16 Mar 2021 18:01:14 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:e1e0:9aee:aecc:ef78])
        by smtp.gmail.com with ESMTPSA id 35sm16892208pgm.64.2021.03.16.18.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 18:01:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210314061054.19451-2-srivasam@codeaurora.org>
References: <20210314061054.19451-1-srivasam@codeaurora.org> <20210314061054.19451-2-srivasam@codeaurora.org>
Subject: Re: [PATCH v7 1/2] arm64: dts: qcom: sc7180-trogdor: Add lpass dai link for I2S driver
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Ajit Pandey <ajitp@codeaurora.org>,
        V Sujith Kumar Reddy <vsujithk@codeaurora.org>,
        Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, dianders@chromium.org,
        judyhsiao@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        rohitkr@codeaurora.org, srinivas.kandagatla@linaro.org
Date:   Tue, 16 Mar 2021 18:01:12 -0700
Message-ID: <161594287222.1478170.13150046375446210090@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2021-03-13 22:10:53)
> From: Ajit Pandey <ajitp@codeaurora.org>
>=20
> Add dai link for supporting lpass I2S driver, which is used
> for audio capture and playback.
> Add lpass-cpu node with  pin controls and i2s primary
> and secondary dai-links
>=20
> Signed-off-by: Ajit Pandey <ajitp@codeaurora.org>
> Signed-off-by: V Sujith Kumar Reddy <vsujithk@codeaurora.org>
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
