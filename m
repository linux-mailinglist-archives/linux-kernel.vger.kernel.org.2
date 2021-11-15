Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2ADF451DB0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236449AbhKPAc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238741AbhKPAa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 19:30:26 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F4FC06FD8F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 14:57:09 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id u22so32004169lju.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 14:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RmphX0MvgxPcyZ1NxD5xM+drSKIWrzBdfK3vQGpFT0Y=;
        b=PTAG7zydJ+Czx1L/qKKrEFKvHQHR2PHUkLnV7dbMJ0n9YPER5y8gWhw+0A4fU6ji6l
         qe9M0vz8I2Nxj7j6lsb9kI9plzoSWN7+JLBMq4KpxUh8j0gnIaO11fHllhUFtKqmVOM3
         jX5Gg5k0vSUQZJbx+Sgc6lISP4h2zVzGzcl7sZ5b+45aqLYzrwGX9DGu4/yrwOZDy/xI
         I6PGAxCTOCUA3Iyf9CgUJoadM29jrjtnvrK5KCtQJA0wjA5lBqGHOx3ViTI6D5IIyZRy
         FGUKigyHPNq2VwV2ZcoSimpbSN7GB0on28jjQ7ZYWSUev9o3eZOeQr5KPdN3/1Nk985Q
         m2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RmphX0MvgxPcyZ1NxD5xM+drSKIWrzBdfK3vQGpFT0Y=;
        b=Z2rorpeWS7271zGAlaLu0GBN0jeEppM3IFfeNWWfb74oCr05In9S6dRjkTl1MTnXwK
         cjyHb/8YYHCAKCz1Xrb74DGQJJxr31vfw1wBCmZ3Dl8VtpQe8EnX6n5hS6n6Avi5zwKw
         SwsuKh6NYsTmj/VwM2/GAs7knZnXvG+7hMHkXxO/3STaz6/1aSUHdqvYHOjpNviFu6bK
         JEYOmYqsDy94KdEiiNA8ifZ8Hpsq0CluC6QepSTXT1PQNJlIHr00pzfpAG3W9C5vRyNG
         xmnJF6noC/Y9yyC4d59GunOtfYt0haFSn+lZ9O3QWtmLgDAXp6u257y2IkvTKtI2S0wj
         KdWg==
X-Gm-Message-State: AOAM531tqpsRQdoepOe2cuSOL1uO/Jj7XhajPgW7Bj4kOMbun7BLzLy5
        BtFE1Xvta0v9c5+8NxaQa8TDP2wPnIi4yaMjTSkW7w==
X-Google-Smtp-Source: ABdhPJx7gdgAc+IXgszBD3wr3x5nZ4t8p3VJpeJTlxk1cFk85uFsL1LfgIM2zpoAdMMdZYsRUKVnSbLxhRvEXvqbe6U=
X-Received: by 2002:a2e:8906:: with SMTP id d6mr1464579lji.454.1637017027772;
 Mon, 15 Nov 2021 14:57:07 -0800 (PST)
MIME-Version: 1.0
References: <20211115153024.209083-1-mw@semihalf.com> <YZK2bPgHE0BFlDMd@lunn.ch>
In-Reply-To: <YZK2bPgHE0BFlDMd@lunn.ch>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Mon, 15 Nov 2021 23:56:54 +0100
Message-ID: <CAPv3WKcUO7fnbOJH5tQ0hKATV2WpOBTog2WpzgEYjQk-JQa5_g@mail.gmail.com>
Subject: Re: [net: PATCH] net: mvmdio: fix compilation warning
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, upstream@semihalf.com,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,


pon., 15 lis 2021 o 20:35 Andrew Lunn <andrew@lunn.ch> napisa=C5=82(a):
>
> On Mon, Nov 15, 2021 at 04:30:24PM +0100, Marcin Wojtas wrote:
> > The kernel test robot reported a following issue:
> >
> > >> drivers/net/ethernet/marvell/mvmdio.c:426:36: warning:
> > unused variable 'orion_mdio_acpi_match' [-Wunused-const-variable]
> >    static const struct acpi_device_id orion_mdio_acpi_match[] =3D {
>
> How come OF never gives these warning, just ACPI? If there something
> missing in ACPI which OF has?

It was enough to compile mvebu_v7_defconfig with W=3D1 to get it (so
CONFIG_ACPI disabled). There may be a similar case for config _OF, but
I couldn't deselect it easily and compile mvmdio at the same time.

>
> > Fixes: c54da4c1acb1 ("net: mvmdio: add ACPI support")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Marcin Wojtas <mw@semihalf.com>
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>

Thanks,
Marcin
