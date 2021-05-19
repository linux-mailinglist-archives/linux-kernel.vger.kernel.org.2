Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 926733895B5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 20:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbhESSqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 14:46:20 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21338 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbhESSqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 14:46:19 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1621449892; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=b0yFyDcZsHnlAN+FoK0XV1WMlt5NBBf9R97ltsLNQqxlf6oezQvvgNoyDsZAMMDPa+X0DhAHJ1tG3N02EIpw9UfZ9+xuvsOzI0dwrQYatGeHD/v7ng3DIrYPf/te2rvWE4ysQJWJHOcHBk9i7B9HJhtMAyH/Pto6+SClEHDYLcc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1621449892; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=/HCEGEUOUTNwUIIpW9v3T4U1UNb4L1UEvk2lq/m6dm8=; 
        b=Fyy3yfwaiAapzWEpTScilpWlTh+XkHzwKbtPJhZJoZ/HYSI/G5AjoBBEKBDptzFtWGUliPym5JZysch802L7Dl1iEVb3/8VoEqFM3hPZDic63fxuEg5mquP2as2GKeHnC52ol8P4pD8m0kHVFuLrvIYVXvXFPP9ZRQiFED5ZfS0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=anirudhrb.com;
        spf=pass  smtp.mailfrom=mail@anirudhrb.com;
        dmarc=pass header.from=<mail@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1621449892;
        s=zoho; d=anirudhrb.com; i=mail@anirudhrb.com;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
        bh=/HCEGEUOUTNwUIIpW9v3T4U1UNb4L1UEvk2lq/m6dm8=;
        b=ditKRJE0pjWxeJiLMs8EAFQJuPGa8AMkj2NhH7NZMubHYGHWyd+VOsi1SnWVM8aE
        OLeoOwWPko7ODmM05WZAY54TpPcrg/+j/UhTCHVq6MII81qZw8WugOzoUc+TYdG3j3R
        mt0tzJl6k/GG1OwuqfK3u6pZrFBRVe7GMYbhLQd0=
Received: from anirudhrb.com (49.207.58.139 [49.207.58.139]) by mx.zohomail.com
        with SMTPS id 1621449891388404.3726339276054; Wed, 19 May 2021 11:44:51 -0700 (PDT)
Date:   Thu, 20 May 2021 00:14:45 +0530
From:   Anirudh Rayabharam <mail@anirudhrb.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Junyong Sun <sunjy516@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+de271708674e2093097b@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] firmware_loader: fix use-after-free in
 firmware_fallback_sysfs
Message-ID: <YKVcnQ7mm1b92mbR@anirudhrb.com>
References: <20210518155921.4181-1-mail@anirudhrb.com>
 <20210519032014.GS4332@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519032014.GS4332@42.do-not-panic.com>
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 03:20:14AM +0000, Luis Chamberlain wrote:
> On Tue, May 18, 2021 at 09:29:20PM +0530, Anirudh Rayabharam wrote:
> > This use-after-free happens when a fw_priv object has been freed but
> > hasn't been removed from the pending list (pending_fw_head). The next
> > time fw_load_sysfs_fallback tries to insert into the list, it ends up
> > accessing the pending_list member of the previoiusly freed fw_priv.
> > 
> > The root cause here is that all code paths that abort the fw load
> > don't delete it from the pending list. For example:
> > 
> > 	_request_firmware()
> > 	  -> fw_abort_batch_reqs()
> > 	      -> fw_state_aborted()
> > 
> > To fix this, delete the fw_priv from the list in __fw_set_state() if
> > the new state is DONE or ABORTED. This way, all aborts will remove
> > the fw_priv from the list. Accordingly, remove calls to list_del_init
> > that were being made before calling fw_state_(aborted|done)().
> > 
> > Also, in fw_load_sysfs_fallback, don't add the fw_priv to the list
> > if it is already aborted. Instead, just jump out and return early.
> > 
> > Fixes: bcfbd3523f3c ("firmware: fix a double abort case with fw_load_sysfs_fallback")
> > Reported-by: syzbot+de271708674e2093097b@syzkaller.appspotmail.com
> > Tested-by: syzbot+de271708674e2093097b@syzkaller.appspotmail.com
> > Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
> > ---
> > 
> > Changes in v4:
> > Documented the reasons behind the error codes returned from
> > fw_sysfs_wait_timeout() as suggested by Luis Chamberlain.
> > 
> > Changes in v3:
> > Modified the patch to incorporate suggestions by Luis Chamberlain in
> > order to fix the root cause instead of applying a "band-aid" kind of
> > fix.
> > https://lore.kernel.org/lkml/20210403013143.GV4332@42.do-not-panic.com/
> > 
> > Changes in v2:
> > 1. Fixed 1 error and 1 warning (in the commit message) reported by
> > checkpatch.pl. The error was regarding the format for referring to
> > another commit "commit <sha> ("oneline")". The warning was for line
> > longer than 75 chars. 
> > 
> > ---
> >  drivers/base/firmware_loader/fallback.c | 46 ++++++++++++++++++-------
> >  drivers/base/firmware_loader/firmware.h |  6 +++-
> >  drivers/base/firmware_loader/main.c     |  2 ++
> >  3 files changed, 40 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
> > index 91899d185e31..f244c7b89ba5 100644
> > --- a/drivers/base/firmware_loader/fallback.c
> > +++ b/drivers/base/firmware_loader/fallback.c
> > @@ -70,7 +70,31 @@ static inline bool fw_sysfs_loading(struct fw_priv *fw_priv)
> >  
> >  static inline int fw_sysfs_wait_timeout(struct fw_priv *fw_priv,  long timeout)
> >  {
> > -	return __fw_state_wait_common(fw_priv, timeout);
> > +	int ret = __fw_state_wait_common(fw_priv, timeout);
> > +
> > +	/*
> > +	 * A signal could be sent to abort a wait. Consider Android's init
> > +	 * gettting a SIGCHLD, which in turn was the same process issuing the
> > +	 * sysfs store call for the fallback. In such cases we want to be able
> > +	 * to tell apart in userspace when a signal caused a failure on the
> > +	 * wait. In such cases we'd get -ERESTARTSYS.
> > +	 *
> > +	 * Likewise though another race can happen and abort the load earlier.
> > +	 *
> > +	 * In either case the situation is interrupted so we just inform
> > +	 * userspace of that and we end things right away.
> > +	 *
> > +	 * When we really time out just tell userspace it should try again,
> > +	 * perhaps later.
> > +	 */
> > +	if (ret == -ERESTARTSYS || fw_state_is_aborted(fw_priv))
> > +		ret = -EINTR;
> > +	else if (ret == -ETIMEDOUT)
> > +		ret = -EAGAIN;
> 
> 
> Shuah has explained to me that the only motivation on her part with
> using -EAGAIN on commit 0542ad88fbdd81bb ("firmware loader: Fix
> _request_firmware_load() return val for fw load abort") was to
> distinguish the error from -ENOMEM, and so there was no real
> reason to stick to -EAGAIN. Given -EAGAIN is used typically to
> ask user to retry, but it makes no sense in this case since the
> sysfs interface is ephemeral, I think we should do away with it
> and document this rationale.

As per Shuah's explanation here:
https://lore.kernel.org/lkml/04b5bb2f-edf7-5b43-585a-3267d83bd8c3@linuxfoundation.org/

It looks like some media drivers expect -EAGAIN when there is a timeout
so that they can retry. So, looks like we have to retain -EAGAIN until
we verify that these media drivers don't need it anymore.

> 
> I think we should stick to use -ETIMEDOUT. Its more telling of what
> happened. And so I think just removing the check should do it, but
> augmenting the comment should suffice.
> 
> Since this change is already big, it would be good for this other
> change to go in as a separate change. If you can test to ensure the

"other change" here refers to getting rid of -EAGAIN and returning
-ETIMEDOUT instead right?

> -ETIMEDOUT does indeed get propagated that'd be appreciated.

Can you please clarify what needs to be tested here?
Obviously it is not getting propagated from this function to the caller. We
are returning -EAGAIN when we receive -ETIMEDOUT.

Thanks for the review!

	- Anirudh.

> 
> Otherwise looks good. Thanks for your patience!
> 
>   Luis
> 
> > +	else if (fw_priv->is_paged_buf && !fw_priv->data)
> > +		ret = -ENOMEM;
> > +
> > +	return ret;
> >  }
> >  
> >  struct fw_sysfs {
> > @@ -91,10 +115,9 @@ static void __fw_load_abort(struct fw_priv *fw_priv)
> >  	 * There is a small window in which user can write to 'loading'
> >  	 * between loading done and disappearance of 'loading'
> >  	 */
> > -	if (fw_sysfs_done(fw_priv))
> > +	if (fw_state_is_aborted(fw_priv) || fw_sysfs_done(fw_priv))
> >  		return;
> >  
> > -	list_del_init(&fw_priv->pending_list);
> >  	fw_state_aborted(fw_priv);
> >  }
> >  
> > @@ -280,7 +303,6 @@ static ssize_t firmware_loading_store(struct device *dev,
> >  			 * Same logic as fw_load_abort, only the DONE bit
> >  			 * is ignored and we set ABORT only on failure.
> >  			 */
> > -			list_del_init(&fw_priv->pending_list);
> >  			if (rc) {
> >  				fw_state_aborted(fw_priv);
> >  				written = rc;
> > @@ -513,6 +535,11 @@ static int fw_load_sysfs_fallback(struct fw_sysfs *fw_sysfs, long timeout)
> >  	}
> >  
> >  	mutex_lock(&fw_lock);
> > +	if (fw_state_is_aborted(fw_priv)) {
> > +		mutex_unlock(&fw_lock);
> > +		retval = -EINTR;
> > +		goto out;
> > +	}
> >  	list_add(&fw_priv->pending_list, &pending_fw_head);
> >  	mutex_unlock(&fw_lock);
> >  
> > @@ -526,20 +553,13 @@ static int fw_load_sysfs_fallback(struct fw_sysfs *fw_sysfs, long timeout)
> >  	}
> >  
> >  	retval = fw_sysfs_wait_timeout(fw_priv, timeout);
> > -	if (retval < 0 && retval != -ENOENT) {
> > +	if (retval < 0) {
> >  		mutex_lock(&fw_lock);
> >  		fw_load_abort(fw_sysfs);
> >  		mutex_unlock(&fw_lock);
> >  	}
> >  
> > -	if (fw_state_is_aborted(fw_priv)) {
> > -		if (retval == -ERESTARTSYS)
> > -			retval = -EINTR;
> > -		else
> > -			retval = -EAGAIN;
> > -	} else if (fw_priv->is_paged_buf && !fw_priv->data)
> > -		retval = -ENOMEM;
> > -
> > +out:
> >  	device_del(f_dev);
> >  err_put_dev:
> >  	put_device(f_dev);
> > diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firmware_loader/firmware.h
> > index 63bd29fdcb9c..36bdb413c998 100644
> > --- a/drivers/base/firmware_loader/firmware.h
> > +++ b/drivers/base/firmware_loader/firmware.h
> > @@ -117,8 +117,12 @@ static inline void __fw_state_set(struct fw_priv *fw_priv,
> >  
> >  	WRITE_ONCE(fw_st->status, status);
> >  
> > -	if (status == FW_STATUS_DONE || status == FW_STATUS_ABORTED)
> > +	if (status == FW_STATUS_DONE || status == FW_STATUS_ABORTED) {
> > +#ifdef CONFIG_FW_LOADER_USER_HELPER
> > +		list_del_init(&fw_priv->pending_list);
> > +#endif
> >  		complete_all(&fw_st->completion);
> > +	}
> >  }
> >  
> >  static inline void fw_state_aborted(struct fw_priv *fw_priv)
> > diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> > index 4fdb8219cd08..68c549d71230 100644
> > --- a/drivers/base/firmware_loader/main.c
> > +++ b/drivers/base/firmware_loader/main.c
> > @@ -783,8 +783,10 @@ static void fw_abort_batch_reqs(struct firmware *fw)
> >  		return;
> >  
> >  	fw_priv = fw->priv;
> > +	mutex_lock(&fw_lock);
> >  	if (!fw_state_is_aborted(fw_priv))
> >  		fw_state_aborted(fw_priv);
> > +	mutex_unlock(&fw_lock);
> >  }
> >  
> >  /* called from request_firmware() and request_firmware_work_func() */
> > -- 
> > 2.26.2
> > 
