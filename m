Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC2ED3B3140
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 16:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbhFXO2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 10:28:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:60392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230170AbhFXO2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 10:28:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1AB7B6024A;
        Thu, 24 Jun 2021 14:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624544760;
        bh=g4nK/+OEJMNnj0M0Sp0XY47oCV+wxBV8N6nu9t8TV80=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AoaFk4wIXu15ykoDaVQ85lXeLgPoLv1GVS7whQVRfWpNulJYJ+TZ7zvXYOpYFtuk9
         g95HwCpM7MnmA2zpKwhSaR17NVo6NZ3dh+c89kP5q0k5Q4YIXCNGbzVV9SG6dHDfwv
         rIVvgmH+FLdOLJu4Yl7sAEMb8ais0oWVCYBIsIIs12cUp9MFElHrywLks1H2bCuTh7
         51wWM2MrsAvjgQt11CI74Mw1j1VSsGHf8HdSK6wrkXAh+35dyuydNZW8aBsa8+U52u
         OZ4E8ldOJkYajALOndRtFa5GLObiS36t8UTx2KPkJzY/TVI4ZvQgbVlvnDAH+WuewL
         MHuEVUw14AHxw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1lwQIq-0007Nc-70; Thu, 24 Jun 2021 16:26:00 +0200
Date:   Thu, 24 Jun 2021 16:26:00 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH RESEND v6 6/8] mfd: hi6421-spmi-pmic: move driver from
 staging
Message-ID: <YNSV+N0h7NoRpo/w@hovoldconsulting.com>
References: <cover.1624525118.git.mchehab+huawei@kernel.org>
 <1ad2cbbd182d18ba2cae716fb5f1497b1cabbdbe.1624525118.git.mchehab+huawei@kernel.org>
 <YNRrISOGujxcJAGR@dell>
 <20210624143605.153e1e34@coco.lan>
 <YNSRwIMr8+m9Sxk3@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNSRwIMr8+m9Sxk3@dell>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 03:08:00PM +0100, Lee Jones wrote:
> On Thu, 24 Jun 2021, Mauro Carvalho Chehab wrote:
> 
> > Em Thu, 24 Jun 2021 12:33:28 +0100
> > Lee Jones <lee.jones@linaro.org> escreveu:

> > > > --- /dev/null
> > > > +++ b/drivers/mfd/hi6421-spmi-pmic.c
> > > > @@ -0,0 +1,316 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * Device driver for regulators in HISI PMIC IC
> > > > + *
> > > > + * Copyright (c) 2013 Linaro Ltd.
> > > > + * Copyright (c) 2011 Hisilicon.
> > > > + * Copyright (c) 2020-2021 Huawei Technologies Co., Ltd  
> > > 
> > > Can this be updated?
> > 
> > Do you mean updating the copyrights to cover this year? E.g.
> > something like this:
> > 
> > 	 * Copyright (c) 2013-2021 Linaro Ltd.
> > 	 * Copyright (c) 2011-2021 Hisilicon.
> > 	 * Copyright (c) 2020-2021 Huawei Technologies Co., Ltd  
> > 
> > Right? Or are you meaning something else?
> 
> Yes, that's it.  I know this is just a move, but to MFD, it's new.

That's not how copyright works. Unless Linaro and Hisilicon made
nontrivial changes every year from 2011/2013 to 2021 you should not
change those lines like this.

Johan
