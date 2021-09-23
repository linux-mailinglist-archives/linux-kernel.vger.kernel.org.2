Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF0B241580E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 08:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239279AbhIWGET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 02:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239239AbhIWGER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 02:04:17 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE62C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 23:02:46 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t28so368532wra.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 23:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google;
        h=reply-to:subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fgwahsTAg8KuN6NY+9uMhllAHmwKLjBVPsZvBLty6KM=;
        b=dZFnSEILauy+orsjX6RvU01y4YVpvooFp7E9cGDWrj1T40VVfgCVE7L2tEfq1n6cKG
         8z7ZfOPolyYJQYU4cr8S+EY8QPb9Q9DFJZTbjlkKgjs/lYCcMrvNjwDIuPA4k4LhZWnN
         RIrFuPNSWNvjf5o5VddHz0ZrOSHU5Xpn7COLOEDDmXOe3VC7JgBMdu69uOc+Yv1/0ASx
         Sh0kszrfF7cXW9ZOT+eeAq9sGaC/4WcXlw3hl5bG5NlBwUBkyiTMCaarRzX2WcSU+GT1
         waD94qWHqeHo1IitWUOpAaiITE+eR/s50a+w0ImR6DnSjrSvPasf8XpGrwuGy5OedDI+
         /i+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=fgwahsTAg8KuN6NY+9uMhllAHmwKLjBVPsZvBLty6KM=;
        b=H8bGPsaIP9h5l5hSs8hp+pbknthk3uiDz7EGvixqEzK4ewYQU5Ze4KtbsKS5K2iQaC
         3Wzed7ySXGm1EhpteFIEeenl5ZeTrfaboboKn9f2WeP2tVytswNfTFbxZF17xWwW6RJU
         tBZZaDR/ZghNyEAdQM9J/TuZniXn5IMcZG+WDnNohJ9oJB/K1eR+nGW84VM7mJzZ8dGk
         0MuXGSp6xqLyk93vp0YWp2plhvoQ7zcRRrpFmh8wib+1P3G6bvUbq4t5981Rn0SR0GT6
         oWydIB9wdOIaMSEYQbX8Rxh+OicmTwkvfyxQOfg7FydDyF6DJ8u+qPA+nJT9gA0zGXNS
         oVjg==
X-Gm-Message-State: AOAM532BMia9IEE8LPequ6kdvBlOmFa5hDrtcywdBY2tDXphYZ3s4leB
        glk0eYAj1Q51liQrAS0A0Bc8yD/z8J9odg==
X-Google-Smtp-Source: ABdhPJzkXEe3am9jBRg6LgVFXpqmI4t8u4H9q8Pj20BOPC/zsrX0oRwMUFh6aErXV66LEF9ciWWoUA==
X-Received: by 2002:a7b:cc96:: with SMTP id p22mr2438390wma.83.1632376965301;
        Wed, 22 Sep 2021 23:02:45 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:410:bb00:88ab:30e5:cd:d558? ([2a01:e0a:410:bb00:88ab:30e5:cd:d558])
        by smtp.gmail.com with ESMTPSA id o7sm5424039wro.45.2021.09.22.23.02.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 23:02:44 -0700 (PDT)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v5] net: openvswitch: IPv6: Add IPv6 extension
 header support
To:     Toms Atteka <cpp.code.lv@gmail.com>, netdev@vger.kernel.org
Cc:     pshelar@ovn.org, davem@davemloft.net, kuba@kernel.org,
        dev@openvswitch.org, linux-kernel@vger.kernel.org
References: <20210920182038.1510501-1-cpp.code.lv@gmail.com>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
Message-ID: <0d70b112-dc7a-7083-db8d-183782b8ef8f@6wind.com>
Date:   Thu, 23 Sep 2021 08:02:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210920182038.1510501-1-cpp.code.lv@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 20/09/2021 à 20:20, Toms Atteka a écrit :
> This change adds a new OpenFlow field OFPXMT_OFB_IPV6_EXTHDR and
> packets can be filtered using ipv6_ext flag.
> 
> Signed-off-by: Toms Atteka <cpp.code.lv@gmail.com>
> ---
>  include/uapi/linux/openvswitch.h |  12 +++
>  net/openvswitch/flow.c           | 140 +++++++++++++++++++++++++++++++
>  net/openvswitch/flow.h           |  14 ++++
>  net/openvswitch/flow_netlink.c   |  24 +++++-
>  4 files changed, 189 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/openvswitch.h b/include/uapi/linux/openvswitch.h
> index a87b44cd5590..dc6eb5f6399f 100644
> --- a/include/uapi/linux/openvswitch.h
> +++ b/include/uapi/linux/openvswitch.h
> @@ -346,6 +346,13 @@ enum ovs_key_attr {
>  #ifdef __KERNEL__
>  	OVS_KEY_ATTR_TUNNEL_INFO,  /* struct ip_tunnel_info */
>  #endif
> +
> +#ifndef __KERNEL__
> +	PADDING,  /* Padding so kernel and non kernel field count would match */
> +#endif
> +
> +	OVS_KEY_ATTR_IPV6_EXTHDRS,  /* struct ovs_key_ipv6_exthdr */
Naive question, why not moving OVS_KEY_ATTR_IPV6_EXTHDRS above
OVS_KEY_ATTR_TUNNEL_INFO?



Regards,
Nicolas
