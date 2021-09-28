Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125AF41B8D7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 22:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242843AbhI1VAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 17:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242836AbhI1VAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 17:00:34 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A070C061746
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 13:58:55 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id e16-20020a4ad250000000b002b5e1f1bc78so56070oos.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 13:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=lN+LkRX7S70D5nVV7zC+dNpbI61BdRQlf1pXpHjEvnU=;
        b=BqNa00Jv/wczuRQl2CsbEF087fnEuBEsWtWuOddVIpEr4F1WAbXg/JebtjR0mpK6V2
         gl/ifgUDTMCHgD0QM5YRmQpoTUm2aq0jE8TJ89Q5fAHnYH6CwtssGC37iz04bmnaO96t
         zRyHti+X3BIiBj/9xx7HNEgec/SyWwjCDTQnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=lN+LkRX7S70D5nVV7zC+dNpbI61BdRQlf1pXpHjEvnU=;
        b=Y1PgHC/MVDguFAzh7+o5zWCdlbc6Xszl1qrerAxBoLeHoXrJALnbsPk7RG6q9xwz7O
         AcgHturc4rCfK1S544lf6HDGIFDCExIz2W/XSXQh/CLBWeZL+vO6Xq4801JyMjQux15Z
         GHzqdRveWwU82WVgCD4fmNX5mfwmx1B3CfJpYv4WF6QaMntwgY7A/pdT7KSryPFLWzfh
         /i8SUQnwBjr13sc5Yz2aYKahrrz/PqBw5TpOJU4W0F0DawmXwrBqc7XpnNClxz2bp9fp
         jtZ6aTZpPKYfpkRvLdxDXkwBm5FNMjmTRGmcKidFjif5HKT/OgFTGHnwZThBuT/IQQDj
         tURQ==
X-Gm-Message-State: AOAM532wsvbZawgY5VOZZi9zmoCxyzugwOutfupwjYrardyyvOAdXgFr
        8w6wTvT9n0lGTzbHbicyqwE5bBLQ5N24Rj1Yc0Y5EagYJKc=
X-Google-Smtp-Source: ABdhPJy09zHOLdQTdxc47vBQk3oh7hLDqzFOIt1B9H5sRlagoeu6wP5B0XwML12xwBIRl5af+iLJeXbM4xt4gYBLo7A=
X-Received: by 2002:a4a:942:: with SMTP id 63mr6740900ooa.25.1632862734306;
 Tue, 28 Sep 2021 13:58:54 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Sep 2021 13:58:53 -0700
MIME-Version: 1.0
In-Reply-To: <20210927184858.1.Ib7e63ae17e827ce0636a09d5dec9796043e4f80a@changeid>
References: <20210927184858.1.Ib7e63ae17e827ce0636a09d5dec9796043e4f80a@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 28 Sep 2021 13:58:53 -0700
Message-ID: <CAE-0n506Pp-VUCOoMcFaSbrnp+Op3_QRVPFG8t9f1yOX8Ps2+Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: sc7180: Factor out ti-sn65dsi86 support
To:     LKML <linux-kernel@vger.kernel.org>,
        Philip Chen <philipchen@chromium.org>
Cc:     dianders@chromium.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Philip Chen (2021-09-27 18:49:39)
> Factor out ti-sn65dsi86 edp bridge as a separate dts fragment.
> This helps us introduce the second source edp bridge later.
>
> Signed-off-by: Philip Chen <philipchen@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
