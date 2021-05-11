Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA336379FEE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 08:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbhEKGsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 02:48:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56971 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229807AbhEKGsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 02:48:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620715634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sx7nPbuFzoppkZ1L0KO8BbiXNbbmx+wsvBNBIIout20=;
        b=btVnUcTRzN4F5T8aFEug+6NV/v3dxNifo4+X5ti68jrwUgK7WTBktJHCsj35TiM77KYWqw
        oF6+gAM0AGoic+YLTTWzHItSWb8grXwyk8WglKmZ7GMqmSeH/h1AFmRvAcWn5c/PVHYfq1
        mQ2PZJsS4AAPPrH77jpX+BL7WRLub9E=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-O_vXHJAIPSGuNzDEJerd1w-1; Tue, 11 May 2021 02:47:13 -0400
X-MC-Unique: O_vXHJAIPSGuNzDEJerd1w-1
Received: by mail-pl1-f197.google.com with SMTP id x7-20020a1709027c07b02900e6489d6231so7160693pll.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 23:47:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=sx7nPbuFzoppkZ1L0KO8BbiXNbbmx+wsvBNBIIout20=;
        b=EqnAImzYKZJ20uPFo8qvW1xDCTJnhEVl0YLwX62Qv3L6Shv3AWkFHmTmRja0TleVY4
         wca5Y11C3TV16lFghLbGg1K+AMpxww5QiqbvKT6HcJIlEHAr1Yj3p+lo/UFHTuOt2jGS
         8UFHmyiUkOgdt5nwEMOiLbZjXKlq9mnrgVo+IX03jefTH3cmTjpeoznTipbvu12xvyeC
         6BJ0/mLP+MqU1I6HPw9Wf3rgICqWWYR81V4JOryILdGWtr1IeM5l/0WyzDttmumTxQ3o
         qDx0A4bnRcePqNVouoSuzzRjLsGCj5SB4R1ToUTogWXk9Kpjmn5TZGpVYiX0SU4JNJsA
         xamg==
X-Gm-Message-State: AOAM530MZig9+CJ76DxaxOFPtXO0ui2POg0ZMUojnTd05r7CJC9iqoLL
        jrbsDpmjvNkgvCc9jcvq9XWUqaIbypTZNk47sPlVuUOhgQhNkGVhXLjzhSnwkqYoNDYfFg/HF1E
        AxwvJ30VMKidm9tbJtgrHETRD
X-Received: by 2002:a63:4a44:: with SMTP id j4mr28981020pgl.283.1620715631786;
        Mon, 10 May 2021 23:47:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4Y68wI4Mxy05AHpRaptwpa5l3QU8whi/1YTywzoMGIWFR/WITTxyH3t+IdjkN5CZAtIhfpw==
X-Received: by 2002:a63:4a44:: with SMTP id j4mr28981001pgl.283.1620715631488;
        Mon, 10 May 2021 23:47:11 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id ml19sm1607366pjb.2.2021.05.10.23.47.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 23:47:10 -0700 (PDT)
Subject: Re: [PATCH 1/4] virtio-net: add definitions for host USO feature
To:     Yuri Benditovich <yuri.benditovich@daynix.com>,
        davem@davemloft.net, kuba@kernel.org, mst@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     yan@daynix.com
References: <20210511044253.469034-1-yuri.benditovich@daynix.com>
 <20210511044253.469034-2-yuri.benditovich@daynix.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <40938c20-5851-089b-c3c0-074bbd636970@redhat.com>
Date:   Tue, 11 May 2021 14:47:02 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210511044253.469034-2-yuri.benditovich@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/5/11 下午12:42, Yuri Benditovich 写道:
> Define feature bit and GSO type according to the VIRTIO
> specification.
>
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> ---
>   include/uapi/linux/virtio_net.h | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> index 3f55a4215f11..a556ac735d7f 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -57,6 +57,7 @@
>   					 * Steering */
>   #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
>   
> +#define VIRTIO_NET_F_HOST_USO     56	/* Host can handle USO packets */
>   #define VIRTIO_NET_F_HASH_REPORT  57	/* Supports hash report */
>   #define VIRTIO_NET_F_RSS	  60	/* Supports RSS RX steering */
>   #define VIRTIO_NET_F_RSC_EXT	  61	/* extended coalescing info */
> @@ -130,6 +131,7 @@ struct virtio_net_hdr_v1 {
>   #define VIRTIO_NET_HDR_GSO_TCPV4	1	/* GSO frame, IPv4 TCP (TSO) */
>   #define VIRTIO_NET_HDR_GSO_UDP		3	/* GSO frame, IPv4 UDP (UFO) */
>   #define VIRTIO_NET_HDR_GSO_TCPV6	4	/* GSO frame, IPv6 TCP */
> +#define VIRTIO_NET_HDR_GSO_UDP_L4	5	/* GSO frame, IPv4 UDP (USO) */


This is the gso_type not the feature actually.

I wonder what's the reason for not

1) introducing a dedicated virtio-net feature bit for this 
(VIRTIO_NET_F_GUEST_GSO_UDP_L4.
2) toggle the NETIF_F_GSO_UDP_L4  feature for tuntap based on the 
negotiated feature.

Thanks


>   #define VIRTIO_NET_HDR_GSO_ECN		0x80	/* TCP has ECN set */
>   	__u8 gso_type;
>   	__virtio16 hdr_len;	/* Ethernet + IP + tcp/udp hdrs */

