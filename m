Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD3D39E091
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 17:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhFGPfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 11:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhFGPfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 11:35:20 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF81C061766
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 08:33:29 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id z3-20020a17090a3983b029016bc232e40bso244089pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 08:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=73i5sakrC+i/nwD2XDXZACOiGIEuee7Cd/JkLRfjWDU=;
        b=GL/9X0t6PeQHVLfFDEvclaSHaaG+z6gqgsGNFmYhcSE+V/N5SWLFUE9+pXJHBg4G9R
         goUzHwlzrsVrOFtONjT4TPLqBtqW1v+/bk9YOx6yqM6cG+U19q3RcZTQ1vw1Ha8vejDS
         a7hJOmVwy9OojR2ZPie0yzHAGXKZAnE473DzJoI2LV27aGFZkxrSFaLkeSbF/L4zZ6el
         8M+M1u/swgmrmyPq8UJjcw3oyfuFferMigYPXTXh6JH9ZWcTZ6knuWhhkMEYXDrpfE2N
         CSpxJsL1cCEHadBP3OJkJUu0+Hrm50xTCiMruIMRnHgGDeafks9XKnFEceez2VJjqIH5
         pr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=73i5sakrC+i/nwD2XDXZACOiGIEuee7Cd/JkLRfjWDU=;
        b=Khs2zi74sOSA/on5CeAX5SXbtHqj18Q1Qt4AtUuI9aAsswwan3UQVUfqO5WcpVN02P
         ed8hazbsQN7lBmoKWcMw0VojOVMKxCY4mwIpoAmnmIvqr1AYokyR89nzvuMX+Pf2vZh0
         EJ2nwOu27XFYbvzZyJJI40wC5o/gAYV/GTSvaPxoMZ97cXCqHfucmNCJCdkllTEvXYmL
         TVXMpYZgySevrCYxAqsGMhE7s0nM8NQMUdYaRYHOv5Ky0k11fZwCFi62UHe5G7xvoA7+
         Ucvcv+2NHSZmJsuqFNRedV1bUKkAeTtfFoVCMhtwh94ihR6ilh2y9qNlBfhIzUYRKNAV
         Ikvg==
X-Gm-Message-State: AOAM533C6R2sXSLBqL1JW6z5UEw7qfwCMKYb3BGPT3Q2K1M/TJeLBT9d
        xvMDAkto3CsTx2gxmPohovEIsQ==
X-Google-Smtp-Source: ABdhPJwiigIXKgYCQ6iUifhbZgwYSJKZ0SAnMRVmqFzUbDiT0h/yeb/MM1nHg7njiWhAJnEBqCa8Mw==
X-Received: by 2002:a17:902:7404:b029:101:af04:4e24 with SMTP id g4-20020a1709027404b0290101af044e24mr18782851pll.3.1623080008978;
        Mon, 07 Jun 2021 08:33:28 -0700 (PDT)
Received: from hermes.local (76-14-218-44.or.wavecable.com. [76.14.218.44])
        by smtp.gmail.com with ESMTPSA id g4sm9377305pgu.46.2021.06.07.08.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 08:33:28 -0700 (PDT)
Date:   Mon, 7 Jun 2021 08:33:25 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     13145886936@163.com
Cc:     davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, gushengxian <gushengxian@yulong.com>
Subject: Re: [PATCH] vlan: Avoid crashing the kernel
Message-ID: <20210607083325.1a68e8e6@hermes.local>
In-Reply-To: <20210607030839.374323-1-13145886936@163.com>
References: <20210607030839.374323-1-13145886936@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  6 Jun 2021 20:08:39 -0700
13145886936@163.com wrote:

> From: gushengxian <gushengxian@yulong.com>
> 
> Avoid crashing the kernel, try using WARN_ON & recovery code
> rather than BUG() or BUG_ON().
> 
> Signed-off-by: gushengxian <gushengxian@yulong.com>
> ---
>  net/8021q/vlan.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
> index 4cdf8416869d..6e784fd8795b 100644
> --- a/net/8021q/vlan.c
> +++ b/net/8021q/vlan.c
> @@ -97,7 +97,7 @@ void unregister_vlan_dev(struct net_device *dev, struct list_head *head)
>  	ASSERT_RTNL();
>  
>  	vlan_info = rtnl_dereference(real_dev->vlan_info);
> -	BUG_ON(!vlan_info);
> +	WARN_ON(!vlan_info);
>  
>  	grp = &vlan_info->grp;

NACK

You change turns bug on into warning and crash from null pointer dereference.
