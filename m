Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B738358507
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 15:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbhDHNoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 09:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbhDHNoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:44:03 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2B0C061761
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 06:43:49 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id d13so4107460lfg.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 06:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nd4MS/2X/IdRu/IPJEY7GmmOKW9PjkQK5am7Q8bLstI=;
        b=hD8KAQHdn5unol9mIEukltB0Fz0T3qQQS2GZ1hEXbDV+LUdIomndFB8jDC+/8r5lsf
         Zuap4QsWc1i4BK0nV76woFFpjpqd78ay7JVuJE7lRA5+35oX3JTgPwkEsw52eqNDq+Js
         5/H5iVyHA5mFpNATM0UjymDtqiGtC0PoWZcHa3SZblgizwLkDZi80MQVS+U5ITAfwY/I
         RxrQHVfGoTFjaWzb+27JUUk9VYyRvsXYcDeuMUUWeKDbqNwM9M1Wo1dWew9qOvQb6Ww+
         zQrZDd9dGfAdGdRTD0k2W6XIjAC/I2SvGAVsnkPq0/YgTNviQ6MVih9Lzi1pAalLAwQf
         a5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nd4MS/2X/IdRu/IPJEY7GmmOKW9PjkQK5am7Q8bLstI=;
        b=OuYkbM9iVXgaxUr+xPeynJDT/yVSmu8zTnQYYQZbb9o4mnaOhIQKQD4wsKnY3fDOiL
         KsS/2gy2arItUsmMvyNxhwZIxUebJSfLaoW0CG+UoY/pMzmx7Tt4xTz237pA3bbg1XGW
         iYGD2o3ZKINDha+DaLn3jN+LyPmjkwxYUkP9JIaPRwBrM9/BGc/8qsqSa+6/EN6li3Ib
         /x0V5BMNFaMY+5tF3xfIxHEf9uMxMaAs4EY77AWBvAA4534YywPWnUjkD+XyFrMbd5xs
         weiYE+0rJ33YcHv4Ug3OD+2WS+msI+MaZyb4WpmVmBCzqJxBK7SHMvmvtkAgoEhJ7Bth
         NInQ==
X-Gm-Message-State: AOAM531c2LOSAXS+XZ1K3n6HKwVOqLNUFYJMnFDzfoJ2/CJN3DUTpEsl
        46qSDU5eCuJbakZ40vMMdIMpQXNMUgaALZnfBLS20w==
X-Google-Smtp-Source: ABdhPJymnbt4FfiI9iPC+BINQwSJEhxevKghWv8S1VlDu3pJBTF5MsChnMg8U1zsHNd7he3i/ZkOw0THQ/rxhuG91CA=
X-Received: by 2002:ac2:4d95:: with SMTP id g21mr6715385lfe.29.1617889427809;
 Thu, 08 Apr 2021 06:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210322104310.863029-1-jay.xu@rock-chips.com>
In-Reply-To: <20210322104310.863029-1-jay.xu@rock-chips.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 8 Apr 2021 15:43:36 +0200
Message-ID: <CACRpkdZWH9Mitp8+SMSCW7kGy5Uz=govbh6=c8gqzL2u6FR-Ew@mail.gmail.com>
Subject: Re: [PATCH 0/3] gpio-rockchip driver
To:     Jianqun Xu <jay.xu@rock-chips.com>
Cc:     Tao Huang <huangtao@rock-chips.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 11:43 AM Jianqun Xu <jay.xu@rock-chips.com> wrote:

> Separate gpio driver from pinctrl driver.

I tried to apply this too, but it fails, can you rebase on the pinctrl "devel"
branch (I suppose the RK3568 driver got in the way).

Yours,
Linus Walleij
