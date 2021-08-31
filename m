Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 485A33FC016
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 02:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239221AbhHaAmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 20:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbhHaAmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 20:42:44 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC57CC061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 17:41:49 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id u3so34818258ejz.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 17:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t6EgJ/pBlXGjmQW+1kycNPH7wqBqGocIxe5B3vOVKdg=;
        b=ozqNjl0qJHwzCO4kLeRZtdKmVX6r37wi9a6tbMXD6kiNe89XfkdS2y1o/bSVxH2TB/
         kZZBD0cHymA0yyOmQyVDhSJ+oP/i6Faea7bdcgRwqRdX/5kGuH6qkyqN3AobnaWQxJcq
         Q/H5HFeNijuHcbSL5AYcJsE5vedAxWkGqU+/RPjCyM47uVUeg3N1i1Z3ZEOSCiXC4vTm
         56dUDooSPjrnIiRUPmKYf2ZWXS1gRvo/YbD0LTCA+nMrqprAvDc26WMudYtoz9BWzpIG
         z4H+/CullndzRIrgzLgm6xlJ78L8eiOHxSCSUXwCdBPHo0dWFuPVlP0Q7Br6L5OYcxn1
         VDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t6EgJ/pBlXGjmQW+1kycNPH7wqBqGocIxe5B3vOVKdg=;
        b=KNtLOlywMrF4zzeAZRSVyvMxWQZXn3Dlb9Zbb9QAZGSBTC9p15PEGwwzwQDZWEn3Kx
         occUJqXMhpUesIPjJ5CdvldoZHJQzOf86Y4M/A5Ebe45uA3/tTAHdzOLf5E32n8UrKbz
         Teaah9pkCwiiqZCheF4l4H8tdd6bFomttEGzfvlW22PrzEvlQov4OS/10neN0BNzoWtM
         M+sxS1yYXwxZf/LbDnLaXpb8M7WxRMbZxkR0B6ocKayHuewrnVSI8jB0X5HAfGtgET/M
         aPt4UZSj/eFeLqNI8M4NoNbR65zPO+ueqawB4eziTwPs1LIH0AizTzzI3m3ecvBafSzt
         k+YQ==
X-Gm-Message-State: AOAM53346Z4YI3MBpC0j8nu+jEmDJeZrWWwTwdSK7eWLL5CIOgxWLCbr
        tTUh7oNMUXf8APRsVxDpiuwiYvo5DnpRZL8jIU+1DA==
X-Google-Smtp-Source: ABdhPJwfDEapt8mz+NTo0uJkU3v5YR5ufjt/WlrI5Z+Q8KSQPjbjAOUEvNuF9+JEMzyiUG+AY7eqBrSXjXnTKMn6BMw=
X-Received: by 2002:a17:906:7749:: with SMTP id o9mr28291109ejn.141.1630370508559;
 Mon, 30 Aug 2021 17:41:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210830180758.251390-1-mike.rudenko@gmail.com>
 <20210830180758.251390-2-mike.rudenko@gmail.com> <6474995.6kXVAnRFRJ@diego>
In-Reply-To: <6474995.6kXVAnRFRJ@diego>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Mon, 30 Aug 2021 21:41:36 -0300
Message-ID: <CAAEAJfB6FBbeEPuzirP2nuU_J9nLFSrczgXYVfNQUZbEJrbc7Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] phy: phy-rockchip-dphy-rx0: refactor for tx1rx1 addition
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     linux-phy@lists.infradead.org,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        linux-media <linux-media@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On Mon, 30 Aug 2021 at 17:46, Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Hi Mikhail,
>
> Am Montag, 30. August 2021, 20:07:50 CEST schrieb Mikhail Rudenko:
> > In order to accommodate for rk3399 tx1rx1 addition, make
> > enable/disable function calls indirect via function pointers in
> > rk_dphy_drv_data. Also rename rk_dphy_write and rk_dphy_enable to
> > avoid naming clashes.
>
> You're a bit too late to the party :-( .
>
> The tx1rx1 dphy is living _inside_ the 2nd DSI controller and is
> configured through it.
>

Would you be so kind to push a patch adding some comments to
drivers/phy/rockchip/phy-rockchip-dphy-rx0.c with this information?

Thanks,
Ezequiel
