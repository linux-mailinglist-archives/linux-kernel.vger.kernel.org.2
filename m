Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB4DC38FACF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 08:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhEYGWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 02:22:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39813 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231200AbhEYGWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 02:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621923667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WiJscerR2fDA86UhiPAlFUiqwQShLis3q+i9fxiZJa0=;
        b=bXMkiB0UdFI0UdKuyoHbJx7JHR5whw1fBjJn9thITlbJXaFxijlDJB8vziizQ7bs6GMsN8
        ThdTWj7hXfM5DUj1psAyxoYzzpvmhGl7dxTWqUJENtnBx11KmhBFYT0kezCiL7sACPJBFR
        hqjK11DskJlqLDKqjtZfy4ccU1K2GfU=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-yFlsw3d5N1S2uQrZQb0K8Q-1; Tue, 25 May 2021 02:21:04 -0400
X-MC-Unique: yFlsw3d5N1S2uQrZQb0K8Q-1
Received: by mail-pl1-f200.google.com with SMTP id o19-20020a170902e293b02900ef869214f9so14255450plc.18
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 23:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=WiJscerR2fDA86UhiPAlFUiqwQShLis3q+i9fxiZJa0=;
        b=hjEI5Bf9I3/CB6yeF4dWSddHOQ8f8nCb6FTYe7BqnRZi3zqCnjl9NCV9boLhkOv+tB
         GF7AWenfLLFr8/NR01glo4z3LyL26gF9T2B6UE7HH3KBkddUHIJz3GFx91UjN8do7EEW
         BeYky4tsqv7166zKSTbsif89Q+W8LZ07PHvG0Mcv0r4KPJWndav+UdXhOEFF/Fl7FdSb
         oiqhWC/Artl+zN+Jhaa3bXTZwc/Ti5JqQfk7X4/y4GhXFQoOrFfmg47eodZBZx1wzaam
         66Ix0iLnsNi8ILFU3LdZ6+AS8wd9jOF3qmtH6N1Mn2jtq1q60+9L+J36F3hvG8jZikG8
         xUXA==
X-Gm-Message-State: AOAM531gA7Ef+tyILJIco1zJOxuM8C7c9HMDaXjJytFpzGa7eX6wYacJ
        EBtWz01tA3BBkTd/xIbl9wymITo4EsSRveihwFUel2DSOtJ/hNGEbNNG8nrWVo1svveFcxDM9y4
        z10pJ9pKBkSbtmkXAKtLeMEukgebUmtUxAtN5GsOmawn9gX2yOsuLw8v1cboSanyauxZWfaCnEl
        gU
X-Received: by 2002:a17:902:f68f:b029:ef:919c:39f2 with SMTP id l15-20020a170902f68fb02900ef919c39f2mr29354322plg.41.1621923663295;
        Mon, 24 May 2021 23:21:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/AkdQfofCrwVKmLTvITcgxgLRS3oscM8uQK+fg65jRMq4L1+zD/Skixv+Y2qe5pD9dBgdgg==
X-Received: by 2002:a17:902:f68f:b029:ef:919c:39f2 with SMTP id l15-20020a170902f68fb02900ef919c39f2mr29354294plg.41.1621923662926;
        Mon, 24 May 2021 23:21:02 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id g4sm13261878pgu.46.2021.05.24.23.21.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 23:21:02 -0700 (PDT)
Subject: Re: [PATCH] virtio-blk: Fix memory leak among suspend/resume
 procedure
To:     Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
        stefanha@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210517084332.280-1-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <80e28363-4ee6-ab9f-90d9-f24e38e360da@redhat.com>
Date:   Tue, 25 May 2021 14:20:58 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210517084332.280-1-xieyongji@bytedance.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/5/17 ÏÂÎç4:43, Xie Yongji Ð´µÀ:
> The vblk->vqs should be freed before we call init_vqs()
> in virtblk_restore().
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   drivers/block/virtio_blk.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 367a1e929d7c..d24a8cea9aab 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -948,6 +948,8 @@ static int virtblk_freeze(struct virtio_device *vdev)
>   	blk_mq_quiesce_queue(vblk->disk->queue);
>   
>   	vdev->config->del_vqs(vdev);
> +	kfree(vblk->vqs);
> +
>   	return 0;
>   }
>   

