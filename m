Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBBE3CD6F9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 16:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241081AbhGSOBp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 19 Jul 2021 10:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbhGSOBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 10:01:44 -0400
X-Greylist: delayed 405 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 19 Jul 2021 07:09:51 PDT
Received: from ursule.remlab.net (vps-a2bccee9.vps.ovh.net [IPv6:2001:41d0:305:2100::8a0c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0F47C061574
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 07:09:51 -0700 (PDT)
Received: from ursule.remlab.net (localhost [IPv6:::1])
        by ursule.remlab.net (Postfix) with ESMTP id 3E484C022F;
        Mon, 19 Jul 2021 17:36:07 +0300 (EEST)
Received: from basile.remlab.net ([2001:14ba:a01a:be01:9434:f69e:d553:3be2])
        by ursule.remlab.net with ESMTPSA
        id oJWJDNeN9WBgcQAAwZXkwQ
        (envelope-from <remi@remlab.net>); Mon, 19 Jul 2021 17:36:07 +0300
From:   =?ISO-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>
To:     courmisch@gmail.com, Yajun Deng <yajun.deng@linux.dev>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] net: Adjustment parameters in rtnl_notify()
Date:   Mon, 19 Jul 2021 17:36:06 +0300
Message-ID: <5299846.uZDWVASI8p@basile.remlab.net>
Organization: Remlab
In-Reply-To: <20210719122506.5414-1-yajun.deng@linux.dev>
References: <20210719122506.5414-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Hi,

Le maanantaina 19. heinäkuuta 2021, 15.25.06 EEST Yajun Deng a écrit :
> The fifth parameter alread modify from 'struct nlmsghdr *nlh' to
> 'int report', just adjustment them.

I can't see that anywhere in the patch.

> Add the case the nlh variable is NULL in nlmsg_report().
> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>

> diff --git a/net/phonet/pn_netlink.c b/net/phonet/pn_netlink.c
> index 59aebe296890..03e04d0b8453 100644
> --- a/net/phonet/pn_netlink.c
> +++ b/net/phonet/pn_netlink.c
> @@ -38,7 +38,7 @@ void phonet_address_notify(int event, struct net_device
> *dev, u8 addr) goto errout;
>  	}
>  	rtnl_notify(skb, dev_net(dev), 0,
> -		    RTNLGRP_PHONET_IFADDR, NULL, GFP_KERNEL);
> +		    RTNLGRP_PHONET_IFADDR, 0, GFP_KERNEL);
>  	return;
>  errout:
>  	rtnl_set_sk_err(dev_net(dev), RTNLGRP_PHONET_IFADDR, err);
> @@ -204,7 +204,7 @@ void rtm_phonet_notify(int event, struct net_device
> *dev, u8 dst) goto errout;
>  	}
>  	rtnl_notify(skb, dev_net(dev), 0,
> -			  RTNLGRP_PHONET_ROUTE, NULL, GFP_KERNEL);
> +			  RTNLGRP_PHONET_ROUTE, 0, GFP_KERNEL);
>  	return;
>  errout:
>  	rtnl_set_sk_err(dev_net(dev), RTNLGRP_PHONET_ROUTE, err);

Sorry but I don't like to replace explicit NULL pointers with implicitly 
converted zeroes.

-- 
雷米‧德尼-库尔蒙
http://www.remlab.net/



