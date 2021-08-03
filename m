Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6EA3DEAF6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 12:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbhHCKbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 06:31:55 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:40569 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234813AbhHCKby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 06:31:54 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MYeZB-1mg1OQ45Ux-00Vjwg for <linux-kernel@vger.kernel.org>; Tue, 03 Aug
 2021 12:31:42 +0200
Received: by mail-wr1-f42.google.com with SMTP id j2so24695139wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 03:31:41 -0700 (PDT)
X-Gm-Message-State: AOAM532L5osBaVvq6gNQeAmjOiAPehSBLbR7gaxxAxqRUd9UXevJqaze
        xE0UEIBXLTtafUIoWRPiBdCja9hjyEjZ2oHBStc=
X-Google-Smtp-Source: ABdhPJyzRliYlPjdId1Z99DKemt0qk/v+fYEz5YBqW5PiKvkp7MKTYM/tsiJthLEpCfm7IyB5pH43Xg/wHicRyI3NeY=
X-Received: by 2002:adf:f7c5:: with SMTP id a5mr22360483wrq.99.1627986701643;
 Tue, 03 Aug 2021 03:31:41 -0700 (PDT)
MIME-Version: 1.0
References: <202108031717.qedj386m-lkp@intel.com>
In-Reply-To: <202108031717.qedj386m-lkp@intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 3 Aug 2021 12:31:25 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0V1B6M6+wjJ=zXCEm3YDiv9o4OSUt3i2pbZ-YsxPxz+w@mail.gmail.com>
Message-ID: <CAK8P3a0V1B6M6+wjJ=zXCEm3YDiv9o4OSUt3i2pbZ-YsxPxz+w@mail.gmail.com>
Subject: Re: [arnd-playground:net-space-cleanup 7/14] drivers/net/ethernet/8390/ax88796.c:104:6:
 warning: no previous prototype for 'ax_NS8390_reinit'
To:     kernel test robot <lkp@intel.com>
Cc:     Michael Schmitz <schmitzmic@gmail.com>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:l45ZMeN+hKf/3gSD8tt1CacwZjHr1RqDp1T8ExWfyWmwwbiTSRe
 az3bmh2zNh81Kqsh5j08Vws2yDCcY7Fv1bXyKUvSyH5LWQdPOjd4ftmlGKgL8BjbD0k7bxN
 ZZVZuAwVlGDvPP77MG+d0SnJUcKKgtyncm0v+Ubj7UWE7WlK6fKZKFuYeBrxVW/P3FaAa09
 sCxTvD7fwUVaWc7RuIWiQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VbTgRc7hpus=:ZHosQTAYiwx6rCiFIoOieP
 YiB9vaoU7t303kemk4mCyQqfoPvcAyjDREjUMemPlX1CfAUvwbqUw1/VDR4DJsxW9DS7044PK
 Hj6+u4wBH8ASvASDSHKCc8Dq5IN4xHbp2lFZzX4CyRzLw8AtJ+/UGNEJ9a5aelaVdt/YyNnXA
 eg1AO/q3qA0phHgjE2cCDzpixciQl3AwqRpN6hCZQDeyj503mdAzsbCheyNr02kVHdjZH2AIj
 Vc0dz2CVhOOyZId+0IqCR+AKlSMmQmqHyvgtmRYGKvFk6ZFJMhiI8g/judXFDzuFQwTlVqawY
 UKZDI8xCK6TpUQZO0NT6o4rOVMYW/gNaTm4W98OCBN/lK5izcNelj2A0pnFoPorMZ1tk2OUad
 TH+HEoc2SxWRkXnG9RY94a7klRlh1mwqEP6fV5L1Td/y16eD/G17ho0x7k8pcyNnQ8GNd5Ixi
 +8JAAeBMteEMxN7MZO4zHPFrzOFgbAeurlKBj2TVMEvNZaslT0440EhIDztfTxB9HCm2qe1TW
 fiCBXEvk9V6YgTe0UAVfufY63gaiarPqOKB/ncECy9QvCuoJ7NXxbvnsG2sdGX8YmXnrH484N
 tfJYjsZ8yPdR8ICVHK9vtLAudRammEJcwhEJa/DaB6KpCIxMxq7IOGBHIp6h2OQLC9QSdH3iu
 3M2d2jFKGXAfqBlWFjAiGFvcF2p2UPnUTmV14k4pM2ejWzQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 3, 2021 at 11:35 AM kernel test robot <lkp@intel.com> wrote:
> All warnings (new ones prefixed by >>):
>
> >> drivers/net/ethernet/8390/ax88796.c:104:6: warning: no previous prototype for 'ax_NS8390_reinit' [-Wmissing-prototypes]
>      104 | void ax_NS8390_reinit(struct net_device *dev)
>          |      ^~~~~~~~~~~~~~~~
>
>
> vim +/ax_NS8390_reinit +104 drivers/net/ethernet/8390/ax88796.c
>
>    103
>  > 104  void ax_NS8390_reinit(struct net_device *dev)
>    105  {
>    106          ax_NS8390_init(dev, 1);
>    107  }
>    108

I'll resend the series in a bit, fixed up this warning by moving the
declaration to include/net/ax88796.h.

       Arnd
