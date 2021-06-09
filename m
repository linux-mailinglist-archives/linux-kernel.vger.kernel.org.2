Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1FDC3A1220
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237301AbhFILRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbhFILRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:17:51 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40091C061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 04:15:56 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id r14so11985726ljd.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 04:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=olC98MYXFE09NuYvJ2tPm+RNCwhGWVV3/05T5xhu3Uo=;
        b=YH8vcYA/ZwssAN7fISdlBtvdYmubomn+aIrUeOrb6h5HR6KTFux/z5CZKE3EqoTuVJ
         NhAh0PmPC4aCejHrQ+moJ8vtcppENaCRfexCkmn67q0PCyJ9wm2y+URdfyZJ9PoDLFpx
         SrKJrPO8aRmQH2A9mAYoioo/tZCh3fpixvb2PBjaD6pUfA4cfjUiodtkDd+HiF3cGb+u
         /N3JlijaZNUvf/1de0fFSKbv6mPwq9Sbhg0Aky1J1dcahiNTn5TlKPdcHbJugRHzJY6M
         n6ThAuIQJiFlWUvLUKCbSQEkrNAKOwgA39ad2Lb8R4M0V/ZfspVI66apjpqR1TNU5H98
         vouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=olC98MYXFE09NuYvJ2tPm+RNCwhGWVV3/05T5xhu3Uo=;
        b=mdcIA/TmVpy664U1Fo5VBab8FvfYO80uOO/mxZI9UzvUiM+Gx1BxsDJchUA99apaGh
         Z0qCMDkQabFPfi2JaBYpYn7gkGb1LPlt3Zqi1XXCl4+/2qWcvGnokK/5YPJd8UhhmGb/
         cckOuv6iWFhicY1TVVyBNpji9mN+vQWNeKbel5e+BCWLsOGHgekWrx7llZrubp/SVX20
         d8Kg37zFdFfZU/tZG4WKV20H7HA6tKcEV4FfxkJYwsyPkrmtXJ2R87BcbB0Zvj/ST4dh
         DjXE0HzvxfMYP2ZsIlglfEBCsrMvBmlE8plZ8iPIyZJCYKT2S4Bngr7Vge9N5eUnHfff
         yEmg==
X-Gm-Message-State: AOAM532ss60QivLkrNgtwceB1InG67zw0Vcye1aTDPhNz7et6TuVwcLg
        nHLnn8kXfmfQ7l+1iarrSUY2TTflF+PWvnv9fzc9/g==
X-Google-Smtp-Source: ABdhPJzZt2f4CMFKxy0STGsifmYNUzF59Rr0w0JqTC4qSDcJkvMUJKmzmZNc3fVhOB/7MclmzbsJLeJg0V/ddbUMUBc=
X-Received: by 2002:a05:651c:1501:: with SMTP id e1mr22755386ljf.74.1623237354584;
 Wed, 09 Jun 2021 04:15:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210608180702.2064253-1-bjorn.andersson@linaro.org>
In-Reply-To: <20210608180702.2064253-1-bjorn.andersson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 9 Jun 2021 13:15:43 +0200
Message-ID: <CACRpkdbSRWMPRANKNQcuQ8p2V_2BUeXkJ2F=PeLNbyYwTYiV0A@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: Make it possible to select SC8180x TLMM
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 8, 2021 at 8:07 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:

> It's currently not possible to select the SC8180x TLMM driver, due to it
> selecting PINCTRL_MSM, rather than depending on the same. Fix this.
>
> Fixes: 97423113ec4b ("pinctrl: qcom: Add sc8180x TLMM driver")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Patch applied for fixes!

Yours,
Linus Walleij
