Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6137A344634
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 14:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhCVNu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 09:50:56 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2724 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbhCVNuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 09:50:50 -0400
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4F3wf75TNnz682gS;
        Mon, 22 Mar 2021 21:42:07 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 22 Mar 2021 14:50:48 +0100
Received: from localhost (10.47.84.0) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 22 Mar
 2021 13:50:47 +0000
Date:   Mon, 22 Mar 2021 13:49:29 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        <kbuild-all@lists.01.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: include/linux/unaligned/be_byteshift.h:46:19: error:
 redefinition of 'get_unaligned_be32'
Message-ID: <20210322134929.0000498b@Huawei.com>
In-Reply-To: <CACRpkda5ofCs=nkpZXVyekw2LoeYZUNrFTu1iGPt47ZSMa-6eg@mail.gmail.com>
References: <202103191536.9cD1TuQQ-lkp@intel.com>
        <CAHp75Vchoe2Z00ODh_AWos3Chfa1AoQMjZw7aD=5cGsTFtK7hQ@mail.gmail.com>
        <CACRpkda5ofCs=nkpZXVyekw2LoeYZUNrFTu1iGPt47ZSMa-6eg@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.84.0]
X-ClientProxiedBy: lhreml711-chm.china.huawei.com (10.201.108.62) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2021 14:33:46 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Fri, Mar 19, 2021 at 10:57 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Fri, Mar 19, 2021 at 9:05 AM kernel test robot <lkp@intel.com> wrote:  
> > >
> > > Hi Linus,
> > >
> > > FYI, the error/warning still remains.  
> (...)
> > >    In file included from include/linux/build_bug.h:5,
> > >                     from include/linux/bitfield.h:10,
> > >                     from drivers/iio/magnetometer/yamaha-yas530.c:22:  
> >
> > Isn't it fixed already somewhere?  
> 
> It is, I think Jonathan already applied the fix, it is just waiting to
> percolate up
> to Greg and then to Torvals:
> https://lore.kernel.org/linux-iio/20210221154511.75b3d8a6@archlinux/

I'm being slow.  Can apply it now as previous set of fixes have gone in.
I'll pick it up when I'm the right machine.

Jonathan

> 
> >> Kconfig warnings: (for reference only)
> >>    WARNING: unmet direct dependencies detected for SND_ATMEL_SOC_PDC
> >>    Depends on SOUND && !UML && SND && SND_SOC && SND_ATMEL_SOC && HAS_DMA
> >>    Selected by
> >>    - SND_ATMEL_SOC_SSC && SOUND && !UML && SND && SND_SOC && SND_ATMEL_SOC
> >>    - SND_ATMEL_SOC_SSC_PDC && SOUND && !UML && SND && SND_SOC && SND_ATMEL_SOC && ATMEL_SSC  
> >
> > This one though is interesting.  
> 
> This looks like nothing to me :/
> As confused as ever about Kconfig.
> 
> Yours,
> Linus Walleij

