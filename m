Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7893B3B342B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 18:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbhFXQvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 12:51:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:49716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229573AbhFXQv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 12:51:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 63551613EE;
        Thu, 24 Jun 2021 16:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624553346;
        bh=MeqLZfUB8tx3ZzyZcTQy1E/T0mhq/q0VqTm0Q8WZCNY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S/EszYzIkqMhReBJSrnSYZCczK+E9eWU7RMshVz5JFn2GPzr2Jz86oyEQbFMC/eJy
         jYPQ9dOJ7G7q72pqNAlCLQOiZsF/3+Lj7385Y6s1+2iTeOFyV600ntL11bQPofiPw9
         q/XqAdDjItAu957n+hOD14NQIOqy+6jEi+ZFZsfc=
Date:   Thu, 24 Jun 2021 18:49:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v7 3/8] staging: hi6421-spmi-pmic: do some additional
 cleanups
Message-ID: <YNS3gICIOD/HOx2N@kroah.com>
References: <cover.1624542940.git.mchehab+huawei@kernel.org>
 <08b3d0eb4256c4fad25652f2aeb701b81d11ece2.1624542940.git.mchehab+huawei@kernel.org>
 <YNSWIUzO1FYDAxyS@kroah.com>
 <20210624174322.0fe582f0@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624174322.0fe582f0@coco.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 05:43:22PM +0200, Mauro Carvalho Chehab wrote:
> Em Thu, 24 Jun 2021 16:26:41 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:
> 
> > On Thu, Jun 24, 2021 at 04:01:32PM +0200, Mauro Carvalho Chehab wrote:
> > > Before moving this driver out of staging, do a couple of
> > > cleanups, in order to make the driver clearer.
> > > 
> > > No functional changes.
> > > 
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > ---
> > >  drivers/staging/hikey9xx/hi6421-spmi-pmic.c   | 122 ++++++++++--------
> > >  .../hikey9xx/hisilicon,hi6421-spmi-pmic.yaml  |   7 +-
> > >  2 files changed, 71 insertions(+), 58 deletions(-)
> > > 
> > > diff --git a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
> > > index 626140cb96f2..252b731e272d 100644
> > > --- a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
> > > +++ b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
> > > @@ -2,9 +2,9 @@
> > >  /*
> > >   * Device driver for regulators in HISI PMIC IC
> > >   *
> > > - * Copyright (c) 2013 Linaro Ltd.
> > > - * Copyright (c) 2011 Hisilicon.
> > > - * Copyright (c) 2020-2021 Huawei Technologies Co., Ltd
> > > + * Copyright (c) 2013- Linaro Ltd.
> > > + * Copyright (c) 2011- Hisilicon.  
> > 
> > What does the "-" mean here?  That does not mean from 2013-present.
> 
> I'm pretty sure I found some copyright notes using this convention
> somewhere to mean "2013-present".

That is not a valid copyright date assignment listing.  There is no way
to say something like this as it does not make any sense.  The years
need to be listed individually or as a range.

thanks,

greg k-h
