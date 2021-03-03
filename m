Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE2232C2BC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351112AbhCDACJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:02:09 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:49639 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387985AbhCCUKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 15:10:08 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mg6Na-1liMQ52ib8-00hh0G for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021
 21:07:35 +0100
Received: by mail-ot1-f51.google.com with SMTP id h22so24853462otr.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 12:07:35 -0800 (PST)
X-Gm-Message-State: AOAM530t4TKC1VqHWIm8sgH995D8zIlCIX1Rw7ILh7Ii8AHL5h43maye
        ZgpH/ml6GExtg9QcTc2UmOuO9amtdXlK15g0CZo=
X-Google-Smtp-Source: ABdhPJxv/7ZtZ1Vrev+3ZiD+ZQuUiDcKrt3mECSCn1uhptL/wvua5yWVTUq0K2mw/w7pqtD2GZGGaKThUFn+Fc98Osc=
X-Received: by 2002:a9d:7f11:: with SMTP id j17mr624298otq.251.1614802054390;
 Wed, 03 Mar 2021 12:07:34 -0800 (PST)
MIME-Version: 1.0
References: <202103040304.DTElvlrq-lkp@intel.com>
In-Reply-To: <202103040304.DTElvlrq-lkp@intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 3 Mar 2021 21:07:18 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3x+JnCDVsNpCn0sSChXG41hCKmQMVAOuiLovGJSStUgA@mail.gmail.com>
Message-ID: <CAK8P3a3x+JnCDVsNpCn0sSChXG41hCKmQMVAOuiLovGJSStUgA@mail.gmail.com>
Subject: Re: COPYING CREDITS Documentation Kbuild Kconfig LICENSES MAINTAINERS
 Makefile README arch block certs crypto drivers fs include init ipc kernel
 lib mm net samples scripts security sound tools usr virt No rule to make
 target 'arch/c6x/Makefile'.
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:PTWNyf113yrihFsWbkAEEKW5NqTAIwmeL+7bHmYvnPmBcwFai1p
 XzWUJnwnSVUwmSQMoCe4dwF407Vg3KuWCYke6+oUrDphvQNe8lVKbSakVwVv1go80CwkrBm
 VDeitkVESz9DtLjVgMjC+RyU4CP28Yr9c+HjOB7IasE86CRYBjSDllXFat89BHSZGif9228
 +36VbHLaNxapY9LV+9/6A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3geSkNoVqZQ=:/H7qUG/f50ulp55eWOCzPF
 kwHWVIAV0oMX+KYPPiTF8QbNMvcOcBc7UV9nYeLN5q8BWjcyzy/So0onhfWejHjch9jQwCzWq
 ISSumI+gKXiZFicav9ZQinj3rP6T81oq63WaD2K7PLsLCpZ9li+vvuEKOiW9cWFPRMteTsB2i
 YDo7MBrGtrbVF5t9WlEgF87fRER7+5vPbvbHJ+J3qesl/pDpDckdXl/84iDM9+SkYrWt7miW/
 jKn0YL7Tia+SpRT8pAZK7nGYMtDdIYNBIb1ohtkkhUZwqjKD8hGp+QB3IpTRCIw/wGnZAPr+p
 X/Mgywzdwi8DXI3IWrje9RcnkA/3AZSTYPh5LujaqU1oeJV0L9nvzf17MCpqJZA3iqvKU2CBn
 qwAKWStxsyMXDGSGV0IDy4AuDwzInm7MKKxwIHcWbQ3FqmQIlM7N1IRXXE3hyIl8yeHdDzV1F
 1BxKaHtvlSHG9VfTmEBhXzKZ0pjriJEDc4K0bQPIXDvghEFFbJwhoYTfX/uDo84x75csb4Nsu
 8D9Q9aPQhI4X3EwyURoLMBAwPHXctBTrr0NqHbGlMxkC7Vu5YogL53xPS4zPI2PyA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 3, 2021 at 8:44 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Arnd,
>
> FYI, the error/warning still remains.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   f69d02e37a85645aa90d18cacfff36dba370f797
> commit: a579fcfa8e49cc77ad59211bb18bc5004133e6a0 c6x: remove architecture
> date:   6 weeks ago
> config: c6x-randconfig-r026-20210303 (attached as .config)
> compiler: c6x-elf-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a579fcfa8e49cc77ad59211bb18bc5004133e6a0
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout a579fcfa8e49cc77ad59211bb18bc5004133e6a0
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=c6x
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    Makefile:681: arch/c6x/Makefile: No such file or directory

Yes, arch/c6x is gone and unlikely to return. Please fix the 0day scripts
to no longer build it on v5.12-rc1 or higher.

        Arnd
