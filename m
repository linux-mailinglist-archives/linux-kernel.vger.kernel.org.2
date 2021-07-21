Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2DB33D0CAF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 13:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238985AbhGUJkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 05:40:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:48330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236370AbhGUJaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 05:30:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFE3F6108B;
        Wed, 21 Jul 2021 10:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626862238;
        bh=xlNP5a4uduYvyMqVF4Oq/f5D4uaNQN51y0PLueC06Os=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EBo9p2yYYcIhOINxDz4pJjeRD+z/tvNLVzQoC71kmOBTNtDVF1poAeRj3Sq412JxZ
         v5JSyAmYQbmMUNybwD0NkPlWVAJZksPNP3tmLoY1JhdcrM09uQGXcRS4/WerD7E7Ir
         6NfeqeFPiKiQa6pFzZBdGAZDw/KPsrbkRCAxUhQmEAov0iJzWY5PRfZ4w289WDGo7Y
         sOPiPKHoH7ky9ICLk+BFTRnAGx7KSwnzmzncT57T3S7lZB0uaWYYCyg0/XakErPiW8
         HIgqzNZ23c6AKgTIaKiXK8ZqauPAOOv9m3ChJFm7JY4UGUBKbuJ3krSU0UfHy+Qh4w
         VNHnn4IT99Rjg==
Date:   Wed, 21 Jul 2021 12:10:31 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Arnd Bergmann <arnd@arndb.de>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v14 5/9] staging: hi6421-spmi-pmic: cleanup drvdata
Message-ID: <20210721121031.04bcadcc@coco.lan>
In-Reply-To: <YPfoGzCtS7sBFESm@kroah.com>
References: <cover.1626515862.git.mchehab+huawei@kernel.org>
        <723edefbb2e9ce0b70d9c7bce95f288e3ea1f5b1.1626515862.git.mchehab+huawei@kernel.org>
        <YPfoGzCtS7sBFESm@kroah.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 21 Jul 2021 11:25:47 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:

> On Sat, Jul 17, 2021 at 11:58:16AM +0200, Mauro Carvalho Chehab wrote:
> > There are lots of fields at struct hi6421_spmi_pmic that aren't
> > used. In a matter of fact, only regmap is needed.
> > 
> > So, drop the struct as a hole, and set just the regmap as
> > the drvdata.
> > 
> > While here, add a missing dot at the Huawei's copyrights.
> > 
> > Acked-by: Mark Brown <broonie@kernel.org>
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  drivers/misc/hi6421v600-irq.c               |  9 ++++----
> >  drivers/regulator/hi6421v600-regulator.c    | 10 ++++-----
> >  drivers/staging/hikey9xx/hi6421-spmi-pmic.c | 16 +++++--------
> >  include/linux/mfd/hi6421-spmi-pmic.h        | 25 ---------------------
> >  4 files changed, 14 insertions(+), 46 deletions(-)
> >  delete mode 100644 include/linux/mfd/hi6421-spmi-pmic.h  
> 
> This patch fails to apply to my 5.14-rc2 tree, it gets a failure in the
> regulator portion of the patch.

Hi Greg,

This one depends on a regression-fix patch merged via this branch:

	https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

The patch is this one[1]:

	https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git/commit/drivers/regulator/hi6421v600-regulator.c?id=5db5dd5be70eaf808d9fd90174b957fc5c2912cb

Mark,

Is this branch stable or do you rebase it? 

If the branch is stable, then perhaps Greg could merge from it before
applying the remaining patches from this series.

-

[1] There's no need of backporting the fix to stable, as the driver
    won't work with upstream Kernels without patches 8 and 9 from 
    this series containing the Open Firmware data needed to probe it.

Thanks,
Mauro
