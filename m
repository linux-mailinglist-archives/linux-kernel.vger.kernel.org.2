Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3EE3B32C3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 17:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbhFXPps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 11:45:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230008AbhFXPpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 11:45:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A03D6613DA;
        Thu, 24 Jun 2021 15:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624549407;
        bh=n60ZkyXBg0SxhfC/yfdkfqBc1HLpzy5XlSv/LlYFBRQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EdmBXl1c0+f5FIq7GZM480CY6UHMhEUmKY/TJGdQ4VeHCcRQsm80EMwTWty2xtGIe
         NrfHBDdlgkngAAWCHZsb+8nC8QHMAGm3M/Ep9zBu9EcIy2DeGxYiXW8K+CrN/78Oxk
         r6DilTdc35/6Ron2QPQWXgVOHmKI+6gtii8G9StjccEtkyKuA7Dah9bwBtgEsLLocG
         d+aJUMEZU1MsAnGTX87T124kLtnOaxhCIb+vinIYMG3rgI4JCBMwPd8ZPU3vFx2Fyu
         o4a/VnZNnJMOJ+rFKML1tRJ51bYwXywAQbuLoXNxO6ux/H7FMHJUXt2iGDmpGat5Cq
         k9e+OXu9NnDyw==
Date:   Thu, 24 Jun 2021 17:43:22 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v7 3/8] staging: hi6421-spmi-pmic: do some additional
 cleanups
Message-ID: <20210624174322.0fe582f0@coco.lan>
In-Reply-To: <YNSWIUzO1FYDAxyS@kroah.com>
References: <cover.1624542940.git.mchehab+huawei@kernel.org>
        <08b3d0eb4256c4fad25652f2aeb701b81d11ece2.1624542940.git.mchehab+huawei@kernel.org>
        <YNSWIUzO1FYDAxyS@kroah.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 24 Jun 2021 16:26:41 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:

> On Thu, Jun 24, 2021 at 04:01:32PM +0200, Mauro Carvalho Chehab wrote:
> > Before moving this driver out of staging, do a couple of
> > cleanups, in order to make the driver clearer.
> > 
> > No functional changes.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  drivers/staging/hikey9xx/hi6421-spmi-pmic.c   | 122 ++++++++++--------
> >  .../hikey9xx/hisilicon,hi6421-spmi-pmic.yaml  |   7 +-
> >  2 files changed, 71 insertions(+), 58 deletions(-)
> > 
> > diff --git a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
> > index 626140cb96f2..252b731e272d 100644
> > --- a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
> > +++ b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
> > @@ -2,9 +2,9 @@
> >  /*
> >   * Device driver for regulators in HISI PMIC IC
> >   *
> > - * Copyright (c) 2013 Linaro Ltd.
> > - * Copyright (c) 2011 Hisilicon.
> > - * Copyright (c) 2020-2021 Huawei Technologies Co., Ltd
> > + * Copyright (c) 2013- Linaro Ltd.
> > + * Copyright (c) 2011- Hisilicon.  
> 
> What does the "-" mean here?  That does not mean from 2013-present.

I'm pretty sure I found some copyright notes using this convention
somewhere to mean "2013-present".

Is there a proper/recommended way to tell so?

Regards,
Mauro
