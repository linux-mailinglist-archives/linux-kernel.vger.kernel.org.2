Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9F73D55F0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 10:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbhGZIPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 04:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbhGZIPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 04:15:36 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AF4C061760
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 01:56:04 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id f12so10463643ljn.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 01:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vfGOANo6TojxjSyUtBk+c/yyOvQBgYLoVpO4rN8lOu8=;
        b=Wo+D0NDi9dCxo6BkePhL3/dXKXwvkD2kVC2GJFC2gJSO3EZLYYYxJQkokJCoepYYXN
         zKDrD9uf5JXkZU5sUlphcVcLPYw2DbuALfhCpYCr16P0sLCoBjVnmpJ4+bkbbZsY+6Ae
         aePG/1QMSSWkKXv1jQoz27Sw0QoS12K/1w8X0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vfGOANo6TojxjSyUtBk+c/yyOvQBgYLoVpO4rN8lOu8=;
        b=OGLjotpWCeC6E2UqZzESVb/WJbpNJEnCP4nO3piWuzoQjHRyNPYjYKfcS+WWysxa0k
         nr6DmG6uP8bAGK+/bmAsuJOGSZGPzbFPe49LBicpk5S9DEIkSkUttEiJjgDKEYgPoeRn
         lEeojiBo7isgUNpIaxZwaUnxzQNpqV/i1xtgIE8GmndppEYiG/ChlxvOE4UlI00yCCHA
         AvSvk24CmpQZachMn1Ox8VD8w1opyZ17pIvH6mOwlDyR9VI4zHiP7L/JdN4I+BUVP8sM
         lo9RNEitU5IWwvPjqI2Qn0e+uuL+2Lie765DgtqolxB0NzFJ1dmoCmecfWySIH1/rNJz
         qDHQ==
X-Gm-Message-State: AOAM5308+TPIDNNoTzh5uGH/OgtvluZPXe19AiNxTzZq1CMCCQHXArke
        iIErSz2CcCbi02kwwrb37Ezl/DQzUGg/ge+mXuj1SQ==
X-Google-Smtp-Source: ABdhPJw67P1wau80aeqooMy907ZYAzpnAEddZ9DMaEPCUCA9XANLeDaDFjZlvhvqn/e4V3NvNlGzJuK3q9X0z2yIpCo=
X-Received: by 2002:a2e:a417:: with SMTP id p23mr7799929ljn.23.1627289763011;
 Mon, 26 Jul 2021 01:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210726050831.1917982-1-hsinyi@chromium.org>
In-Reply-To: <20210726050831.1917982-1-hsinyi@chromium.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 26 Jul 2021 16:55:52 +0800
Message-ID: <CAGXv+5FmKHft-s9u_G0aEXuK2x5p1+unC-35ksaS_D=52JRkYA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mt8183: kukui: Use aliases to mmc nodes
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Eizan Miyamoto <eizan@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 1:09 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> Use aliases to mmc nodes so the partition name for eMMC and SD card will
> be consistent across boots.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
