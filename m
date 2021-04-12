Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF67635D3C7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 01:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244442AbhDLXQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 19:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241881AbhDLXQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 19:16:57 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B2DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 16:16:39 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 30so7202427qva.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 16:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uUysqPcVScshCWNmq+4LaopyuP9HdeVJMmV1VT6XP+Y=;
        b=W75v1fZMpylDD7xLu+nJdgkNAIo3NBSGzAF6M2JoZ2TF94FTH630yBz0iWXBFC+8ck
         nUL/us/eFm9pk0sZH7Rb8smdKe6v8UuY7EeDTLW5Hk9gncCQKyY1txlul6ubstOrpQHp
         XDdwETVySNZJiR31vKJlwbc1e1h8p2SG8XhFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uUysqPcVScshCWNmq+4LaopyuP9HdeVJMmV1VT6XP+Y=;
        b=fQrMtLCD5Ln13oUtv2Wq9GxlHYAj0ayA+YXoHuC8OIzMmutd9uHS/sqvb5ldWZB/OJ
         sdmWOcWKWq+Bp9FwGM+b3C00aSIBcTrwC4moM41iUEkPEBwYYzPcZy/fEheY8j8NISba
         GidKzlrXpYlGIJs3o2jEPNXJsJInUg3K3OY3x85GlOZVZzBxIAvfNi/9b9aA7RABrKX8
         Rruun5Xu4Yjod/lQZ+KrY4KmRZ/5NdaKAvz3OdwCwuXcEn5nMEeR7shQn4hHHtcrxEYJ
         f3ABama+fwvTbBqJhzeddTHaHb797H6KQBVMAb3npXUpH/vO8shHnGbxZcE402rnyWL6
         9YCQ==
X-Gm-Message-State: AOAM532pac0FfdLT+tErwTZ0ahY6Xgg6Z9z3w6znSH4Ad1vHsuC2unhp
        eyuwpGMv0tptIkL6u/VwnccX2G8AFQ7qYA==
X-Google-Smtp-Source: ABdhPJyvf4p/7xKuAXLHUMYmFaTR0FiUN2ygMf8CUKOrSHXdhLvTfrqYPbR+MKvpY9gqvVU9qkdA3A==
X-Received: by 2002:ad4:498d:: with SMTP id t13mr23774664qvx.49.1618269398188;
        Mon, 12 Apr 2021 16:16:38 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id k126sm9011605qkb.4.2021.04.12.16.16.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 16:16:38 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id z1so16057716ybf.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 16:16:37 -0700 (PDT)
X-Received: by 2002:a05:6902:4c3:: with SMTP id v3mr7697541ybs.276.1618269392732;
 Mon, 12 Apr 2021 16:16:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210315133924.v2.1.I601a051cad7cfd0923e55b69ef7e5748910a6096@changeid>
In-Reply-To: <20210315133924.v2.1.I601a051cad7cfd0923e55b69ef7e5748910a6096@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 12 Apr 2021 16:16:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=ViWgXzudGAiVLakaKuGK_gEnUxQ8nOkZjCrxQHjdGx9w@mail.gmail.com>
Message-ID: <CAD=FV=ViWgXzudGAiVLakaKuGK_gEnUxQ8nOkZjCrxQHjdGx9w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: Add "dmic_clk_en" for sc7180-trogdor-coachz
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        Ajit Pandey <ajitp@codeaurora.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn,

On Mon, Mar 15, 2021 at 1:39 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> This was present downstream. Add upstream too. NOTE: upstream I
> managed to get some sort of halfway state and got one pinctrl entry in
> the coachz-r1 device tree. Remove that as part of this since it's now
> in the dtsi.
>
> Cc: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> Cc: Ajit Pandey <ajitp@codeaurora.org>
> Cc: Judy Hsiao <judyhsiao@chromium.org>
> Cc: Cheng-Yi Chiang <cychiang@chromium.org>
> Cc: Stephen Boyd <swboyd@chromium.org>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> This applies atop the patch ("arm64: dts: qcom: Add sound node for
> sc7180-trogdor-coachz") [1].
>
> NOTE: downstream this property was present in each of the board
> revisions. There's actually no longer any reason for this and I'll
> shortly post a downstream patch to fix this.
>
> [1] https://lore.kernel.org/r/20210313054654.11693-3-srivasam@codeaurora.org/
>
> Changes in v2:
> - Remove the pinctrl from the -r1
>
>  .../boot/dts/qcom/sc7180-trogdor-coachz-r1.dts   | 13 -------------
>  .../boot/dts/qcom/sc7180-trogdor-coachz.dtsi     | 16 ++++++++++++++++
>  2 files changed, 16 insertions(+), 13 deletions(-)

I guess this patch missed the boat for 5.13? Can it get queued up for
5.14 whenever that happens?

Thanks!

-Doug
