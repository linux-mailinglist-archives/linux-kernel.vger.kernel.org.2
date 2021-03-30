Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E66B34E676
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 13:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbhC3Lnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 07:43:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36571 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231842AbhC3LnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 07:43:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617104594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YdResl2kuic95sH6TzZMvcjnCw/gcVH4dBotfJe6QDs=;
        b=PbWgNLmXaQTocqxYdyIGkpshahjpMX053j3A/bdCdcxfwMR2xvYtvgeYagmiXoLuD6U/i0
        JX/0Ns1Dy/eQng/fG9rFcfDpNxHSRBiMaV6hEnUYwUusnuu7J9SLsy1g1xcUpmF84BrT2K
        H9/1J+GdviLDtSgIEjufonxOCvGurM4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-Jl5xkqmKPCGWUcPJIyqu2Q-1; Tue, 30 Mar 2021 07:43:12 -0400
X-MC-Unique: Jl5xkqmKPCGWUcPJIyqu2Q-1
Received: by mail-ej1-f69.google.com with SMTP id fy8so7028067ejb.19
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 04:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=YdResl2kuic95sH6TzZMvcjnCw/gcVH4dBotfJe6QDs=;
        b=WUO5gCQZA3OC5oYkz8+nqzGUPOKqRnBL8ZSz9ZTZA8b3vTa0h96jHH9qqDlpGs0gTl
         pylOFsSVoANDEEsxFVVtyOl88jnGcA70HZi0djnYrMweS9MyJ0CHQ4PEFM9OEUVslI2o
         KL//GA8rkuhJBDljvCyUr5Sy/AGJOxInNHzbm6TL0gdK+SAoGk/HFf+RzREklGBtkaUf
         MEZbGwQ+S2UP6WY3GYspC6MT0NyZ35Zn31jFSN13R5rCT6lXIyywyFUZJ8JnM5Fi5e6O
         taTocgwAu5PiCqKVwNSWB6JQ4PKw/Cdo/TMqGpS+DE9jKrpuNACBLzj5TqNO3iGjHzX2
         mTOg==
X-Gm-Message-State: AOAM531GToi7fOl/1jLlz+jyfyIMvCzjXQumk0MMoAATYX27nQCA/eDd
        AWBEs3L4KK2Js285lNDZ7ZgvB51QacHc/amkHNQTk43eOIVWTAi5AJ1VoIUS0Nb8jcatHuZiSlI
        02F1a+p/o5yAhiQGjMbQbNPDmCZBZ0morCYni7QK6UPBugGWTXC7ocUv+E5BATCJ0q6mfDwe5zQ
        dR
X-Received: by 2002:aa7:cd0e:: with SMTP id b14mr33934064edw.354.1617104590861;
        Tue, 30 Mar 2021 04:43:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDoAlTwzQHxlgfI0onMmuRddii3uOQW4heyvgibFcoZfZlHeKAUghgXQPcpnC/JNOsO8VMNA==
X-Received: by 2002:aa7:cd0e:: with SMTP id b14mr33934042edw.354.1617104590647;
        Tue, 30 Mar 2021 04:43:10 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id o6sm10888718edw.24.2021.03.30.04.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 04:43:10 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Haiyang Zhang <haiyangz@microsoft.com>,
        linux-hyperv@vger.kernel.org, netdev@vger.kernel.org
Cc:     haiyangz@microsoft.com, kys@microsoft.com, sthemmin@microsoft.com,
        olaf@aepfle.de, davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] hv_netvsc: Add error handling while switching
 data path
In-Reply-To: <1617060095-31582-1-git-send-email-haiyangz@microsoft.com>
References: <1617060095-31582-1-git-send-email-haiyangz@microsoft.com>
Date:   Tue, 30 Mar 2021 13:43:09 +0200
Message-ID: <87lfa4uasy.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Haiyang Zhang <haiyangz@microsoft.com> writes:

> Add error handling in case of failure to send switching data path message
> to the host.
>
> Reported-by: Shachar Raindel <shacharr@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
>
> ---
>  drivers/net/hyperv/hyperv_net.h |  6 +++++-
>  drivers/net/hyperv/netvsc.c     | 35 +++++++++++++++++++++++++++++----
>  drivers/net/hyperv/netvsc_drv.c | 18 +++++++++++------
>  3 files changed, 48 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
> index 59ac04a610ad..442c520ab8f3 100644
> --- a/drivers/net/hyperv/hyperv_net.h
> +++ b/drivers/net/hyperv/hyperv_net.h
> @@ -269,7 +269,7 @@ int rndis_filter_receive(struct net_device *ndev,
>  int rndis_filter_set_device_mac(struct netvsc_device *ndev,
>  				const char *mac);
>  
> -void netvsc_switch_datapath(struct net_device *nv_dev, bool vf);
> +int netvsc_switch_datapath(struct net_device *nv_dev, bool vf);
>  
>  #define NVSP_INVALID_PROTOCOL_VERSION	((u32)0xFFFFFFFF)
>  
> @@ -1718,4 +1718,8 @@ struct rndis_message {
>  #define TRANSPORT_INFO_IPV6_TCP 0x10
>  #define TRANSPORT_INFO_IPV6_UDP 0x20
>  
> +#define RETRY_US_LO	5000
> +#define RETRY_US_HI	10000
> +#define RETRY_MAX	2000	/* >10 sec */
> +
>  #endif /* _HYPERV_NET_H */
> diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> index 5bce24731502..9d07c9ce4be2 100644
> --- a/drivers/net/hyperv/netvsc.c
> +++ b/drivers/net/hyperv/netvsc.c
> @@ -31,12 +31,13 @@
>   * Switch the data path from the synthetic interface to the VF
>   * interface.
>   */
> -void netvsc_switch_datapath(struct net_device *ndev, bool vf)
> +int netvsc_switch_datapath(struct net_device *ndev, bool vf)
>  {
>  	struct net_device_context *net_device_ctx = netdev_priv(ndev);
>  	struct hv_device *dev = net_device_ctx->device_ctx;
>  	struct netvsc_device *nv_dev = rtnl_dereference(net_device_ctx->nvdev);
>  	struct nvsp_message *init_pkt = &nv_dev->channel_init_pkt;
> +	int ret, retry = 0;
>  
>  	/* Block sending traffic to VF if it's about to be gone */
>  	if (!vf)
> @@ -51,15 +52,41 @@ void netvsc_switch_datapath(struct net_device *ndev, bool vf)
>  		init_pkt->msg.v4_msg.active_dp.active_datapath =
>  			NVSP_DATAPATH_SYNTHETIC;
>  
> +again:
>  	trace_nvsp_send(ndev, init_pkt);
>  
> -	vmbus_sendpacket(dev->channel, init_pkt,
> +	ret = vmbus_sendpacket(dev->channel, init_pkt,
>  			       sizeof(struct nvsp_message),
> -			       (unsigned long)init_pkt,
> -			       VM_PKT_DATA_INBAND,
> +			       (unsigned long)init_pkt, VM_PKT_DATA_INBAND,
>  			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
> +
> +	/* If failed to switch to/from VF, let data_path_is_vf stay false,
> +	 * so we use synthetic path to send data.
> +	 */
> +	if (ret) {
> +		if (ret != -EAGAIN) {
> +			netdev_err(ndev,
> +				   "Unable to send sw datapath msg, err: %d\n",
> +				   ret);
> +			return ret;
> +		}
> +
> +		if (retry++ < RETRY_MAX) {
> +			usleep_range(RETRY_US_LO, RETRY_US_HI);
> +			goto again;
> +		} else {
> +			netdev_err(
> +				ndev,
> +				"Retry failed to send sw datapath msg, err: %d\n",
> +				ret);

err is always -EAGAIN here, right?

> +			return ret;
> +		}

Nitpicking: I think we can simplify the above a bit:

	if (ret) {
		if (ret == -EAGAIN && retry++ < RETRY_MAX) {
			usleep_range(RETRY_US_LO, RETRY_US_HI);
			goto again;
		}
		netdev_err(ndev, "Unable to send sw datapath msg, err: %d\n", ret);
		return ret;
	}

> +	}
> +
>  	wait_for_completion(&nv_dev->channel_init_wait);
>  	net_device_ctx->data_path_is_vf = vf;
> +
> +	return 0;
>  }
>  
>  /* Worker to setup sub channels on initial setup
> diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
> index 97b5c9b60503..7349a70af083 100644
> --- a/drivers/net/hyperv/netvsc_drv.c
> +++ b/drivers/net/hyperv/netvsc_drv.c
> @@ -38,9 +38,6 @@
>  #include "hyperv_net.h"
>  
>  #define RING_SIZE_MIN	64
> -#define RETRY_US_LO	5000
> -#define RETRY_US_HI	10000
> -#define RETRY_MAX	2000	/* >10 sec */
>  
>  #define LINKCHANGE_INT (2 * HZ)
>  #define VF_TAKEOVER_INT (HZ / 10)
> @@ -2402,6 +2399,7 @@ static int netvsc_vf_changed(struct net_device *vf_netdev, unsigned long event)
>  	struct netvsc_device *netvsc_dev;
>  	struct net_device *ndev;
>  	bool vf_is_up = false;
> +	int ret;
>  
>  	if (event != NETDEV_GOING_DOWN)
>  		vf_is_up = netif_running(vf_netdev);
> @@ -2418,9 +2416,17 @@ static int netvsc_vf_changed(struct net_device *vf_netdev, unsigned long event)
>  	if (net_device_ctx->data_path_is_vf == vf_is_up)
>  		return NOTIFY_OK;
>  
> -	netvsc_switch_datapath(ndev, vf_is_up);
> -	netdev_info(ndev, "Data path switched %s VF: %s\n",
> -		    vf_is_up ? "to" : "from", vf_netdev->name);
> +	ret = netvsc_switch_datapath(ndev, vf_is_up);
> +
> +	if (ret) {
> +		netdev_err(ndev,
> +			   "Data path failed to switch %s VF: %s, err: %d\n",
> +			   vf_is_up ? "to" : "from", vf_netdev->name, ret);
> +		return NOTIFY_DONE;
> +	} else {
> +		netdev_info(ndev, "Data path switched %s VF: %s\n",
> +			    vf_is_up ? "to" : "from", vf_netdev->name);
> +	}
>  
>  	return NOTIFY_OK;
>  }

-- 
Vitaly

