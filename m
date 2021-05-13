Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF8937FB64
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 18:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbhEMQXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 12:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbhEMQW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 12:22:56 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04744C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 09:21:47 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id i23-20020a9d68d70000b02902dc19ed4c15so20063561oto.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 09:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=dgHsi4uL/mIogUUPS9S351fL40I/K3+T9vuN9hTTz7w=;
        b=iCVdZl0Yn608I/Ise9u2VIbuQosG+fyguuaj2b/r9pzeoPbxOttg4bEjdOO1lKLC5f
         rLc8KnRcMt5qSnxEemOIyz0H5szo7z1ww+3ovDtnVUnQHzytFEldNouMimQj7H8eVGz3
         /G4d02VBfKYrWVjoWNN3KLMC1kBNk2UrcDGcxQVIT1KrCrnFMj6wqoTHE7Skqm4f5zps
         SJUIxHdm3UgIdEpxbPRhzVGbXaKHsXZsH3IDlZJa+hfTVu453XxPq6PPBDxT3P6gaeNq
         06ttTJshZB7N2dotA45ABZXy+hI7aaEuMvJe5eQHVkpP4+VfFBE+9BLxywanlfkRluRp
         ZGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=dgHsi4uL/mIogUUPS9S351fL40I/K3+T9vuN9hTTz7w=;
        b=HBYddxrAVjHTUV2LRfPYMuqvZbxJ4w31ajmGuxQwgJZJT+LxkpU2wMjoA/f4NhdqM+
         6aWYU8CvGVdoSQg8OUi4nPKASEAwGTyvAp8ZIyoDVXRmq/EFkzC1gcpkePB2RTWPmYXs
         yZN1JH4XfWRggjVa+TVKoqGgvTxd9nAiN+uaV0RMPAJx9r1wQCBnl6XtRzAm2JXLqtey
         PikIVJbFmYebiOOFYGDerm/NhfBYH65GPlkN8ulC3FuidWwyN3EJv3V6+SgC8cxkJu+A
         O/NyRyYlcoLMA0sNBDg3XvFLKuyJ2bBnzd8DCIspPBxeEDO1U5kc3umpUsW4OSJ6sRs1
         tQhg==
X-Gm-Message-State: AOAM533Q9xXINyTPows8OxDowjifNCRsXoQB9uhdq4UuJuo1oFKNYZBj
        c4DY85Hspil6b3P2ZXUc+9hd3PbuBQ==
X-Google-Smtp-Source: ABdhPJyYLp5S/qQBA1OuEVBcW0m4KEGrpE/QwsI8w/jV7EwdlSAbGoLiUdk0ZupldjNaSG1FddaCMQ==
X-Received: by 2002:a9d:7a88:: with SMTP id l8mr28062977otn.185.1620922906348;
        Thu, 13 May 2021 09:21:46 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id r189sm683530oif.8.2021.05.13.09.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 09:21:45 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:412b:6b1b:237c:6ae7])
        by serve.minyard.net (Postfix) with ESMTPSA id DCEC5180052;
        Thu, 13 May 2021 16:21:43 +0000 (UTC)
Date:   Thu, 13 May 2021 11:21:42 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ipmi/watchdog: Stop watchdog timer when the current
 action is 'none'
Message-ID: <20210513162142.GA2921206@minyard.net>
Reply-To: minyard@acm.org
References: <10a41bdc-9c99-089c-8d89-fa98ce5ea080@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10a41bdc-9c99-089c-8d89-fa98ce5ea080@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 02:26:36PM +0200, Petr Pavlu wrote:
> When an IPMI watchdog timer is being stopped in ipmi_close() or
> ipmi_ioctl(WDIOS_DISABLECARD), the current watchdog action is updated to
> WDOG_TIMEOUT_NONE and _ipmi_set_timeout(IPMI_SET_TIMEOUT_NO_HB) is called
> to install this action. The latter function ends up invoking
> __ipmi_set_timeout() which makes the actual 'Set Watchdog Timer' IPMI
> request.
> 
> For IPMI 1.0, this operation results in fully stopping the watchdog timer.
> For IPMI >= 1.5, function __ipmi_set_timeout() always specifies the "don't
> stop" flag in the prepared 'Set Watchdog Timer' IPMI request. This causes
> that the watchdog timer has its action correctly updated to 'none' but the
> timer continues to run. A problem is that IPMI firmware can then still log
> an expiration event when the configured timeout is reached, which is
> unexpected because the watchdog timer was requested to be stopped.
> 
> The patch fixes this problem by not setting the "don't stop" flag in
> __ipmi_set_timeout() when the current action is WDOG_TIMEOUT_NONE which
> results in stopping the watchdog timer. This makes the behaviour for
> IPMI >= 1.5 consistent with IPMI 1.0. It also matches the logic in
> __ipmi_heartbeat() which does not allow to reset the watchdog if the
> current action is WDOG_TIMEOUT_NONE as that would start the timer.

Yes, I believe this is correct, though it took a bit to be sure :).
Applied for linux-next.  I'm also requesting backport to stable kernels.

-corey

> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
>  drivers/char/ipmi/ipmi_watchdog.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_watchdog.c b/drivers/char/ipmi/ipmi_watchdog.c
> index 32c334e34d55..e4ff3b50de7f 100644
> --- a/drivers/char/ipmi/ipmi_watchdog.c
> +++ b/drivers/char/ipmi/ipmi_watchdog.c
> @@ -371,16 +371,18 @@ static int __ipmi_set_timeout(struct ipmi_smi_msg  *smi_msg,
>  	data[0] = 0;
>  	WDOG_SET_TIMER_USE(data[0], WDOG_TIMER_USE_SMS_OS);
>  
> -	if ((ipmi_version_major > 1)
> -	    || ((ipmi_version_major == 1) && (ipmi_version_minor >= 5))) {
> -		/* This is an IPMI 1.5-only feature. */
> -		data[0] |= WDOG_DONT_STOP_ON_SET;
> -	} else if (ipmi_watchdog_state != WDOG_TIMEOUT_NONE) {
> -		/*
> -		 * In ipmi 1.0, setting the timer stops the watchdog, we
> -		 * need to start it back up again.
> -		 */
> -		hbnow = 1;
> +	if (ipmi_watchdog_state != WDOG_TIMEOUT_NONE) {
> +		if ((ipmi_version_major > 1) ||
> +		    ((ipmi_version_major == 1) && (ipmi_version_minor >= 5))) {
> +			/* This is an IPMI 1.5-only feature. */
> +			data[0] |= WDOG_DONT_STOP_ON_SET;
> +		} else {
> +			/*
> +			 * In ipmi 1.0, setting the timer stops the watchdog, we
> +			 * need to start it back up again.
> +			 */
> +			hbnow = 1;
> +		}
>  	}
>  
>  	data[1] = 0;
> -- 
> 2.26.2
> 
