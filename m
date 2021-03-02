Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B73932A3DE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379126AbhCBJup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 04:50:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:45838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1838140AbhCBJ35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 04:29:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9F56600EF;
        Tue,  2 Mar 2021 09:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614677356;
        bh=9k0fYvYEyCFSTkyTlfzhxcGmZse997cxXoLvoct07Ac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=slsjcyX+3I9q0+Up2i5FJgqaIOnvVZYiBzNS4znVrmFUCm1wFnKw92VEISBSS/BTV
         tFt9nyGv+j5TaHqQridot+Jj6GR+umrxCYtcD7EwXag03Xb3TT0myfKouNlJI4+Ccw
         LuJD3mokm+697piLSNJfdZ5hWUZ/k/FoO7VfgApk=
Date:   Tue, 2 Mar 2021 10:29:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     gabriele.modena@gmail.com
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH] wimax: attempt to address style issues.
Message-ID: <YD4FaaPZ4DmCXsaP@kroah.com>
References: <20210302091102.1598-1-gabriele.modena@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302091102.1598-1-gabriele.modena@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 10:11:02AM +0100, gabriele.modena@gmail.com wrote:
> From: Gabriele Modena <gabriele.modena@gmail.com>
> 
> When running checkpatch.pl on op-msg.c, op-rfkill.c
> and stack.c I noticed that they contained a few style issues
> at warning level of severity. This patch is both an attempt to
> address the warnings, as well as a way for me to familiarise
> with the linux kernel contribution process, by following
> tasks proposed by a popular online challenge.
> 
> Signed-off-by: Gabriele Modena <gabriele.modena@gmail.com>
> ---
>  drivers/staging/wimax/op-msg.c    |  8 ++++----
>  drivers/staging/wimax/op-rfkill.c |  7 ++++---
>  drivers/staging/wimax/stack.c     | 12 ++++++------
>  3 files changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/staging/wimax/op-msg.c b/drivers/staging/wimax/op-msg.c
> index e20ac7d84e82..11da48bf704f 100644
> --- a/drivers/staging/wimax/op-msg.c
> +++ b/drivers/staging/wimax/op-msg.c
> @@ -142,8 +142,8 @@ struct sk_buff *wimax_msg_alloc(struct wimax_dev *wimax_dev,
>  	}
>  	result = nla_put(skb, WIMAX_GNL_MSG_DATA, size, msg);
>  	if (result < 0) {
> -		dev_err(dev, "no memory to add payload (msg %p size %zu) in "
> -			"attribute: %d\n", msg, size, result);
> +		dev_err(dev, "no memory to add payload (msg %p size %zu) in attribute: %d\n",
> +			msg, size, result);
>  		goto error_nla_put;
>  	}
>  	genlmsg_end(skb, genl_msg);
> @@ -260,6 +260,7 @@ int wimax_msg_send(struct wimax_dev *wimax_dev, struct sk_buff *skb)
>  	struct device *dev = wimax_dev_to_dev(wimax_dev);
>  	void *msg = skb->data;
>  	size_t size = skb->len;
> +
>  	might_sleep();
>  
>  	d_printf(1, dev, "CTX: wimax msg, %zu bytes\n", size);
> @@ -340,8 +341,7 @@ int wimax_gnl_doit_msg_from_user(struct sk_buff *skb, struct genl_info *info)
>  	/* Unpack arguments */
>  	result = -EINVAL;
>  	if (info->attrs[WIMAX_GNL_MSG_DATA] == NULL) {
> -		dev_err(dev, "WIMAX_GNL_MSG_FROM_USER: can't find MSG_DATA "
> -			"attribute\n");
> +		dev_err(dev, "WIMAX_GNL_MSG_FROM_USER: can't find MSG_DATA attribute\n");
>  		goto error_no_data;
>  	}
>  	msg_buf = nla_data(info->attrs[WIMAX_GNL_MSG_DATA]);
> diff --git a/drivers/staging/wimax/op-rfkill.c b/drivers/staging/wimax/op-rfkill.c
> index 78b294481a59..52612ed09183 100644
> --- a/drivers/staging/wimax/op-rfkill.c
> +++ b/drivers/staging/wimax/op-rfkill.c
> @@ -294,7 +294,8 @@ int wimax_rfkill(struct wimax_dev *wimax_dev, enum wimax_rf_state state)
>  		/* While initializing, < 1.4.3 wimax-tools versions use
>  		 * this call to check if the device is a valid WiMAX
>  		 * device; so we allow it to proceed always,
> -		 * considering the radios are all off. */
> +		 * considering the radios are all off.
> +		 */
>  		if (result == -ENOMEDIUM && state == WIMAX_RF_QUERY)
>  			result = WIMAX_RF_OFF << 1 | WIMAX_RF_OFF;
>  		goto error_not_ready;
> @@ -378,6 +379,7 @@ int wimax_rfkill_add(struct wimax_dev *wimax_dev)
>  void wimax_rfkill_rm(struct wimax_dev *wimax_dev)
>  {
>  	struct device *dev = wimax_dev_to_dev(wimax_dev);
> +
>  	d_fnstart(3, dev, "(wimax_dev %p)\n", wimax_dev);
>  	rfkill_unregister(wimax_dev->rfkill);
>  	rfkill_destroy(wimax_dev->rfkill);
> @@ -415,8 +417,7 @@ int wimax_gnl_doit_rfkill(struct sk_buff *skb, struct genl_info *info)
>  	dev = wimax_dev_to_dev(wimax_dev);
>  	result = -EINVAL;
>  	if (info->attrs[WIMAX_GNL_RFKILL_STATE] == NULL) {
> -		dev_err(dev, "WIMAX_GNL_RFKILL: can't find RFKILL_STATE "
> -			"attribute\n");
> +		dev_err(dev, "WIMAX_GNL_RFKILL: can't find RFKILL_STATE attribute\n");
>  		goto error_no_pid;
>  	}
>  	new_state = nla_get_u32(info->attrs[WIMAX_GNL_RFKILL_STATE]);
> diff --git a/drivers/staging/wimax/stack.c b/drivers/staging/wimax/stack.c
> index ace24a6dfd2d..e44158334246 100644
> --- a/drivers/staging/wimax/stack.c
> +++ b/drivers/staging/wimax/stack.c
> @@ -51,9 +51,7 @@ static char wimax_debug_params[128];
>  module_param_string(debug, wimax_debug_params, sizeof(wimax_debug_params),
>  		    0644);
>  MODULE_PARM_DESC(debug,
> -		 "String of space-separated NAME:VALUE pairs, where NAMEs "
> -		 "are the different debug submodules and VALUE are the "
> -		 "initial debug value to set.");
> +		 "String of space-separated NAME:VALUE pairs, where NAMEs are the different debug submodules and VALUE are the initial debug value to set.");
>  
>  /*
>   * Authoritative source for the RE_STATE_CHANGE attribute policy
> @@ -62,7 +60,7 @@ MODULE_PARM_DESC(debug,
>   * close to where the data is generated.
>   */
>  /*
> -static const struct nla_policy wimax_gnl_re_status_change[WIMAX_GNL_ATTR_MAX + 1] = {
> + * static const struct nla_policy wimax_gnl_re_status_change[WIMAX_GNL_ATTR_MAX + 1] = {
>  	[WIMAX_GNL_STCH_STATE_OLD] = { .type = NLA_U8 },
>  	[WIMAX_GNL_STCH_STATE_NEW] = { .type = NLA_U8 },
>  };
> @@ -156,6 +154,7 @@ int wimax_gnl_re_state_change_send(
>  {
>  	int result = 0;
>  	struct device *dev = wimax_dev_to_dev(wimax_dev);
> +
>  	d_fnstart(3, dev, "(wimax_dev %p report_skb %p)\n",
>  		  wimax_dev, report_skb);
>  	if (report_skb == NULL) {
> @@ -275,8 +274,8 @@ void __wimax_state_change(struct wimax_dev *wimax_dev, enum wimax_st new_state)
>  	/* Execute the actions of entry to the new state */
>  	switch (new_state) {
>  	case __WIMAX_ST_NULL:
> -		dev_err(dev, "SW BUG: wimax_dev %p entering NULL state "
> -			"from %u\n", wimax_dev, wimax_dev->state);
> +		dev_err(dev, "SW BUG: wimax_dev %p entering NULL state from %u\n",
> +			wimax_dev, wimax_dev->state);
>  		WARN_ON(1);		/* Nobody can enter this state */
>  		break;
>  	case WIMAX_ST_DOWN:
> @@ -362,6 +361,7 @@ EXPORT_SYMBOL_GPL(wimax_state_change);
>  enum wimax_st wimax_state_get(struct wimax_dev *wimax_dev)
>  {
>  	enum wimax_st state;
> +
>  	mutex_lock(&wimax_dev->mutex);
>  	state = wimax_dev->state;
>  	mutex_unlock(&wimax_dev->mutex);
> -- 
> 2.11.0
> 
> _______________________________________________
> devel mailing list
> devel@linuxdriverproject.org
> http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
