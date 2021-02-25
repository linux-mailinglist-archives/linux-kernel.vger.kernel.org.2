Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED063258DD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 22:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbhBYVmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 16:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbhBYVmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 16:42:15 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6845EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 13:41:35 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id u4so8237552ljh.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 13:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tMZfr/tKOoxxB+DCAYtgYdWGNraNZZUqKf4iILc1Yu0=;
        b=GDZvyIneiMg5vDxH2jD1JHrH3AsgaytvfXkjx/E7I71t+eN3GMy6C2KFiywKfz0NKz
         AQzIhyZH5OAe2QOhWbB/W60IaPoLCcaD+FKmKzNKcT2/u1AOeqt9rPbYtdh3ldiw4sFq
         WETGM1nenTR3+jU0ji2VJHloz9fHFqWjl++L4ZU39PhZ26P5JJMCoVuquyfTHsG6rvkI
         s9tEnR2uC1aVRy2DCm2m0Bpht6ctaymSo8/zwnEpZwnOpqf5Ximd2uw4o/LnLafFt8Xk
         uUVDt8+8IaALaEkLxJYQGM9pg4AAYIV2FzdZyJLbCZEaie90QBighrCdRFQ5+gteilRc
         e8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tMZfr/tKOoxxB+DCAYtgYdWGNraNZZUqKf4iILc1Yu0=;
        b=GGhfsQVtPkdfWFuDIYr48nA6WDXT2ohqZtMdv2oYBXXJV8rfUti7kBAsD+rW3V6mU/
         lAYqr5PMSGC6M2CCxjoZtB3yp6ubSL4azSNKp8fLhf96OngmwHFpoActtDPl3kfcvihR
         wTLkI/FqE2ywzn3U4SUxB/enygu2JtEJs01GMxhWVdSsZVCgWD+iSpI50SZVOsd643YQ
         EK0ogrY0HWXXLOUyFbdfUpyrOWhaR4o89YH0PyEdIHkaxZPSpzLUGYAcADTOtrVAZrB8
         U5h/7kX+OACMHw983RzxNia8u5TvD3bOxztUxva2FtohAqHAuTybGPHKDGCh/iYBDtU6
         /EqQ==
X-Gm-Message-State: AOAM5301y3ihnoyxH4dqbJTlwFDdYcniwcH913UuzIA8fKYodWrd5m66
        pGkFP2YHjnWLpXwC4pRiFJdsgHX+eD+1TRWXMKTOGQ==
X-Google-Smtp-Source: ABdhPJzpaHHG/VqAnvXltFRPkFieUucDnl5K/H4IFKyZGqzVyuPtfN6Hpn7/hf1abbxGUFA9bMGI9AandXX968J7TYw=
X-Received: by 2002:a2e:b617:: with SMTP id r23mr23499ljn.116.1614289293663;
 Thu, 25 Feb 2021 13:41:33 -0800 (PST)
MIME-Version: 1.0
References: <20210225145953.404859-1-arnd@kernel.org> <20210225145953.404859-2-arnd@kernel.org>
In-Reply-To: <20210225145953.404859-2-arnd@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 25 Feb 2021 13:41:23 -0800
Message-ID: <CAKwvOd=kk9XhU=jyB3ZZd7bCW+9w6nwXbE48xbtFdBjeTQoj8w@mail.gmail.com>
Subject: Re: [PATCH 2/2] mt76: mt7921: remove incorrect error handling
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 7:00 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Clang points out a mistake in the error handling in
> mt7921_mcu_tx_rate_report(), which tries to dereference a pointer that
> cannot be initialized because of the error that is being handled:
>
> drivers/net/wireless/mediatek/mt76/mt7921/mcu.c:409:3: warning: variable 'stats' is uninitialized when used here [-Wuninitialized]
>                 stats->tx_rate = rate;
>                 ^~~~~
> drivers/net/wireless/mediatek/mt76/mt7921/mcu.c:401:32: note: initialize the variable 'stats' to silence this warning
>         struct mt7921_sta_stats *stats;
>                                       ^
> Just remove the obviously incorrect line.

Yeah, looks like perhaps a small mistake from when the driver was
introduced. Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Fixes: 1c099ab44727 ("mt76: mt7921: add MCU support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7921/mcu.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> index db125cd22b91..b5cc72e7e81c 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> @@ -405,10 +405,8 @@ mt7921_mcu_tx_rate_report(struct mt7921_dev *dev, struct sk_buff *skb,
>         if (wlan_idx >= MT76_N_WCIDS)
>                 return;
>         wcid = rcu_dereference(dev->mt76.wcid[wlan_idx]);
> -       if (!wcid) {
> -               stats->tx_rate = rate;
> +       if (!wcid)
>                 return;
> -       }
>
>         msta = container_of(wcid, struct mt7921_sta, wcid);
>         stats = &msta->stats;
> --
> 2.29.2
>


-- 
Thanks,
~Nick Desaulniers
