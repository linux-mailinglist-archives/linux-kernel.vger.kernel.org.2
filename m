Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3A345295A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 06:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbhKPFEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 00:04:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27152 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237217AbhKPFEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 00:04:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637038864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NZbJVFSsiYxk6JEYO0Xpu55G92qAXMwmH+tm+8XpReU=;
        b=AxtLH/8vHIUJ3uoKaIj3dRD5pDN39ed/qKFYiIYwBVAb3cUlr4n8NreW15bHlprCVzZHuU
        CljWU1dPEkKsUSVmS/DxwZVIAsJXXETChTwCMlHmY7DUhMce5bMEUmaX7Qc6tKt1BJcTh9
        Sju7aCV3M/1JLuBnh/rnWbAfJa/jZ2c=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-OEoMW5oVMYquo_cG0GiOrw-1; Tue, 16 Nov 2021 00:01:02 -0500
X-MC-Unique: OEoMW5oVMYquo_cG0GiOrw-1
Received: by mail-lf1-f69.google.com with SMTP id n18-20020a0565120ad200b004036c43a0ddso7730159lfu.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 21:01:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NZbJVFSsiYxk6JEYO0Xpu55G92qAXMwmH+tm+8XpReU=;
        b=mjMHBY0gTyR86Blui6ewXLqBMV3CitP+DLBwwPp40ZWGaKYlY2Q+UcN6eDWV4+P9nx
         UPR6esq0lotOwpqrxX+uo6NKiwJbUM7tSQpm/6Gg8WjL0AMXTwF81iA34C7zjHxIAZJD
         XqRQqtudwkIQx0qSFQk3Pq+7QCuxZlvNR5+0a6uhFOGbWRefZe62cy+gil7cmaIGvTbZ
         7rtQNGOmKMvIdZcVtMVr53zolK66drGfYz23vWMioHZr29c6H4L2J7YZkDGDcOY8B2XB
         stI2mvnDgydJYyXkbKavKGWTfRPE84bW9P3lLet/p+b6VeRVuwu/mbV1OEDBFmyuYbhh
         3y/g==
X-Gm-Message-State: AOAM533Y2y459w/zZDEVcjjUYkuZBwkI0oXKwsReJjxuWTv1o0iE7C9O
        hvY+emuHenlDLnMIOLeeHfAs4aG9v9hEelTcgabW0ZvFhyEMT3k1nIiMp0NP6AJ/ERc0bqbwKgg
        cz/XhV8JMBB9SeQzbRUgKI8qDHFIBIx7G+1Un5QVb
X-Received: by 2002:ac2:518b:: with SMTP id u11mr3980765lfi.498.1637038861127;
        Mon, 15 Nov 2021 21:01:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwmwi8ZBJDwkdhthf+6U7z0+K409Zl2U1G1z4cKoLh4WJGn9JeAOqnszcmQh+p5V5nQXwNj+ySZvlSCNDXcV2U=
X-Received: by 2002:ac2:518b:: with SMTP id u11mr3980732lfi.498.1637038860836;
 Mon, 15 Nov 2021 21:01:00 -0800 (PST)
MIME-Version: 1.0
References: <20211115153003.9140-1-arbn@yandex-team.com> <20211115153003.9140-6-arbn@yandex-team.com>
In-Reply-To: <20211115153003.9140-6-arbn@yandex-team.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 16 Nov 2021 13:00:50 +0800
Message-ID: <CACGkMEumax9RFVNgWLv5GyoeQAmwo-UgAq=DrUd4yLxPAUUqBw@mail.gmail.com>
Subject: Re: [PATCH 6/6] vhost_net: use RCU callbacks instead of synchronize_rcu()
To:     Andrey Ryabinin <arbn@yandex-team.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        kvm <kvm@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 11:32 PM Andrey Ryabinin <arbn@yandex-team.com> wrote:
>
> Currently vhost_net_release() uses synchronize_rcu() to synchronize
> freeing with vhost_zerocopy_callback(). However synchronize_rcu()
> is quite costly operation. It take more than 10 seconds
> to shutdown qemu launched with couple net devices like this:
>         -netdev tap,id=tap0,..,vhost=on,queues=80
> because we end up calling synchronize_rcu() netdev_count*queues times.
>
> Free vhost net structures in rcu callback instead of using
> synchronize_rcu() to fix the problem.

I admit the release code is somehow hard to understand. But I wonder
if the following case can still happen with this:

CPU 0 (vhost_dev_cleanup)   CPU1
(vhost_net_zerocopy_callback()->vhost_work_queue())
                                                if (!dev->worker)
dev->worker = NULL

wake_up_process(dev->worker)

If this is true. It seems the fix is to move RCU synchronization stuff
in vhost_net_ubuf_put_and_wait()?

Thanks

>
> Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
> ---
>  drivers/vhost/net.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 97a209d6a527..0699d30e83d5 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -132,6 +132,7 @@ struct vhost_net {
>         struct vhost_dev dev;
>         struct vhost_net_virtqueue vqs[VHOST_NET_VQ_MAX];
>         struct vhost_poll poll[VHOST_NET_VQ_MAX];
> +       struct rcu_head rcu;
>         /* Number of TX recently submitted.
>          * Protected by tx vq lock. */
>         unsigned tx_packets;
> @@ -1389,6 +1390,18 @@ static void vhost_net_flush(struct vhost_net *n)
>         }
>  }
>
> +static void vhost_net_free(struct rcu_head *rcu_head)
> +{
> +       struct vhost_net *n = container_of(rcu_head, struct vhost_net, rcu);
> +
> +       kfree(n->vqs[VHOST_NET_VQ_RX].rxq.queue);
> +       kfree(n->vqs[VHOST_NET_VQ_TX].xdp);
> +       kfree(n->dev.vqs);
> +       if (n->page_frag.page)
> +               __page_frag_cache_drain(n->page_frag.page, n->refcnt_bias);
> +       kvfree(n);
> +}
> +
>  static int vhost_net_release(struct inode *inode, struct file *f)
>  {
>         struct vhost_net *n = f->private_data;
> @@ -1404,15 +1417,8 @@ static int vhost_net_release(struct inode *inode, struct file *f)
>                 sockfd_put(tx_sock);
>         if (rx_sock)
>                 sockfd_put(rx_sock);
> -       /* Make sure no callbacks are outstanding */
> -       synchronize_rcu();
>
> -       kfree(n->vqs[VHOST_NET_VQ_RX].rxq.queue);
> -       kfree(n->vqs[VHOST_NET_VQ_TX].xdp);
> -       kfree(n->dev.vqs);
> -       if (n->page_frag.page)
> -               __page_frag_cache_drain(n->page_frag.page, n->refcnt_bias);
> -       kvfree(n);
> +       call_rcu(&n->rcu, vhost_net_free);
>         return 0;
>  }
>
> --
> 2.32.0
>

