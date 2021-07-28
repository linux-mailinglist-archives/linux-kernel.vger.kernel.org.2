Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B643D8A82
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 11:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbhG1JZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 05:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234649AbhG1JZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 05:25:02 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3004FC061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 02:25:01 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id n10so1939986plf.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 02:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MtOK6evAa5bZBoqmOq1f4f1uWcdaYPO67v3iF8CegQ0=;
        b=LxWeYindgYnG+zutRD/Pw32ej8CyUdnhhNbJsdx3tBcXKYQRAFyjODpSivM0m8jx3b
         5VpTZE7VEZgQEwqaZEb0UwJh06wGXniqgJUT0pBT/FraHL/vTd2QruCvMrx4FIM1Jg9S
         35H85Ug9btpnNDGcT2htxF6q23ssQGldEAaCT21tF2D5KdT4G3v6uvPsUp1KRL1Gi59G
         s9lM4R/bkImu4ZPNEkAybkmTCvGigtNMmlzLdkee/bc9JTqwexGSQgo8NznoGkitYoOW
         /48PZyRsD2Bl5tWIwcR33AIKAqRUc1pX0fUYJb6ZM6yDodtZrvevldTeNi8PJXYF+wOR
         m+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MtOK6evAa5bZBoqmOq1f4f1uWcdaYPO67v3iF8CegQ0=;
        b=DMktBEKHW3kQmdI2Z190UNGsczrD/woC5Hs2ZjrXvJb+lb7yP/p/fkTvitGPLFAB07
         xBdY8lxLQhgnxfNLZjim0k4xi5kpqCopjrkM/TpuwLRxgXoUcSaCZToOj1bgY0uTiGaW
         mpz33lT4ngt5JL+OT41jGPYY+nQt+ldzhVhnSdlsAk7YXi4jPZG03Loio9eFKF3bbxWB
         EtAcilPyOEo6cyFJ8Va+O33K42LwXDGbCNqvCjh5bsDDSHwzU6OPAWL5TJRt6Wu21w/h
         I30fuP53DRCModxksMS6DjQuDzhcZCj8ioxP/SX7F4mXiKE3QWQGb8Mtgkz83qba6JNk
         qRSQ==
X-Gm-Message-State: AOAM531hY1gzJHgkWY2d5P8/DnGvJJNShW6TKPkEOMgnHX2OJ6qbOj94
        dIsR7eZMCYT5G/MIlCAll1+MfIFy5rJwEKTMyb4=
X-Google-Smtp-Source: ABdhPJzDNA+5L0HPhfytoEC01RRk5fmu16c7BHxsbAh6UB9y9VTGnv+qqOaNNXstHQMhXy3uMdWs9NQgah63mcaCBsc=
X-Received: by 2002:a62:84cb:0:b029:3a6:3dad:e271 with SMTP id
 k194-20020a6284cb0000b02903a63dade271mr727403pfd.40.1627464300712; Wed, 28
 Jul 2021 02:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210715115856.11304-1-song.bao.hua@hisilicon.com>
 <20210715115856.11304-5-song.bao.hua@hisilicon.com> <YPAlg5c8uDSZ2WvZ@smile.fi.intel.com>
 <YPCe+f3GPDUuvwnW@yury-ThinkPad> <CAHp75VcoNPiKDaZzTVr3unV3F5u+LQwAjy1hKSq0WUw_tB6uAw@mail.gmail.com>
 <YPDDdAwgYEptz2Uq@yury-ThinkPad> <YPgHtJqXi8cKad1Q@kroah.com>
 <YPmmR3JfgM/yIh1H@yury-ThinkPad> <YPmvMJHouZFDHVds@kroah.com>
 <YPm4eaqdx8mOIJ6p@yury-ThinkPad> <YPm8xVFSvola+RII@kroah.com> <e185c0c722b74da3baff1cb4e1c1eaf4@hisilicon.com>
In-Reply-To: <e185c0c722b74da3baff1cb4e1c1eaf4@hisilicon.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 28 Jul 2021 12:24:23 +0300
Message-ID: <CAHp75VdvOo1rStUrno1wNKi=O_Jj5MJ2q2V9QpMsAxsz1oOBEQ@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] lib: test_bitmap: add bitmap_print_to_buf test cases
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        "Ma, Jianpeng" <jianpeng.ma@intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Guodong Xu <guodong.xu@linaro.org>,
        tangchengchang <tangchengchang@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        yangyicong <yangyicong@huawei.com>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        Linuxarm <linuxarm@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 12:08 PM Song Bao Hua (Barry Song)
<song.bao.hua@hisilicon.com> wrote:
> > From: Greg Kroah-Hartman [mailto:gregkh@linuxfoundation.org]
> > Sent: Friday, July 23, 2021 6:45 AM

...

> +static int vb_bits = sizeof(large_bitmap) * BITS_PER_BYTE;
> +DECLARE_BITMAP(vbmap, sizeof(large_bitmap) * BITS_PER_BYTE);

Just side note: we have BITS_PER_TYPE() macro :-)

-- 
With Best Regards,
Andy Shevchenko
