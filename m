Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC4E3D689C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 23:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbhGZUqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 16:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhGZUqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 16:46:18 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A04EC061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 14:26:46 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id n1-20020a4ac7010000b0290262f3c22a63so2571884ooq.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 14:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=dsXLrpCdTeZdTsazEhHari1/KxHVLO68J91/QVfecJs=;
        b=aAWGFqPFyI0kkrSxC4Fy7yP5VdRgQ3oXaBHb6bTRznq7iougjzTRIHv/qBQbBTseao
         4ekq90X8LiToPoOziZohy0HRfqgZ19xE5EOnzExavHL48gvfUri/n0YhD+1FSiTTYk/v
         EFwKXMDulBpzkSeJUWtA4ZTal1kWRv7CYgeZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=dsXLrpCdTeZdTsazEhHari1/KxHVLO68J91/QVfecJs=;
        b=faERLAaWEuM8uOKAFOEmYhj31OJN7t5MErFu4T1i1cFjEhmqYoNoYh1m18PTQYsxBc
         qQaS/Ro+JTfe10aUAM6Nx1FzjwquY/+AU+G983Uk6muYNRiZtWsjd6oQ6zXLxPjfzcHo
         +9D2pKkebziM6MuGj2/O+IgQKCcn4oYWUznfLBoP1kaZkxfeE3qnR2hT/WlLLwrDgUbY
         olL+5vdOnZd0VtC27kIYRMOjRcZMUcntsfT8GFxC3d9Ks/01Wc2Qy+9qhOyG9Md58tZH
         2EzkyAsqbSrLhpn3goZbdHk2wvIA2c/kN4+SYr6szlzBHLqm6FIv6/bGvg3bX6BINfzs
         m9zA==
X-Gm-Message-State: AOAM5310t/dpPWuRyiF7cl1FvUK8VXLOOKP/wF0hkG8L+6EbmtKNan2+
        GNpbcJkJw8XbneNowNIMsLzVuj6Kz7+qgCPhVLVs7g==
X-Google-Smtp-Source: ABdhPJzO02a2bZc7k1feIJVeSEY+Tn0KBX1O7wFM+yGIo+VYF2Zdo5F+gt2SfRXZ51hs8JhzLs/n/vHjZp6jarqJBGk=
X-Received: by 2002:a4a:a6c2:: with SMTP id i2mr11718060oom.92.1627334806023;
 Mon, 26 Jul 2021 14:26:46 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Jul 2021 17:26:45 -0400
MIME-Version: 1.0
In-Reply-To: <20210726120910.20335-2-srivasam@codeaurora.org>
References: <20210726120910.20335-1-srivasam@codeaurora.org> <20210726120910.20335-2-srivasam@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 26 Jul 2021 17:26:45 -0400
Message-ID: <CAE-0n52HKAN1ATOhhTOt6TQo_gke2qaOWGywZU3qvDAj4b9rEw@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] arm64: dts: qcom: sc7180: Update lpass cpu node
 for audio over dp
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, dianders@chromium.org,
        judyhsiao@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        rohitkr@codeaurora.org, srinivas.kandagatla@linaro.org
Cc:     V Sujith Kumar Reddy <vsujithk@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2021-07-26 05:09:09)
> From: V Sujith Kumar Reddy <vsujithk@codeaurora.org>
>
> Updaate lpass dts node with HDMI reg, interrupt and iommu
> for supporting audio over dp.
>
> Signed-off-by: V Sujith Kumar Reddy <vsujithk@codeaurora.org>
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
