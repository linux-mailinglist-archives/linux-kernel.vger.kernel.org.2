Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7986D3ABE9D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 00:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbhFQWTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 18:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbhFQWTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 18:19:10 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0B9C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 15:17:01 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id ji1so6377836ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 15:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ybMe0lmQbosDLY3cne/H0mPnypKlqLOjNhEtZI+tynw=;
        b=TSe1lIb7GNp6tmwWwLbF/rr4f678W+T+unft30gpSl49fgdPDf0VUq8jcKQCA0/hCl
         vOExD7Gdto+xHcAi2mgQlA04SzJlG/n9uWT3Msw6y50Pc8TIrsLQSJtIPIxOhV50No3x
         y6JIX+LXXOxXviA86YWI5eGQDAqVzk54/Iym+cL5Bfu6B0nTSsmx4+ZVuZwpIWzCQ7aK
         b9PBUaBixEbHf43+HuJTTJzKjzeHAhqi1sezSY/6iJusjOJEOig/ADSGY49Ow5/KhuuJ
         SnFqMFrCqm4rYfvIKQCh89AtCM1tUV66hIv88Xf1AFKhGv+hGGq6MAxVVCOcj8nb/ySQ
         XbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ybMe0lmQbosDLY3cne/H0mPnypKlqLOjNhEtZI+tynw=;
        b=N4H1BOdknjdqpNXIEkZAgECVqXP5hWuSFJhE/xmVwekjfkN72HVNdskZ8O09udH8T7
         Qge9ZZnhgBPetwj7/122WYWV8gmKAN4+k4iIZYgncN+9zD1m7jCNZythiJDl3XX/Wn6n
         9Zg9qb2BW7Jg22AYuT44MnO3k5CU7tmmC7jPRTliab4KFsFs+0nb32uwPgmxh0ERFtdf
         gXusGEmL7svENwJ1Zzq5MCjDxn4ru5rfOK68Y3AfXVzYf4//WLrFUi0KU/0sEt8tu0gO
         /CeUNGRU0z4j0+S3nzmqq+kjwgdgH/NRApOaLu2+4SnmNeaeT4W+xgm9dcTSKuPdL/ul
         C92Q==
X-Gm-Message-State: AOAM532kbDguY1bohdgQGSJetn6j+Hl4mm218V7Ap5dDB6Qe7eXu7YwM
        J0rCBH2JjGO6XQU5eYrEAocn9EVHBVui57OfDas=
X-Google-Smtp-Source: ABdhPJyHiCQZPtWEEUn80WFtwkk1XE+OvA8BVP6yd4SX0BugyxFtURFkuWV+GY6KXpOzcWdy7DhuvpJFdY0ZgjAKERI=
X-Received: by 2002:a17:906:3b99:: with SMTP id u25mr7628425ejf.539.1623968219820;
 Thu, 17 Jun 2021 15:16:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210617194154.2397-1-linux.amoon@gmail.com> <20210617194154.2397-6-linux.amoon@gmail.com>
In-Reply-To: <20210617194154.2397-6-linux.amoon@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 18 Jun 2021 00:16:49 +0200
Message-ID: <CAFBinCD1dJ=oqjzkCrAdMMdxF8W1Aujcwo20vJ1oLv=mtn5TZw@mail.gmail.com>
Subject: Re: [RFCv1 5/8] phy: amlogic: meson8b-usb2: Reorder phy poweroff
 callback function
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

On Thu, Jun 17, 2021 at 9:44 PM Anand Moon <linux.amoon@gmail.com> wrote:
>
> Move the phy_meson8b_usb2_power_off fundtion to avoid compilation
> error.
>
> drivers/phy/amlogic/phy-meson8b-usb2.c:247:3: error:
>         implicit declaration of function 'phy_meson8b_usb2_power_off';
you have introduced this warning in patch #4 of this series


Best regards,
Martin
