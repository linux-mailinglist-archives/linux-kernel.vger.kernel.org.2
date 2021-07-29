Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF193DA46E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 15:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237597AbhG2NhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 09:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237515AbhG2NhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 09:37:13 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F728C061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 06:37:10 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id o2-20020a9d22020000b0290462f0ab0800so5855316ota.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 06:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=gBxV/M7bf2etL/92MOXLTUY4CDfUBQBpgr1XUu4vYcA=;
        b=oGAthEtoTSzHFxxLQFMLZPF5yd9CQBS7RH1B1es+5lCOp2ehQKryNcj/fXd4xtn1CS
         XsoxAcnNjO17jL2FmsXRcZf5tJEE77N8xW+WZhLu43aH6J0uy3XPxz1chSLz4zJC7QhO
         BEJ5G7/MstWPmXNut1M4N44l8dJ+kQ3qvCsPelSUMGB0Ph24D3oFpLiGrrjvWwjQixIb
         /1lJ/JI8LbCmmixhIPE2mBuzZ32UG33wgT1N1oWmCEmkozn/1TRMtJJzb5oPEXuiwqLY
         tKPWPTvxYkx/HmZckEQhnQO4RVZLqKm54SaGhAmKAcmoHnzfherPul7fOLtyNK9QnCFJ
         Cfmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=gBxV/M7bf2etL/92MOXLTUY4CDfUBQBpgr1XUu4vYcA=;
        b=NQDTdmdiE2Md7rt0q+vQobh9X9kSSlDK5SUMAs2d4UTUKfgvBaYfN/cxQ0rTTUhfS0
         dH9qlG/ixOVqQb1ip8N8hWgGzmTwCCIrqTIoZgZAroMJpgzfsaZRxpXaoyR/lgn9V/w5
         UR0QeGnPJhtARRwpcSmilgyaZJXx4toepyfMAY4H4YBeSpMYAUpP5PHV+AdcYALwjHfW
         iuj1I5xLpPfXRQhNDOq84cxKAlGyebIBoafoeIrXaACV9Yfy7oAWWH3vdq74IoCpPCE7
         ltVpH/Dz8l3iYkXjd6cm74DN77WgVBWFSM1CDyB9nEbUCGunXNei1kqW4PATpaRYjn/G
         dd0A==
X-Gm-Message-State: AOAM532106Cs6d+77swPlc7RFM7Q60fXisUDYATXpGyq13BT8ZLry+Df
        S+KdsYvaotyM3jJT6WsFdA==
X-Google-Smtp-Source: ABdhPJzjEk41gfRrNOFiVGteeIFO1VphmT7/VAtIp7bnH9p4eXZFRDKwHQBh5DNB/gtyudCBsu+MnA==
X-Received: by 2002:a05:6830:1dab:: with SMTP id z11mr3457577oti.107.1627565829930;
        Thu, 29 Jul 2021 06:37:09 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id m4sm477094oou.0.2021.07.29.06.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 06:37:08 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:e842:87d0:ed02:228a])
        by serve.minyard.net (Postfix) with ESMTPSA id C921A18005A;
        Thu, 29 Jul 2021 13:37:07 +0000 (UTC)
Date:   Thu, 29 Jul 2021 08:37:06 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Wen Yang <wenyang@linux.alibaba.com>
Cc:     Baoyou Xie <baoyou.xie@alibaba-inc.com>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmi: rate limit ipmi smi_event failure message
Message-ID: <20210729133706.GY3406@minyard.net>
Reply-To: minyard@acm.org
References: <20210729093228.77098-1-wenyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729093228.77098-1-wenyang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2021 at 05:32:28PM +0800, Wen Yang wrote:
> Sometimes we can't get a valid si_sm_data, and we print an error
> message accordingly. But the ipmi module seem to like retrying a lot,
> in which case we flood the kernel log with a lot of messages, eg:

This is reasonable.  I moved the #define into the dev_warn_ratelimited
because that looked a little strange, and having the #define really
didn't add any value.  But that's it, queued for next release.

Thanks,

-corey

> 
> [46318019.164726] ipmi_si IPI0001:00: Could not set the global enables: 0xc1.
> [46318020.109700] ipmi_si IPI0001:00: Could not set the global enables: 0xc1.
> [46318021.158677] ipmi_si IPI0001:00: Could not set the global enables: 0xc1.
> [46318022.212598] ipmi_si IPI0001:00: Could not set the global enables: 0xc1.
> [46318023.258564] ipmi_si IPI0001:00: Could not set the global enables: 0xc1.
> [46318024.210455] ipmi_si IPI0001:00: Could not set the global enables: 0xc1.
> [46318025.260473] ipmi_si IPI0001:00: Could not set the global enables: 0xc1.
> [46318026.308445] ipmi_si IPI0001:00: Could not set the global enables: 0xc1.
> [46318027.356389] ipmi_si IPI0001:00: Could not set the global enables: 0xc1.
> [46318028.298288] ipmi_si IPI0001:00: Could not set the global enables: 0xc1.
> [46318029.363302] ipmi_si IPI0001:00: Could not set the global enables: 0xc1.
> 
> Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
> Cc: Baoyou Xie <baoyou.xie@alibaba-inc.com>
> Cc: Corey Minyard <minyard@acm.org>
> Cc: openipmi-developer@lists.sourceforge.net
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/char/ipmi/ipmi_si_intf.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
> index 62929a3..f64c3ac 100644
> --- a/drivers/char/ipmi/ipmi_si_intf.c
> +++ b/drivers/char/ipmi/ipmi_si_intf.c
> @@ -591,7 +591,7 @@ static void handle_transaction_done(struct smi_info *smi_info)
>  		smi_info->handlers->get_result(smi_info->si_sm, msg, 3);
>  		if (msg[2] != 0) {
>  			/* Error clearing flags */
> -			dev_warn(smi_info->io.dev,
> +			dev_warn_ratelimited(smi_info->io.dev,
>  				 "Error clearing flags: %2.2x\n", msg[2]);
>  		}
>  		smi_info->si_state = SI_NORMAL;
> @@ -683,10 +683,11 @@ static void handle_transaction_done(struct smi_info *smi_info)
>  		/* We got the flags from the SMI, now handle them. */
>  		smi_info->handlers->get_result(smi_info->si_sm, msg, 4);
>  		if (msg[2] != 0) {
> -			dev_warn(smi_info->io.dev,
> -				 "Couldn't get irq info: %x.\n", msg[2]);
> -			dev_warn(smi_info->io.dev,
> -				 "Maybe ok, but ipmi might run very slowly.\n");
> +#define IPMI_WARN_CHECKING_ENABLES "Maybe ok, but ipmi might run very slowly."
> +
> +			dev_warn_ratelimited(smi_info->io.dev,
> +				"Couldn't get irq info: %x, %s\n",
> +				msg[2], IPMI_WARN_CHECKING_ENABLES);
>  			smi_info->si_state = SI_NORMAL;
>  			break;
>  		}
> @@ -721,7 +722,7 @@ static void handle_transaction_done(struct smi_info *smi_info)
>  
>  		smi_info->handlers->get_result(smi_info->si_sm, msg, 4);
>  		if (msg[2] != 0)
> -			dev_warn(smi_info->io.dev,
> +			dev_warn_ratelimited(smi_info->io.dev,
>  				 "Could not set the global enables: 0x%x.\n",
>  				 msg[2]);
>  
> @@ -1343,7 +1344,7 @@ static int try_get_dev_id(struct smi_info *smi_info)
>  
>  		if (cc != IPMI_CC_NO_ERROR &&
>  		    ++retry_count <= GET_DEVICE_ID_MAX_RETRY) {
> -			dev_warn(smi_info->io.dev,
> +			dev_warn_ratelimited(smi_info->io.dev,
>  			    "BMC returned 0x%2.2x, retry get bmc device id\n",
>  			    cc);
>  			goto retry;
> -- 
> 1.8.3.1
> 
