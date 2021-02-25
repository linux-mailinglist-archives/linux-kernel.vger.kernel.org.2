Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D05325995
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 23:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbhBYWWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 17:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbhBYWRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 17:17:55 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A32C061756
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 14:16:59 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id f17so7309571qkl.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 14:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/28pMZEAxPunJv3VDFxY9qRg4v622m5ASv9egU51f+c=;
        b=MQqIRfSbdfNH5JT7Cx56a6oYyOuCTo5vwJnGQX1ixbtEe2ZnSFKMyks+3R0hidOSsU
         5y11pQl7qRHZFSnlriBPtKO4SsalOauMyCuLbf7loI2mdGba3ibmGSkhzjgjXEXIFb/v
         7J7ZoUcOwTarrmA3X5j1xmeQYemg69GihSM58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/28pMZEAxPunJv3VDFxY9qRg4v622m5ASv9egU51f+c=;
        b=hsgE8bNU55e+KZBo9TzcLL0fYX/YquU3ajobh7BOmP7jN/NKjNZ+n7WSqn9qzxIJG+
         L6vPbfq1tsrFCeQkRdCkRZixno8DKScU4ttuAZmAWfl3DiLn0Np8mbMBpvUB1CtHun2e
         ftkRkkbr9nFLkYIJ7VfWo86iaOy2CeaICeMqaXuvpXrfl7tM5bMkaAm50U8++cCGWEqA
         7xF/FmsN2IMP82YEUf75jwZsJ4FtK8/Y54TXjiU7tfxuSlGaG9C5fAJP3M4P6Kr8CT5B
         I3guwTGyTXfyUtdfZRb8NePzozr+tjUy/U/nehPNZf6iPaSsPnHld56wzHWHk3jCVm0u
         yaDQ==
X-Gm-Message-State: AOAM533lsHpVvTvsBJmo01M+jIIWug3rVehFcjf+qgeAwPTefrUxysid
        x/vrqd+CHa4zbY3VFZjwWVTvmmqQ6TN1+w==
X-Google-Smtp-Source: ABdhPJwMfk83slZBREYdVFKmUhKSS081f+VzKg/JpTyjeF8bBoUrnxDv8cF+at1Ga7myrzKHjHXsMQ==
X-Received: by 2002:a37:9a84:: with SMTP id c126mr4787909qke.399.1614291418487;
        Thu, 25 Feb 2021 14:16:58 -0800 (PST)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id 136sm4881877qko.12.2021.02.25.14.16.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Feb 2021 14:16:57 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id d9so7013501ybq.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 14:16:57 -0800 (PST)
X-Received: by 2002:a25:ab54:: with SMTP id u78mr101535ybi.276.1614291417357;
 Thu, 25 Feb 2021 14:16:57 -0800 (PST)
MIME-Version: 1.0
References: <1605526408-15671-1-git-send-email-srivasam@codeaurora.org>
In-Reply-To: <1605526408-15671-1-git-send-email-srivasam@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 25 Feb 2021 14:16:45 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VipGLw+wqzb-ies2LK8esP3=PfFjpxubH2YYONQt5jCA@mail.gmail.com>
Message-ID: <CAD=FV=VipGLw+wqzb-ies2LK8esP3=PfFjpxubH2YYONQt5jCA@mail.gmail.com>
Subject: Re: [PATCH] Asoc: qcom: dts: Change MI2S GPIO configuration to pulldown
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        V Sujith Kumar Reddy <vsujithk@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 16, 2020 at 3:35 AM Srinivasa Rao Mandadapu
<srivasam@codeaurora.org> wrote:
>
> From: V Sujith Kumar Reddy <vsujithk@codeaurora.org>
>
> Change LPASS MI2S gpio configuration to pull down from pull up.
>
> Fixes: 9b72f4e6a3f8 (arm64: dts: qcom: sc7180: Add lpass cpu node for I2S driver)
>
> Signed-off-by: V Sujith Kumar Reddy <vsujithk@codeaurora.org>
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Should be replaced with:

[PATCH 02/13] arm64: dts: qcom: Move sc7180 MI2S config to board files
and make pulldown

https://lore.kernel.org/r/20210225141022.2.Id27e7e6f90c29bf623fa4880e18a14ba1dffd2d2@changeid

-Doug
