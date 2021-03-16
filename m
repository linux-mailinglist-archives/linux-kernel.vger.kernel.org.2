Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D7C33D3E6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 13:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbhCPMdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 08:33:00 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:40613 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbhCPMcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 08:32:42 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MV5G4-1lF1Zv0plu-00SA4J for <linux-kernel@vger.kernel.org>; Tue, 16 Mar
 2021 13:32:41 +0100
Received: by mail-ot1-f52.google.com with SMTP id m1so8377684ote.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 05:32:40 -0700 (PDT)
X-Gm-Message-State: AOAM533rKFt3nM296gaoF2lyim7oKhuzFMhmaWtatxJ/hRyn8e5dEDaO
        O2zZ1raU4IlPxCxUmBmy6AIOsRECy/s8aVIDk14=
X-Google-Smtp-Source: ABdhPJxTUHnHXhAN4tXia6iWRwvgcQBgg+nHTP2QDb3F8BwK2hKVm3L1WodVtpIpvIHt60w1eagv+6FsWiWu8tKez3c=
X-Received: by 2002:a05:6830:14c1:: with SMTP id t1mr3480821otq.305.1615897959980;
 Tue, 16 Mar 2021 05:32:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210316083254.GR2087@kadam>
In-Reply-To: <20210316083254.GR2087@kadam>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 16 Mar 2021 13:32:23 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3trJHFLV+Qy+d5hD6=nGJgw8e=UU6BsPaCZDx5yNDKtA@mail.gmail.com>
Message-ID: <CAK8P3a3trJHFLV+Qy+d5hD6=nGJgw8e=UU6BsPaCZDx5yNDKtA@mail.gmail.com>
Subject: Re: drivers/usb/host/ohci-hcd.c:1318 ohci_hcd_mod_init() warn:
 ignoring unreachable code.
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, Stephen Boyd <sboyd@kernel.org>,
        kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Baryshkov <dbaryshkov@gmail.com>,
        Ian Molton <spyro@f2s.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:aOOZF4sMnIgwJUipW7WwCLF/QDxXi7unUbWRHbVqjTN3yJ/Q0/J
 4Baq0GExLr/nW5uP9MrMfNbbt8xVkPHBaa06fkppEmHcplYc4vvz8MjUiOnS/71VATkChQA
 Ut5Lilw5emKN0iCRmzQiBcnGuuhp99XqZtGPOIRzU0db9LZZazEI/ALs3YG6sxWLw68OpUz
 +9ezFMM3VKSPpNx0MNp7Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xKa4uThsZNE=:8/hHakkjaW3fsKhz9Sj7RA
 EJumHu30/aTlEcyXgVpoDAX1i7qQkqi3Hma8WqYmz8mR8cqJoU1lb7c8QgAg8OUxM3QvtM8Bh
 JjiHjGuAA/gH9bMFYNXj5LwNI8Yxl0WOdbdlhbiS+c/aQCLzVZMrkA0pQq9W29rFzmx8Ihcac
 RgtLsEoOiP0HPhJ8XB3Ki93EmK054JESX3a7WkQq/zOA+/oMiLisVo0fPcvrSjdB8bcgX591m
 FWWC2OexqZi4SY4XePC35PBhkxm3/H07o5QqZkmmYrC7c8Wx7m54zlN3Pzgu2sL46+0pfsE1O
 mC7fOFpzd6D+7c5Goz5vZKhEBVlTGV7Cu+WCaj1+fRSW0wLYq5pmX31vcJVEPOWHpGA9K9jxn
 pSx0CQDDWrvJ7ThXtiX87oD3jUt8boPJbd2RlbvJpsywxbizLWdFh/MyhfoGb
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 9:32 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   1a4431a5db2bf800c647ee0ed87f2727b8d6c29c
> commit: bbd7ffdbef6888459f301c5889f3b14ada38b913 clk: Allow the common clk framework to be selectable
> config: arm-randconfig-m031-20210316 (attached as .config)
> compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> smatch warnings:
> drivers/usb/host/ohci-hcd.c:1318 ohci_hcd_mod_init() warn: ignoring unreachable code.
>
> vim +1318 drivers/usb/host/ohci-hcd.c
>
> 78c73414f4f674 Dmitry Eremin-Solenikov 2008-10-08  1313
> 5e16fabe5dbcff Sylvain Munaut          2006-12-13  1314         return retval;
>                                                                 ^^^^^^^^^^^^^
>
> 5e16fabe5dbcff Sylvain Munaut          2006-12-13  1315
> 5e16fabe5dbcff Sylvain Munaut          2006-12-13  1316         /* Error path */
> 78c73414f4f674 Dmitry Eremin-Solenikov 2008-10-08  1317  #ifdef TMIO_OHCI_DRIVER
> 78c73414f4f674 Dmitry Eremin-Solenikov 2008-10-08 @1318         platform_driver_unregister(&TMIO_OHCI_DRIVER);
>                                                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Unreachable

It looks like this has been the case since tmio support was added in:
78c73414f4f6 ("USB: ohci: add support for tmio-ohci cell")

I wonder if any of the original developers are still around to fix it, it should
be trivial.

       Arnd
