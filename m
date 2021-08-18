Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8443F0C6A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 22:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbhHRUIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 16:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbhHRUIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 16:08:13 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82B6C0613D9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 13:07:38 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id f16-20020a056830205000b00519b99d3dcbso5619334otp.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 13:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=cfm13iXUxECEplWQ0q6Pxak3YtFCZRWGUuhoBsOQF1o=;
        b=FiSrUv34t+HgydbQhzRo7RHOAQFm9OxrQI98LwsaMAeyJz41igKBAGF/7khk9DESSF
         2uo0zyzxy+hlRiFcu5axiGiY/bPo8RUcNImSiN3Kyq+BuI8hGe5+GFGRUA4J2mgdicgA
         OE3Al9FgiJ2bfV2UIx6fosxcF57TPy/3vdZ7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=cfm13iXUxECEplWQ0q6Pxak3YtFCZRWGUuhoBsOQF1o=;
        b=pA+8NJQ+rG/ID7J7aNO1Qdmkdlg6SdkhG0d2GULy5GQn2RGkCqv6ozsXpA25Pllb17
         Uxu1iIlCXL3g+LmU8YW9RM+zmuURHKXPksXY8IL/P+ek2i+MqzugbcZQQgJ1UizfHMRq
         I8n9IzPeBIumZ5Htbu/PpcMKlPJ69Zg+dOd9nWRjWgJYGxMUgTIePbrzTfF68UfdDwes
         /1MvAN6R6rm1qPyOR2YIPsGhdqQMa15xGs7IlhQwMb4v7XWaqpV3apNScCLKKqGxnUUk
         sdWYpebnCcsw2kt437w3m2xdr2NaRn5eRM9kDlA6PFwlSyZBEwoFq8X4dKa+9RprWkUx
         UYHQ==
X-Gm-Message-State: AOAM531Pnx9ll54xV6P/I7O6J3t8KYhIvGnYEyCuDDez3Cde8TfmN0WH
        bbAVHEXjhwkSRqGrItjMQiQGlEm0lxWWTSzVBjiHWA==
X-Google-Smtp-Source: ABdhPJyELNhhchyiGz4aTzehMCOLQwh2D+h4c08VfwqU9GfrDc66h204pRTnxTXnauLt5QAn0FSePec2ZgVpt81vPKo=
X-Received: by 2002:a05:6830:2473:: with SMTP id x51mr1798273otr.34.1629317258305;
 Wed, 18 Aug 2021 13:07:38 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 18 Aug 2021 13:07:37 -0700
MIME-Version: 1.0
In-Reply-To: <1629282424-4070-1-git-send-email-mkrishn@codeaurora.org>
References: <1629282424-4070-1-git-send-email-mkrishn@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 18 Aug 2021 13:07:37 -0700
Message-ID: <CAE-0n52r-+MjLO0o3JOWCsLHHWVOYNKnSuZYTwiarpJW-M643g@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] dt-bindings: msm: add DT bindings for sc7280
To:     Krishna Manikandan <mkrishn@codeaurora.org>,
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

Quoting Krishna Manikandan (2021-08-18 03:27:01)
> MSM Mobile Display Subsystem (MDSS) encapsulates sub-blocks
> like DPU display controller, DSI, EDP etc. Add required DPU
> device tree bindings for SC7280.
>
> Signed-off-by: Krishna Manikandan <mkrishn@codeaurora.org>
> ---

Please send a cover-letter next time.

Do you have the display port dts bits and driver code ready too? Can it
be part of this patch series?
