Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6A43B42A5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 13:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhFYLl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 07:41:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229458AbhFYLlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 07:41:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF0C161581;
        Fri, 25 Jun 2021 11:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624621144;
        bh=JGnEWaUyjgGCu2eYR28hbPglosr5/9B3AT1Cb7ByNaQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YpJU1fGRXPl1aoSGFS9JRNEcVNQKTVDnSKitshbSzxbxk0bh/qXw44EITET3ZvS8I
         MxhQoLimsjNLU7/ONgF8n87pvkdSnso5Fs/hcntVPn5YgZVsfWTwitM9JxFm5JAsM5
         ZT9QTEVj9NI4OvlQG5Q+iOsNq8fKRL24AzkAn49VSJdKBRy7Op8Q1SEmRUbG+7nmFS
         d7cWhHjw8i+gKc6R8NPYl78HaGEpeFM7XE3nA+LCF6VU9kkDsRJxc+zsSiE/h/h6vv
         k5MmV3Tn3EKXPpMHfdnbmPrZjYMh+lE9oaUCLs5grxPXfzj8wyHu+FEYgzB85frEW1
         J2jNzN9BzgSSA==
Date:   Fri, 25 Jun 2021 13:38:58 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Johan Hovold <johan@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH RESEND v6 6/8] mfd: hi6421-spmi-pmic: move driver from
 staging
Message-ID: <20210625133858.3bf1835f@coco.lan>
In-Reply-To: <YNSV+N0h7NoRpo/w@hovoldconsulting.com>
References: <cover.1624525118.git.mchehab+huawei@kernel.org>
        <1ad2cbbd182d18ba2cae716fb5f1497b1cabbdbe.1624525118.git.mchehab+huawei@kernel.org>
        <YNRrISOGujxcJAGR@dell>
        <20210624143605.153e1e34@coco.lan>
        <YNSRwIMr8+m9Sxk3@dell>
        <YNSV+N0h7NoRpo/w@hovoldconsulting.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 24 Jun 2021 16:26:00 +0200
Johan Hovold <johan@kernel.org> escreveu:

> On Thu, Jun 24, 2021 at 03:08:00PM +0100, Lee Jones wrote:
> > On Thu, 24 Jun 2021, Mauro Carvalho Chehab wrote:
> >   
> > > Em Thu, 24 Jun 2021 12:33:28 +0100
> > > Lee Jones <lee.jones@linaro.org> escreveu:  
> 
> > > > > --- /dev/null
> > > > > +++ b/drivers/mfd/hi6421-spmi-pmic.c
> > > > > @@ -0,0 +1,316 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > +/*
> > > > > + * Device driver for regulators in HISI PMIC IC
> > > > > + *
> > > > > + * Copyright (c) 2013 Linaro Ltd.
> > > > > + * Copyright (c) 2011 Hisilicon.
> > > > > + * Copyright (c) 2020-2021 Huawei Technologies Co., Ltd    
> > > > 
> > > > Can this be updated?  
> > > 
> > > Do you mean updating the copyrights to cover this year? E.g.
> > > something like this:
> > > 
> > > 	 * Copyright (c) 2013-2021 Linaro Ltd.
> > > 	 * Copyright (c) 2011-2021 Hisilicon.
> > > 	 * Copyright (c) 2020-2021 Huawei Technologies Co., Ltd  
> > > 
> > > Right? Or are you meaning something else?  
> > 
> > Yes, that's it.  I know this is just a move, but to MFD, it's new.  
> 
> That's not how copyright works. Unless Linaro and Hisilicon made
> nontrivial changes every year from 2011/2013 to 2021 you should not
> change those lines like this.

Only Linaro can answer what happened up to 2018, as this driver 
originally came from a Linaro tree, which has exactly one commit
for this driver:

	https://github.com/96boards-hikey/linux/commit/08464419fba2417aa849fce976fac9c5f51b3ada#diff-604ef8563dcd9ace6e3e58aac38337c72924b0889f6972d7ee9e15e2335ba964

After merged upstream at staging, all changes are covered by the
Huawei's copyright (2020-2021).

So, I'll just drop this patch. If the information is not accurate,
someone from the original copyright holders can send followup
patches.

Thanks,
Mauro
