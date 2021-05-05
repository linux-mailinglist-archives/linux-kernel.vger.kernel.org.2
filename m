Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6EA4373BBD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 14:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbhEEMxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 08:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbhEEMxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 08:53:32 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3A7C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 05:52:36 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 12so2343135lfq.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 05:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DUJ6wIodjpCneHighQ0GfY8iqpoBiT6LHmEd2Kcx/xc=;
        b=EUV6OxDbgS6qzK3ecwukeDactMuVot2m/JQ5e65pqn9Y5KX9Wd0U4L5oGUUHTVMc8T
         sJTshB6mNhR87tzS/RUDKmqmDpZtp/jo9bgY/Ct9XH7TaNonjfjWYaCgAeffGhlGUuwL
         Ocm1KpZ1GTP60hKlL1xK4R9ryauExez8czBIh+EjqHYAaxBTcAEka/pXR83SOD/Db9V6
         ZBeuEb3hvfy0Mn5rfZMEDpph73rCJFBfpMIoTXc/IBnR0UPvWX2eFwM+hd98bki354Xd
         4bQAOMFTyavJo49o2wwbesF9tIzRDR0zbWYURxbxMmh7ypjI6+qua08ndZVANo5e+KGq
         vvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DUJ6wIodjpCneHighQ0GfY8iqpoBiT6LHmEd2Kcx/xc=;
        b=FbW5i8bKjkyMB1E3obV7/4UIvLWbB6peCAEyWH3/A6UCDSkX/ZTo5SFDoxEy0KoXzZ
         UbD578Vix6JMmr73zia/K/YjCAe2+wPPp0DhgyxYdcKTgiy1YukyFdhOBzVePFoepYVR
         9JHyxMCla5cLJjijz1jrcmC9Oa/FDe389xAKwmqGoqEq3KVlT2dk0Qbp4UxXDzyXHwhA
         q7qjnQTZL+VC1wAjhtzB2vioYQLEkyq29XpqcgZJkb/n92fOExkEUyB+GZUBu+8zClnp
         tcf/fZh1YSPMSsOEHaXs78G3K5REgFuKEzRhn1runWfD4nBEAIlvb4sF7daeHRhKSAan
         FH4w==
X-Gm-Message-State: AOAM532Y6HmwWWXo9Dp4P6R2hgYPiCbxaQId5YBzyO/TkIlks1NcCldj
        VcYX59mkw0F6opxzDyTafAzRJ0DT1+5+Cn9Jje44Ag==
X-Google-Smtp-Source: ABdhPJxYcof+sEcIS6k1g2fBI94Tsit285jfjEfq4xJ9sCMXYWCCpOkw77yViYGWgY2XHiMONxP5KDRPgNY4lIinde4=
X-Received: by 2002:a19:b0b:: with SMTP id 11mr19983583lfl.291.1620219154638;
 Wed, 05 May 2021 05:52:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210503144350.7496-1-aardelean@deviqon.com>
In-Reply-To: <20210503144350.7496-1-aardelean@deviqon.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 5 May 2021 14:52:23 +0200
Message-ID: <CACRpkdZcnzx6+OQjG_3z8MP1EkhGFBKx1kDxaSFBmDcxs4KHGw@mail.gmail.com>
Subject: Re: [PATCH] iio: core: return ENODEV if ioctl is unknown
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Nuno Sa <nuno.sa@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 3, 2021 at 4:43 PM Alexandru Ardelean <aardelean@deviqon.com> wrote:

> When the ioctl() mechanism was introduced in IIO core to centralize the
> registration of all ioctls in one place via commit 8dedcc3eee3ac ("iio:
> core: centralize ioctl() calls to the main chardev"), the return code was
> changed from ENODEV to EINVAL, when the ioctl code isn't known.
>
> This was done by accident.
>
> This change reverts back to the old behavior, where if the ioctl() code
> isn't known, ENODEV is returned (vs EINVAL).
>
> This was brought into perspective by this patch:
>   https://lore.kernel.org/linux-iio/20210428150815.136150-1-paul@crapouillou.net/
>
> Fixes: 8dedcc3eee3ac ("iio: core: centralize ioctl() calls to the main chardev")
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Paul Cercueil <paul@crapouillou.net>
> Cc: Nuno Sa <nuno.sa@analog.com>
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
