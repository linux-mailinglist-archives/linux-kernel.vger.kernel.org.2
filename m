Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4648645A732
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 17:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238718AbhKWQL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 11:11:29 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:35493 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236886AbhKWQL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 11:11:28 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N9Mh8-1mbTr43e1k-015MrU for <linux-kernel@vger.kernel.org>; Tue, 23 Nov
 2021 17:08:18 +0100
Received: by mail-wr1-f51.google.com with SMTP id u1so39814590wru.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 08:08:18 -0800 (PST)
X-Gm-Message-State: AOAM531tYLLvy5exHRJqynoQt8wtRWLWsoqwfM9V/7f1Tzgua0KLErYB
        DugRkCyE8RJbWvz1MWI9PGEO3uR7UB644DSxIDw=
X-Google-Smtp-Source: ABdhPJyLu6C9tvxPe7oJkk0ORj7r3QxU0+nfpWuLT3vDnu+YqZ4sAuYzRYlOmmJb4SJV8RrpndWX4BapnzxR8jBRhc8=
X-Received: by 2002:adf:f088:: with SMTP id n8mr8650853wro.411.1637683697394;
 Tue, 23 Nov 2021 08:08:17 -0800 (PST)
MIME-Version: 1.0
References: <202111232352.1I2ZjeBh-lkp@intel.com>
In-Reply-To: <202111232352.1I2ZjeBh-lkp@intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 23 Nov 2021 17:08:01 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0qKiaNHYVNDMA-NhOx8VJtsY9mOPE20Fy1Ms0pbjLydQ@mail.gmail.com>
Message-ID: <CAK8P3a0qKiaNHYVNDMA-NhOx8VJtsY9mOPE20Fy1Ms0pbjLydQ@mail.gmail.com>
Subject: Re: arch/arm/kernel/sys_oabi-compat.c:251:51: sparse: sparse:
 incorrect type in argument 3 (different address spaces)
To:     kernel test robot <lkp@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:4LwkbLTWK+wjZCZvc94EsYQkhs2+/mYJsQDJE49+WZ8buIiDgJf
 BkdNXDtq3Ta9M4Op2WV+syjaj+IujnBWdROHZYrboPjKvX/PIDD6DQOHfaLFvX8wwx8roVa
 ta+WIJvLXjT8Mguey8QN5ZFfVubzMm7lP0bLGab9rsEdgdXdfpOP1lupc2ZB2d6SJmBKXwc
 e2lypVTJ2pcCIXLEz9i5Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WHiKxtHdMhI=:GhImYQRF3RlXCk0PmAuMEg
 dGihNS/0XDEuIIbYMI+hUOgDmFQfTXTx+CMwPDGTHO/IlxWCn72ZNNZqRq9W4dmu8HobJkUTN
 txWTdg72pKHe/5GLLRpBlWV1pSxxwhskJhvVFqgojTU5nC3nWXz3tdYl3gona1QPs6+9b4GFv
 yV+pagzN3JfB9MPW3mLpR49tZsTFi7VZ6efw01BQQanxQedxnZgaFgcKiOD+XwclTCsXAAyx7
 /9yK7yDfhqQg3ki7yNj9YUcGaLz37DVEVyVNcj2O8fkQCVTG56w7CvNSEzSOgy61cCsSEImf5
 NsuVh1rcRph28Y/+dvLH44Cz70i+6E0GwE3fyitkvzjDQBZe1uv6ODtT3Jc1Q5ylOTPI+GifR
 VKYokBi/QuJGZMxl+aBx7XdYAel9rxIgLsj2KG9h2TlEbLk0w/6eZXNC23RVbfY3X7MUiaewj
 UPR7ndSCK6hoI6XjE+7eQiypt5jvjTCzOl43osxs2MN3A5O0q4HKbtbvz1h/x7ygI99X6lkKt
 OhbhdqhMJnwgI9YnOv1R6SfadsErdf0yskRoVgQJaXC6TWCAzrmU9K6wyBgG7SGUfJotBSS07
 W+8hlmrF4dcFdSc9sTqk699SceqNbwCHJxNBL5MeyysmPEjhcWw0+/0n6J5r8WMtNMQL2xhEt
 lNMJIkU53ly/eVEibx7KdNlsgUVkPU4GIhlJ0nuWgbLwB7mz/rUwaeyZfjqCVoQarehw=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 4:12 PM kernel test robot <lkp@intel.com> wrote:
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
>
> sparse warnings: (new ones prefixed by >>)
> >> arch/arm/kernel/sys_oabi-compat.c:251:51: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected struct flock64 [noderef] __user *user @@     got struct flock64 * @@
>    arch/arm/kernel/sys_oabi-compat.c:251:51: sparse:     expected struct flock64 [noderef] __user *user
>    arch/arm/kernel/sys_oabi-compat.c:251:51: sparse:     got struct flock64 *
>    arch/arm/kernel/sys_oabi-compat.c:265:55: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected struct flock64 [noderef] __user *user @@     got struct flock64 * @@
>    arch/arm/kernel/sys_oabi-compat.c:265:55: sparse:     expected struct flock64 [noderef] __user *user
>    arch/arm/kernel/sys_oabi-compat.c:265:55: sparse:     got struct flock64 *
>    arch/arm/kernel/sys_oabi-compat.c:292:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __poll_t [usertype] events @@     got unsigned int [addressable] [usertype] events @@
>    arch/arm/kernel/sys_oabi-compat.c:292:23: sparse:     expected restricted __poll_t [usertype] events
>    arch/arm/kernel/sys_oabi-compat.c:292:23: sparse:     got unsigned int [addressable] [usertype] events
>    arch/arm/kernel/sys_oabi-compat.c:312:21: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int __pu_val @@     got restricted __poll_t [usertype] revents @@
>    arch/arm/kernel/sys_oabi-compat.c:312:21: sparse:     expected unsigned int __pu_val
>    arch/arm/kernel/sys_oabi-compat.c:312:21: sparse:     got restricted __poll_t [usertype] revents

Thanks for the report. I see this was a pre-existing problem that now
shows up on
arm as well, sent a fix for it at

https://lore.kernel.org/linux-fsdevel/20211123160531.93545-1-arnd@kernel.org/T/

        Arnd
