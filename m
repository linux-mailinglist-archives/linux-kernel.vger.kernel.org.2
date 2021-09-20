Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B98411557
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 15:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239225AbhITNQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 09:16:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:38906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235540AbhITNQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 09:16:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E25A60FE6;
        Mon, 20 Sep 2021 13:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632143698;
        bh=tAZABOypw1IlJ2knAgYtx3xxSfYFHOPFbRsn6jg6CSE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BD8z1gsLT8T/lfDWwpR6e7/aM4AqS/OVbTzAwcaqI8lycrDj8LFKg4TDR9NIo74kc
         n/S0hsRSWoWcbgSNfTpHK2vHnVxSZJf4CNAt5DnKuCV6hJ2xHNVv9MO3R/xcdqzVnj
         7qICeQkp+a4HVIjPIiDtEpT1naLcbJcRRRQ2zkd6H9irPYp8ac2M/uIZ83hmN74qBM
         13W5f8bb1T/1csPzIDDMM2VG5BJKPGUeBbkz5etc3rJ07/BAVn5JKddeEjpKEc1hf4
         AU+sIGKFK3uW95Sfb7Oew9PHpuh/LFpLLkoz+ZBgq1EvTrrimDLQAMthCaMSNLVr9E
         YIcA6L3KOJF2g==
Received: by mail-wr1-f44.google.com with SMTP id x6so29541262wrv.13;
        Mon, 20 Sep 2021 06:14:58 -0700 (PDT)
X-Gm-Message-State: AOAM530wj0mG4YDCvBG9ZFjlYj8H6ojVI1vOxHiww7s2fZGy2/2BGE8u
        XPx8GNHzqp8j/1OX01wxL9RJXBa4bmIdMWXN4Z8=
X-Google-Smtp-Source: ABdhPJztJWWZTJcIQrQfR2lMH/0PSWjOyy6RRBCJn+gZMd0asiRPg8bt1UOeEDdEsQJAworhHh5pxVkf7wmrIbtE8Y0=
X-Received: by 2002:a1c:23cb:: with SMTP id j194mr29086176wmj.1.1632143696757;
 Mon, 20 Sep 2021 06:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210920121421.93297-1-arnd@kernel.org> <20210920123131.6kpv3ffxvm7xeqga@pali>
In-Reply-To: <20210920123131.6kpv3ffxvm7xeqga@pali>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 20 Sep 2021 15:14:40 +0200
X-Gmail-Original-Message-ID: <CAK8P3a10NR5CqoTxtjyrx5g6kO-hEkhaw7psEJHSSOZM9S+JXQ@mail.gmail.com>
Message-ID: <CAK8P3a10NR5CqoTxtjyrx5g6kO-hEkhaw7psEJHSSOZM9S+JXQ@mail.gmail.com>
Subject: Re: [PATCH] hwmon: dell-smm-hwmon: remove unused variable warning
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Armin Wolf <W_Armin@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Carlos Alberto Lopez Perez <clopez@igalia.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sebastian Oechsle <setboolean@icloud.com>,
        linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 2:31 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
> On Monday 20 September 2021 14:14:16 Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > When procfs is disabled
>
> ... then the i8k_init_procfs function should not be called as the
> purpose of I8K code / config option is to export functionality over
> procfs. So when procfs is disabled then this i8k is noop.
>
> Patch which do not allow compilation of I8K when procfs is not enabled
> is pending here:
>
> https://lore.kernel.org/linux-hwmon/20210910071921.16777-1-rdunlap@infrad=
ead.org/
>
> Ideally please test or review it. As you are not the first one who
> spotted -Werror problems with i8k and tried to workaround it.

Ok, I'm now using that version in my randconfig tree, it looks sensible
and it addresses another problem. I'll let you know if something else
comes up with that patch applied, but I'm sure it fixes the issue
I reported. Feel free to add

Reported-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>

to Randy's patch if you like.

> > the code produces a warning
> > for an unused variable:
> >
> > drivers/hwmon/dell-smm-hwmon.c: In function 'i8k_init_procfs':
> > drivers/hwmon/dell-smm-hwmon.c:624:31: error: unused variable 'data' [-=
Werror=3Dunused-variable]
> >   624 |         struct dell_smm_data *data =3D dev_get_drvdata(dev);
> >       |                               ^~~~
>
> I'm starting to hate this -Werror decision... but seems that we have to
> deal with it and together cleanup code as much as possible.

Oh, I totally would have sent you my patch without the -Werror change
as well ;-)

       Arnd
