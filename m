Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7CB732F006
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 17:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbhCEQ2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 11:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhCEQ2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 11:28:12 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADE5C061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 08:28:11 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id g8so2347969otk.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 08:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=lUGxFCa19Qge6BfZF3XEo9svsUoPl+tPT1E5xfKUypY=;
        b=b3Vc9HVFsH7dG2dvFFlT+2vCVZUi7IfBDZcZfHVskNF1zOcUp/LI21gf+lQCon71Nt
         lR3KFZJU5GWX2izLs9UwdZdRa/PRr+L6MgJX35i7kVhYSveq4Slkip/+9so/RvPt0mkb
         DUAM//Pnq9zntP6B57Eb2CfDfiwV2eUQnPUOaEcvWLeZJMdeTnbf15AWYEXEyT2/jwgk
         BKCJ1IE1h90e1OUer9I+ONvYOUD0kqxfE087DDPN7Kxb2BxzaiZL2x0xw38++N96WuQe
         PHxdtB5opwuNlHjvPw0+iMSW+kQaD5w64Yz1l0+FWi3i+/0qSQqS+gyi+nr4WJ7kZdTg
         KlvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=lUGxFCa19Qge6BfZF3XEo9svsUoPl+tPT1E5xfKUypY=;
        b=HeLshYycVLxYdhzysJiOb4nOTgZuOCHaEmTfBN3WtUlXz3HVOjT1mP7rXq6SHlieqO
         2t1ZnklF0ZPBYhXDHNR070MdadOz4ZP+nVcD5f2QXDD/dK2wcejtZq7w7nBWk8pzh2QD
         hGE5pIYw/qo4W3TMr0iuTnOYZo1rR3ffT0FdVmSGBloT3FTXqGRqrSMUVyj+1DmZt1Sx
         f9KU1OYAg7LqZpFTwYpKFwVCnJZpRXPm3BxUS3W7bK10/dL3pBwScUrfDHg0X9UVhu5T
         vPvHtUzJSLlx7lBz/P+zNHAzOy5Bs71StgK78VmGIF2BBuhYLpQA/0zUUxDhAl6zO7kH
         FleA==
X-Gm-Message-State: AOAM532SP8vg3tjDm5lbkJfn+0ChFQnEDOf5yjg7IYDrhNxstcdEXLXV
        WJ2cP1nZNLdu2tIUDTJ4DQ==
X-Google-Smtp-Source: ABdhPJz/azMRQuiZWWGE6OYIMFqa2yvThlz0NtS0KSJiiK70pYeeIwBjKw1D6ZZP0/rAMMTrw6DFmA==
X-Received: by 2002:a9d:4004:: with SMTP id m4mr8790449ote.63.1614961691127;
        Fri, 05 Mar 2021 08:28:11 -0800 (PST)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id b133sm606409oia.17.2021.03.05.08.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 08:28:10 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:6dff:5584:10ea:8fa1])
        by serve.minyard.net (Postfix) with ESMTPSA id 779B0180053;
        Fri,  5 Mar 2021 16:28:09 +0000 (UTC)
Date:   Fri, 5 Mar 2021 10:28:08 -0600
From:   Corey Minyard <minyard@acm.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmi: Handle device properties with software node API
Message-ID: <20210305162808.GW507977@minyard.net>
Reply-To: minyard@acm.org
References: <20210304090312.26827-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304090312.26827-1-heikki.krogerus@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 12:03:12PM +0300, Heikki Krogerus wrote:
> The old device property API is going to be removed.
> Replacing the device_add_properties() call with the software
> node API equivalent, device_create_managed_software_node().

Ok, this has been queued for next release.

Thanks,

-corey

> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/char/ipmi/ipmi_plat_data.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_plat_data.c b/drivers/char/ipmi/ipmi_plat_data.c
> index 28471ff2a3a3e..747b51ae01a80 100644
> --- a/drivers/char/ipmi/ipmi_plat_data.c
> +++ b/drivers/char/ipmi/ipmi_plat_data.c
> @@ -102,7 +102,7 @@ struct platform_device *ipmi_platform_add(const char *name, unsigned int inst,
>  		goto err;
>  	}
>   add_properties:
> -	rv = platform_device_add_properties(pdev, pr);
> +	rv = device_create_managed_software_node(&pdev->dev, pr, NULL);
>  	if (rv) {
>  		dev_err(&pdev->dev,
>  			"Unable to add hard-code properties: %d\n", rv);
> -- 
> 2.30.1
> 
