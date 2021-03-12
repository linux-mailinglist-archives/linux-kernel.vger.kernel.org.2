Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B83C339912
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 22:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235237AbhCLV2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 16:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235165AbhCLV2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 16:28:25 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA9DC061762
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 13:28:25 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id s7so25867738qkg.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 13:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8axFXEbeUUKhC51b/Zbb+pz1bcSRSZPhDQ6IrijfhIA=;
        b=B28f+Z5CSKc5xbTKtMVU9/m1anUyDUmueNMuPUDLur4M9F/uAgVBH8EzrHsY1lVfNf
         1JrINUh28Q8zXAo8zMB+DeM8pXXDJHTcIcfmQWioYBZ/ccrJkVpKc2BNeb8A77/RRsQu
         PUdGRPUHIa5J6ohWMcFxrYEyfWOoihlNosARk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8axFXEbeUUKhC51b/Zbb+pz1bcSRSZPhDQ6IrijfhIA=;
        b=oyN0uPA9yGNJP7iU878bO66mReFVGQmO9Ep27FyJA2al5PWzDkqModd5ftEuMcZewa
         cVjqQBnqdABwS7Vj0Ly7tbkNhZMzLip5i9V18e6z6ZB6X/Vd99qA0GLA8Fab+TgUiSbP
         aHnGKk8er697pJf38qYgELYAJAj+HQLEfPT+K8C6WIMP/pPe+NGw2BSP+EuVlVRpqiky
         xN9z51f8NxC2ymhS6nqi4u5j+Xpo/klcaMKN7xHWUmcLTutwxR+vuzIJYI8m+B2DxAPi
         cjMiUvDBxbVUxl22XCqPWeBl7jGjU57uyyoF8JJuzHLPzDp0FtJ+3TeqIUFyAwp2NO/G
         3BeQ==
X-Gm-Message-State: AOAM530PGkh5x4H2tQDnFn1jvzsaBajsYgBNywbTftRsOk9CM2Xwr2Tm
        LqeBB7v3Yf9MFfFKq7YQA7Df/B5VlW/MyQ==
X-Google-Smtp-Source: ABdhPJx2rvFDpWuv7xAhX2VK6aT4KAflXXjqe4aYwpZFxXjdt01C0WTqHqmY/lQmeCpjq9aLU0BWyA==
X-Received: by 2002:a37:65d4:: with SMTP id z203mr14168916qkb.254.1615584504464;
        Fri, 12 Mar 2021 13:28:24 -0800 (PST)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id f8sm4627215qth.6.2021.03.12.13.28.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Mar 2021 13:28:23 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id h82so26768093ybc.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 13:28:23 -0800 (PST)
X-Received: by 2002:a25:ab54:: with SMTP id u78mr22419877ybi.276.1615584502806;
 Fri, 12 Mar 2021 13:28:22 -0800 (PST)
MIME-Version: 1.0
References: <20210312160622.24165-1-srivasam@codeaurora.org> <20210312160622.24165-2-srivasam@codeaurora.org>
In-Reply-To: <20210312160622.24165-2-srivasam@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 12 Mar 2021 13:28:11 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UmLh+RBucrcW=Y3HgD-E4g9vAEK-G4Aj0enszETwBciA@mail.gmail.com>
Message-ID: <CAD=FV=UmLh+RBucrcW=Y3HgD-E4g9vAEK-G4Aj0enszETwBciA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] arm64: dts: qcom: sc7180-trogdor: Add lpass dai
 link for I2S driver
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Ajit Pandey <ajitp@codeaurora.org>,
        V Sujith Kumar Reddy <vsujithk@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 12, 2021 at 8:06 AM Srinivasa Rao Mandadapu
<srivasam@codeaurora.org> wrote:
>
> +               dai-link@0 {
> +                       link-name = "MultiMedia0";
> +                       reg = <MI2S_PRIMARY>;
> +                       cpu {
> +                               sound-dai = <&lpass_cpu MI2S_PRIMARY>;
> +                       };
> +
> +                       multimedia0_codec: codec {
> +                               sound-dai = <&alc5682 MI2S_PRIMARY>;

Please change "MI2S_PRIMARY" to "0". "MI2S_PRIMARY" is a numbering
system for "lpass_cpu" not for "alc5682". I'm not aware of symbolic
names for the alc5682's DAIs.

From digging through the code and testing, it appears that for alc5682:
0 - aif1
1 - aif2

Thus you could be a little more documenting by doing:

sound-dai = <&alc5682 0 /*aif1*/>;

-Doug
