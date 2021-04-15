Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25B1360224
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 08:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhDOGFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 02:05:51 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21331 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbhDOGFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 02:05:48 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1618466719; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=M3ddWaQ+qb+J8RiAPpgE3x1VqPC/HFoUS6tsXNcnRaJp3X3BumAThmX2P2eSpDv8k0NIqhdwDmGaxZMzceClbFBiX2MhFwGmegsYBjm7eIhUO+xj4ujVmus7E/W17pnBqvYPVHi5a2rzpOaHEOAT49+xyIURmRlPk2YNW+6+Fj8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1618466719; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=BtxGurJ2WPFeR1ekeiCa0B5pnQ7t0xfLSrOPoZH2J/Q=; 
        b=MBtcS26uunXxkQEUH9+4IXvK1SMo4K88WuJXgXDDwxXjQWWQ1lN6GrUpiYTmqpw2tBVNUsccrkA/ZoiqSntoCohvGUcfVVQUle/lv9oviqIpxESD8S+Lhl9phClO36xlcMtUk8mV3UUKf+ulVOfx+6SuujELx5FzuNSjlmaoEBo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=anirudhrb.com;
        spf=pass  smtp.mailfrom=mail@anirudhrb.com;
        dmarc=pass header.from=<mail@anirudhrb.com> header.from=<mail@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1618466719;
        s=zoho; d=anirudhrb.com; i=mail@anirudhrb.com;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
        bh=BtxGurJ2WPFeR1ekeiCa0B5pnQ7t0xfLSrOPoZH2J/Q=;
        b=uNTy7y1sMukjSX7E3XVJlJbLU+jIcbCHv9aiupm6+mwMqik9J0NZ+ERDb9CrHoLY
        QsLdxHKSJguvD3MdeopBu32fJT+a33IW3llBuA1znBbTXY025lvN+dxBDipwZLlmYAP
        BhIp/jEI8igJ1Ct3xR1vi+R04JbRVyYHyiWLZbvo=
Received: from anirudhrb.com (49.207.216.151 [49.207.216.151]) by mx.zohomail.com
        with SMTPS id 1618466718199202.62878359563967; Wed, 14 Apr 2021 23:05:18 -0700 (PDT)
Date:   Thu, 15 Apr 2021 11:35:12 +0530
From:   Anirudh Rayabharam <mail@anirudhrb.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Junyong Sun <sunjy516@gmail.com>,
        syzbot+de271708674e2093097b@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] firmware_loader: fix use-after-free in
 firmware_fallback_sysfs
Message-ID: <YHfXmFDwiLJir6z7@anirudhrb.com>
References: <20210414085406.1842-1-mail@anirudhrb.com>
 <20210414125540.GJ4332@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414125540.GJ4332@42.do-not-panic.com>
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 12:55:40PM +0000, Luis Chamberlain wrote:
> Shuah, a question for you toward the end here.
> 
> On Wed, Apr 14, 2021 at 02:24:05PM +0530, Anirudh Rayabharam wrote:
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
> > that were being made before calling fw_state_(aborted|done).
> > 
> > Also, in fw_load_sysfs_fallback, don't add the fw_priv to the pending
> > list if it is already aborted. Instead, just jump out and return early.
> > 
> > Fixes: bcfbd3523f3c ("firmware: fix a double abort case with fw_load_sysfs_fallback")
> > Reported-by: syzbot+de271708674e2093097b@syzkaller.appspotmail.com
> > Tested-by: syzbot+de271708674e2093097b@syzkaller.appspotmail.com
> > Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
> > ---
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
> >  drivers/base/firmware_loader/fallback.c | 8 ++++++--
> >  drivers/base/firmware_loader/firmware.h | 6 +++++-
> >  drivers/base/firmware_loader/main.c     | 2 ++
> >  3 files changed, 13 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
> > index 91899d185e31..73581b6998b4 100644
> > --- a/drivers/base/firmware_loader/fallback.c
> > +++ b/drivers/base/firmware_loader/fallback.c
> > @@ -94,7 +94,6 @@ static void __fw_load_abort(struct fw_priv *fw_priv)
> >  	if (fw_sysfs_done(fw_priv))
> >  		return;
> >  
> > -	list_del_init(&fw_priv->pending_list);
> >  	fw_state_aborted(fw_priv);
> >  }
> >  
> > @@ -280,7 +279,6 @@ static ssize_t firmware_loading_store(struct device *dev,
> >  			 * Same logic as fw_load_abort, only the DONE bit
> >  			 * is ignored and we set ABORT only on failure.
> >  			 */
> > -			list_del_init(&fw_priv->pending_list);
> >  			if (rc) {
> >  				fw_state_aborted(fw_priv);
> >  				written = rc;
> > @@ -513,6 +511,11 @@ static int fw_load_sysfs_fallback(struct fw_sysfs *fw_sysfs, long timeout)
> >  	}
> >  
> >  	mutex_lock(&fw_lock);
> > +	if (fw_state_is_aborted(fw_priv)) {
> > +		mutex_unlock(&fw_lock);
> > +		retval = -EAGAIN;
> > +		goto out;
> > +	}
> 
> Thanks for the quick follow up!
> 
> This would regress commit 76098b36b5db1 ("firmware: send -EINTR on
> signal abort on fallback mechanism") which I had mentioned in my follow
> up email you posted a link to. It would regress it since the condition
> is just being met earlier and you nullify the effort. So essentially
> on Android you would make not being able to detect signal handlers
> like the SIGCHLD signal sent to init, if init was the same process
> dealing with the sysfs fallback firmware upload.

Thanks for the detailed comments, Luis!

I don't see how my patch changes existing error code behaviour. Even
without my patch this function would return -EAGAIN if the fw is already
aborted. Without my patch, it would call fw_sysfs_wait_timeout() which
would return -ENOENT (because fw is already aborted) as follows:

	ret = wait_for_completion_killable_timeout(...)
	if (ret != 0 && fw_st->status == FW_STATUS_ABORTED)
		return -ENOENT;
	if (!ret)
		return -ETIMEDOUT;

	return ret < 0 ? ret : 0;

Now, this -ENOENT gets converted to -EAGAIN due to this piece of code
in fw_load_sysfs_fallback():

	if (fw_state_is_aborted(fw_priv)) {
		if (retval == -ERESTARTSYS)
			retval = -EINTR;
		else
			retval = -EAGAIN;
	} else if (fw_priv->is_paged_buf && !fw_priv->data)
		retval = -ENOMEM;

So, at the end, fw_load_sysfs_fallback() returns -EAGAIN for the case
where the fw is already aborted.  Which is what I did in my patch. So, my
patch doesn't seem to regress anything. If this is not the intended behavior
then it means that things are already regressed and not because of this
patch.

Please do correct me if I missed something here.

> 
> The way I dealt with this in my patch was I decided to return -EINTR
> in the earlier case in the hunk you added, instead of -EAGAIN. In
> addition to this, later on fw_load_sysfs_fallback() when
> fw_sysfs_wait_timeout() is used that would also deal with checking
> for error codes on wait, and only then check if it was a signal
> that cancelled things (the check for -ERESTARTSYS). We therefore
> only send to userspace -EAGAIN when the wait really did hit the
> timeout.
> 
> But also note that my change added a check for
> fw_state_is_aborted(fw_priv) inside fw_sysfs_wait_timeout(),
> as that was a recently intended goal.
> 
> In either case I documented well *why* we do these error checks
> before sending a code to userspace on fw_sysfs_wait_timeout() since
> otherwise it would be easy to regress that code, so please also
> document that as I did.

The goal of this patch is to fix the UAF reported by syzbot.

I am okay with simply documenting the reasons behind error codes, but I
would rather not do any more refactoring of the error handling code in
this patch since it doesn't directly contribute to fixing the uaf.

Does that sound reasonable?

Thanks!

	- Anirudh.
