Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6FE36B769
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 19:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235134AbhDZREC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 13:04:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:44790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233736AbhDZREB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 13:04:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D9C761104;
        Mon, 26 Apr 2021 17:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619456598;
        bh=r8NpZkLje05ZZJnM7NLUCg5ZcNDlIr14U1wSOtMhKdI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mbkQz9qp56+F+Y9RkvjDTr3vM0/xyUz2mj9KylsyPxnm3C9Xpvt9ScoJdt5fKiZYt
         MCVYZyQ3ceEsvoDiHlN8kRlfEjcz0ZF+IOzjtufU29WB3as0jRMLAi9/SreAWRB+cG
         EQtAQmblhchJlusjFW9RMK9qWgvbKKsq3qwnp6Nk=
Date:   Mon, 26 Apr 2021 19:03:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>
Subject: Re: [PATCH 100/190] Revert "staging: greybus: audio_manager: fix a
 missing check of ida_simple_get"
Message-ID: <YIbyVMmwf45lLJCf@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-101-gregkh@linuxfoundation.org>
 <20210422051345.gmxlylb5ykal7xqv@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422051345.gmxlylb5ykal7xqv@vireshk-i7>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 10:43:45AM +0530, Viresh Kumar wrote:
> On 21-04-21, 14:59, Greg Kroah-Hartman wrote:
> > This reverts commit b5af36e3e5aa074605a4d90a89dd8f714b30909b.
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
> > Cc: Vaibhav Agarwal <vaibhav.sr@gmail.com>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/staging/greybus/audio_manager.c | 3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/drivers/staging/greybus/audio_manager.c b/drivers/staging/greybus/audio_manager.c
> > index 9a3f7c034ab4..7c7ca671876d 100644
> > --- a/drivers/staging/greybus/audio_manager.c
> > +++ b/drivers/staging/greybus/audio_manager.c
> > @@ -45,9 +45,6 @@ int gb_audio_manager_add(struct gb_audio_manager_module_descriptor *desc)
> >  	int err;
> >  
> >  	id = ida_simple_get(&module_id, 0, 0, GFP_KERNEL);
> > -	if (id < 0)
> > -		return id;
> > -
> >  	err = gb_audio_manager_module_create(&module, manager_kset,
> >  					     id, desc);
> >  	if (err) {
> 
> FWIW, this patch was doing the right thing IMO. So we may not want to
> revert it.

Thanks for the review, I'll drop this revert.

greg k-h
