Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F211E45D9A8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 12:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240453AbhKYMBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 07:01:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:44551 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235199AbhKYL7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 06:59:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637841367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zn5qUDNHigeTHkfOIEeNHxGhyTGmOPHFVQziaWMqPvM=;
        b=aeJ6eK25GzeZU9x8GJIoFRRYMIhOKi3XTHMKa40e7VIsZGdKb3n0c1Mzi6GiGWWnG1Q6tj
        PV9Oyz5ZixOsB0LQm9LMJqy1zOVTUtqWFoq5+OQ7qobJdzdJ2zlOs3EuhEsDYdLSdq0NTV
        sGr7e8o1wWcusTOu5sSqd3A09wpmSM4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-487-4btyKCsEN--mV-6f6ErNGQ-1; Thu, 25 Nov 2021 06:56:06 -0500
X-MC-Unique: 4btyKCsEN--mV-6f6ErNGQ-1
Received: by mail-ed1-f69.google.com with SMTP id n11-20020aa7c68b000000b003e7d68e9874so5325614edq.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 03:56:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Zn5qUDNHigeTHkfOIEeNHxGhyTGmOPHFVQziaWMqPvM=;
        b=sTTd2IxOw2UK40SKSbvWMEeoVvbHPi45bXrrFL86P/2342kP5S4BmVF7x0lsBGZTTr
         eqS/xHWtAeSCDuteM1SDnBPoEgXTEEZHIOVA+9NnHLcJeRh0DBh4C3XOpPUbfPsHl3N9
         UgZqL2LiIGHxKYhPmeX+DwJwW7Lydw9+9q1d5RhWR3hpAC/au5zoHoIBkwkCZzBsHwpm
         481vNM31MWVjDbw443do1GuUVedu0bP0LSR7yB54Gh/ZKhanbUUROvDdsOfH+rBSfstB
         7LNIyflGKIkdRoecgCF69rjyBLUeG0ZH0duIfDqYmoG4ssMak1zomXRcArQ6JI19PQqv
         ilEQ==
X-Gm-Message-State: AOAM5300vPYYnzTqyHh5Ugfm2kNz9VAuEUELdtnaccrgYoDJIXtGd5mu
        S1VutsVx9BDQUhKsLsASfWo+FcIcfgq46R4h8706cEKPi1EEYg8my8OgFYLcOT9tu9r5HGxVHwO
        FLDpApC9xTR87IBE2spFeVF0u
X-Received: by 2002:a17:906:4904:: with SMTP id b4mr29488581ejq.174.1637841364377;
        Thu, 25 Nov 2021 03:56:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxy2FXQerCQWL0wz8KKtmO9VIUCLeFCt/3u04ynCT2Qttsffm9/94f9BQjkCB8lwUvJzBQCww==
X-Received: by 2002:a17:906:4904:: with SMTP id b4mr29488392ejq.174.1637841362580;
        Thu, 25 Nov 2021 03:56:02 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ne33sm1507828ejc.6.2021.11.25.03.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 03:56:01 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2A0F21802A0; Thu, 25 Nov 2021 12:56:01 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shay Agroskin <shayagr@amazon.com>,
        Arthur Kiyanovski <akiyano@amazon.com>,
        David Arinzon <darinzon@amazon.com>,
        Noam Dagan <ndagan@amazon.com>,
        Saeed Bishara <saeedb@amazon.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Russell King <linux@armlinux.org.uk>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Edward Cree <ecree.xilinx@gmail.com>,
        Martin Habets <habetsm.xilinx@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Yajun Deng <yajun.deng@linux.dev>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Cong Wang <cong.wang@bytedance.com>, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 net-next 21/26] ice: add XDP and XSK generic
 per-channel statistics
In-Reply-To: <77407c26-4e32-232c-58e0-2d601d781f84@iogearbox.net>
References: <20211123163955.154512-1-alexandr.lobakin@intel.com>
 <20211123163955.154512-22-alexandr.lobakin@intel.com>
 <77407c26-4e32-232c-58e0-2d601d781f84@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 25 Nov 2021 12:56:01 +0100
Message-ID: <87bl28bga6.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Borkmann <daniel@iogearbox.net> writes:

> Hi Alexander,
>
> On 11/23/21 5:39 PM, Alexander Lobakin wrote:
> [...]
>
> Just commenting on ice here as one example (similar applies to other drivers):
>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
>> index 1dd7e84f41f8..7dc287bc3a1a 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
>> @@ -258,6 +258,8 @@ static void ice_clean_xdp_irq(struct ice_tx_ring *xdp_ring)
>>   		xdp_ring->next_dd = ICE_TX_THRESH - 1;
>>   	xdp_ring->next_to_clean = ntc;
>>   	ice_update_tx_ring_stats(xdp_ring, total_pkts, total_bytes);
>> +	xdp_update_tx_drv_stats(&xdp_ring->xdp_stats->xdp_tx, total_pkts,
>> +				total_bytes);
>>   }
>> 
>>   /**
>> @@ -277,6 +279,7 @@ int ice_xmit_xdp_ring(void *data, u16 size, struct ice_tx_ring *xdp_ring)
>>   		ice_clean_xdp_irq(xdp_ring);
>> 
>>   	if (!unlikely(ICE_DESC_UNUSED(xdp_ring))) {
>> +		xdp_update_tx_drv_full(&xdp_ring->xdp_stats->xdp_tx);
>>   		xdp_ring->tx_stats.tx_busy++;
>>   		return ICE_XDP_CONSUMED;
>>   	}
>> diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
>> index ff55cb415b11..62ef47a38d93 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
>> @@ -454,42 +454,58 @@ ice_construct_skb_zc(struct ice_rx_ring *rx_ring, struct xdp_buff **xdp_arr)
>>    * @xdp: xdp_buff used as input to the XDP program
>>    * @xdp_prog: XDP program to run
>>    * @xdp_ring: ring to be used for XDP_TX action
>> + * @lrstats: onstack Rx XDP stats
>>    *
>>    * Returns any of ICE_XDP_{PASS, CONSUMED, TX, REDIR}
>>    */
>>   static int
>>   ice_run_xdp_zc(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
>> -	       struct bpf_prog *xdp_prog, struct ice_tx_ring *xdp_ring)
>> +	       struct bpf_prog *xdp_prog, struct ice_tx_ring *xdp_ring,
>> +	       struct xdp_rx_drv_stats_local *lrstats)
>>   {
>>   	int err, result = ICE_XDP_PASS;
>>   	u32 act;
>> 
>> +	lrstats->bytes += xdp->data_end - xdp->data;
>> +	lrstats->packets++;
>> +
>>   	act = bpf_prog_run_xdp(xdp_prog, xdp);
>> 
>>   	if (likely(act == XDP_REDIRECT)) {
>>   		err = xdp_do_redirect(rx_ring->netdev, xdp, xdp_prog);
>> -		if (err)
>> +		if (err) {
>> +			lrstats->redirect_errors++;
>>   			goto out_failure;
>> +		}
>> +		lrstats->redirect++;
>>   		return ICE_XDP_REDIR;
>>   	}
>> 
>>   	switch (act) {
>>   	case XDP_PASS:
>> +		lrstats->pass++;
>>   		break;
>>   	case XDP_TX:
>>   		result = ice_xmit_xdp_buff(xdp, xdp_ring);
>> -		if (result == ICE_XDP_CONSUMED)
>> +		if (result == ICE_XDP_CONSUMED) {
>> +			lrstats->tx_errors++;
>>   			goto out_failure;
>> +		}
>> +		lrstats->tx++;
>>   		break;
>>   	default:
>>   		bpf_warn_invalid_xdp_action(act);
>> -		fallthrough;
>> +		lrstats->invalid++;
>> +		goto out_failure;
>>   	case XDP_ABORTED:
>> +		lrstats->aborted++;
>>   out_failure:
>>   		trace_xdp_exception(rx_ring->netdev, xdp_prog, act);
>> -		fallthrough;
>> +		result = ICE_XDP_CONSUMED;
>> +		break;
>>   	case XDP_DROP:
>>   		result = ICE_XDP_CONSUMED;
>> +		lrstats->drop++;
>>   		break;
>>   	}
>
> Imho, the overall approach is way too bloated. I can see the
> packets/bytes but now we have 3 counter updates with return codes
> included and then the additional sync of the on-stack counters into
> the ring counters via xdp_update_rx_drv_stats(). So we now need
> ice_update_rx_ring_stats() as well as xdp_update_rx_drv_stats() which
> syncs 10 different stat counters via u64_stats_add() into the per ring
> ones. :/
>
> I'm just taking our XDP L4LB in Cilium as an example: there we already
> count errors and export them via per-cpu map that eventually lead to
> XDP_DROP cases including the /reason/ which caused the XDP_DROP (e.g.
> Prometheus can then scrape these insights from all the nodes in the
> cluster). Given the different action codes are very often application
> specific, there's not much debugging that you can do when /only/
> looking at `ip link xdpstats` to gather insight on *why* some of these
> actions were triggered (e.g. fib lookup failure, etc). If really of
> interest, then maybe libxdp could have such per-action counters as
> opt-in in its call chain..

To me, standardising these counters is less about helping people debug
their XDP programs (as you say, you can put your own telemetry into
those), and more about making XDP less "mystical" to the system
administrator (who may not be the same person who wrote the XDP
programs). So at the very least, they need to indicate "where are the
packets going", which means at least counters for DROP, REDIRECT and TX
(+ errors for tx/redirect) in addition to the "processed by XDP" initial
counter. Which in the above means 'pass', 'invalid' and 'aborted' could
be dropped, I guess; but I don't mind terribly keeping them either given
that there's no measurable performance impact.

> But then it also seems like above in ice_xmit_xdp_ring() we now need
> to bump counters twice just for sake of ethtool vs xdp counters which
> sucks a bit, would be nice to only having to do it once:

This I agree with, and while I can see the layering argument for putting
them into 'ip' and rtnetlink instead of ethtool, I also worry that these
counters will simply be lost in obscurity, so I do wonder if it wouldn't
be better to accept the "layering violation" and keeping them all in the
'ethtool -S' output?

[...]

> +  xdp-channel0-rx_xdp_redirect: 7
> +  xdp-channel0-rx_xdp_redirect_errors: 8
> +  xdp-channel0-rx_xdp_tx: 9
> +  xdp-channel0-rx_xdp_tx_errors: 10
> +  xdp-channel0-tx_xdp_xmit_packets: 11
> +  xdp-channel0-tx_xdp_xmit_bytes: 12
> +  xdp-channel0-tx_xdp_xmit_errors: 13
> +  xdp-channel0-tx_xdp_xmit_full: 14
>
>  From a user PoV to avoid confusion, maybe should be made more clear that the latter refers
> to xsk.

+1, these should probably be xdp-channel0-tx_xsk_* or something like
that...

-Toke

