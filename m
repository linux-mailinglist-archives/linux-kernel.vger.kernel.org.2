Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F8142CF0F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 01:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhJMXTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 19:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhJMXS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 19:18:59 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27899C061746
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 16:16:55 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id w14so16553345edv.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 16:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tiCnQHVrdBabcToDZIXeMhi1lk1+r3rn3k08DaY++3k=;
        b=gXp7ANWKXJjGzPX8TUlAUpIrWwa4yllom1qQmDKgBHfENLyvHx5P2aT5JqhvjUHg7u
         eUAsV84owtZ5nGVG3xN+XfpnyICgDndXnGFWVxGJZnI9ZotQk02eFB4tTTSoi4Dcmui8
         LvWYwMAnRZtOfCJ4/5YgIvAne78HKKPSGVZQFFNXrWDJvYC4VrBKSAXawZsQjE6fFBrB
         6twNb9t/gbLWUzoVKSkY/GZ/OjS9w7NApeAyWkEjifx641uWxcq5EjFlRNVov/Pa61uU
         cqqM5CUENzoh29AAnwd1oSryY7ZLY9zSG+KKJHTCvUFgb1bSNLps8T/RBwSOhC0sUzbz
         ZskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tiCnQHVrdBabcToDZIXeMhi1lk1+r3rn3k08DaY++3k=;
        b=cqPTZZ0fWbDwuyOObYQxlu3NxXgq6CE433qRNbF1bcO/nSz7HoJy2P2yb1gAJdqv9C
         uQEO7On20FoaDsvfvugN2SRChpowtIiHg4Htq1PKEzhLArIRx5uJAwKRCm0x9kWqFbkE
         y57t4aEu6l0uf+N+Cpt/RjYZ+nc1C/uExFdvzdf+xR1s8oYnKMUUjLzD05jroJPbsWZs
         PUMipLk2001+nGMQE1jr9Nwq8uBWc1g+zIfEmeArfgffsxddC8sh8KKpjjuG4+8HnENc
         FSptPzClCqOVvaJ8y+Zqy8BKdtgqvm4SVy22ALEHMbTxVXCcdWlL9CTfZf0ZvSxsHb4g
         MkBg==
X-Gm-Message-State: AOAM530NZnLxK7FXBxYDEAGEzLZzF/VimiSol6sojSOEvLf+flDdx270
        oYohBu6GeiMQp9pUV/n7HOW+AR3ZCS0Yny7X5L+m3w==
X-Google-Smtp-Source: ABdhPJxu0km3cFQTmT8RT+LuC6goiXXQsKlnz/Be1AH+gs6vANTgQ5AtYZTSuZjdyka1+YfqWnTR3cs3oqVz8LGFO64=
X-Received: by 2002:a05:6402:1d4e:: with SMTP id dz14mr3538927edb.348.1634167013772;
 Wed, 13 Oct 2021 16:16:53 -0700 (PDT)
MIME-Version: 1.0
References: <20211008122517.617633-1-fabien.dessenne@foss.st.com>
In-Reply-To: <20211008122517.617633-1-fabien.dessenne@foss.st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 Oct 2021 01:16:42 +0200
Message-ID: <CACRpkdZqioY0uLJz1yQfxwmKreuJcwkNh_PbJNZ2c-Eh0aMPbw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: stm32: use valid pin identifier in stm32_pinctrl_resume()
To:     Fabien Dessenne <fabien.dessenne@foss.st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 8, 2021 at 2:25 PM Fabien Dessenne
<fabien.dessenne@foss.st.com> wrote:

> When resuming from low power, the driver attempts to restore the
> configuration of some pins. This is done by a call to:
>   stm32_pinctrl_restore_gpio_regs(struct stm32_pinctrl *pctl, u32 pin)
> where 'pin' must be a valid pin value (i.e. matching some 'groups->pin').
> Fix the current implementation which uses some wrong 'pin' value.
>
> Fixes: e2f3cf18c3e2 ("pinctrl: stm32: add suspend/resume management")
> Signed-off-by: Fabien Dessenne <fabien.dessenne@foss.st.com>

Patch applied for fixes.

Yours,
Linus Walleij
