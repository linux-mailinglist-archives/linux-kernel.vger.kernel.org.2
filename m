Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1910033C6F0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 20:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbhCOTie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 15:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbhCOTiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 15:38:08 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE85C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 12:38:08 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id s7so32889122qkg.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 12:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bQgWtkKs155MccZMhkLMAA6hlfzyu0erwh4dS45kygM=;
        b=TA4kd7+lQ0INPNYmhlZ+/kkEZuJI+mcK4QWfrLnUerPdu8Yo4at4Kj6rFiSpVwDrSD
         hO/EhpvvYKl5cxA/eCANmpE0Nw5gK0PrKlTyC7LVQZ+Zwqm+GJUaXAvfUXh+uAlE/EQv
         XYq4FsssAipO7mTgwRArE9A/oDl93E3N/qG04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bQgWtkKs155MccZMhkLMAA6hlfzyu0erwh4dS45kygM=;
        b=P2x8cFPRiY53iJRsCzShGQSEJeTzjbsjoty4wJ83YM5Fbff9oxzHJ7P1zjyvYDveHO
         7MOJDCzU3JyNCWjQKOwOvI0ehFf9a2wTUNbq3nBzsfOxVlQzwjVV7jLSAMbKJWTI54kw
         51p/U6h1L8IY0TyCkHZlOCR04MyCVd215zUOrvVJ3Jo+KwRtWjJmvihkzyIn/iVnDpRm
         PTeFjxLuxQoD53qzxEbJ+snfWGGbLrTaYpdnwSupNXRdtlMGRWIG/46dxgVax5o6Hxs+
         EUb7OjYugu0wXf4aD1cV4Ub3KJ7Ks/dS2s21llebrsOmg88AbfzK1fZRtxip1LmmUZkV
         DtZA==
X-Gm-Message-State: AOAM5314VKfPjAnR5LxzjpgqhdptoRRVaAYn9v/gpTH3tbUHNlNETJLi
        OB7jD54M2a+rRXYqOwROj1pF9Eyft159aQ==
X-Google-Smtp-Source: ABdhPJy7H8rzYwOkrgm9fUYMJrkduJ6SN64zzbS4sWykLtPfCVwbudVmUVQb0xXinTLUYh8pN8YRIg==
X-Received: by 2002:a05:620a:630:: with SMTP id 16mr28333256qkv.304.1615837086603;
        Mon, 15 Mar 2021 12:38:06 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id t2sm11554722qtd.13.2021.03.15.12.37.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Mar 2021 12:37:51 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id p193so34416287yba.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 12:37:50 -0700 (PDT)
X-Received: by 2002:a25:ab54:: with SMTP id u78mr2053766ybi.276.1615837070313;
 Mon, 15 Mar 2021 12:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210314061054.19451-1-srivasam@codeaurora.org> <20210314061054.19451-2-srivasam@codeaurora.org>
In-Reply-To: <20210314061054.19451-2-srivasam@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 15 Mar 2021 12:37:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VA4-ht8Mmroc+T=En6c=GEDchoJ70W1ziSs-MVyqQOfw@mail.gmail.com>
Message-ID: <CAD=FV=VA4-ht8Mmroc+T=En6c=GEDchoJ70W1ziSs-MVyqQOfw@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] arm64: dts: qcom: sc7180-trogdor: Add lpass dai
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

On Sat, Mar 13, 2021 at 10:11 PM Srinivasa Rao Mandadapu
<srivasam@codeaurora.org> wrote:
>
> From: Ajit Pandey <ajitp@codeaurora.org>
>
> Add dai link for supporting lpass I2S driver, which is used
> for audio capture and playback.
> Add lpass-cpu node with  pin controls and i2s primary
> and secondary dai-links

You missed Stephen's comments on your commit message [1]

[1] https://lore.kernel.org/r/161566899554.1478170.1265435102634351195@swboyd.mtv.corp.google.com/

> Signed-off-by: Ajit Pandey <ajitp@codeaurora.org>
> Signed-off-by: V Sujith Kumar Reddy <vsujithk@codeaurora.org>
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 58 ++++++++++++++++++++
>  1 file changed, 58 insertions(+)

The commit message nits aren't terribly important and Bjorn can
presumably just fix them when applying if he cares. IMO you don't need
to re-spin.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

With these two patches plus commit 9922f50f7178 ("ASoC: qcom:
lpass-cpu: Fix lpass dai ids parse") in the sound tree I get audio on
sc7180-trogdor-lazor! Thus:

Tested-by: Douglas Anderson <dianders@chromium.org>
