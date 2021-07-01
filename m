Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07143B8EFD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 10:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235489AbhGAIno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 04:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235356AbhGAInn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 04:43:43 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF51C0617A8
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 01:41:13 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id w11so7414101ljh.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 01:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=94oP0rsAT+ayytaK2fzZltuXE6U/Q4mr4HlOcI5ZZUc=;
        b=IYfWYr+Ll1UHRSBEQLgPnx0M/OFTM1LsCjadsw0+P1P68+KYnrpVzB9D0/zTj9eTDY
         n1sST4eb5nWLIAUz/KUoAO7T9Rz22Xb4TEvo8pHlUXDZhtrw9kF4ndiBAHSvYuo3qjyi
         qeoha0gJyPVepVX2k8QfzsjvcJFw0paxkGH4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=94oP0rsAT+ayytaK2fzZltuXE6U/Q4mr4HlOcI5ZZUc=;
        b=ir/5mfjKWOqrcKztzffqxVetpRsXNxIDHlyQExhB5fEPX1OF5k+Jm1DXlxOPfT/vlZ
         w8+QeGzjtJJO+NSGaFi6806Td6+fIM4iqokdPKk6BXgwNn6K0rmDl5Xvv40g2SkG2yWT
         kVAAXU+bKHxX3WKCt80XUZMANYVYNWILb+kZcgPSPdvy4eLjpziaJI8u69XmPQoiSndn
         AJoOL+khrg9tiVNG8wQkowCyi4+h3Mb1wbulAK8Elu3nx5KNT4c9HbRcKOptOPshmY+W
         4tFJgk3TUV6QExQQeT7ZZbAm+3jrI7Zcy8+dctdbnYx8VcEcW2EFGwOGlp8+M2MrVYPP
         16EA==
X-Gm-Message-State: AOAM530GVHjjKBC9mQrOmzHOftwuCRAh0JeqB066XEtB0GeFooyXzmE1
        OA157DtUTR7WmLRVkHm77SCRFWRXt8Z7BZRzYq1Qgw==
X-Google-Smtp-Source: ABdhPJwIdOfvGf0L+sdqDn+8ax6dglU62QnDYlxOrENc/AZUpEnZMm4CzLSj2dG+W2SfU2waOpppkNuVrFn+raLvkGw=
X-Received: by 2002:a05:651c:32e:: with SMTP id b14mr11049376ljp.251.1625128871805;
 Thu, 01 Jul 2021 01:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210701080955.2660294-1-hsinyi@chromium.org>
In-Reply-To: <20210701080955.2660294-1-hsinyi@chromium.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 1 Jul 2021 16:41:01 +0800
Message-ID: <CAGXv+5Ecbttkw1AAG5KofoR1oDW-ot68BL1OR=Jpiii8v8DTyw@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: mediatek: Fix fallback behavior for bias_set_combo
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        zhiyong.tao@mediatek.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 1, 2021 at 4:10 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> Some pin doesn't support PUPD register, if it fails and fallbacks with
> bias_set_combo case, it will call mtk_pinconf_bias_set_pupd_r1_r0() to
> modify the PUPD pin again.
>
> Since the general bias set are either PU/PD or PULLSEL/PULLEN, try
> bias_set or bias_set_rev1 for the other fallback case. If the pin
> doesn't support neither PU/PD nor PULLSEL/PULLEN, it will return
> -ENOTSUPP.
>
> Fixes: 81bd1579b43e ("pinctrl: mediatek: Fix fallback call path")
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
