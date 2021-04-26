Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B167936B74A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 18:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbhDZQze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 12:55:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:59548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233736AbhDZQzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 12:55:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3381B61104;
        Mon, 26 Apr 2021 16:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619456091;
        bh=90z46Z30C/iIST0Wjmb9mX4F/+fisVbzWLYW5Uk2PZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OOW4Hgb5Fe1hKrjE2HSo3+4Gey9luXJiYUnrJit23iCgos3kyviy8S4AL4sRPEUOT
         LnyYdWaMxoeuh2bNLWoou49oQNsPLjakgo1V16adwu3wcCcwSqjTy0TqQwBknCotd4
         0WShR62xg1+UXuh9E5tO1RGyb5qE0Xt6wCYl9YW4=
Date:   Mon, 26 Apr 2021 18:54:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>
Subject: Re: [PATCH 165/190] Revert "mfd: mc13xxx: Fix a missing check of a
 register-read failure"
Message-ID: <YIbwWfVJLm5LEUw1@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-166-gregkh@linuxfoundation.org>
 <20210423093042.GE6446@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423093042.GE6446@dell>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 10:30:42AM +0100, Lee Jones wrote:
> On Wed, 21 Apr 2021, Greg Kroah-Hartman wrote:
> 
> > This reverts commit 9e28989d41c0eab57ec0bb156617a8757406ff8a.
> > 
> > Commits from @umn.edu addresses have been found to be submitted in "bad
> > faith" to try to test the kernel community's ability to review "known
> > malicious" changes.  The result of these submissions can be found in a
> > paper published at the 42nd IEEE Symposium on Security and Privacy
> > entitled, "Open Source Insecurity: Stealthily Introducing
> > Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> > of Minnesota) and Kangjie Lu (University of Minnesota).
> > 
> > Because of this, all submissions from this group must be reverted from
> > the kernel tree and will need to be re-reviewed again to determine if
> > they actually are a valid fix.  Until that work is complete, remove this
> > change to ensure that no problems are being introduced into the
> > codebase.
> > 
> > Cc: Kangjie Lu <kjlu@umn.edu>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/mfd/mc13xxx-core.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
> > index 1abe7432aad8..b2beb7c39cc5 100644
> > --- a/drivers/mfd/mc13xxx-core.c
> > +++ b/drivers/mfd/mc13xxx-core.c
> > @@ -271,9 +271,7 @@ int mc13xxx_adc_do_conversion(struct mc13xxx *mc13xxx, unsigned int mode,
> >  
> >  	mc13xxx->adcflags |= MC13XXX_ADC_WORKING;
> >  
> > -	ret = mc13xxx_reg_read(mc13xxx, MC13XXX_ADC0, &old_adc0);
> > -	if (ret)
> > -		goto out;
> > +	mc13xxx_reg_read(mc13xxx, MC13XXX_ADC0, &old_adc0);
> >  
> >  	adc0 = MC13XXX_ADC0_ADINC1 | MC13XXX_ADC0_ADINC2 |
> >  	       MC13XXX_ADC0_CHRGRAWDIV;
> 
> Thanks for bringing this commit to my attention.
> 
> The associated LWN article was an interesting read and I have to say,
> I was very disappointed to hear about the actions of these so called
> researchers.
> 
> Upon re-review of the original commit, this one does appear valid.
> 
> Do I need to conduct anymore due diligence or can I drop this patch?

I've dropped this revert from my tree now, thanks.

greg k-h
