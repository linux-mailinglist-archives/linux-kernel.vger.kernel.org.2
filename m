Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA0045283F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 04:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343755AbhKPDMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 22:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239810AbhKPDMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 22:12:40 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD30C10E5C7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 15:39:28 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id b5-20020a9d60c5000000b0055c6349ff22so30199281otk.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 15:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=0r6JTcdejGzU6nsZn/1Xqgl+XNT+bHSUSIJqwEF6P5I=;
        b=HWhPucp0iue/5BCvKtcMziH/SE9slJFIAE5tlwez/Q8+1HJGha6SJ8GlkG1CmG6s2+
         2R8+3Sl6It+RGVDcidgJqLZWNNfZsyBtflsD+zEJGUXer2TuehVftpnXkA8dIPYwAinn
         N29XMNSd/DijdWsqj5XEMxPosQuePaHFfYE5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=0r6JTcdejGzU6nsZn/1Xqgl+XNT+bHSUSIJqwEF6P5I=;
        b=nIH+LFc1/AaAmEGAMjCpb25c7SdiCIKokXK3w5j1a5ReyWp2kw+uiGd9ptd4UIKLPj
         bruFXS+GIFQRB2HlYFi6kOD9sgEpihWc3t6CvBcNB6rbNViIvy495v/q22yQWk9sdqvl
         WFJl9MdBIF16d4H59fzaDxpygffK7ItDfKVyLBJhX4vioxmxhkrCjdL8CnM45+rEb6nq
         SnFtFn+MdorHuE2m7vESCbfI/zKsx8D4v9d5SZO2VUwUdY+gXbWUhBoyciJ3AZrpjY41
         3l7icLRTbuL6zNB6hln/T8Hq5jaONp5KVCAd5VLkulVIJTasARbugj7Jrj0zdZm/20U1
         9g5g==
X-Gm-Message-State: AOAM531NP/9Cx42wI5oVCy3SZHKVDy9TuNTuTHAgwsmTa3rqb4cbPSrL
        g9WBXwFAxUp36qXJqdeheGbkwflWuyNBxUNqneHGPA==
X-Google-Smtp-Source: ABdhPJzC1gjX/8UQ6va8Dux2WwnKx59xgq+wgXAUVpZ1ewPHwjoYDMuhWR0XxIu9/V2evROn1oFvLn8lYWyyy69HTTs=
X-Received: by 2002:a9d:7655:: with SMTP id o21mr2383170otl.126.1637019567581;
 Mon, 15 Nov 2021 15:39:27 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Nov 2021 15:39:27 -0800
MIME-Version: 1.0
In-Reply-To: <1635896673-5841-1-git-send-email-quic_khsieh@quicinc.com>
References: <1635896673-5841-1-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 15 Nov 2021 15:39:27 -0800
Message-ID: <CAE-0n53ArJSYEAtLbc5dFrPspKhi3Kv=hpu=wS1TMsOWcmz6pw@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: dts: qcom: sc7280: Add Display Port node
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        robdclark@gmail.com, robh+dt@kernel.org, sean@poorly.run,
        vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, aravindh@codeaurora.org,
        quic_sbillaka@quicinc.com, quic_mkrishn@quicinc.com,
        quic_kalyant@quicinc.coml, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kuogee Hsieh <khsieh@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2021-11-02 16:44:33)
> From: Kuogee Hsieh <khsieh@codeaurora.org>
>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---

What tree is this based on? I don't see edp_phy upstream for sc7280

Otherwise, looks good to me.

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
