Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3734B38CFAB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 23:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhEUVQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 17:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhEUVQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 17:16:50 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A6CC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 14:15:25 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id h7so10515031qvs.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 14:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CDXffk8yuVYOn1p3JAQ7iuPJM3NbY++kDuUelyU/OiQ=;
        b=IUe8dgsBYwdkeskH874YCPmph/UsPTlXVZoGqqKDDhoBMBgaFAVyPAsh42s2HQ1qrL
         Oe01LVrNZhKPvoHDtSKhAaGKIMuxoRrXuKb6wZlD10kYHdcwfnc+FCI/bz87BebQf5hw
         Flyruw2yZu5Oa2kYYTQ1hAmjWnRoMq4kjU/gY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CDXffk8yuVYOn1p3JAQ7iuPJM3NbY++kDuUelyU/OiQ=;
        b=MTGMUWC3yEiNDGJn6NIomakp1VDBMeAxLD52ftUOab14+Z2989LFmFJmpMCQSQ9avV
         sG4Np1S1F+ZFgxlnAhxH2+wLYzIwNDLswSfTF+1hWSGFsA0TjGGbwqTtfEoYRLKrV6lt
         x8r0UJJBB0Ou8Td/R0Js+HospoKxAIIgLZ1wWaL3SuntUxAzdZBODyFcBTYAseCgCxlk
         Ja5APrZSYAfpi5Uun9yic1a3Dff/I7/0xHGmpBQOZ+AdyuwonGHUyL1So9hAVroUMKx/
         oEUnrnARDhFMwE5K2HaqMt8Bd7dKi0YTy5h8maQVbL4A+I983yU77c5StGiW2sNWxChM
         rsxw==
X-Gm-Message-State: AOAM531PA1r7uSdK5Def/y5F2GMwPE0MExNP7Z3Zz446MQOBGxNzjw4J
        /mVmUrBK9SW24R1zBjNIQRwmg8qAiyjRjQ==
X-Google-Smtp-Source: ABdhPJxqZQXqwN7JF2MkF0K187v1vIDRgPqvowrwbUaSIM5I+nikmpdm57XnsDIGmxBsXVWHBlyPNQ==
X-Received: by 2002:ad4:478d:: with SMTP id z13mr15723607qvy.39.1621631724273;
        Fri, 21 May 2021 14:15:24 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id t128sm5567668qkh.50.2021.05.21.14.15.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 14:15:23 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id b13so27890686ybk.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 14:15:23 -0700 (PDT)
X-Received: by 2002:a25:734d:: with SMTP id o74mr19566830ybc.32.1621631723160;
 Fri, 21 May 2021 14:15:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210521200529.1991729-1-sujitka@chromium.org> <20210521130511.v1.1.Ia83c80aec3b9535f01441247b6c3fb6f80b0ec7f@changeid>
In-Reply-To: <20210521130511.v1.1.Ia83c80aec3b9535f01441247b6c3fb6f80b0ec7f@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 21 May 2021 14:15:11 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VO6aiAULtsDbqbJd+F-BXxyOOKvwRXxUCahQEetdfcbA@mail.gmail.com>
Message-ID: <CAD=FV=VO6aiAULtsDbqbJd+F-BXxyOOKvwRXxUCahQEetdfcbA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] arm64: dts: qcom: sc7180: Move sdc pinconf to
 board specific DT files
To:     Sujit Kautkar <sujitka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 21, 2021 at 1:06 PM Sujit Kautkar <sujitka@chromium.org> wrote:
>
> Move sdc1/sdc2 pinconf from SoC specific DT file to board specific DT
> files
>
> Signed-off-by: Sujit Kautkar <sujitka@chromium.org>
> ---
>
>  arch/arm64/boot/dts/qcom/sc7180-idp.dts      | 102 +++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 102 +++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sc7180.dtsi         | 102 -------------------
>  3 files changed, 204 insertions(+), 102 deletions(-)

Yup, this looks good to me. Basically a no-op change moving this to
the two boards.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
