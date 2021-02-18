Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B31331EFDA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 20:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbhBRTaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbhBRSrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 13:47:02 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1FCC061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 10:46:19 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d13so1753279plg.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 10:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=drmiTJ2Rk9ucy2iYLORJ+griMgMAYYSsxQgICUqTnik=;
        b=eYcml0geDRNXaW610yxESdhDgqNum66QY8BF55CxpxFl117dd2xNH0RrujDY2e0r6i
         NnpiyX4SSmQDyJzHXIMsxQMgMnThVoz0pq1XsPVZw4a1F7l2jB8NHclRgXsXhhb1fxA4
         3p840Cnu4pcfmWr+yrIGQGHqDFBaJL+QTvWfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=drmiTJ2Rk9ucy2iYLORJ+griMgMAYYSsxQgICUqTnik=;
        b=VwRHeq3c1qOuMUNK1CTo15lIjQjWWHrtSfYWdl2XwjhfcYcpjflWZwdtGRrF5LOSb4
         7Exe2ft/ttRPBLSiyRQY2gkzZwNrYPfdDYg8Gk0bddxrBpHgxpmPOdmlN0c8sAwoA4wz
         uXCuWFXKEuua7QhuDZAKj0bQ/fy5ezgWsLKz0iqyP549ttwhZYmgMFtbAOIWMufoTiNE
         4fo8AlBEj55RzpHwJ9Hk8jsftN6lU7c7WH/sNyxViL1AVB8uDAGiy1DXXvIdFzaz3vfV
         wCZ/oVla2rHaRrjozkknyvOCHyp75kUvqf6ZeSxZ2C1KNMq1mTaP5jppNgk7ACMZgc7m
         IA0w==
X-Gm-Message-State: AOAM530CW7LoDsX4EAYVzYprVhHKqqKSoVr0y263fpuOO6gQFUoal46K
        HFVN0sbbyHgER1fyPhkzRSMCeg==
X-Google-Smtp-Source: ABdhPJxJni7HMteZ57iewZ7//VvhwYQcbuDCtH1IKTW8sEoD3IMpcVitwBWi/yftGIPLZx0TCCVH1Q==
X-Received: by 2002:a17:90a:cf82:: with SMTP id i2mr5100794pju.209.1613673979305;
        Thu, 18 Feb 2021 10:46:19 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:ec84:ed2b:a796:b756])
        by smtp.gmail.com with ESMTPSA id b17sm6546618pfb.75.2021.02.18.10.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 10:46:18 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1613667070-27613-1-git-send-email-khsieh@codeaurora.org>
References: <1613667070-27613-1-git-send-email-khsieh@codeaurora.org>
Subject: Re: [PATCH v2 1/2] phy/qualcomm: add hbr3_hbr2 voltage and premphasis swing table
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     tanmay@codeaurora.org, abhinavk@codeaurora.org,
        aravindh@codeaurora.org, khsieh@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Kuogee Hsieh <khsieh@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, robdclark@gmail.com, sean@poorly.run,
        vkoul@kernel.org
Date:   Thu, 18 Feb 2021 10:46:17 -0800
Message-ID: <161367397738.1254594.12158219605796616035@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2021-02-18 08:51:10)
> Add hbr3_hbr2 voltage and premphasis swing table to support
> HBR3 link rate.
>=20
> Changes in V2:
> -- replaced upper case with lower case at hbr3_hbr2 table
>=20
> Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

BTW, the DP driver already set rates for HBR2, so does that mean this is
fixing the voltage and preemphasis settings for HBR2? If so we should
backport this to stable trees and mark it as fixing commit 52e013d0bffa
("phy: qcom-qmp: Add support for DP in USB3+DP combo phy").
