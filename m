Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC6383B7E0B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 09:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbhF3HaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 03:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbhF3HaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 03:30:10 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C77BC061767
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 00:27:41 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id a18so3266252lfs.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 00:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PqChqbCdyi7I3z8ajBtnm4crKLtFjV3f+EdiX7z1gfA=;
        b=jUr7gIdpi/tS//Cxavgazy26slgxlenoY/rYuBZMS2ddK3JRhqdExl4YEthPBGhICK
         fOkzphay2TG+9GeCjQmi0rQFmeSuQpoAdedd5f3yGg3Bf2z49YdsPst0opNI99Cg/XER
         aMbmzWgpadDHUOAW+GlV0oh7XiUJAVKdxrQhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PqChqbCdyi7I3z8ajBtnm4crKLtFjV3f+EdiX7z1gfA=;
        b=AUnbSJO2zKZpP64hNjKBtxtblxn8fYoL2Ne0sJNpjKQqJv1aIYjKDUC5W4OTb7fYmh
         Ub/Qln1pGOFS5YWQojgp6DF0FB7143Yj2I7UQQHyNw/iZxYH2JVRN/4w9X1JuYsjPiVO
         DU7l2tYK+8ZcFjntdPP4gC5vOFy/TPtGICQix80zVw1VkMHesKboStElskPUwfB7nX+O
         Y5V7ELhAmPhkR9RRutUJhLMF16j6KLoruEenMt62KcRaRGo/sB5JBV7yU4YzaxUbEaHz
         2iPMWFWks6ypN9q3KKxsO5aCqdbKlPjAHkmFPXrb9aOMrZvxuIc3g3onvJWPvHLl0b5i
         HG3w==
X-Gm-Message-State: AOAM531SbHAjYYA/NvdjSJ5PxEjFF/E/Ez8BJb0bQRPMwNk9srmpaeJk
        sM9WS6dy8t8WX01dO8LJyaGnLvDkDobgu846WQLuEQ==
X-Google-Smtp-Source: ABdhPJwXTLvf7WkEdKH0kiRYx7KjKKymzqJOW8pf4v4ankygH2rmshV2ToQvOyzTvFQ05hkpl8KgHD/m3A3riEJ7Rts=
X-Received: by 2002:ac2:5a11:: with SMTP id q17mr26529672lfn.479.1625038059798;
 Wed, 30 Jun 2021 00:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210630035443.2144958-1-hsinyi@chromium.org>
In-Reply-To: <20210630035443.2144958-1-hsinyi@chromium.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 30 Jun 2021 15:27:28 +0800
Message-ID: <CAGXv+5ERomKaid2wQ5Sz9CB-q+DVLMzWq08b+rkkh5=3WnG5Vg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mt8183: kukui: use generic pin configs for
 i2c pins
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        zhiyong.tao@mediatek.com, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2021 at 11:55 AM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> mt8183 i2c pins don't support PUPD register, so change to use generic
> pin configs instead of let it fail and fallback.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

On a side note, the `mediatek,pull-up-adv` property probably should be
merged into `bias-pull-up` with an argument.
