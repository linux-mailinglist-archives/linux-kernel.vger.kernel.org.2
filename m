Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D2243A4AB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 22:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238653AbhJYU3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 16:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235238AbhJYU2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 16:28:55 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCD1C0432C2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 13:22:49 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id o4so17239495oia.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 13:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=MIgjsnj2t5G4/nas/d5Scx9CJRo0MWjSv4YqCCkr6zQ=;
        b=dMlhV3hi8OeiZcg3u0Od1E9kdTBADg502uY9rRfMB/wWqyLxgWb0NYx6fm8W/3TSmJ
         j1Gon8iuUGR9+woMRKq6atAqAsTCF6m842fySCF01wJK9WyzW1am7v0+GIS0QtjOwbde
         /D/jfKCyBO9A4EfaExNL259Yt9BnHAgOnDSFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=MIgjsnj2t5G4/nas/d5Scx9CJRo0MWjSv4YqCCkr6zQ=;
        b=EQ9lzGzeOfRZ7IKbhx99/MjXafb7P6YSM/mRpsqLVCWEsaPu1twFJPUVA14iRPLl/G
         m8HPTYrDf2H9hmAceo1t3xqyDbK3K348wEpjeuY2d617AA9tZ4SlJy2fTvKFoCbXEmBv
         98G+trJr8efv/MmJmf7TLj30e+1nHxeVQIWirdteHOTb6Kw7Gl3KB1hUBQHEkiNMYnzC
         s5z+VHeECMMMd3dq4aXuuOYaRMIxCtItVj0vHEjWc4tZU5jd7B5wYxm78cfK8APfpw10
         rbINW/iOYgI92igdkH9sDq0/xRQJtK3zI3JKOH579yvo3vtXN+81jWoa7ZAA1lJX0oMG
         7dkQ==
X-Gm-Message-State: AOAM532oDmcmxMMbxOWL8SciuONJQi342w3w525knFi4esJLaBQ1hmXA
        rzPPIccKTEEwcjABLKT6mq1aUX74UdF3jJaVlR9Uaw==
X-Google-Smtp-Source: ABdhPJztxG/yxrPY5e4sNf62Kn1bNHGpMkkmYXAFUoysctVppmYp6RlKF3Y/ERcj27cwPr8knlXHCorAw/g5RhQ7LpA=
X-Received: by 2002:a05:6808:23c2:: with SMTP id bq2mr25087505oib.32.1635193368630;
 Mon, 25 Oct 2021 13:22:48 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 25 Oct 2021 13:22:48 -0700
MIME-Version: 1.0
In-Reply-To: <1635070162-21669-1-git-send-email-tdas@codeaurora.org>
References: <1635070162-21669-1-git-send-email-tdas@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 25 Oct 2021 13:22:48 -0700
Message-ID: <CAE-0n52rCpAHndio63yYeN7wnNO=u4c8iL9tpm-rA0reHLLOtA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Add camcc clock node
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2021-10-24 03:09:22)
> Add the camera clock controller node for SC7280 SoC. Also add the header
> file for lpass clock controller.
>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index d74a4c8..8e6b011 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -4,10 +4,11 @@
>   *
>   * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
>   */
> -

BTW, I see this line is deleted but that's probably not intended.

> +#include <dt-bindings/clock/qcom,camcc-sc7280.h>
