Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE32A43FC4F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 14:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbhJ2M2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 08:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbhJ2M2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 08:28:03 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C40CC061570;
        Fri, 29 Oct 2021 05:25:35 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id bk22so2360561qkb.6;
        Fri, 29 Oct 2021 05:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=VG9TUuOVApoHapxovZ6uli91ugtXAJN9UYyzn6LgSaU=;
        b=lsW8NKAEQKMDPA3gxlEvxroe1/RNKIIL40hm3Wm3R2K2cFoVNKzVeB95QYNdY9N9Qw
         Fio3jdxZsA8Yzj/ruay1pi3OlK97oKFUjD3MJ5UDEqrONKFRgMU6mICTy+QFALbTN9+o
         m2O2Hgm0cUJyqsIttkDtMY3y4bKmsxmCNhhw3t9qRmyqI/6UJ1oTboVHE9FWoV/oNusE
         t5gYwLYNB/lrD8mymjh30k2ocabdLH63GYmkpMYna4qJoPc/SW3aWatB7lAs3+IBP7VP
         GOLzDFN9D6EmKBYzS1h9djt2sl/DnqaNtMPdA4479elRWXtDAzJJW61/tAmxL0aNi1PZ
         9yaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=VG9TUuOVApoHapxovZ6uli91ugtXAJN9UYyzn6LgSaU=;
        b=SyK2kEfCWxIoW2EChtCPjIOvqVZxEkIR4ru+0GKMCzYLB6uRD2LtHLlQ6MtqZqx5h0
         WU9pcwnEDCNFXA4xVeIyhQPGh++DRpa/AIXulkN73l/7/GTZsrgj9O6wBNZDaK97VoOd
         aDiUOGertJ690mKNay1q2uLXL8D6+J4RtuNnjqVMGF2cx/HFCl/jL7BcvKFWgxXSloJ9
         RCCvsBCnOlIA9dBhrKwAlHX0pciVuZvQlKLuIzLzTRcbe3N9F+Z+uGG668jfNEhDn+7p
         pwSx/uhvCzt6hmJbtrkpsd/fV9BAOeMJuGcB79FRlU3bP7qzpWbd8BlZCdHqmba1Xt7B
         8SJg==
X-Gm-Message-State: AOAM530CaUGyXB++3MNaXzeg4TkRa5NOq4LzO9Xf2KpeqljyhwPq1YG4
        FAdV+CbAprnrS3RQlrZx1A==
X-Google-Smtp-Source: ABdhPJxgHKfyVjwUHaWtg9tbyLdD9b2TT5/jOQN6+2BsmNP9xWjrdfNpls4O4m/cFJ+SnCVf6wsXzw==
X-Received: by 2002:a37:9345:: with SMTP id v66mr8395650qkd.185.1635510334095;
        Fri, 29 Oct 2021 05:25:34 -0700 (PDT)
Received: from serve.minyard.net ([47.184.156.158])
        by smtp.gmail.com with ESMTPSA id u189sm3710308qkh.14.2021.10.29.05.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 05:25:33 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:7441:9fa8:649a:f004])
        by serve.minyard.net (Postfix) with ESMTPSA id AA33D1800B4;
        Fri, 29 Oct 2021 12:25:32 +0000 (UTC)
Date:   Fri, 29 Oct 2021 07:25:31 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     zweiss@equinix.com, andrew@aj.id.au,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ipmi: kcs_bmc: Fix a memory leak in the error handling
 path of 'kcs_bmc_serio_add_device()'
Message-ID: <20211029122531.GD4667@minyard.net>
Reply-To: minyard@acm.org
References: <ecbfa15e94e64f4b878ecab1541ea46c74807670.1631048724.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecbfa15e94e64f4b878ecab1541ea46c74807670.1631048724.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2021 at 11:06:32PM +0200, Christophe JAILLET wrote:
> In the unlikely event where 'devm_kzalloc()' fails and 'kzalloc()'
> succeeds, 'port' would be leaking.
> 
> Test each allocation separately to avoid the leak.

Yeah, looks reasonable.  It's in my queue.

-corey

> 
> Fixes: 3a3d2f6a4c64 ("ipmi: kcs_bmc: Add serio adaptor")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/char/ipmi/kcs_bmc_serio.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/ipmi/kcs_bmc_serio.c b/drivers/char/ipmi/kcs_bmc_serio.c
> index 7948cabde50b..7e2067628a6c 100644
> --- a/drivers/char/ipmi/kcs_bmc_serio.c
> +++ b/drivers/char/ipmi/kcs_bmc_serio.c
> @@ -73,10 +73,12 @@ static int kcs_bmc_serio_add_device(struct kcs_bmc_device *kcs_bmc)
>  	struct serio *port;
>  
>  	priv = devm_kzalloc(kcs_bmc->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
>  
>  	/* Use kzalloc() as the allocation is cleaned up with kfree() via serio_unregister_port() */
>  	port = kzalloc(sizeof(*port), GFP_KERNEL);
> -	if (!(priv && port))
> +	if (!port)
>  		return -ENOMEM;
>  
>  	port->id.type = SERIO_8042;
> -- 
> 2.30.2
> 
