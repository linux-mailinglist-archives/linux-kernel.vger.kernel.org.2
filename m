Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F34B140ED19
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 00:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240710AbhIPWGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 18:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbhIPWGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 18:06:43 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384CAC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 15:05:22 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d18so4791748pll.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 15:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pc3VGvRcHS+5HOxv6BUlJ0pcBYgpx5RMDU9krFJbSFI=;
        b=L9Q0s9st6IwFUEPzVmbOCNGgjCrmNDpcr28U9cZK4tTmz1j4mRtwNPsTNwmFxm9QPT
         5KOLA+IeJ+ETgpRQNvpWWO6HQ3dzliERyKKbo9DNqWKooqXhaghSVvKfT6piuRrennIY
         IVR802SufbqXdHydO7wRcXR8T/kfWIQ2WVoRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pc3VGvRcHS+5HOxv6BUlJ0pcBYgpx5RMDU9krFJbSFI=;
        b=Wxa/CY+pp3lu4CuRNpw60QVDX+fbtrmmoXvAzjOtp7xgVJzfNHmhHsDaXMz2vV58Co
         nKaK5BL2vWG1sEyvxRiTi8NqajzXlE7st064i+jwR9Lk0yeOQ3PWmPCxvib8w3ZAwoKe
         u5ifc/B0rB99dBIwalOcec+R2r7irEKX5XsidUFGTsrO5Zt+P0YRwoZ1RAWa60qScQqb
         AHRy6CWlLdQREBE2AkEUgs0ATyB0+L9NbksICO4Ny9dT6z6ovn6xTSJOPgJMVYzwR0Xt
         hG063DWz3gqvvM/vJAhAVM5TkSXNQqrNPfmE00Wx7UwVommpq5bWTeztf4uYMe/eJCdG
         nzww==
X-Gm-Message-State: AOAM531Q8oQV15uL1j9gYiBoZanRtIORrbR8W1dSZUB6pqJ7pyo/hote
        eT9zqaawAsYxmC6Ew19xjInXZQ==
X-Google-Smtp-Source: ABdhPJzlx4QqzuYqWgTlMu8HdcAgL44WNF97KaSbw9uVDYW3Rvi+9yNLWyGiEwBOJot16CXQYA3dhA==
X-Received: by 2002:a17:90b:1d8d:: with SMTP id pf13mr17425080pjb.130.1631829921820;
        Thu, 16 Sep 2021 15:05:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a11sm3858739pfo.31.2021.09.16.15.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 15:05:21 -0700 (PDT)
Date:   Thu, 16 Sep 2021 15:05:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Huth <thuth@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>, linux-s390@vger.kernel.org,
        Jia He <hejianet@gmail.com>,
        Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] lockd: change the proc_handler for nsm_use_hostnames
Message-ID: <202109161503.07F872F6@keescook>
References: <20210803105937.52052-1-thuth@redhat.com>
 <20210803105937.52052-3-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803105937.52052-3-thuth@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2021 at 12:59:37PM +0200, Thomas Huth wrote:
> From: Jia He <hejianet@gmail.com>
> 
> nsm_use_hostnames is a module parameter and it will be exported to sysctl
> procfs. This is to let user sometimes change it from userspace. But the
> minimal unit for sysctl procfs read/write it sizeof(int).
> In big endian system, the converting from/to  bool to/from int will cause
> error for proc items.
> 
> This patch use a new proc_handler proc_dobool to fix it.
> 
> Signed-off-by: Jia He <hejianet@gmail.com>
> Reviewed-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
> [thuth: Fix typo in commit message]
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  fs/lockd/svc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
> index 2de048f80eb8..0ab9756ed235 100644
> --- a/fs/lockd/svc.c
> +++ b/fs/lockd/svc.c
> @@ -584,7 +584,7 @@ static struct ctl_table nlm_sysctls[] = {
>  		.data		= &nsm_use_hostnames,
>  		.maxlen		= sizeof(int),

For robustness, maybe this should be:

		.maxlen		= sizeof(nsm_use_hostnames),

>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec,
> +		.proc_handler	= proc_dobool,
>  	},
>  	{
>  		.procname	= "nsm_local_state",
> -- 
> 2.27.0
> 

Reviewed-by: Kees Cook <keescook@chromium.org>

Also, I wonder what other BE-corrupted bools are out there?

-- 
Kees Cook
