Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E139379FF4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 08:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhEKGsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 02:48:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22896 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230251AbhEKGsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 02:48:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620715667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XGT3PCvhdMF1ySAiULwwXSWctoW1fgtrGIWAnzk21Yk=;
        b=iHrdbDbHve6wSjyKc5K1C6Ck0AiOif8IO6cPiFms6KdG/foq+5AIVUTrNUFyTuB9hoM9KN
        Yh56IEUw9c1srU6TXeQkwzB109O+Qq7QpxGERgArebe3GV0mtcR049qiHzyaQiAbLJHQpR
        6opCd2zZUd980NjWnbqRRzrgBlsRxFM=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204--lPkGFx3N4SbFBgqJDcwcg-1; Tue, 11 May 2021 02:47:45 -0400
X-MC-Unique: -lPkGFx3N4SbFBgqJDcwcg-1
Received: by mail-pf1-f200.google.com with SMTP id 125-20020a6215830000b029028ef0e94e38so12318033pfv.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 23:47:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=XGT3PCvhdMF1ySAiULwwXSWctoW1fgtrGIWAnzk21Yk=;
        b=L1uE/xGKpDB0ULIot+Bijcp/g+AxZ5oWm3vakkyflr2z0WuYy5wAkOC+SkIW6DoO3K
         TmbcOLNSenjqBDUYx2yF5crUMzeJDyQCWE4Scynj5BPa/1s7bs9p/H0g4/pXa4iT/W4J
         EnrBRz2HowBMadB1CPY19VLju72Ke7ywl2ppAXxfrqSCVilunQ5kZ5Uipe4VD+UzylVE
         i3/mt7BLdyp1scNxwMTkmvbqA2Rri1Cs3D9MMgk+FeOhlTVKJWepqLLSSekZXiGeyi6h
         lempwag1XbSpsWO1zJWDH7HGl8NQmmJ3Mu2QPdLkhXn5qRaVGV99I/sYaZx5lGzTKnC5
         g88Q==
X-Gm-Message-State: AOAM533AmDXMkIrBNfUOm9PZgjGj2JU3KLz8iNneOscN0zOnA/fYO+q6
        ucOIAVHWcXfybNLhC+U8jF8zfetJgXJzxlm6FkDUpGRuMDuBUT+fYVxVdNEmkQzMYW3zvp7D5Qn
        Z54OM+DZCLGRYLzgKrDq10Pp4
X-Received: by 2002:a63:175e:: with SMTP id 30mr29171619pgx.48.1620715664814;
        Mon, 10 May 2021 23:47:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvwbj9SMbJvN2l/IkE6Fv7+EyyvfRZyr3PmFk8lIByMWRMcgD0FGP+VR5/y5nomzefatXMaQ==
X-Received: by 2002:a63:175e:: with SMTP id 30mr29171606pgx.48.1620715664592;
        Mon, 10 May 2021 23:47:44 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id h15sm12760024pfk.26.2021.05.10.23.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 23:47:44 -0700 (PDT)
Subject: Re: [PATCH 2/4] virtio-net: add support of UDP segmentation (USO) on
 the host
To:     Yuri Benditovich <yuri.benditovich@daynix.com>,
        davem@davemloft.net, kuba@kernel.org, mst@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     yan@daynix.com
References: <20210511044253.469034-1-yuri.benditovich@daynix.com>
 <20210511044253.469034-3-yuri.benditovich@daynix.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <0e31ea70-f12a-070e-c72b-6e1d337a89bc@redhat.com>
Date:   Tue, 11 May 2021 14:47:39 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210511044253.469034-3-yuri.benditovich@daynix.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/5/11 ÏÂÎç12:42, Yuri Benditovich Ð´µÀ:
> Large UDP packet provided by the guest with GSO type set to
> VIRTIO_NET_HDR_GSO_UDP_L4 will be divided to several UDP
> packets according to the gso_size field.
>
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> ---
>   include/linux/virtio_net.h | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index b465f8f3e554..4ecf9a1ca912 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -51,6 +51,11 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
>   			ip_proto = IPPROTO_UDP;
>   			thlen = sizeof(struct udphdr);
>   			break;
> +		case VIRTIO_NET_HDR_GSO_UDP_L4:
> +			gso_type = SKB_GSO_UDP_L4;
> +			ip_proto = IPPROTO_UDP;
> +			thlen = sizeof(struct udphdr);
> +			break;


This is only for rx, how about tx?

Thanks



>   		default:
>   			return -EINVAL;
>   		}

