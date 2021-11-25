Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2251E45DC45
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 15:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355601AbhKYO16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 09:27:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348424AbhKYOZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 09:25:58 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947B7C061746
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 06:21:44 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id 132so11795151qkj.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 06:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=RzP6b9r8+MGJsGKUfdXV3PdSyaq0SjwQnaEljKzQwcc=;
        b=F1cE1GDHtA1VuR+vAENA+apO92UpCF0A+0f1qEtpNiEXO3vI/T/V5jjZRfj2y60/oP
         cC62Dw7YAyiCsy5M2KOXoEhRJoOJlmUQXtFj8JMETP/yQJYtLdVbciIx/YaII6mf7lJJ
         c1XhdwxHxLY02jRtG+ys1Nj+n+IKLRMPX91TCqeRO0Q4SZCA+h3YN3+pEr6XRTtc+uXZ
         OmRvYC2oXMleFAKfWETRZwhnpJhMsCbKdwqFRGGsC2Qv5/RH/+wqEVAZ3P71FVZDGl3H
         A0vbezSVUfDpTr+3lVCwbQX8zZ226kyCikHj1+cB210UsWGatSF3aDcHRwD0Uc9bLBmL
         6SBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=RzP6b9r8+MGJsGKUfdXV3PdSyaq0SjwQnaEljKzQwcc=;
        b=TCHUwjJrAI5gub9286/khYjAxfuOKPDlTERkSsK/aO81j9RFz/kZaQu2J0wHRmOylu
         M0nYEj3gDHx/zpFeVCQkGAM/gv91+GkN+EB0xUX/heaWCx37JvHbVA4l74XSXD2bhzlG
         x/PuGpSQOXkeRNCdVNbGAtdj3/5GbPjxaKp6/tUBEGfvEOn6aPbkVPm93MH/wd1oH+ND
         LONqFVWFqxoGb2NcFdOLilu9FKc0fDllB/e/aF1oyvISQwBaTMzY2YR9JBTOCOwbv9I0
         dsSDvPN9kvJ0gAVeUE8OYcpDhr9Z9FGw3hcGhQjEIxrue5HaT5ZhsyJTqEgg4549f4ba
         sAxQ==
X-Gm-Message-State: AOAM531SkbqYTcbbiq+EkXXUMIDOE2a+tfyBOTozrid34PvHIK2RVZhK
        TY8ZPywu5IRFZ+q2PCgPKw==
X-Google-Smtp-Source: ABdhPJyv4EAWbQQrBXkbBngyIJ5yCRuwEyJL1p4Kz7Fbxu3QwUqgLQB5VnxgKJmLidFPyTKdlYgXGw==
X-Received: by 2002:a05:620a:5f8:: with SMTP id z24mr7445042qkg.677.1637850103573;
        Thu, 25 Nov 2021 06:21:43 -0800 (PST)
Received: from serve.minyard.net ([47.184.156.158])
        by smtp.gmail.com with ESMTPSA id c24sm1578859qkp.43.2021.11.25.06.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 06:21:43 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:adf8:b831:eb9b:b451])
        by serve.minyard.net (Postfix) with ESMTPSA id 1BCA21800BA;
        Thu, 25 Nov 2021 14:21:42 +0000 (UTC)
Date:   Thu, 25 Nov 2021 08:21:40 -0600
From:   Corey Minyard <minyard@acm.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     andrew.manley@sealingtech.com,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] ipmi: fix oob access due to uninit smi_msg type
Message-ID: <20211125142140.GV15676@minyard.net>
Reply-To: minyard@acm.org
References: <20211124210323.1950976-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124210323.1950976-1-kuba@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 01:03:23PM -0800, Jakub Kicinski wrote:
> We're hitting OOB accesses in handle_ipmb_direct_rcv_rsp() (memcpy of
> size -1) after user space generates a message. Looks like the message
> is incorrectly assumed to be of the new IPMB type, because type is never
> set and message is allocated with kmalloc() not kzalloc().
> 
> Fixes: 059747c245f0 ("ipmi: Add support for IPMB direct messages")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

This is correct, and in my queue.  Thanks for the fix.

-corey

> ---
> Would it be possible to get something like this to Linus ASAP?
> It's flipping over all my test boxes.
> ---
>  drivers/char/ipmi/ipmi_msghandler.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index deed355422f4..f0b18c25cbb1 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -5031,6 +5031,7 @@ struct ipmi_smi_msg *ipmi_alloc_smi_msg(void)
>  	if (rv) {
>  		rv->done = free_smi_msg;
>  		rv->user_data = NULL;
> +		rv->type = IPMI_SMI_MSG_TYPE_NORMAL;
>  		atomic_inc(&smi_msg_inuse_count);
>  	}
>  	return rv;
> -- 
> 2.31.1
> 
