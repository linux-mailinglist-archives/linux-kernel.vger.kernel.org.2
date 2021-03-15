Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E40C533C700
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 20:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbhCOTo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 15:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhCOTog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 15:44:36 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFDEC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 12:44:36 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id l11so4490867otq.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 12:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VY11BYIgAhCdWHUv8waddSOddoxkrAGuQw5MjJrS3vE=;
        b=GDpRPRI//le1LnCEZjHY3CRsvGZn1WUwU0XqZETVFu0JTsDRUob8NaBFBE/QPkSije
         lWALMkwyNNGg0/Az5S/GYNsvSdsOM3ItFDLJORMlJZ088/Ja9Zvrbu0IQhhQGbMfAjt2
         G3C1QHIazpw562mBVqTlCFFPlIarX8xkZfckg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VY11BYIgAhCdWHUv8waddSOddoxkrAGuQw5MjJrS3vE=;
        b=mVpUaVG2DyU61z3TV6E6+OmY80tpt1ddH98baEPfr6V9/r+pxcXZXqZwWLQlKI1TBM
         KvOC09WWXb9R9+aJl4A/mZ+4aLCuMu6kMUoMWTMv5axtYx1QXbY3C4yq6cMU4qzKU3q5
         5YT8O5UXKMIffAWFLxb6mLRYm9zoibd4iBs4GlKwFTJSepq+IOs5MfDrC8xmQVHoTWuq
         lEzrHnjMLuKTF0w8Mk9RZem16nuzCkK341vE1sVzAD0TljiYvQl1wuWJPfU/g4DuU73+
         QTkwM1HGlSf40GlIeLCJwvxi8b+LdkoOdLNCgGJ0UeycayyKV9AB8mSw27+1VIWScMNH
         R6BA==
X-Gm-Message-State: AOAM533DECRP74R/8m83vNnkJ8OFAwDUnb5sspGUom3lHG9Ckc1IGqxE
        BKQRqpaHQX4riQt8k8QM3FvcrOP37vRSGg==
X-Google-Smtp-Source: ABdhPJzNC5Y78oh34VUppI/KC6ocMq7JvBqcujKsw7IjOilw9jbcVeTMomWrHw9SJCfHSPgDn0fIag==
X-Received: by 2002:a05:6830:3497:: with SMTP id c23mr558380otu.344.1615837475547;
        Mon, 15 Mar 2021 12:44:35 -0700 (PDT)
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com. [209.85.161.47])
        by smtp.gmail.com with ESMTPSA id n22sm6706685oie.32.2021.03.15.12.44.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Mar 2021 12:44:35 -0700 (PDT)
Received: by mail-oo1-f47.google.com with SMTP id j20-20020a4ad6d40000b02901b66fe8acd6so3567519oot.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 12:44:35 -0700 (PDT)
X-Received: by 2002:a25:cf88:: with SMTP id f130mr1887543ybg.476.1615837084349;
 Mon, 15 Mar 2021 12:38:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210314061054.19451-1-srivasam@codeaurora.org> <20210314061054.19451-3-srivasam@codeaurora.org>
In-Reply-To: <20210314061054.19451-3-srivasam@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 15 Mar 2021 12:37:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VcOsSsn1MGkhd-t0dPv4cTOO2UV6+44oPrZ5iS0-f56w@mail.gmail.com>
Message-ID: <CAD=FV=VcOsSsn1MGkhd-t0dPv4cTOO2UV6+44oPrZ5iS0-f56w@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] arm64: dts: qcom: Add sound node for sc7180-trogdor-coachz
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Judy Hsiao <judyhsiao@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Mar 13, 2021 at 10:11 PM Srinivasa Rao Mandadapu
<srivasam@codeaurora.org> wrote:
>
> This is a trgodor variant, required to have sound node variable
> for coachz specific platform.
>
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

With these two patches plus commit 9922f50f7178 ("ASoC: qcom:
lpass-cpu: Fix lpass dai ids parse") in the sound tree I get audio on
sc7180-trogdor-coachz! Thus:

Tested-by: Douglas Anderson <dianders@chromium.org>
