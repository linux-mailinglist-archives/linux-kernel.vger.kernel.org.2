Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD02422114
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 10:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbhJEIsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 04:48:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:53908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232511AbhJEIsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 04:48:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B07C6120F;
        Tue,  5 Oct 2021 08:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633423620;
        bh=yXhzl3h0sKXQyctT2YSx7eahcPkhmMrjQ5NDPOPyW5Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WW3Z5pCirJQ5ppdZwXQ/8Veh8W4ckTb7Az8gQ7DXJwA+1BGKe/m/fO9T2ZMAvlCn2
         YCXsQ3q16130lQV0eFC47Kk5grsl3+5GNbtFzsINhV6ZiblJ1Ye5TZmff2yulmWLxS
         DfUpwvt5fc/b3zU9uhwqvO2ia2ApgAVIIfQ2knkmdAYr8oC7EmMXfA9Irt5iVd8tUi
         2dz6ShZfRHmwjNhxEsQv/v6QxF5GDFKNg0ATAcmm9UX0gwULEEuAFJcbweYZnpiYHG
         Bv6KjyJAEKWMiOzc6MBhop2b/q0tN4oq1rUAmOh+hfjd7pCGsVQB3pmsiOqlkYC6yZ
         ZiFcZz9GEnvKA==
Date:   Tue, 5 Oct 2021 10:46:56 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] mfd: hi6421-spmi-pmic: cleanup drvdata
Message-ID: <20211005104656.22d450b6@coco.lan>
In-Reply-To: <YVwImlQYPhc3/nhi@google.com>
References: <b6102d6db357ebb5c937f460a564c6f26281e403.1631709890.git.mchehab+huawei@kernel.org>
        <YVwD2sPZMCtwP9yf@google.com>
        <20211005095603.0e204776@coco.lan>
        <YVwImlQYPhc3/nhi@google.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 5 Oct 2021 09:11:06 +0100
Lee Jones <lee.jones@linaro.org> escreveu:

> On Tue, 05 Oct 2021, Mauro Carvalho Chehab wrote:
> 
> > Em Tue, 5 Oct 2021 08:50:50 +0100
> > Lee Jones <lee.jones@linaro.org> escreveu:
> >   
> > > On Wed, 15 Sep 2021, Mauro Carvalho Chehab wrote:
> > >   
> > > > There are lots of fields at struct hi6421_spmi_pmic that aren't
> > > > used. In a matter of fact, only regmap is needed.
> > > > 
> > > > So, drop the struct as a hole, and set just the regmap as
> > > > the drvdata.
> > > > 
> > > > Acked-by: Mark Brown <broonie@kernel.org>
> > > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > > ---
> > > >  drivers/mfd/hi6421-spmi-pmic.c           | 16 +++++----------
> > > >  drivers/misc/hi6421v600-irq.c            |  9 ++++-----
> > > >  drivers/regulator/hi6421v600-regulator.c | 10 +++++-----
> > > >  include/linux/mfd/hi6421-spmi-pmic.h     | 25 ------------------------
> > > >  4 files changed, 14 insertions(+), 46 deletions(-)
> > > >  delete mode 100644 include/linux/mfd/hi6421-spmi-pmic.h    
> > > 
> > > For my own reference (apply this as-is to your sign-off block):
> > > 
> > >   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > > 
> > > I intend to take this with a Misc Ack.  
> > 
> > Hi Lee,
> > 
> > Greg already gave you:
> > 
> > 	https://lore.kernel.org/all/YVLA14jbwqXjNM2f@kroah.com/  
> 
> Yes, I found that after I replied to this one.
> 
> I was having some trouble applying it with `b4` just as you replied:
> 
>   https://lore.kernel.org/tools/CAF2Aj3icJtU+wacosM-LO2aqMChWL69T6bf7dK3xqPMSk6Ux3w@mail.gmail.com/T/#u

Weird. Yeah, getting acks are sometimes problematic. I remember
having issues with that (a long time ago) with patchwork too.

> I fixed the spelling/grammar mistakes and applied the patch.

Thank you!

Best regards,
Mauro
