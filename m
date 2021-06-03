Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F21D39A245
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 15:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhFCNgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 09:36:12 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:40662 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhFCNgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 09:36:12 -0400
Received: by mail-wr1-f54.google.com with SMTP id y7so1238176wrh.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 06:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google;
        h=reply-to:subject:to:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y114KDoLC1d7O+Zn9RCBinCUsUIhN/la9oGG1fZ/Rc0=;
        b=itVxeMX7JUDfpHrmQ/XP/lT0FbYDYzkZxtWUmNU8GZmyTix96VqdK4OVh2LoH11kWh
         XhIOamhPBhVnpBCqFQXuxOHaQQowYGAsSPod2vGjSzfY0d8xPvqsfcIK9fwqADzVpX55
         goni2ncWrv+4a0BNDTARCyqSzRU9vHFLM15xTVJg+VbhMv0OhJdR7iqQyNn0AtA6XVC3
         OlljGZgNA5XAMRRjtaU3hVN2S6rZN4YqnVGkNzKkEh/YUkSFu808Rt/rY8otD8m+kRIq
         rIj81WGC/6WVn0A/90hGRlK5OCQx6zBVcaoJxm5PV+GmlU0LE3bMnT+wLG8K8hRTnvCY
         q+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Y114KDoLC1d7O+Zn9RCBinCUsUIhN/la9oGG1fZ/Rc0=;
        b=l7cX8PLrsEHfsHixrBSAqUpLXQgWLUQD26cMP/RJr26IK2kAtYfRyod/CsLJPHtPdd
         5x5deNKZ9lwJ9MP89ceJj5ubCMMNGOx5TWRIRG2Ca1QyZkeviLJshVm3tJrO8+9JMLod
         x2C8cgEZh0QVEqT4/HZ40ZEqxL5IhMokJLMyTSJUQ9H69Glcr30vaPZH2Vf6iagXZi7R
         pIw3GouWj0p5R6Fj0gyviOqtp++tvPPFr2XbZ4R3dAjzsMo51RUsL56DTiRiJDlpAa0z
         YUFmIPHr3SitsWeRuRrppRbT6yomiCqIGy4nkQGy6AiO+TkqocHZBCy3H6IhY0o+ode+
         nPpg==
X-Gm-Message-State: AOAM533QRCksBkUqJgLWZ+SIVABj4kV5p7Qw9UHOUS0WZOxL6FQyHaPP
        Y43Pfz9MOViJEKhBOwqrR7k+N8Crc7f6Nw==
X-Google-Smtp-Source: ABdhPJyrVHytZfD8Ie1d6zCBkpXcLxE/o6GfK/L3RDlmZ5FJjNAIAlNe9bNl3s97K1xirDaw7fi3pg==
X-Received: by 2002:a5d:68ca:: with SMTP id p10mr13316wrw.65.1622727206952;
        Thu, 03 Jun 2021 06:33:26 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:410:bb00:104d:bd76:408:a323? ([2a01:e0a:410:bb00:104d:bd76:408:a323])
        by smtp.gmail.com with ESMTPSA id a4sm2855847wme.45.2021.06.03.06.33.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 06:33:26 -0700 (PDT)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH] ipv6: parameter p.name is empty
To:     zhang kai <zhangkaiheb@126.com>, davem@davemloft.net,
        yoshfuji@linux-ipv6.org, dsahern@kernel.org, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210603095030.2920-1-zhangkaiheb@126.com>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
Message-ID: <d1085905-215f-fb78-4d68-324bd6e48fdd@6wind.com>
Date:   Thu, 3 Jun 2021 15:33:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210603095030.2920-1-zhangkaiheb@126.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 03/06/2021 à 11:50, zhang kai a écrit :
> so do not check it.
> 
> Signed-off-by: zhang kai <zhangkaiheb@126.com>
> ---
>  net/ipv6/addrconf.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index b0ef65eb9..4c6b3fc7e 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -2833,9 +2833,6 @@ static int addrconf_set_sit_dstaddr(struct net *net, struct net_device *dev,
>  	if (err)
>  		return err;
>  
> -	dev = __dev_get_by_name(net, p.name);
> -	if (!dev)
> -		return -ENOBUFS;
>  	return dev_open(dev, NULL);
>  }
>  
> 
This bug seems to exist since the beginning of the SIT driver (24 years!):
https://git.kernel.org/pub/scm/linux/kernel/git/davem/netdev-vger-cvs.git/commit/?id=e5afd356a411a
Search addrconf_set_dstaddr()

Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
