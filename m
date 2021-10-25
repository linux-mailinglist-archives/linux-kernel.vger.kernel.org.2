Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E9443A57B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 23:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234784AbhJYVKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 17:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbhJYVKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 17:10:19 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA106C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 14:07:56 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id t16so11584546qto.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 14:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=e3DNRPCFYalAfFsInyW5lanrcNUI3WrTPjGsoLlw0sQ=;
        b=jaJLhQVtytdtdqyFjUqYKAmNKeJDLdc4TbpBly8Py6IeEsIKacLZwmWYf9aqF3b9d8
         gCzf+TWG2Mcv5YtkqIMhRvd4SLWEtoKa9LgNCpO5/CnYatsA2/sarYRL8QATHMBN/Xm0
         yn4KuWhvI5zPLrUxcQ4sesKq0GVMU78M1P8GlHgvmYuxQxH5AO3Dl8WVmV5YlEpAZcVZ
         e/ZsFkSXWlxf414QdBI9xP8cyCtwC1z9edKSh9Nju7EJ4AoN32JEnTX0Bi8bguw255ta
         Y1g9o76XOWvGMRyqcF6a74kXgKISt7dCywj2cupoQwEP83DnfuNtd8TyhIlI50J5DKfx
         u2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=e3DNRPCFYalAfFsInyW5lanrcNUI3WrTPjGsoLlw0sQ=;
        b=adfZ/8uRoNHXfQj1q+gyy0C/hhHjgsf/pvh8JZhxzVPXIrCyd4eDF6wvhctiLy3Ktt
         wmSHTLje5LAVCNeiqwcrfhVu+GTc0FbLLLP/5lNfHw3CmpQ485aLSK0MyZHrK17KqbQm
         sXQdNAsVabeG2okCjCTmwv0KsPJXdRemUwXIuivBCocBOlsilubJgCDm2gLhWwV5Zl/5
         /Ln8dQulPYdV5ceza4m0+Jn+tuWxZTatyOzphmgCRXe+Giuhwt2/xbG0VeST1mrRw0xY
         sGU8s395ylYXrIqnW4h+/OlHxAafxSZh3/kR4LLV20Ha3WE/6tVENkkHsr4H7WkHDDs2
         ZLDQ==
X-Gm-Message-State: AOAM531yudgswBFruGPDCnjItrKSkDoHPRkWsGvTnLIekZGlZpyX5k26
        318YNe0QHLoXZE0VY+uzyA==
X-Google-Smtp-Source: ABdhPJxpTxYKuwQnEVM4z4QHx6Chz9IznL/YPzIA14NKlKpllDt7SEiXvUdGAdUS3YF75BzXzxw1gA==
X-Received: by 2002:ac8:430e:: with SMTP id z14mr19995010qtm.208.1635196075593;
        Mon, 25 Oct 2021 14:07:55 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id b23sm8990535qkk.83.2021.10.25.14.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 14:07:55 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:ad7f:7a7f:3b9a:4eab])
        by serve.minyard.net (Postfix) with ESMTPSA id D8C0318000C;
        Mon, 25 Oct 2021 21:07:53 +0000 (UTC)
Date:   Mon, 25 Oct 2021 16:07:52 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, kael_w@yeah.net
Subject: Re: [PATCH] ipmi: simplify duplicated if condition
Message-ID: <20211025210752.GC2744412@minyard.net>
Reply-To: minyard@acm.org
References: <20211025012206.21189-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025012206.21189-1-wanjiabing@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 24, 2021 at 09:22:06PM -0400, Wan Jiabing wrote:
> There are 5 duplicated 'if' conditions to judge the 'run_to_completion',
> which looks redundant. And there is no function to modify this variable.

It's modified in panic_event().

> 
> Reduce the 'if' conditions from 5 times to 1 time can make code easy to
> understand and fix following coccicheck warning:
> 
> ./drivers/char/ipmi/ipmi_msghandler.c :4771:2-19: ERROR: nested
> lock+irqsave that reuses flags from line 4764.

I'm not sure this matters that much.  The comments are messed up a bit,
and probably need to be reworked.  But I'm not inclined to take this.

-corey

> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  drivers/char/ipmi/ipmi_msghandler.c | 38 ++++++++++++++---------------
>  1 file changed, 18 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index a60201d3f735..072da25124cf 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -4756,32 +4756,30 @@ void ipmi_smi_msg_received(struct ipmi_smi *intf,
>  	unsigned long flags = 0; /* keep us warning-free. */
>  	int run_to_completion = intf->run_to_completion;
>  
> -	/*
> -	 * To preserve message order, we keep a queue and deliver from
> -	 * a tasklet.
> -	 */
> -	if (!run_to_completion)
> +	if (!run_to_completion) {
> +		/*
> +		 * To preserve message order, we keep a queue and deliver from
> +		 * a tasklet.
> +		 */
>  		spin_lock_irqsave(&intf->waiting_rcv_msgs_lock, flags);
> -	list_add_tail(&msg->link, &intf->waiting_rcv_msgs);
> -	if (!run_to_completion)
> +		list_add_tail(&msg->link, &intf->waiting_rcv_msgs);
>  		spin_unlock_irqrestore(&intf->waiting_rcv_msgs_lock,
>  				       flags);
> -
> -	if (!run_to_completion)
>  		spin_lock_irqsave(&intf->xmit_msgs_lock, flags);
> -	/*
> -	 * We can get an asynchronous event or receive message in addition
> -	 * to commands we send.
> -	 */
> -	if (msg == intf->curr_msg)
> -		intf->curr_msg = NULL;
> -	if (!run_to_completion)
> +		/*
> +		 * We can get an asynchronous event or receive message in addition
> +		 * to commands we send.
> +		 */
> +		if (msg == intf->curr_msg)
> +			intf->curr_msg = NULL;
>  		spin_unlock_irqrestore(&intf->xmit_msgs_lock, flags);
> -
> -	if (run_to_completion)
> -		smi_recv_tasklet(&intf->recv_tasklet);
> -	else
>  		tasklet_schedule(&intf->recv_tasklet);
> +	} else {
> +		list_add_tail(&msg->link, &intf->waiting_rcv_msgs);
> +		if (msg == intf->curr_msg)
> +			intf->curr_msg = NULL;
> +		smi_recv_tasklet(&intf->recv_tasklet);
> +	}
>  }
>  EXPORT_SYMBOL(ipmi_smi_msg_received);
>  
> -- 
> 2.20.1
> 
