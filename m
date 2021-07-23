Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713E23D3EA1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 19:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbhGWQqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 12:46:21 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:37555 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbhGWQqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 12:46:19 -0400
Received: by mail-pl1-f172.google.com with SMTP id n10so3990476plf.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 10:26:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eIP+gAEGNdJZ8KZlRhJNzrwP+HxVTKEl8qy9jJpz/Y8=;
        b=mUVqwfFAXnF5Lg0whLF/UJ5vMW0F7xg1JcRPjNsb1b8oiwEdXLigVsZuUHmhLXD99C
         T/D6EKHU1YPs+be5W1Ok7dLQXB42AV/yoHrqYDxtYYahg/JoBsZ8Ryhm9lLtT942fPko
         P1SjYKvfCS8XA+FjSRG5INqDUveZiUvj99gGQCzb0uuUioAvGamUdO/Nh2I6yzphbAjh
         A28MwDo/cX0xDFNyI/YzMzhFlrLsJ5I+t/aHe+2bF3L91X3IlE1oO/FQa5qd8MItR2sx
         RkyYj3DhJOsLaEb7ZWTAInFzLqMfThgPueKD3DCiK8Mk//QqsfW4NpnZOLjf3v+r+DaU
         Zxow==
X-Gm-Message-State: AOAM533eQvkHvgw8Ow/ZxivLPgSItm/bJqcrLxBr8LPlF8l6Mx83CNyx
        FVRN0AUmEZGWc6HwacdyXdM=
X-Google-Smtp-Source: ABdhPJzFSvdsmTNBbMK1sP98CGL3teU4mJjqQXEpZZpuvjaTewxPkFSJ0Xns15C8cpBJr1f5OWPQtA==
X-Received: by 2002:aa7:8509:0:b029:2e5:8cfe:bc17 with SMTP id v9-20020aa785090000b02902e58cfebc17mr5714529pfn.2.1627061212441;
        Fri, 23 Jul 2021 10:26:52 -0700 (PDT)
Received: from garbanzo ([191.96.121.239])
        by smtp.gmail.com with ESMTPSA id j13sm9145526pjl.1.2021.07.23.10.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 10:26:51 -0700 (PDT)
Date:   Fri, 23 Jul 2021 10:26:49 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Anirudh Rayabharam <mail@anirudhrb.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v6 1/2] firmware_loader: use -ETIMEDOUT instead of
 -EAGAIN in fw_load_sysfs_fallback
Message-ID: <20210723172649.t4b2hqlmhk3v7wn5@garbanzo>
References: <20210722123229.8731-1-mail@anirudhrb.com>
 <20210722123229.8731-2-mail@anirudhrb.com>
 <20210722195924.oezxwv3u3p5k737l@garbanzo>
 <YPrLIzMpSghz6YGL@anirudhrb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPrLIzMpSghz6YGL@anirudhrb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2021 at 07:28:59PM +0530, Anirudh Rayabharam wrote:
> On Thu, Jul 22, 2021 at 12:59:24PM -0700, Luis Chamberlain wrote:
> > On Thu, Jul 22, 2021 at 06:02:28PM +0530, Anirudh Rayabharam wrote:
> > > The only motivation for using -EAGAIN in commit 0542ad88fbdd81bb
> > > ("firmware loader: Fix _request_firmware_load() return val for fw load
> > > abort") was to distinguish the error from -ENOMEM, and so there is no
> > > real reason in keeping it. Keeping -ETIMEDOU is much telling of what the
> > 
> > Since you'll have to respin, a missing here   ^, also add that the
> > -ETIMEDOUT is what we'd get when we do time out on the wait, as its
> > not clear from the conext being changed.
> > 
> > > reason for a failure is, so just use that.
> > > 
> > > The rest is just trying to document a bit more of the motivations for the
> > > error codes, as otherwise we'd lose this information easily.
> > 
> > This is a separate change, and it actually does more than just that.
> > Moving code around should be done separately. The idea is to
> > first just remove the -EAGAIN so that the change is *easy* to review.
> > A remove of a return code *and* a move of code around makes it less
> > obvious for code review. And part of the comment is wrong now that we
> > removed -EAGAIN. When breaking patches up please review each change
> > going into each patch and consider if it makes sense, atomically.
> > 
> > > Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> > > Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
> > > ---
> > >  drivers/base/firmware_loader/fallback.c | 34 +++++++++++++++++--------
> > >  1 file changed, 24 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
> > > index 91899d185e31..1db94165feaf 100644
> > > --- a/drivers/base/firmware_loader/fallback.c
> > > +++ b/drivers/base/firmware_loader/fallback.c
> > > @@ -70,7 +70,29 @@ static inline bool fw_sysfs_loading(struct fw_priv *fw_priv)
> > >  
> > >  static inline int fw_sysfs_wait_timeout(struct fw_priv *fw_priv,  long timeout)
> > >  {
> > > -	return __fw_state_wait_common(fw_priv, timeout);
> > > +	int ret = __fw_state_wait_common(fw_priv, timeout);
> > > +
> > > +	/*
> > > +	 * A signal could be sent to abort a wait. Consider Android's init
> > > +	 * gettting a SIGCHLD, which in turn was the same process issuing the
> > > +	 * sysfs store call for the fallback. In such cases we want to be able
> > > +	 * to tell apart in userspace when a signal caused a failure on the
> > > +	 * wait. In such cases we'd get -ERESTARTSYS.
> > > +	 *
> > > +	 * Likewise though another race can happen and abort the load earlier.
> > 
> > This comment is about the check for fw_load_abort() so since the move is
> > not going to happen when you remove -EAGAIN just leave it out. It can be
> > added once you do the move.
> > 
> > > +	 *
> > > +	 * In either case the situation is interrupted so we just inform
> > > +	 * userspace of that and we end things right away.
> > 
> > Be mindful that this is in context of both cases when re-writing the
> > patches.
> > 
> > > +	 *
> > > +	 * When we really time out just tell userspace it should try again,
> > > +	 * perhaps later.
> > 
> > That's the thing, we're getting rid of that -EAGAIN as it made no sense,
> > the goal was to just distinguish the error from -ENOMEM. That's it.
> > Since we are removing the -EAGAIN, this comment makes no sense as we
> > have clarified with Shuah that the goal of her patch was just to
> > distinguish the error.
> > 
> > So "tell userspace to try again" makes no sense since if a timeout
> > happened userspace can't really try again as we have aborted the whole
> > operation to allow firmware to be uploaded.
> > 
> > In fact, please add that to the commit log which removes the -EAGAIN,
> > something like:
> > 
> > "Using -EAGAIN is also not correct as this return code is typically used
> > to tell userspace to try something again, in this case re-using the
> > sysfs loading interface cannot be retried when a timeout happens, so
> > the return value is also bogus."
> > 
> > > +	 */
> > > +	if (ret == -ERESTARTSYS || fw_state_is_aborted(fw_priv))
> > > +		ret = -EINTR;
> > > +	else if (fw_priv->is_paged_buf && !fw_priv->data)
> > > +		ret = -ENOMEM;
> > > +
> > > +	return ret;
> > >  }
> > >  
> > >  struct fw_sysfs {
> > > @@ -526,20 +548,12 @@ static int fw_load_sysfs_fallback(struct fw_sysfs *fw_sysfs, long timeout)
> > >  	}
> > >  
> > >  	retval = fw_sysfs_wait_timeout(fw_priv, timeout);
> > > -	if (retval < 0 && retval != -ENOENT) {
> > > +	if (retval < 0) {
> > >  		mutex_lock(&fw_lock);
> > >  		fw_load_abort(fw_sysfs);
> > >  		mutex_unlock(&fw_lock);
> > >  	}
> > >  
> > > -	if (fw_state_is_aborted(fw_priv)) {
> > > -		if (retval == -ERESTARTSYS)
> > > -			retval = -EINTR;
> > > -		else
> > > -			retval = -EAGAIN;
> > 
> > All we want to do is remove this -EAGAIN line in one patch. We
> > don't want to move code to another place. We do this to make code
> 
> Is the move necessary or should I drop it from this series entirely?

The move is possible, sure. Maybe do that in a separate patch. But
just read each patch as you write it, and make sure they do just *one*
thing at a time. Re-read the patch once done and make sure each
patch makes sense on its own.

  Luis
