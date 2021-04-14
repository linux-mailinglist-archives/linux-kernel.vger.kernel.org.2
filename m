Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEA135EF03
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 10:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349890AbhDNIEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 04:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbhDNIDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 04:03:20 -0400
X-Greylist: delayed 103955 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 14 Apr 2021 01:02:57 PDT
Received: from office2.cesnet.cz (office2.cesnet.cz [IPv6:2001:718:1:101::144:244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB5CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 01:02:53 -0700 (PDT)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by office2.cesnet.cz (Postfix) with ESMTPSA id E113440006D;
        Wed, 14 Apr 2021 10:02:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
        s=office2-2020; t=1618387370;
        bh=VL+3Khe0pTD/l2rOSGRuJdOoL2SvZynD8rVDjpFMxG4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc;
        b=k+LZ1KkbwicpSivb9kbGRF54c5MYAbcKOPXglu7THalVBLwgXPGnqkQnPjwLU5ETY
         f3DJptZHGoyL19FK/fHyhjbwgaN0ToLVVIHIP7w43lUIb8yjxq66ayZ8r8tcpEn1OS
         tcMJj7gJJAutzdvR4iz7xh3X69frbiVyxH2eX9N4Y/PK0Q3klZejR60PHO/pz5i7VC
         7CLuo/dcXj+7Z3tXPAQn3AdFW23Qs8XbGE/AyBksJmPrgu/Q/ZBng9mByMUkSFSwCq
         aLMsNEe42XvX91HXPkzgJ2nY9vPshhzw0LUOn11D7PcJus7XrDBokfNx2txSHDkYX+
         5bBoIogzn6NGw==
Received: by mail-pg1-f177.google.com with SMTP id q10so13837449pgj.2;
        Wed, 14 Apr 2021 01:02:50 -0700 (PDT)
X-Gm-Message-State: AOAM530Ra2GSXAYKwP0WXVEM0nzFAgisCBrLErtAKL5hyZKXjBXeQt/z
        DqHNwFh7MBo0XvdWtN/aNDx2ipb9k0iJs9CEvlM=
X-Google-Smtp-Source: ABdhPJy+0298vwEUg05EWx7t5fB0g2In9DE2gbsBf5kChy0/MbPy1qlZcfKQpji0MJ3w6Y2k+XZ62DsKCbGfmQs38lw=
X-Received: by 2002:a63:2404:: with SMTP id k4mr1212088pgk.381.1618387369456;
 Wed, 14 Apr 2021 01:02:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210329143833.1047539-1-kubernat@cesnet.cz> <20210414001308.3434548-1-kubernat@cesnet.cz>
 <20210414032902.GA242591@roeck-us.net>
In-Reply-To: <20210414032902.GA242591@roeck-us.net>
From:   =?UTF-8?B?VsOhY2xhdiBLdWJlcm7DoXQ=?= <kubernat@cesnet.cz>
Date:   Wed, 14 Apr 2021 10:02:37 +0200
X-Gmail-Original-Message-ID: <CABKa3npPWguWVF-b4KmVCDFGLDE3m78WV+B7M5E=XYBjwfDZrQ@mail.gmail.com>
Message-ID: <CABKa3npPWguWVF-b4KmVCDFGLDE3m78WV+B7M5E=XYBjwfDZrQ@mail.gmail.com>
Subject: Re: [PATCH v5] hwmon: Add driver for fsp-3y PSUs and PDUs
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

st 14. 4. 2021 v 5:29 odes=C3=ADlatel Guenter Roeck <linux@roeck-us.net> na=
psal:
>
> On Wed, Apr 14, 2021 at 02:13:06AM +0200, V=C3=A1clav Kubern=C3=A1t wrote=
:
> > This patch adds support for these devices:
> > - YH-5151E - the PDU
> > - YM-2151E - the PSU
> >
> > The device datasheet says that the devices support PMBus 1.2, but in my
> > testing, a lot of the commands aren't supported and if they are, they
> > sometimes behave strangely or inconsistently. For example, writes to th=
e
> > PAGE command requires using PEC, otherwise the write won't work and the
> > page won't switch, even though, the standard says that PEC is optional.
> > On the other hand, writes to SMBALERT don't require PEC. Because of
> > this, the driver is mostly reverse engineered with the help of a tool
> > called pmbus_peek written by David Brownell (and later adopted by my
> > colleague Jan Kundr=C3=A1t).
> >
> > The device also has some sort of a timing issue when switching pages,
> > which is explained further in the code.
> >
> > Because of this, the driver support is limited. It exposes only the
> > values, that have been tested to work correctly.
> >
> > Signed-off-by: V=C3=A1clav Kubern=C3=A1t <kubernat@cesnet.cz>
>
> checkpatch says:
>
> WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> #108: FILE: Documentation/hwmon/fsp-3y.rst:1:
> +Kernel driver fsp3y
>
> WARNING: line length of 137 exceeds 100 columns
> #409: FILE: drivers/hwmon/pmbus/fsp-3y.c:225:
> +               dev_warn(&client->dev, "Device mismatch: Configured %s (%=
d), detected %d\n", id->name, (int)id->driver_data, data->chip);
>
> Please fix and resubmit.
>

Done.

V=C3=A1clav

> Thanks,
> Guenter
