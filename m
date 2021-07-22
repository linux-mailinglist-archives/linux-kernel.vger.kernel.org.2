Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6C33D2D0D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 21:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhGVTS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 15:18:56 -0400
Received: from mail-pj1-f53.google.com ([209.85.216.53]:51914 "EHLO
        mail-pj1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhGVTSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 15:18:54 -0400
Received: by mail-pj1-f53.google.com with SMTP id my10so7664845pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 12:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hzmNOJgHcRn2MiGozy1lBfawPHwtsA6A3uBHBd2a0hc=;
        b=SRmFoS/7geAUUCzcP79yq4BHZLfUudtk5V01LdbGlWap3U9JDzyYL1b98BWTbEhJmN
         RJJRNP7TS1F/4MUOoevOdruGthQZ/AUGvNIt7Vr3Tp00P1ZD8EdHLHKDYRRaUEOiiUft
         /rFg3K6RHig1XxQ2y7J35VEmvPudJms9z6ByGR5zRk9U4s1az/Iv+qC98/oJmwtX0LCr
         auFIOlr6V4XOCZ8gO8ULxU+LxIxRicj1suCcgBImiVnTJzt2yRC1i8gtpVLjN53cBlGD
         LNo3WqVAiRMJ0gU8MzHJiesn1SPhQBq2AhUAqPaxNfzkGtZ1VGKSJOIgqbK0mCGE6CkL
         smEg==
X-Gm-Message-State: AOAM533EQay5+1R5ZqwHJvgPWogX8FaVZfc6kYd3QHeR+0lPE6NtHnEf
        E8SDQ82rlTZ6sXnXkC63pIs=
X-Google-Smtp-Source: ABdhPJx/Vqc4HyEpr1E1bQckHOiQFu0A8y7forK0Rri2gv86diD5A07b+RGp8bSqPiXGEcPrOzkUOg==
X-Received: by 2002:a17:90a:ce18:: with SMTP id f24mr1332166pju.82.1626983967603;
        Thu, 22 Jul 2021 12:59:27 -0700 (PDT)
Received: from garbanzo ([191.96.121.239])
        by smtp.gmail.com with ESMTPSA id w6sm35375831pgh.56.2021.07.22.12.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 12:59:26 -0700 (PDT)
Date:   Thu, 22 Jul 2021 12:59:24 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Anirudh Rayabharam <mail@anirudhrb.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v6 1/2] firmware_loader: use -ETIMEDOUT instead of
 -EAGAIN in fw_load_sysfs_fallback
Message-ID: <20210722195924.oezxwv3u3p5k737l@garbanzo>
References: <20210722123229.8731-1-mail@anirudhrb.com>
 <20210722123229.8731-2-mail@anirudhrb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722123229.8731-2-mail@anirudhrb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 06:02:28PM +0530, Anirudh Rayabharam wrote:
> The only motivation for using -EAGAIN in commit 0542ad88fbdd81bb
> ("firmware loader: Fix _request_firmware_load() return val for fw load
> abort") was to distinguish the error from -ENOMEM, and so there is no
> real reason in keeping it. Keeping -ETIMEDOU is much telling of what the

Since you'll have to respin, a missing here   ^, also add that the
-ETIMEDOUT is what we'd get when we do time out on the wait, as its
not clear from the conext being changed.

> reason for a failure is, so just use that.
> 
> The rest is just trying to document a bit more of the motivations for the
> error codes, as otherwise we'd lose this information easily.

This is a separate change, and it actually does more than just that.
Moving code around should be done separately. The idea is to
first just remove the -EAGAIN so that the change is *easy* to review.
A remove of a return code *and* a move of code around makes it less
obvious for code review. And part of the comment is wrong now that we
removed -EAGAIN. When breaking patches up please review each change
going into each patch and consider if it makes sense, atomically.

> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
> ---
>  drivers/base/firmware_loader/fallback.c | 34 +++++++++++++++++--------
>  1 file changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
> index 91899d185e31..1db94165feaf 100644
> --- a/drivers/base/firmware_loader/fallback.c
> +++ b/drivers/base/firmware_loader/fallback.c
> @@ -70,7 +70,29 @@ static inline bool fw_sysfs_loading(struct fw_priv *fw_priv)
>  
>  static inline int fw_sysfs_wait_timeout(struct fw_priv *fw_priv,  long timeout)
>  {
> -	return __fw_state_wait_common(fw_priv, timeout);
> +	int ret = __fw_state_wait_common(fw_priv, timeout);
> +
> +	/*
> +	 * A signal could be sent to abort a wait. Consider Android's init
> +	 * gettting a SIGCHLD, which in turn was the same process issuing the
> +	 * sysfs store call for the fallback. In such cases we want to be able
> +	 * to tell apart in userspace when a signal caused a failure on the
> +	 * wait. In such cases we'd get -ERESTARTSYS.
> +	 *
> +	 * Likewise though another race can happen and abort the load earlier.

This comment is about the check for fw_load_abort() so since the move is
not going to happen when you remove -EAGAIN just leave it out. It can be
added once you do the move.

> +	 *
> +	 * In either case the situation is interrupted so we just inform
> +	 * userspace of that and we end things right away.

Be mindful that this is in context of both cases when re-writing the
patches.

> +	 *
> +	 * When we really time out just tell userspace it should try again,
> +	 * perhaps later.

That's the thing, we're getting rid of that -EAGAIN as it made no sense,
the goal was to just distinguish the error from -ENOMEM. That's it.
Since we are removing the -EAGAIN, this comment makes no sense as we
have clarified with Shuah that the goal of her patch was just to
distinguish the error.

So "tell userspace to try again" makes no sense since if a timeout
happened userspace can't really try again as we have aborted the whole
operation to allow firmware to be uploaded.

In fact, please add that to the commit log which removes the -EAGAIN,
something like:

"Using -EAGAIN is also not correct as this return code is typically used
to tell userspace to try something again, in this case re-using the
sysfs loading interface cannot be retried when a timeout happens, so
the return value is also bogus."

> +	 */
> +	if (ret == -ERESTARTSYS || fw_state_is_aborted(fw_priv))
> +		ret = -EINTR;
> +	else if (fw_priv->is_paged_buf && !fw_priv->data)
> +		ret = -ENOMEM;
> +
> +	return ret;
>  }
>  
>  struct fw_sysfs {
> @@ -526,20 +548,12 @@ static int fw_load_sysfs_fallback(struct fw_sysfs *fw_sysfs, long timeout)
>  	}
>  
>  	retval = fw_sysfs_wait_timeout(fw_priv, timeout);
> -	if (retval < 0 && retval != -ENOENT) {
> +	if (retval < 0) {
>  		mutex_lock(&fw_lock);
>  		fw_load_abort(fw_sysfs);
>  		mutex_unlock(&fw_lock);
>  	}
>  
> -	if (fw_state_is_aborted(fw_priv)) {
> -		if (retval == -ERESTARTSYS)
> -			retval = -EINTR;
> -		else
> -			retval = -EAGAIN;

All we want to do is remove this -EAGAIN line in one patch. We
don't want to move code to another place. We do this to make code
easier to review.

We preserve the error code from the wait when a signal did not interrupt
the process (-ERESTARTSYS), and so this can only be -ETIMEDOUT.

> -	} else if (fw_priv->is_paged_buf && !fw_priv->data)
> -		retval = -ENOMEM;
> -

Thanks for keeping up with the series!

  Luis
