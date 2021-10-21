Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B95436AAA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 20:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbhJUSkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 14:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbhJUSkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 14:40:18 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFD8C061348
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 11:38:02 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id i24so591825lfj.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 11:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=ALLaW870u1D1a3B4tAR7fsm6fvwLLBmkhU/jhS/DyGQ=;
        b=RFcdf8vxBZSlF3NhN63EcUhe39FktWlYXAtFZyTy04hol6b95W6yQpfhhSBjy4r8m7
         VUFtR/fHTZJk1PPVMdk8JBd6hYmAzzWB601z67ELbEEb6wHw8OegxXMfZd5VyCpIvVmk
         Z1Ywi86yueW+7Pmna+OtBJkZ6nniow00mAWj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=ALLaW870u1D1a3B4tAR7fsm6fvwLLBmkhU/jhS/DyGQ=;
        b=RMppvgy5gn5ge3JxFoLUlsOudojaokjah3vNbrwBYwW3UxhLPnUyN33BrSwnNx41qv
         a5W2adbT5UfwWhV7Rlqjw9HFDH3KwM/qJCQ010BgCGmsgcZ08BxUq7wZpEH2Wgkolyhf
         C/K9ovNsjPJxh4hGgr3KU1hUGJgI9kURQZWnC0Bxs/kTf8X7HTCNtsoz6vxE/ix89yUY
         //xJonAP0v02h2V26J0uugcrGHEUxRhMzDpqsKct0ibf8QLp9R4IiLn3HBHQYHoEo3ZJ
         BRFIBsHTmOtGZQpi3teA72MEG5RAhsHpIU/tExaCfN4esdnCgUB7VUUC2P/Jxb8ht88e
         6QQA==
X-Gm-Message-State: AOAM533RTzCvmZ4I+lP7r3tckpB0PO/vmDtTg6HlVC82pLkfU8RLufTS
        0bN9nmqj17M+Epyr/LAqWIOxCQ2MdP+qshOy22wITQ==
X-Google-Smtp-Source: ABdhPJzt5GhiXXEzu0cgd6TJgL13cjs2Vjd06K5GNoIpxGCZQz7SctOsayb2q+AEKJocwmLURo2d1holaUwo0FaEQVo=
X-Received: by 2002:a05:6512:63:: with SMTP id i3mr7201386lfo.74.1634841480855;
 Thu, 21 Oct 2021 11:38:00 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 21 Oct 2021 11:38:00 -0700
MIME-Version: 1.0
In-Reply-To: <1634738333-3916-1-git-send-email-quic_mkrishn@quicinc.com>
References: <1634738333-3916-1-git-send-email-quic_mkrishn@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 21 Oct 2021 11:37:59 -0700
Message-ID: <CAE-0n52+B0dWa_axZpA1T3mL0rGp96Ov+HanNxGf+Dpr3sUogQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: msm: add DT bindings for sc7280
To:     Krishna Manikandan <quic_mkrishn@quicinc.com>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kalyan_t@codeaurora.org, sbillaka@codeaurora.org,
        abhinavk@codeaurora.org, robdclark@gmail.com,
        bjorn.andersson@linaro.org, khsieh@codeaurora.org,
        rajeevny@codeaurora.org, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krishna Manikandan (2021-10-20 06:58:50)
> MSM Mobile Display Subsystem (MDSS) encapsulates sub-blocks
> like DPU display controller, DSI, EDP etc. Add required DPU
> device tree bindings for SC7280.
>
> Signed-off-by: Krishna Manikandan <quic_mkrishn@quicinc.com>
>
> Changes in v2:
>   - Drop target from description (Stephen Boyd)
>   - Drop items from compatible (Stephen Boyd)
>   - Add clock names one per line for readability (Stephen Boyd)
>   - Use correct indendation (Stephen Boyd)

This changelog should come after the triple dash. qcom maintainers don't
want drm style changelogs in the commit text.

> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
