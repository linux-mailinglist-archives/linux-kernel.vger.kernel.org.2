Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04793ECA40
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 18:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbhHOQhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 12:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhHOQhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 12:37:18 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E4EC061764
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 09:36:47 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1mFJ7p-0000Nz-8G; Sun, 15 Aug 2021 18:36:41 +0200
Date:   Sun, 15 Aug 2021 18:36:41 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, fmdefrancesco@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: remove kernel version depended code
 paths
Message-ID: <20210815163641.i7sysnhpaoldbzg3@viti.kaiser.cx>
References: <20210815102406.3707-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210815102406.3707-1-straube.linux@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Michael Straube (straube.linux@gmail.com):

> Remove kernel version depended code paths from the driver.
> Reported by checkpatch.

> WARNING: LINUX_VERSION_CODE should be avoided, code should be for the version to which it is merged

> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_mlme.c      |  4 ----
>  drivers/staging/r8188eu/os_dep/os_intfs.c    | 24 +-------------------
>  drivers/staging/r8188eu/os_dep/rtw_android.c |  9 --------
>  drivers/staging/r8188eu/os_dep/xmit_linux.c  |  5 ----
>  4 files changed, 1 insertion(+), 41 deletions(-)

> diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
> index 9189f5c845f3..d5ef5783f4ad 100644
> --- a/drivers/staging/r8188eu/core/rtw_mlme.c
> +++ b/drivers/staging/r8188eu/core/rtw_mlme.c
> @@ -1499,11 +1499,7 @@ void rtw_dynamic_check_timer_handlder(struct adapter *adapter)

>  	rcu_read_lock();

> -#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36)
>  	if (rcu_dereference(adapter->pnetdev->rx_handler_data) &&
> -#else
> -	if (rcu_dereference(adapter->pnetdev->br_port) &&
> -#endif
>  	    (check_fwstate(pmlmepriv, WIFI_STATION_STATE|WIFI_ADHOC_STATE) == true)) {
>  		/*  expire NAT2.5 entry */
>  		nat25_db_expire(adapter);
> diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
> index cc7e54170948..f4bf4732578a 100644
> --- a/drivers/staging/r8188eu/os_dep/os_intfs.c
> +++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
> @@ -637,19 +637,7 @@ static unsigned int rtw_classify8021d(struct sk_buff *skb)
>  	return dscp >> 5;
>  }

> -static u16 rtw_select_queue(struct net_device *dev, struct sk_buff *skb
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(5, 2, 0))
> -			    ,struct net_device *sb_dev
> -#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(4, 19, 0))
> -			    ,struct net_device *sb_dev
> -                            ,select_queue_fallback_t fallback
> -#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 14, 0))
> -			    ,void *unused
> -                            ,select_queue_fallback_t fallback
> -#elif (LINUX_VERSION_CODE == KERNEL_VERSION(3, 13, 0))
> -			    , void *accel
> -#endif
> -)
> +static u16 rtw_select_queue(struct net_device *dev, struct sk_buff *skb, struct net_device *sb_dev)
>  {
>  	struct adapter	*padapter = rtw_netdev_priv(dev);
>  	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
> @@ -706,15 +694,9 @@ int rtw_init_netdev_name(struct net_device *pnetdev, const char *ifname)
>  	return 0;
>  }

> -#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,39)
>  static const struct device_type wlan_type = {
>  	.name = "wlan",
>  };
> -#else
> -static struct device_type wlan_type = {
> -	.name = "wlan",
> -};
> -#endif

>  struct net_device *rtw_init_netdev(struct adapter *old_padapter)
>  {
> @@ -992,11 +974,7 @@ void netdev_br_init(struct net_device *netdev)

>  	rcu_read_lock();

> -#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36)
>  	if (rcu_dereference(adapter->pnetdev->rx_handler_data)) {
> -#else
> -	if (rcu_dereference(adapter->pnetdev->br_port)) {
> -#endif
>  		struct net_device *br_netdev;
>  		struct net *devnet = NULL;

> diff --git a/drivers/staging/r8188eu/os_dep/rtw_android.c b/drivers/staging/r8188eu/os_dep/rtw_android.c
> index d666feb87a7a..bdd381606ba6 100644
> --- a/drivers/staging/r8188eu/os_dep/rtw_android.c
> +++ b/drivers/staging/r8188eu/os_dep/rtw_android.c
> @@ -63,13 +63,8 @@ int rtw_android_cmdstr_to_num(char *cmdstr)
>  {
>  	int cmd_num;
>  	for (cmd_num=0; cmd_num < ANDROID_WIFI_CMD_MAX; cmd_num++)
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(4, 0, 0))
>  		if (!strncasecmp(cmdstr, android_wifi_cmd_str[cmd_num],
>  		    strlen(android_wifi_cmd_str[cmd_num])))
> -#else
> -		if (0 == strnicmp(cmdstr, android_wifi_cmd_str[cmd_num],
> -		   strlen(android_wifi_cmd_str[cmd_num])))
> -#endif
>  			break;
>  	return cmd_num;
>  }
> @@ -162,11 +157,7 @@ int rtw_android_priv_cmd(struct net_device *net, struct ifreq *ifr, int cmd)
>  		ret = -ENOMEM;
>  		goto exit;
>  	}
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(5, 0, 0))
>  	if (!access_ok(priv_cmd.buf, priv_cmd.total_len)) {
> -#else
> -	if (!access_ok(VERIFY_READ, priv_cmd.buf, priv_cmd.total_len)) {
> -#endif
>  		DBG_88E("%s: failed to access memory\n", __func__);
>  		ret = -EFAULT;
>  		goto exit;
> diff --git a/drivers/staging/r8188eu/os_dep/xmit_linux.c b/drivers/staging/r8188eu/os_dep/xmit_linux.c
> index 3a1b9d8988f2..4f1ce346b3a5 100644
> --- a/drivers/staging/r8188eu/os_dep/xmit_linux.c
> +++ b/drivers/staging/r8188eu/os_dep/xmit_linux.c
> @@ -108,7 +108,6 @@ void rtw_os_xmit_resource_free(struct adapter *padapter,

>  void rtw_os_pkt_complete(struct adapter *padapter, struct sk_buff *pkt)
>  {
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 35))
>  	u16	queue;
>  	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;

> @@ -121,10 +120,6 @@ void rtw_os_pkt_complete(struct adapter *padapter, struct sk_buff *pkt)
>  		if (__netif_subqueue_stopped(padapter->pnetdev, queue))
>  			netif_wake_subqueue(padapter->pnetdev, queue);
>  	}
> -#else
> -	if (netif_queue_stopped(padapter->pnetdev))
> -		netif_wake_queue(padapter->pnetdev);
> -#endif

>  	dev_kfree_skb_any(pkt);
>  }
> -- 
> 2.32.0

Hi Michael,

looks good to me.

Acked-by: Martin Kaiser <martin@kaiser.cx>
