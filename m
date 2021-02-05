Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6EB310944
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 11:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbhBEKiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 05:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbhBEKff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 05:35:35 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC328C0613D6
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 02:34:54 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id r12so11111307ejb.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 02:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aC0hEy91gIITr9mEqagVdgJnBixTe7YH/U4CspdXVEw=;
        b=qKmZ+vAKTB8wPIsqOlZFIv/6Klp0MZaTRXPjC71aN/OlcEB5ABgRDk4FGbVc7QFAyg
         nuiPZF6+zay939LiJoKXK5hYtsB7pS54cjSPCOrg8oR5W21pV+zzree8xkFfNmFZiChs
         pPhZ93vk4uu989w+SHUVsjOpAd9ASg6phhmOhAIdRH0wxdLTGahMrcBj8lGIfwxrxM1j
         ndiWepYLtwmfuZbGXCv/8wJLBgL3JMoJlyqZFLk0OMojPpDcWRiFt14kjsArZiCk5Qh2
         GCF5B5skCbPhGl1fIk+JUcG5KAJlDbOFUelVzldygUchktpl8pn+xroVERrG1lG85Imy
         uBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aC0hEy91gIITr9mEqagVdgJnBixTe7YH/U4CspdXVEw=;
        b=BzF3qZjimqxpVt450SwDhF3Rb7UX5mlsRASzHy9GlN91P3KCdzsWTwniahW7FlWnR+
         7LjTtJKGk9as5SOwdvkcqQViaFbjUEXpUeZvEjkyiW5NGbITUsdLAiCI+zpZHql7QZXp
         g7E4tvcEDxyFYVSKMYz1ihVOrlPy5L3WIQssYFUPlqUYScHLAc3PgQdTKCyOHnlR1e8n
         RZWyn+4zcJ5Gskv19fE1Bn6QHkkkFYCZKIU670X0d9hFS5Lhl6APpy5qc12EHsxtcqua
         psisyoOtbgPIEw+JEKCIRY9qlbBGcc0onFFz+dVj1WpfjqgvuktxfTyIBGpPgGxWtVrQ
         PPnQ==
X-Gm-Message-State: AOAM531pF5/OwHDPYl7PSuPFCs+g4pCidFpW0oSyQfas552eMUd/gz6u
        R5eEeSvwWf+jkey1a1WeVP0sDsH2yjPii24FpNDVvg==
X-Google-Smtp-Source: ABdhPJwVhiRc6hnwu6JHUAx/obykx4YGVbuzemFS3gkjteNp4MFr5mXYDvfdw3Eb6808h3IxPGgohZQe335ydgkJ/K8=
X-Received: by 2002:a17:906:9401:: with SMTP id q1mr3508045ejx.516.1612521293560;
 Fri, 05 Feb 2021 02:34:53 -0800 (PST)
MIME-Version: 1.0
References: <20210205080507.16007-1-nikita.shubin@maquefel.me>
In-Reply-To: <20210205080507.16007-1-nikita.shubin@maquefel.me>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 5 Feb 2021 11:34:42 +0100
Message-ID: <CAMpxmJVNwB5Pwj_QduBmMY76OUdjsFBFP=0o731rCGHOLYWP2w@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] gpio: ep93xx: fixes series patch
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita,

please include the review tags from previous series in the future.
Linus has left his Reviewed-by: under v3.

Bart

On Fri, Feb 5, 2021 at 9:05 AM Nikita Shubin <nikita.shubin@maquefel.me> wrote:
>
> v2:
> https://lore.kernel.org/linux-gpio/20210127104617.1173-1-nikita.shubin@maquefel.me/
>
> v3:
> https://lore.kernel.org/linux-gpio/20210128122123.25341-1-nikita.shubin@maquefel.me/
>
> v3->v4 changes
>
> [PATCH v4 1/7] gpio: ep93xx: fix BUG_ON port F usage
> As suggested Alexander and Andy, drop confusing index conversion and embed
> all necessary IRQ data into struct ep93xx_gpio_irq_chip, this keeps indexes
> consistent and simplifies access.
