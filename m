Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4FA3107C0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 10:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhBEJXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 04:23:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48326 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230153AbhBEJSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 04:18:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612516617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=57F239YtV0oHbCCj5J8DpWnEViN3tCKhKGovQyK+Lic=;
        b=ZzTPajMUgqW5xYX//MobQ/+xEIQNbQ2VWZ4IwSZwkV+jq4KgbNoxSxrjcDVb6MAHjcndBh
        LNzb2pK8TnuLb8Zoh6mDAvxIFK2jvmgzNfufEz3vQnKwOJRckHwnlhApVml1GDZ55OUqgx
        98tAqUUdJb9gDzGrl7bTVFDBzTwhsKI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-xWUnxE-gNEm18Y6ch7tOwg-1; Fri, 05 Feb 2021 04:16:55 -0500
X-MC-Unique: xWUnxE-gNEm18Y6ch7tOwg-1
Received: by mail-wr1-f71.google.com with SMTP id l7so4943593wrp.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 01:16:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=57F239YtV0oHbCCj5J8DpWnEViN3tCKhKGovQyK+Lic=;
        b=qaT/ViU51IUNeHaX5lJH7dwWxByN3oy6Xt08rchgnno/zK7eELQyhQ82406Vvnjnvf
         JuwiSFlILd5aajQos+dS+k52lQ6B01AGLd6PfkjX2hDFJabX0Stylu6holalNUqcoCOb
         OttQvKIUDdqjzQ1AJy+e8mbvlBz/1OahKrc51M/ZE2IRpUsFr0MidUSBrBmqOTKxv9GW
         1bHcKqLQ+UMcZSuH2AYaY4HcYMkTFNIyWyioxfZDw8v0SQt0IxnOF3EOkIO5WkQWwjOA
         fzPv/Z1/D9CjePdn6xkMwYlwpfmS384zaHpMfq15bSxY3Eb2vC+8IiwwdfkTVSQYmSYs
         vpXQ==
X-Gm-Message-State: AOAM531z4PGfXwkvZJgFRfJYRR0stbuRQjNKfFY/PHLadZ356Ipej/Mf
        mfOEvukabek3ccufT06xpzLbN1ue82PdTt1kIcZK8OoZbIrFHrnxUha01zo0Qwhb8zwitaLznZj
        4G3kGEb7je4b2/8Luw+u3/nVt
X-Received: by 2002:adf:d84a:: with SMTP id k10mr3934400wrl.156.1612516614250;
        Fri, 05 Feb 2021 01:16:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxm4rfj82uV3tGDph5pyyVq3oRWewQ+gBUMQfr86xZKT355ALHumrHiplodlmOUoLsCMMAfbw==
X-Received: by 2002:adf:d84a:: with SMTP id k10mr3934381wrl.156.1612516614060;
        Fri, 05 Feb 2021 01:16:54 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it. [79.34.249.199])
        by smtp.gmail.com with ESMTPSA id g14sm12104482wru.45.2021.02.05.01.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 01:16:53 -0800 (PST)
Date:   Fri, 5 Feb 2021 10:16:51 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Xie Yongji <xieyongji@bytedance.com>, kvm@vger.kernel.org,
        Laurent Vivier <lvivier@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/13] vhost/vdpa: remove vhost_vdpa_config_validate()
Message-ID: <20210205091651.xfcdyuvwwzew2ufo@steredhat>
References: <20210204172230.85853-1-sgarzare@redhat.com>
 <20210204172230.85853-10-sgarzare@redhat.com>
 <6919d2d4-cc8e-2b67-2385-35803de5e38b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6919d2d4-cc8e-2b67-2385-35803de5e38b@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 11:27:32AM +0800, Jason Wang wrote:
>
>On 2021/2/5 上午1:22, Stefano Garzarella wrote:
>>get_config() and set_config() callbacks in the 'struct vdpa_config_ops'
>>usually already validated the inputs. Also now they can return an error,
>>so we don't need to validate them here anymore.
>>
>>Let's use the return value of these callbacks and return it in case of
>>error in vhost_vdpa_get_config() and vhost_vdpa_set_config().
>>
>>Originally-by: Xie Yongji <xieyongji@bytedance.com>
>>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>---
>>  drivers/vhost/vdpa.c | 41 +++++++++++++----------------------------
>>  1 file changed, 13 insertions(+), 28 deletions(-)
>>
>>diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>>index ef688c8c0e0e..d61e779000a8 100644
>>--- a/drivers/vhost/vdpa.c
>>+++ b/drivers/vhost/vdpa.c
>>@@ -185,51 +185,35 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
>>  	return 0;
>>  }
>>-static int vhost_vdpa_config_validate(struct vhost_vdpa *v,
>>-				      struct vhost_vdpa_config *c)
>>-{
>>-	long size = 0;
>>-
>>-	switch (v->virtio_id) {
>>-	case VIRTIO_ID_NET:
>>-		size = sizeof(struct virtio_net_config);
>>-		break;
>>-	}
>>-
>>-	if (c->len == 0)
>>-		return -EINVAL;
>>-
>>-	if (c->len > size - c->off)
>>-		return -E2BIG;
>>-
>>-	return 0;
>>-}
>>-
>>  static long vhost_vdpa_get_config(struct vhost_vdpa *v,
>>  				  struct vhost_vdpa_config __user *c)
>>  {
>>  	struct vdpa_device *vdpa = v->vdpa;
>>  	struct vhost_vdpa_config config;
>>  	unsigned long size = offsetof(struct vhost_vdpa_config, buf);
>>+	long ret;
>>  	u8 *buf;
>>  	if (copy_from_user(&config, c, size))
>>  		return -EFAULT;
>>-	if (vhost_vdpa_config_validate(v, &config))
>>+	if (config.len == 0)
>>  		return -EINVAL;
>>  	buf = kvzalloc(config.len, GFP_KERNEL);
>
>
>Then it means usersapce can allocate a very large memory.

Good point.

>
>Rethink about this, we should limit the size here (e.g PAGE_SIZE) or 
>fetch the config size first (either through a config ops as you 
>suggested or a variable in the vdpa device that is initialized during 
>device creation).

Maybe PAGE_SIZE is okay as a limit.

If instead we want to fetch the config size, then better a config ops in 
my opinion, to avoid adding a new parameter to __vdpa_alloc_device().

I vote for PAGE_SIZE, but it isn't a strong opinion.

What do you and @Michael suggest?

Thanks,
Stefano

