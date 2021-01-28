Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F01E30718D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 09:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhA1Ibm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 03:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbhA1Iau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 03:30:50 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89039C061756
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 00:30:08 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id 31so2915782plb.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 00:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=ylVX93kG0pfKLjOK+VyaAAnOVEasqsi8+AYeDV5CIVc=;
        b=m1b089FNnXo/FIiunebnJhh/k60S/WpehXj3Sn+4cJjvq7c7gjsn3qu3e1LmwBksDI
         c1uj3sQjem5jPatGk0juLcrRCEyooTxLT869X7uL5VkZRiITvBItmB0neRIuYzBqVhX+
         ewZGSlmSnNBvkKwWR0vJTGCrtbVA/WUvXlyBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=ylVX93kG0pfKLjOK+VyaAAnOVEasqsi8+AYeDV5CIVc=;
        b=iUTQEwfqcF4pldYEm21F7WRsOgSMHmZdm1cnxkEyb5NSXXoMJik3a8baOprJq7fopp
         qxQ46/sG3XSa6PE8Hit7GaWP+uL3dRRqEM2AhbzWrD651v2k+mSRECLWBZdcedOYSfj3
         Pi3KSQVQ2V9cEEBjDrLglGmNb+srzvcHP7uRxzFpsa9cDNq5SizZiBf/ZSirjlJO3go2
         gae5Y64dQ9rDXpsMJk6/Uozu+fhXeUZuwHaAe7st3qlRPPMMq/0ed1MKaaOlf8T7xnNb
         vASdR4Vpc+UBW5SguJkgWr3R5ZIB8yS2oA6/rBf99RM9T393QylNG842Dy33wVkfTGPD
         3f/Q==
X-Gm-Message-State: AOAM530PWvzs8bbc1Yi59CLr5r0ufduBXt4SfqZ5yBWTdJHFl7DdU0kb
        kV9ww88v0OrITweRaB7ZkbmJ7Q==
X-Google-Smtp-Source: ABdhPJxv0VGQQsxMPwF5kTuNuglyyXV6LtQH2Bm9BpqAnuekS43gpU7rJFA5oCN9CaT2gYItOLy3cA==
X-Received: by 2002:a17:90a:df0c:: with SMTP id gp12mr10171448pjb.3.1611822608072;
        Thu, 28 Jan 2021 00:30:08 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:304c:5453:303a:8268])
        by smtp.gmail.com with ESMTPSA id l190sm4813102pfl.205.2021.01.28.00.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 00:30:07 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210128021753.2560931-1-judyhsiao@google.com>
References: <20210128021753.2560931-1-judyhsiao@google.com>
Subject: Re: [PATCH] drm/msm/dp: trigger unplug event in msm_dp_display_disable
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>, Taniya Das <tdas@codeaurora.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Patrick Lai <plai@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>, dianders@chromium.org,
        dgreid@chromium.org, cychiang@google.com, tzungbi@chromium.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, Judy Hsiao <judyhsiao@google.com>,
        Judy Hsiao <judyhsiao@chromium.org>
To:     Judy Hsiao <judyhsiao@chromium.org>, linux-kernel@vger.kernel.org
Date:   Thu, 28 Jan 2021 00:30:05 -0800
Message-ID: <161182260580.76967.3767678954967498619@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Judy Hsiao (2021-01-27 18:17:53)
> 1. Trigger the unplug event in msm_dp_display_disable() to shutdown
>    audio properly.
> 2. Reset the completion before signal the disconnect event.
>=20
> Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>
> ---

Fixes: 158b9aa74479 ("drm/msm/dp: wait for audio notification before disabl=
ing clocks")

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Tested-by: Stephen Boyd <swboyd@chromium.org>
