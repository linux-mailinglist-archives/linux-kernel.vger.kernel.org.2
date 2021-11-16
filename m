Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92449453441
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 15:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237442AbhKPOgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 09:36:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30441 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237383AbhKPOg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 09:36:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637073210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e5bI5miZtE31XzDT/uNmoUa6s8KHDiRkZC5V/D8t8c4=;
        b=UOYRE8exzC2Dbx6acKkzgOvYsnzDcRN2RBqllD0V7i/svsQ36DT6kPnDtuuesk6+5GMaRJ
        DjoG1FXPfUc4bnl+dP+1Mmp/J/Uo0JAoPzp7q5vJhA1pNoyyDNm4O0wxiC6HZAGIgKR92u
        AHTGxg4wx/jOnI3fiaM0BeXQXbWKp6U=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-6-bQt7NwFpO8GRM8VpBvC9qg-1; Tue, 16 Nov 2021 09:33:29 -0500
X-MC-Unique: bQt7NwFpO8GRM8VpBvC9qg-1
Received: by mail-ed1-f72.google.com with SMTP id y9-20020aa7c249000000b003e7bf7a1579so5974967edo.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 06:33:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e5bI5miZtE31XzDT/uNmoUa6s8KHDiRkZC5V/D8t8c4=;
        b=0D499+shUUa3zd1OAGjwmg1ZTCdPx3ccM53alWCms/0JHVbVaFtyNeAoPb90CDvgVT
         vzeMv+ZnRFpyNdWR/Es2Vh/f2DRRBGp5rvjN+++U1uNjCQFLoqz5h/+XS5ZHFYNfE06q
         YaE2Q745+eqp+vff8Gqd/qJHnKkMiA9EZkJ8FxNdCViOdfIAXn+/tFbO+cFnspOmwo3q
         p64pp6psIcm4CxIm2u/jUXkkCoshsfCHULEfuC6NlAdwLQM6fqDB3eArWVzoXpcT2meD
         rnEEq0zNcsSJ2BQAJrTPTJ/7RVFhhpIUnGDUtQ5Dz2mTifJ8ECFbUnrr5gj1b6EfRLok
         IShw==
X-Gm-Message-State: AOAM532hCq3K4fElkIxS8lAnlPc7NDOkOU9RZMc/OOp4dXbxLVI90IFK
        JivuUotkJ69VNoBGk+In+w/zRV4tLglGyYQaU1En5pQA5tJUXYuoAW4nHJhQ5CnrkkpelmQmc2P
        o4u1QxJbK+oIJaHPFvjf9Fw8H
X-Received: by 2002:a05:6402:4255:: with SMTP id g21mr10631425edb.256.1637073207834;
        Tue, 16 Nov 2021 06:33:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwc5owemSfBUpNeotKB3UAbjc+AN7gGsaiauGNpfHdqICsObV5qFX6XIBKC3Eh9ctsxyL6amg==
X-Received: by 2002:a05:6402:4255:: with SMTP id g21mr10631390edb.256.1637073207612;
        Tue, 16 Nov 2021 06:33:27 -0800 (PST)
Received: from steredhat (host-87-10-72-39.retail.telecomitalia.it. [87.10.72.39])
        by smtp.gmail.com with ESMTPSA id jx10sm4918812ejc.102.2021.11.16.06.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 06:33:27 -0800 (PST)
Date:   Tue, 16 Nov 2021 15:33:23 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Andrey Ryabinin <arbn@yandex-team.com>,
        Mike Christie <michael.christie@oracle.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] vhost: get rid of vhost_poll_flush() wrapper
Message-ID: <20211116143323.g7c27u2ho4vpp4cp@steredhat>
References: <20211115153003.9140-1-arbn@yandex-team.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20211115153003.9140-1-arbn@yandex-team.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 06:29:58PM +0300, Andrey Ryabinin wrote:
>vhost_poll_flush() is a simple wrapper around vhost_work_dev_flush().
>It gives wrong impression that we are doing some work over vhost_poll,
>while in fact it flushes vhost_poll->dev.
>It only complicate understanding of the code and leads to mistakes
>like flushing the same vhost_dev several times in a row.
>
>Just remove vhost_poll_flush() and call vhost_work_dev_flush() directly.
>
>Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
>---
> drivers/vhost/net.c   |  4 ++--
> drivers/vhost/test.c  |  2 +-
> drivers/vhost/vhost.c | 12 ++----------
> drivers/vhost/vsock.c |  2 +-
> 4 files changed, 6 insertions(+), 14 deletions(-)

Adding Mike since these changes could be relevant for "[PATCH V4 00/12] 
vhost: multiple worker support" [1] series.

>
>diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
>index 28ef323882fb..11221f6d11b8 100644
>--- a/drivers/vhost/net.c
>+++ b/drivers/vhost/net.c
>@@ -1375,8 +1375,8 @@ static void vhost_net_stop(struct vhost_net *n, struct socket **tx_sock,
>
> static void vhost_net_flush_vq(struct vhost_net *n, int index)
> {
>-	vhost_poll_flush(n->poll + index);
>-	vhost_poll_flush(&n->vqs[index].vq.poll);
>+	vhost_work_dev_flush(n->poll[index].dev);
>+	vhost_work_dev_flush(n->vqs[index].vq.poll.dev);
> }
>
> static void vhost_net_flush(struct vhost_net *n)
>diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
>index a09dedc79f68..1a8ab1d8cb1c 100644
>--- a/drivers/vhost/test.c
>+++ b/drivers/vhost/test.c
>@@ -146,7 +146,7 @@ static void vhost_test_stop(struct vhost_test *n, void **privatep)
>
> static void vhost_test_flush_vq(struct vhost_test *n, int index)
> {
>-	vhost_poll_flush(&n->vqs[index].poll);
>+	vhost_work_dev_flush(n->vqs[index].poll.dev);
> }
>
> static void vhost_test_flush(struct vhost_test *n)
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 59edb5a1ffe2..ca088481da0e 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -245,14 +245,6 @@ void vhost_work_dev_flush(struct vhost_dev *dev)
> }
> EXPORT_SYMBOL_GPL(vhost_work_dev_flush);
>
>-/* Flush any work that has been scheduled. When calling this, don't hold any
>- * locks that are also used by the callback. */
>-void vhost_poll_flush(struct vhost_poll *poll)
>-{
>-	vhost_work_dev_flush(poll->dev);
>-}
>-EXPORT_SYMBOL_GPL(vhost_poll_flush);
>-

We should remove also the declaration in vhost.h:

--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -45,7 +44,6 @@ void vhost_poll_init(struct vhost_poll *poll, vhost_work_fn_t fn,
                      __poll_t mask, struct vhost_dev *dev);
  int vhost_poll_start(struct vhost_poll *poll, struct file *file);
  void vhost_poll_stop(struct vhost_poll *poll);
-void vhost_poll_flush(struct vhost_poll *poll);
  void vhost_poll_queue(struct vhost_poll *poll);
  void vhost_work_dev_flush(struct vhost_dev *dev);


> void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
> {
> 	if (!dev->worker)
>@@ -663,7 +655,7 @@ void vhost_dev_stop(struct vhost_dev *dev)
> 	for (i = 0; i < dev->nvqs; ++i) {
> 		if (dev->vqs[i]->kick && dev->vqs[i]->handle_kick) {
> 			vhost_poll_stop(&dev->vqs[i]->poll);
>-			vhost_poll_flush(&dev->vqs[i]->poll);
>+			vhost_work_dev_flush(dev->vqs[i]->poll.dev);
> 		}
> 	}
> }
>@@ -1712,7 +1704,7 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
> 	mutex_unlock(&vq->mutex);
>
> 	if (pollstop && vq->handle_kick)
>-		vhost_poll_flush(&vq->poll);
>+		vhost_work_dev_flush(vq->poll.dev);
> 	return r;
> }
> EXPORT_SYMBOL_GPL(vhost_vring_ioctl);
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 938aefbc75ec..b0361ebbd695 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -711,7 +711,7 @@ static void vhost_vsock_flush(struct vhost_vsock *vsock)
>
> 	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++)
> 		if (vsock->vqs[i].handle_kick)
>-			vhost_poll_flush(&vsock->vqs[i].poll);
>+			vhost_work_dev_flush(vsock->vqs[i].poll.dev);
> 	vhost_work_dev_flush(&vsock->dev);
> }
>
>-- 
>2.32.0
>

The rest LGTM.

Thanks,
Stefano

[1] 
https://lore.kernel.org/virtualization/20211104190502.7053-1-michael.christie@oracle.com/

