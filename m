Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4CED4540ED
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 07:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbhKQGjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 01:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbhKQGjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 01:39:01 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD42C061764
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 22:36:03 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id s139so4099950oie.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 22:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to;
        bh=Y7Xd9ph0fDKSywYa55tSEaM+V4r5UmEcGXjx4Q25R9U=;
        b=IVNXIAUC3KPwl7El8I+MErQQuN/F/XfPk53PIjPrOfAPwYM9iy+krBHSX9GaWxWKMc
         WTEMjd1T2A/DbZfgSuLgNo9STwMgWK3EzF6QtPQIji/5G9ofFvmUCr3oTt3amP8C+i1W
         loGy4CdWVsn2L5pDG+uJ8fahpxyuakmmT/fn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to;
        bh=Y7Xd9ph0fDKSywYa55tSEaM+V4r5UmEcGXjx4Q25R9U=;
        b=YxQxXr9V+T/BVSQKksPYVzn7R+h7mjFsTUk37C+mcxtDZCGlsgS5lNPjX1GAi3lIMs
         NmV4MneYDKPVfZzOSSJKmpdfhQ2xy8uLZ2R3NakUNTCNPXQJZIWoDyoJH+CzLfE8lGuB
         a0/xHhDjUNTViLsU5BpBtUTbrQM/bsNPCvh+a1YfRqCyRE7q9JT6OKupw1Bd4dGzq0Mg
         FLP5PXXNTy84DgqCnkiCv9mKuez8rnN1GYewBN5ClWBfXiqmkU1RuArpZT22Kq6qp+QD
         xqcbSHKnt6HdrX8x1D4rrgFbIxzFULA67cJ6FXlWqUDpSluPv5QXwR/s40BlFeJilbij
         SQJQ==
X-Gm-Message-State: AOAM530A3I11JxX3t2DzxR11F62j5Z9d0K//ma4g58THgcBe+ihINfo5
        GpGzoaPd1ZgAfdCdxU2H4rav/Y8ntv9T4J5Y5Jv/2Q==
X-Google-Smtp-Source: ABdhPJx/a4FT1Q2CNnTcgMnNb5L2pkUu10+8GtECVUHin1lv4ihG7qvYSPB8yEOF66UrI6B266m6Eh3GlLfMnkyDLjo=
X-Received: by 2002:a54:4506:: with SMTP id l6mr58749014oil.32.1637130963025;
 Tue, 16 Nov 2021 22:36:03 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Nov 2021 22:36:02 -0800
MIME-Version: 1.0
In-Reply-To: <1637060508-30375-4-git-send-email-pmaliset@codeaurora.org>
References: <1637060508-30375-1-git-send-email-pmaliset@codeaurora.org> <1637060508-30375-4-git-send-email-pmaliset@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 16 Nov 2021 22:36:02 -0800
Message-ID: <CAE-0n50UkMbgEOE9ckbqRfNCr6Pu9ieptUNkpkne1Z-J6HbOAg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: Fix 'interrupt-map' parent
 address cells
To:     Prasad Malisetty <pmaliset@codeaurora.org>, agross@kernel.org,
        bhelgaas@google.com, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com,
        manivannan.sadhasivam@linaro.org, mka@chromium.org,
        robh+dt@kernel.org, svarbanov@mm-sol.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Prasad Malisetty (2021-11-16 03:01:48)
> Update interrupt-map parent address cells for sc7280
> Similar to existing Qcom SoCs.
>
> Fixes: 92e0ee9f8 ("arm64: dts: qcom: sc7280: Add PCIe and PHY related nodes")
>

There shouldn't be a newline between Fixes and SoB

> Signed-off-by: Prasad Malisetty <pmaliset@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
