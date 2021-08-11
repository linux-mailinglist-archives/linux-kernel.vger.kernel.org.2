Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB8A3E9242
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 15:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbhHKNK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 09:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhHKNKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 09:10:23 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551E3C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 06:09:59 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id n7so4572691ljq.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 06:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=30PrYrxRiTwRaXmvYCFwrXC2WmCVC7G1BrqAmcqOYeY=;
        b=n2GGSdKDAmxJtzoGrNbBf1OOsA7noQcWb75rHS6OthmG3FML+dYKyMj7iACezQPVsN
         Qx0aMb58i9l9GA0oRZyUvGPZcJSSK1hpfJ/ON4pGFp6DDrX/AXcmnQkvOAPfHvG3pFgw
         fO1Hj8dmtpvuCzCmLP8aymxRvC1QCHhneOnw0Qo5K6Xz05q+1/Zwi3bp31xpJ3lt+Oqy
         cRC35o7o7FV94oERHypuhXEV11Yh4TwcDu2EKcMykng0RyvdIK3LryhHEQTOMkOU1lB9
         FfH0HZOWMGDtW4shsRKSrUqdcbFpvstVZdTHR8B/aK9apTDvAwfIKrAcCEZ5B8Nb5YxT
         FfmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=30PrYrxRiTwRaXmvYCFwrXC2WmCVC7G1BrqAmcqOYeY=;
        b=p9T1Dm1c9LHO3FEQNKSKvm9TeIJAbj1iLSco+5oTPgwCTc9fujb9l0N5judKR2fDvA
         BSNeM+TnPlYdLNllGkRU99uGlsOOMoQtstJ8uj+0RlZg/lqJMkklhnzWce2AwHHjpgwt
         zo2tDvmW9shADs06aHDD+1bzWSeVx1gk8ZZMAPXiEZV36lpcGra/KSdIxGdMrzJoQhjf
         qf7uua7efVuSti0S/63finVgrf0rcFLejxwl7SF18gKFiYagIsf0u39TxShFSxdqdBHs
         maa8JnqPBytuyEKABOPxDdrch+MmDG+XromCrOJ8D7Men5yXRtCKM+nBXQ1UaYVltm0V
         HS6g==
X-Gm-Message-State: AOAM532XByGlvYGzPsVkGjehPbyFxmlXkLddLeIhBjr72ysH238PrmAS
        sa1bU4rVdxgEnUSEjNq6f4ft5YCOQhy88C/Ls5ZeIg==
X-Google-Smtp-Source: ABdhPJwqZ1Exlivd3XmoXAPJSzPqRbycJrfGC+vuwlmSgIK27TRACmN2JRpVppF8VLC5I1VQmQqJxwjg4Jor2IR1lnw=
X-Received: by 2002:a2e:a231:: with SMTP id i17mr12749238ljm.467.1628687396439;
 Wed, 11 Aug 2021 06:09:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210729071905.3235953-1-yangyingliang@huawei.com>
In-Reply-To: <20210729071905.3235953-1-yangyingliang@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Aug 2021 15:09:45 +0200
Message-ID: <CACRpkdazA0+ho72BpP5y4A8MNy+wZJkodGr-kHR9eadfhU3oLA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: zynqmp: Drop pinctrl_unregister for devm_
 registered device
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2021 at 9:12 AM Yang Yingliang <yangyingliang@huawei.com> wrote:

> It's not necessary to unregister pin controller device registered
> with devm_pinctrl_register() and using pinctrl_unregister() leads
> to a double free.
>
> Fixes: fa99e7013827 ("pinctrl: zynqmp: some code cleanups")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Patch applied!

Yours,
Linus Walleij
