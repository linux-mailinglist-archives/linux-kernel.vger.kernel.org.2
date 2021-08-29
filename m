Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03EC43FA96F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 08:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbhH2GR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 02:17:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:41228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229889AbhH2GRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 02:17:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D1BC60E94;
        Sun, 29 Aug 2021 06:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630217822;
        bh=z9NHJIp+9m32JFBHohbDfSx+jDKGjKtqZOmus2xodAQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VgTX1TXFr9Ojrbsqzv/yCzf3s+/Ti/N+W5hWwnxF3TzS+yZyLtrxJbBX3n/mIUm1j
         UKkh8MIdXhYAbZeUBnnHuQkWD91ZWBkNEDmnhGHUuA/s585lJxu1Z2zmaGGGait7M4
         1MD5WfDr5QqTuX2obk9ezaX6gQ8cshyCWaXdJ8bk=
Date:   Sun, 29 Aug 2021 08:16:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Krish Jain <krishjain02939@gmail.com>
Cc:     Bryan Brattlof <hello@bryanbrattlof.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] Declare the file_operations struct as const
Message-ID: <YSsmV3LIZ9NLZkdQ@kroah.com>
References: <CAPGkw+x+B1731SL=afoSKiWwH-n-FA5YJ+WOwYdv8iyFhWk1zA@mail.gmail.com>
 <3634721.RBzQ2xsved@localhost.localdomain>
 <1742120.GgyQvu0Ciu@localhost.localdomain>
 <CAPGkw+yJ=V0OwFE+uqCeWWS8JbJD=YBE3+Uk-OKpmHRnvSTh+A@mail.gmail.com>
 <CAPGkw+w-y+iC3dMDLxi8DR3N+jf8roiJ2Vs_-uHxJ=i57eTiUA@mail.gmail.com>
 <CAPGkw+zyj4e-m19KdrHpAN_vHksNDy=k_cPPAftSN-hNoph0=w@mail.gmail.com>
 <20210827233835.px4az5hyqks2n4o5@h510>
 <CAPGkw+x7sXUtrZYv6tm+Apbjk5CYwd1j1BvvL6uCPWsot3zKSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPGkw+x7sXUtrZYv6tm+Apbjk5CYwd1j1BvvL6uCPWsot3zKSg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 29, 2021 at 04:13:43AM +0200, Krish Jain wrote:
> On Sat, Aug 28, 2021 at 1:38 AM Bryan Brattlof <hello@bryanbrattlof.com> wrote:
> > As for your patch, I built the driver using:
> >
> >   $ make CCFLAGS=-Werror W=1 M=drivers/staging/android
> >
> > Which produced the following error:
> >
> >
> > drivers/staging/android/ashmem.c: In function ‘ashmem_mmap’:
> > drivers/staging/android/ashmem.c:380:2: warning: ‘static’ is not at beginning of declaration [-Wold-style-declaration]
> >   380 |  const static struct file_operations vmfile_fops;
> >       |  ^~~~~
> > drivers/staging/android/ashmem.c:431:16: error: assignment of read-only variable ‘vmfile_fops’
> >   431 |    vmfile_fops = *vmfile->f_op;
> >       |                ^
> > drivers/staging/android/ashmem.c:432:21: error: assignment of member ‘mmap’ in read-only object
> >   432 |    vmfile_fops.mmap = ashmem_vmfile_mmap;
> >       |                     ^
> > drivers/staging/android/ashmem.c:433:34: error: assignment of member ‘get_unmapped_area’ in read-only object
> >   433 |    vmfile_fops.get_unmapped_area =
> >       |                                  ^
> > make[1]: *** [scripts/Makefile.build:271: drivers/staging/android/ashmem.o] Error 1
> > make: *** [Makefile:1851: drivers/staging/android] Error 2
> >
> 
> Hi, this seems very useful and I tried this myself just now. I don't
> get any errors that you do though. When I hit enter I just get a new
> shell prompt. What am I doing wrong? Probably a silly mistake. I ran
> make CCFLAGS=-Werror M=drivers/staging/android/.

Are you sure the file is being built at all?  You usually have to select
the proper configuration option to enable that driver as well.

thanks,

greg k-h
