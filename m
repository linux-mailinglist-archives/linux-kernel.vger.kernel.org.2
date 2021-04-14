Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E18835F45C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 14:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233989AbhDNM4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 08:56:07 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:36494 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233716AbhDNM4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 08:56:05 -0400
Received: by mail-pg1-f169.google.com with SMTP id j7so4921102pgi.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 05:55:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yB5q3nfZpouWMXDTNGS66uxl43cgKeR5a3QGJsy5StM=;
        b=Vz9XE0+oL1nMNzRzoLWdXPDff1ZZ6optKUSvuAZ2V28acJtwchFWELvnBR2DyhAiC8
         U/c4lvHMvz3MyreMD6bnDpnSp7ObaCatuVK1/WNGLhMJquijQv9rBzuIwgHolX/bYd/Y
         hDTwNrWPs5YyE+VpMf4JBXF5W5skpbyVqMKyMXMDJTF4y0wEjvUbrJDnDTAwBTMkW4y8
         X5INkahh2CBQImDW+myIaVfHT9yXIWb79pxm2vMQoKX4xbfzKiN5u+w8Gb1c6PanPH6U
         Nye1JJA6dvHrU4+Ko6uFiELG/z4TgYtBaXgkE/XlEjyktGIYFi+mt1ZyS2rCGaaOSmxR
         ayrw==
X-Gm-Message-State: AOAM532Dr9Du8Uw+hGYrmsqT3E2j6z7folvdvjK4V0zF+3bDu26Kj8Ab
        X5pZWH7X12jcEGfTzl5NaAa281eLZu8xTQ==
X-Google-Smtp-Source: ABdhPJz90xaTmqSxUG4rWFURO1X3RYHFjeJjTNZzbfj+Y3UNbgdE8WE/5fuICxyRZZLMMLJkQ11Y9Q==
X-Received: by 2002:a63:4842:: with SMTP id x2mr36597294pgk.229.1618404942600;
        Wed, 14 Apr 2021 05:55:42 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id x20sm4865589pjp.12.2021.04.14.05.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 05:55:41 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 8EC2340402; Wed, 14 Apr 2021 12:55:40 +0000 (UTC)
Date:   Wed, 14 Apr 2021 12:55:40 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Anirudh Rayabharam <mail@anirudhrb.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Junyong Sun <sunjy516@gmail.com>,
        syzbot+de271708674e2093097b@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] firmware_loader: fix use-after-free in
 firmware_fallback_sysfs
Message-ID: <20210414125540.GJ4332@42.do-not-panic.com>
References: <20210414085406.1842-1-mail@anirudhrb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414085406.1842-1-mail@anirudhrb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shuah, a question for you toward the end here.

On Wed, Apr 14, 2021 at 02:24:05PM +0530, Anirudh Rayabharam wrote:
> This use-after-free happens when a fw_priv object has been freed but
> hasn't been removed from the pending list (pending_fw_head). The next
> time fw_load_sysfs_fallback tries to insert into the list, it ends up
> accessing the pending_list member of the previoiusly freed fw_priv.
> 
> The root cause here is that all code paths that abort the fw load
> don't delete it from the pending list. For example:
> 
> 	_request_firmware()
> 	  -> fw_abort_batch_reqs()
> 	      -> fw_state_aborted()
> 
> To fix this, delete the fw_priv from the list in __fw_set_state() if
> the new state is DONE or ABORTED. This way, all aborts will remove
> the fw_priv from the list. Accordingly, remove calls to list_del_init
> that were being made before calling fw_state_(aborted|done).
> 
> Also, in fw_load_sysfs_fallback, don't add the fw_priv to the pending
> list if it is already aborted. Instead, just jump out and return early.
> 
> Fixes: bcfbd3523f3c ("firmware: fix a double abort case with fw_load_sysfs_fallback")
> Reported-by: syzbot+de271708674e2093097b@syzkaller.appspotmail.com
> Tested-by: syzbot+de271708674e2093097b@syzkaller.appspotmail.com
> Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
> ---
> 
> Changes in v3:
> Modified the patch to incorporate suggestions by Luis Chamberlain in
> order to fix the root cause instead of applying a "band-aid" kind of
> fix.
> https://lore.kernel.org/lkml/20210403013143.GV4332@42.do-not-panic.com/
> 
> Changes in v2:
> 1. Fixed 1 error and 1 warning (in the commit message) reported by
> checkpatch.pl. The error was regarding the format for referring to
> another commit "commit <sha> ("oneline")". The warning was for line
> longer than 75 chars. 
> 
> ---
>  drivers/base/firmware_loader/fallback.c | 8 ++++++--
>  drivers/base/firmware_loader/firmware.h | 6 +++++-
>  drivers/base/firmware_loader/main.c     | 2 ++
>  3 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
> index 91899d185e31..73581b6998b4 100644
> --- a/drivers/base/firmware_loader/fallback.c
> +++ b/drivers/base/firmware_loader/fallback.c
> @@ -94,7 +94,6 @@ static void __fw_load_abort(struct fw_priv *fw_priv)
>  	if (fw_sysfs_done(fw_priv))
>  		return;
>  
> -	list_del_init(&fw_priv->pending_list);
>  	fw_state_aborted(fw_priv);
>  }
>  
> @@ -280,7 +279,6 @@ static ssize_t firmware_loading_store(struct device *dev,
>  			 * Same logic as fw_load_abort, only the DONE bit
>  			 * is ignored and we set ABORT only on failure.
>  			 */
> -			list_del_init(&fw_priv->pending_list);
>  			if (rc) {
>  				fw_state_aborted(fw_priv);
>  				written = rc;
> @@ -513,6 +511,11 @@ static int fw_load_sysfs_fallback(struct fw_sysfs *fw_sysfs, long timeout)
>  	}
>  
>  	mutex_lock(&fw_lock);
> +	if (fw_state_is_aborted(fw_priv)) {
> +		mutex_unlock(&fw_lock);
> +		retval = -EAGAIN;
> +		goto out;
> +	}

Thanks for the quick follow up!

This would regress commit 76098b36b5db1 ("firmware: send -EINTR on
signal abort on fallback mechanism") which I had mentioned in my follow
up email you posted a link to. It would regress it since the condition
is just being met earlier and you nullify the effort. So essentially
on Android you would make not being able to detect signal handlers
like the SIGCHLD signal sent to init, if init was the same process
dealing with the sysfs fallback firmware upload.

The way I dealt with this in my patch was I decided to return -EINTR
in the earlier case in the hunk you added, instead of -EAGAIN. In
addition to this, later on fw_load_sysfs_fallback() when
fw_sysfs_wait_timeout() is used that would also deal with checking
for error codes on wait, and only then check if it was a signal
that cancelled things (the check for -ERESTARTSYS). We therefore
only send to userspace -EAGAIN when the wait really did hit the
timeout.

But also note that my change added a check for
fw_state_is_aborted(fw_priv) inside fw_sysfs_wait_timeout(),
as that was a recently intended goal.

In either case I documented well *why* we do these error checks
before sending a code to userspace on fw_sysfs_wait_timeout() since
otherwise it would be easy to regress that code, so please also
document that as I did.

I'll re-iterate again also:

	Shuah's commit 0542ad88fbdd81bb ("firmware loader: Fix
	_request_firmware_load() return val for fw load abort") also wanted to
	distinguish the timeout vs -ENOMEM, but for some reason in the timeout
	case -EAGAIN was being sent back to userspace. I am no longer sure if
	that is a good idea, but since we started doing that at some point I
	guess we want to keep that behaviour.

Shuah, can you think of any reason to retain -EAGAIN other than you
introduced it here? If there's no real good reason I think it can
simplify the error handling here. But, we *would* change what we do
to userspace... and for that reason we may have to live with it.

  Luis
