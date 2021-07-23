Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 416C43D3401
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 07:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhGWEnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 00:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbhGWEnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 00:43:19 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D23BC061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 22:23:53 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id a19so684967oiw.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 22:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=QrIRJF9RofbYH9iU/wiHncDBO5Vg6i2VjMBiDfskl+c=;
        b=AaOHiU8hxeiJRQI/nQxcRonIBltBTvgos+tyJ2OweZKsTeBIweQGGChjgbH680rgGX
         NdHCLzFKNWs6wchpfAQzRRpRDTAXLFF9flDPZsfHr84g1AoSYW+nmKqKiiX3B0DsH90z
         HxXhUeRpjDvkik0rb3OX/Cwgv3gGa4O99n1fY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=QrIRJF9RofbYH9iU/wiHncDBO5Vg6i2VjMBiDfskl+c=;
        b=NPPGH+uGuoIJ0BFy+B8AbmwM3tcDu2fEGxmrCrAh63asbEMkomwZYG37rit1SGhpae
         9WV621nLuvXo+fOHoHzFm2qX9K40yOXc6hpEsWeIgtcWjSgRBlIe7nmhtAbitUzEgYzO
         QRoY7WeGNtuDysrm6HfI9s4IP6QGvFguejXDU7aRiBk9NOEDSDVNWxiZ42ESsAt/zY2E
         piw18VrkUta01pDfR5Yj/KRMJbfXyU66o3dGB+0004knLyy82K10/PFml11w4z9udZKS
         HsO3ZsxuxayCh0lFPg/aI0jH+qhxHZvErHut1ki36gsnqb59NRHXW8WLnyS9S2olZfoo
         zYoA==
X-Gm-Message-State: AOAM531LOR9fmH/MalOafTNVUQx3B+KgGDLQi7AM6FPmw1fVODOz23vH
        7kIqURRJ6vBNF63C1iiKgYwQiMgNsqENIBHtP6gJDw==
X-Google-Smtp-Source: ABdhPJx5qd3hiNyuX6akrBxVGshX+vTI7xdfErJFXbTfeV1Ph6BJBjuKjtmFvXf/oMSd23Szqu+9XGYUYZITAQzqg9s=
X-Received: by 2002:a05:6808:a83:: with SMTP id q3mr7787904oij.125.1627017832959;
 Thu, 22 Jul 2021 22:23:52 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Jul 2021 05:23:52 +0000
MIME-Version: 1.0
In-Reply-To: <1626992117-28887-1-git-send-email-khsieh@codeaurora.org>
References: <1626992117-28887-1-git-send-email-khsieh@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Fri, 23 Jul 2021 05:23:52 +0000
Message-ID: <CAE-0n50QeAEbphveMJZrPFHg87AyZrTFQdGV2Makc0XJKgNfqg@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dp: signal audio plugged change at dp_pm_resume
To:     Kuogee Hsieh <khsieh@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, robdclark@gmail.com, sean@poorly.run,
        vkoul@kernel.org
Cc:     abhinavk@codeaurora.org, aravindh@codeaurora.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2021-07-22 15:15:17)
> There is a scenario that dp cable is unplugged from DUT during system
> suspended  will cause audio option state does not match real connection
> state. Fix this problem by Signaling audio plugged change with realtime
> connection status at dp_pm_resume() so that audio option will be in
> correct state after system resumed.
>
> Fixes: bd52cfedb5a8 ("drm/msm/dp: power off DP phy at suspend")

This should be

Fixes: f591dbb5fb8c ("drm/msm/dp: power off DP phy at suspend")

> Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
