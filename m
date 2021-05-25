Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B2F38F767
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 03:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhEYBOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 21:14:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37016 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229555AbhEYBOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 21:14:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621905187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UBzLgDtqavpwimWGiZi7MD4QY+93E8r07zUbXutzxWU=;
        b=hlqdVbkJ0yiboBKs/nJyrG4gvp++R0/uWTIdm/3LCgptpv+70tq/0bGFXpSetce8q0BIqs
        Z0A8KGZfa+mwptA9DiZUs+fOz8EzZBLDvjWY3rey66ceV4t+19nsKHC49NPZgECmt1sq1P
        8Zs4N1uFTAYL3LdtflNSI9EIIg62U5o=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-2u-zoZkGNjOK4syY6NOVvQ-1; Mon, 24 May 2021 21:13:05 -0400
X-MC-Unique: 2u-zoZkGNjOK4syY6NOVvQ-1
Received: by mail-pj1-f70.google.com with SMTP id c13-20020a17090aa60db029015c73ea2ce5so15153029pjq.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 18:13:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=UBzLgDtqavpwimWGiZi7MD4QY+93E8r07zUbXutzxWU=;
        b=f3DcN3owxHafDW9bKFP0CZdymyKewXcw+chEu2XEjzu4AJ4HxoI8CsfOeC4ygt4OAi
         jVnQ1ZAi3UAu1jM0L96Ayg0AuHtC+xZdJYoe7KqZejxiQrksdydgbbVH1+US0v3YdCx8
         Z4yHSJcYVnKc2OrI78lCllf3fwNRzPAThOINLml1pukTJgILWrERoL4KyBIysEn5ukRk
         ZkC/wi96OHOT2DA0pFN099CD2wQjndiM64+PBlb7D3vJcv+YKqn7E7GUqH6ZfkZxjnhQ
         naRlY7Gikp8CH7jq8h7bryhLf9ekXcLJ0NUIjjZ3EcacBggLtL+wjmZ7ujZ96ojCEUWt
         qoGA==
X-Gm-Message-State: AOAM530wDxeXRBgHO8zK2L2HeI2R0O48NTj+2oKm5M/xnUzSl4CLEqwD
        r3pCb0tGmlQCsySTgnb0C0sfizVo5IU++k7mv/6GUjM8UNL8B8bPue8fvbRCGhjH+HpHp5Z02nD
        ahs3Z2sFe/gIivMC7t8mNc5LZ
X-Received: by 2002:a63:ed41:: with SMTP id m1mr16325190pgk.252.1621905184668;
        Mon, 24 May 2021 18:13:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6D+XOATiRb+OS1/ThQcY+LFli2pfGqzdPD1APVDzJx1s8GwA9GrRbRoA7EMCbeWMP3l95kw==
X-Received: by 2002:a63:ed41:: with SMTP id m1mr16325169pgk.252.1621905184388;
        Mon, 24 May 2021 18:13:04 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 204sm11729687pfy.56.2021.05.24.18.13.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 18:13:03 -0700 (PDT)
Subject: Re: [PATCH -next] virtio_ring: Correct function name
 virtqueue_get_buf_ctx()
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     mst@redhat.com
References: <20210518050057.614081-1-yangyingliang@huawei.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <d5e348da-6101-9ead-f675-387db8c90844@redhat.com>
Date:   Tue, 25 May 2021 09:12:56 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210518050057.614081-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/5/18 ÏÂÎç1:00, Yang Yingliang Ð´µÀ:
> Fix the following make W=1 kernel build warning:
>
>    drivers/virtio/virtio_ring.c:1903: warning: expecting prototype for virtqueue_get_buf(). Prototype was for virtqueue_get_buf_ctx() instead
>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>   drivers/virtio/virtio_ring.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 88f0b16b11b8..992cb1cbec93 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1882,7 +1882,7 @@ bool virtqueue_kick(struct virtqueue *vq)
>   EXPORT_SYMBOL_GPL(virtqueue_kick);
>   
>   /**
> - * virtqueue_get_buf - get the next used buffer
> + * virtqueue_get_buf_ctx - get the next used buffer
>    * @_vq: the struct virtqueue we're talking about.
>    * @len: the length written into the buffer
>    * @ctx: extra context for the token


Acked-by: Jason Wang <jasowang@redhat.com>


