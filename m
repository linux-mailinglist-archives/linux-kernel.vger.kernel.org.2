Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9BE41C0AB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 10:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244738AbhI2IeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 04:34:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22457 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244459AbhI2IeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 04:34:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632904342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=33L2kvYESyBjFzI5T12hFb+rWTsyBJjmF6Rb3+aaSJw=;
        b=DPhtQRATFXW5DUFG4STk4GLNZOfKTq2utGGfhyMf423oCtWqRNIPl0k9OwXB917mrfZEPg
        tQVRbCitHUN0IGWUpfghaY0cePxKbE5b3l4TfLfnb4LBnVKJPXKNj6Z6vMF5+2gn1Y3J1T
        kxSMUQ6vnDNnJ74psLR1lPqCkZIAoHg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-564-FAo91RcIPEOMuyhpN4HXfA-1; Wed, 29 Sep 2021 04:32:20 -0400
X-MC-Unique: FAo91RcIPEOMuyhpN4HXfA-1
Received: by mail-wm1-f72.google.com with SMTP id z137-20020a1c7e8f000000b0030cd1800d86so874119wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 01:32:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=33L2kvYESyBjFzI5T12hFb+rWTsyBJjmF6Rb3+aaSJw=;
        b=d9h2s/N3HF3YdnjzWUxknHO3DhSOfz0IqViSgO7DXj3txP0mR7pPQ8ONMpp4Mu1byZ
         qiZDa1U/N9V+au1uIOVU3LY6C5wX1s8FEI8+67balTZtwQ59RCcZMcISaIo4/0BJa4L2
         0grplUoD7RoyZ3QQz3v7W7XQ8A3/o5bzI7QN97FbgighiQclyFKTNlmKCd6Y1rIPAb0C
         9PiU8ZN0xfudf3y99V+H2B8JImEaILeIgz1VR3Li4yFI6rfWJM/ZyWNaDe9qbLkn8yLx
         qgFV2ibgMxCX3Ga3j8HOh/EQEc1jScmZIkNygjxE8v9ju0AHaHbVbyPfWeW68Wr1QJEg
         Px+w==
X-Gm-Message-State: AOAM531iu+wdFKybWcx+VMhUjozITrqVWXeLL+otbOVahbTJA3cmMrp8
        dfjA4QslXPRDL8vKuwJdXE1FSxFvxentUhOI/ojJmXt5uOez633gGuwF4Uy4K2jVpXTAe+QxBNS
        IoLdC0LqMRbzS+wQEDk33wz89
X-Received: by 2002:a1c:4407:: with SMTP id r7mr9093110wma.69.1632904339605;
        Wed, 29 Sep 2021 01:32:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxiFH8QvVbSSfltUTVNYrFe4cgpOa802Pjd2dc9VAv6jOjC98+5gHvsdXJBd6/yPoXBjvvJDg==
X-Received: by 2002:a1c:4407:: with SMTP id r7mr9093089wma.69.1632904339405;
        Wed, 29 Sep 2021 01:32:19 -0700 (PDT)
Received: from redhat.com ([2.55.12.29])
        by smtp.gmail.com with ESMTPSA id l21sm851391wme.39.2021.09.29.01.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 01:32:18 -0700 (PDT)
Date:   Wed, 29 Sep 2021 04:32:15 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Cindy Lu <lulu@redhat.com>
Cc:     jasowang@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost-vdpa:fix the worng input in config_cb
Message-ID: <20210929043142-mutt-send-email-mst@kernel.org>
References: <20210929075437.12985-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929075437.12985-1-lulu@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 03:54:37PM +0800, Cindy Lu wrote:
> Fix the worng input in for config_cb,
> in function vhost_vdpa_config_cb, the input
> cb.private was used as struct vhost_vdpa,
> So the inuput was worng here, fix this issue
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>

Maybe add

Fixes: 776f395004d8 ("vhost_vdpa: Support config interrupt in vdpa")

and fix typos in the commit log.

> ---
>  drivers/vhost/vdpa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 942666425a45..e532cbe3d2f7 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -322,7 +322,7 @@ static long vhost_vdpa_set_config_call(struct vhost_vdpa *v, u32 __user *argp)
>  	struct eventfd_ctx *ctx;
>  
>  	cb.callback = vhost_vdpa_config_cb;
> -	cb.private = v->vdpa;
> +	cb.private = v;
>  	if (copy_from_user(&fd, argp, sizeof(fd)))
>  		return  -EFAULT;
>  
> -- 
> 2.21.3

