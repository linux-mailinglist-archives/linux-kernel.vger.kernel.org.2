Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE803A1240
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238855AbhFILVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:21:23 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:40915 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238795AbhFILVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:21:22 -0400
Received: by mail-lf1-f44.google.com with SMTP id w33so37459630lfu.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 04:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b9O4t6ei1D8lp6tbh7xKEJ5OiZwVBxTMlh+LjUyHQ54=;
        b=JJZhVBK8XAeaFL6DQ8+82CH3Tn27KdaGFCTgYUZmudfX3Q/cnQXnIZvxUARhticvpC
         JycTC4ZOyQIZfYn0/HlZ6zKqQYWsLVhkD2xM6H21LShj4YIaMowxdtUPl0sHreMG6pfg
         iogNmtktJywuOe7b7Zs/BMrpw2PHEZMoYqW+XS8uqi3iI6xXJgP8NSFZqDZTDnNw+yEU
         qcsSnKO99UJcGNn3K6R3FY7XpYqPCtPh4FcbMjP0x4Lqe2J3Zna34PNL5b4Gnj2QInhO
         2dLE0mxaniEQcolKdtm+vSIkMkMQA3y49Y6nx38isVwhIQsyOa5RKQFoiWJOwEvK9ymm
         6AuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b9O4t6ei1D8lp6tbh7xKEJ5OiZwVBxTMlh+LjUyHQ54=;
        b=aDEoi+mPjEwj2pOrX85anb1g0oiDesm/Z3o8fLazPZWSISbmP0syaEFW6gbtIYX9D/
         NcnKJGd3DvXO4c4goK2yEGrxiq+EjyJKti9Ez4gUnHUoGpReIcLrn505s5+ULeSJClIR
         WnVT+nQpCXxbpdmTv7yJeinwHlODCfR5miQtMp0H/mkjSkcy5AqbbOJjIMCVgWRchMUH
         Vt8TESlXqsHf4EN1Gc29SqTBtkn4SlBKa25f6nxerilJLvgCaJZMXjpmAf6SleCeeYwS
         pDSIQTYr3Igly9RHiupFZQ+oJ2n2izP15Au1RghB37mLwM8m0TjnLK+XUHV6ugLKWAP7
         na3w==
X-Gm-Message-State: AOAM532z+JvYGu7H3f5RLAR3Ip5B9GqDIJX6EZJxpIfogEwLol6i26QQ
        0O/Yr+FWPgDJtkDuOd5TUKFNhqzipD9O27kQpZdk4A==
X-Google-Smtp-Source: ABdhPJz6NHE+0gvKyfv7+YEJSuyHHStlfocuRfWgrhgqSQh4vX6owc1UlB2pSgkAV6u9cWfZUZXY08Yzd+FfgNCdZtI=
X-Received: by 2002:a05:6512:2105:: with SMTP id q5mr18131046lfr.649.1623237507147;
 Wed, 09 Jun 2021 04:18:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210608150656.29007-1-matthias.bgg@kernel.org>
In-Reply-To: <20210608150656.29007-1-matthias.bgg@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 9 Jun 2021 13:18:16 +0200
Message-ID: <CACRpkdZ+9LeokSfZDhMWyR4yE-oq4CSbSPRqwJncOS0rm_f8Tg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mediatek: fix mode encoding
To:     matthias.bgg@kernel.org
Cc:     Sean Wang <sean.wang@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Matthias Brugger <mbrugger@suse.com>,
        Fabien Parent <fparent@baylibre.com>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 8, 2021 at 5:07 PM <matthias.bgg@kernel.org> wrote:

> From: Matthias Brugger <mbrugger@suse.com>
>
> Pin modes are encoded in the SoC data structure. Use that value to set
> IES SMT.
>
> Cc: Fabien Parent <fparent@baylibre.com>
> Cc: Sean Wang <sean.wang@kernel.org>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: linux-mediatek@lists.infradead.org
> Fixes: 696beef77521 ("pinctrl: mediatek: move bit assignment")
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>

Patch applied!

Yours,
Linus Walleij
