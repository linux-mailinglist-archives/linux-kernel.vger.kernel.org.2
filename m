Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCAC3CF478
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 08:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235620AbhGTFpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 01:45:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25975 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232191AbhGTFo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 01:44:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626762337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+pFjrkcG2ZRzROzSDXE/qK9WLlZjt36K6e23WeKajZ8=;
        b=cfEzMyi4dscivap6mZVQ4CYHeSuu/QvSwU+v+ncbOTvPfbMyG7o4VNOXdzVToTHF2Krw4h
        nR2WIewAC3V380eEeWMjma+PgViEwVPofS6XSIxTInaYIbg3eKARlcyGvggWqO60GdVBxH
        a5zpDokfKyC0bdFWcZvCq/Jgy/tLvo4=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-ubu1EMiaNamr5XmWoh33mA-1; Tue, 20 Jul 2021 02:25:36 -0400
X-MC-Unique: ubu1EMiaNamr5XmWoh33mA-1
Received: by mail-pf1-f200.google.com with SMTP id x130-20020a627c880000b0290332acd337a6so12947153pfc.23
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 23:25:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+pFjrkcG2ZRzROzSDXE/qK9WLlZjt36K6e23WeKajZ8=;
        b=q13O5+Sef+oVMfbQhZ7UC+hjbeSRjJ3nCtr5xXeagNH53BZVd27ZioeWVZLysdb9gy
         Av/84ohpMpIUNERD/ZQoZAJnwGRAwSlwFvo0vACmOjTUO/KbXPdljYSlfOjXD1pNqBQD
         tswpsX1i0QlLakVn6NIBDUUADfyDDnV4n3GW5mD1G7EmDZFZGsntswigr98s+3RnpqAE
         je8pKLBSgGNLDRbXnMhRdpcY2dE79GNceYm+edFupDQUnWnPQiZs0X6b+JqKdTD2zBGb
         1rIeiOxLLBtT+XuCxvh/PY5HjLFH3HynYQZVMmHLB0Hyr+XxLTtmHEDJw9hbHsPWuU+9
         RhoA==
X-Gm-Message-State: AOAM531ykZjx4AjbNlWoQ5UpZU1F+yrONfl8Phex8TNLJqTeLrc0skd+
        z83vMclBleJ3WTxwKmGCLceSG0jhcnAEYWOSqbCFDhjPO6r7yBwHyC0AKTMYJA7xQw90ZWMwPnZ
        3sx2hwjTRW0n0e1xN535vnJ11dOb4dNFH/Z2QXK9LvX+EBjfq6TRUXVfyBxQkoRJSK9gp8fe4gC
        zJ
X-Received: by 2002:a63:2041:: with SMTP id r1mr14924126pgm.59.1626762334990;
        Mon, 19 Jul 2021 23:25:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJFTlgkaKXwIn+1kT2a5RmA050X86XDvyy0tTwV3OcM/kDFkzn7QDPYu1L0FUL3OWMF00cPA==
X-Received: by 2002:a63:2041:: with SMTP id r1mr14924097pgm.59.1626762334630;
        Mon, 19 Jul 2021 23:25:34 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d13sm21831104pfn.136.2021.07.19.23.25.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 23:25:34 -0700 (PDT)
Subject: Re: [PATCH] vsock/virtio: set vsock frontend ready in
 virtio_vsock_probe()
To:     Xianting Tian <tianxianting.txt@linux.alibaba.com>,
        stefanha@redhat.com, sgarzare@redhat.com, davem@davemloft.net,
        kuba@kernel.org
Cc:     kvm@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210720034039.1351-1-tianxianting.txt@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <9a790a52-8f14-1a9a-51e0-9c35a03d33dd@redhat.com>
Date:   Tue, 20 Jul 2021 14:25:29 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210720034039.1351-1-tianxianting.txt@linux.alibaba.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/7/20 ÉÏÎç11:40, Xianting Tian Ð´µÀ:
> Add the missed virtio_device_ready() to set vsock frontend ready.
>
> Signed-off-by: Xianting Tian <tianxianting.txt@linux.alibaba.com>
> ---
>   net/vmw_vsock/virtio_transport.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> index e0c2c992a..eb4c607c4 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -637,6 +637,8 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
>   	vdev->priv = vsock;
>   	rcu_assign_pointer(the_virtio_vsock, vsock);
>   
> +	virtio_device_ready(vdev);
> +
>   	mutex_unlock(&the_virtio_vsock_mutex);


It's better to do this after the mutex.

Thanks


>   
>   	return 0;

