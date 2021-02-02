Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6F530C750
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 18:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237306AbhBBRRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 12:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236857AbhBBRO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 12:14:29 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AC9C061788
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 09:13:49 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id nm1so2666938pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 09:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=R9+VZ08mb33ZsTxVzQHNgGkTJo5Su5clNDxSbYpH3ag=;
        b=diRSFPRygD49Poc/JZ4AusskfpBz3SaZRrJbDOY2fzcR5LXqQZkKd93tiH5mFnVm+c
         l1os581Ds05eO63iyR7OnzGQMv2TCaYRXhmgGXRHMgUlySvwd30gJYp/5SmK4zxMQ/r3
         vIwgooy/K8jXDGjVec6xdrGb/eVPIVdbTEm8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=R9+VZ08mb33ZsTxVzQHNgGkTJo5Su5clNDxSbYpH3ag=;
        b=mEo6wl8HQp/+kvJI5ZArUc8OQpnm3K0s56QK/1nO1V90vkB7W2D7FI2Yu4+GJ8no+4
         KV8nke4A21wweCBIcu9LVm+uV3VRs9766+9lsJc2XGIsOqeYrOMg9WSD3BNsYCcoOuHC
         hSXYxI7e2dYNoGMcSDOsI4fhMAuKdFpw3SlSyLPBG3acRq/1fn06WWWi7sn3YR+43sim
         KShlOIWIN6bztIw6WqaExe19e4Vt1/p4PEEUx9aYsAeEcTPk/lUityErslyijj8c0gRV
         fThypmKTUmqKT92gJjbuMxJa8Z01SF36ImsS4kKEJz+ONVQCTM3ybpaKleLU51XgUAWJ
         UYRQ==
X-Gm-Message-State: AOAM5322XjGwuQKCJJ8eotINvEHh6gq/8j5Io0bwR0OYRVSMSq1vocf3
        wsa5tAQmnCIU/Gjk8MWdudBITQ==
X-Google-Smtp-Source: ABdhPJxEYEQvyqydvkJ+XYVfnYzEhjQ5pqGLkN0GNmAahlnaTN7GjhaapXRizG0V3QW8Ky6mrCbAVQ==
X-Received: by 2002:a17:902:d4d0:b029:df:d246:ca81 with SMTP id o16-20020a170902d4d0b02900dfd246ca81mr23826450plg.58.1612286029370;
        Tue, 02 Feb 2021 09:13:49 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3571:bd6e:ee19:b59f])
        by smtp.gmail.com with ESMTPSA id c17sm21839493pfi.88.2021.02.02.09.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 09:13:48 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210202062727.22469-1-srivasam@codeaurora.org>
References: <20210202062727.22469-1-srivasam@codeaurora.org>
Subject: Re: [PATCH] ASoC: qcom: Fix typo error in HDMI regmap config callbacks
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        agross@kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, bjorn.andersson@linaro.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        lgirdwood@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, perex@perex.cz, plai@codeaurora.org,
        robh+dt@kernel.org, rohitkr@codeaurora.org,
        srinivas.kandagatla@linaro.org, tiwai@suse.com
Date:   Tue, 02 Feb 2021 09:13:47 -0800
Message-ID: <161228602729.76967.7642340787963440028@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2021-02-01 22:27:27)
> Had a typo in lpass platform driver that resulted in crash
> during suspend/resume with an HDMI dongle connected.
>=20
> The regmap read/write/volatile regesters validation callbacks in lpass-cpu
> were using MI2S rdma_channels count instead of hdmi_rdma_channels.
>=20
> This typo error causing to read registers from the regmap beyond the leng=
th
> of the mapping created by ioremap().
>=20
> This fix avoids the need for reducing number hdmi_rdma_channels,
> which is done in
> commit 7dfe20ee92f6 ("ASoC: qcom: Fix number of HDMI RDMA channels on sc7=
180").
> So reverting the same.
>=20
> Fixes: 7cb37b7bd0d3c ("ASoC: qcom: Add support for lpass hdmi driver")
>=20
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Tested-by: Stephen Boyd <swboyd@chromium.org>
