Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B30032A7BA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1835060AbhCBQ2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 11:28:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22364 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1573020AbhCBOI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 09:08:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614694022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9ZZPA/RjfCV3cwHtIqxM2nNGL0XO9fFuMgdZl9YFKtA=;
        b=HaDTi3Z9efIcnDhflmI4de1wo66oErY0gFm819aBXCCoDzr5biR78WtxS58waL+DAT/e+h
        oZebZmEi5//YrnR4SrHCzh8op4TjnKp9lVk862EpE2t5p7IBRhLnpKU81vF54K39+MPmRR
        KsABr935fG/oRYm6l01VdWA1JrGwGZU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-gG9nPFMxNn6rXnwE3gTNjg-1; Tue, 02 Mar 2021 09:06:59 -0500
X-MC-Unique: gG9nPFMxNn6rXnwE3gTNjg-1
Received: by mail-wm1-f71.google.com with SMTP id w10so733802wmk.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 06:06:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9ZZPA/RjfCV3cwHtIqxM2nNGL0XO9fFuMgdZl9YFKtA=;
        b=mNEQFnixHAPztQYar8T5zHz5euB/Fh7QHV5kuBJcWXZeQ0syVjQlAuH5dWksqhvQLq
         D+vu+7uLRa1fb8+2bcy+W65UhmUYQ8mBMfQOCSGrKS2QFGN3bhpKG+HM8ReFrUWfVDeW
         1TY61WzFROYJbeWiZmEl9tQXYzIVeF7z9/TUDJcoTMzbxHrshCCmz8kkfqJ+6bsVyYOV
         KY1tM7TCvk8/0TDvyJ5T23CnwnI9dYl6M+W2y9lObFlAdkDel3e8Bbqr8z3S34ycav3t
         wqX344OdGphWv0pVDPIYZWVw/Tyt7F0UtKSEz9Py+Ngff2gzSUO+87guinVbdek+EUCN
         jovQ==
X-Gm-Message-State: AOAM530nBqtA8VmOdeNoF/n5I3hm8FgiuQFL9F/AUGTEu4COtUe80Fwd
        zEYtie6gyIC5gppUs20W8FItGtx9bRgrhkh7QnMCDG7p2ICpuxFcgRpuCxSxOtSLsG2CheCoU5s
        FlB/B+g+tzCgsLjoH7IrWUM+E
X-Received: by 2002:adf:e603:: with SMTP id p3mr19332952wrm.360.1614694017990;
        Tue, 02 Mar 2021 06:06:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxPGvxaY2j2NNhchVLownsWlN5RsZOvtKftuEEVsTkK4Mn+YSpvgBcb/lnrmcwYWFG9dj3inA==
X-Received: by 2002:adf:e603:: with SMTP id p3mr19332896wrm.360.1614694017534;
        Tue, 02 Mar 2021 06:06:57 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it. [79.34.249.199])
        by smtp.gmail.com with ESMTPSA id o20sm745021wmq.5.2021.03.02.06.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 06:06:57 -0800 (PST)
Date:   Tue, 2 Mar 2021 15:06:54 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH 10/10] vhost/vdpa: return configuration bytes read
 and written to user space
Message-ID: <20210302140654.ybmjqui5snp5wxym@steredhat>
References: <20210216094454.82106-1-sgarzare@redhat.com>
 <20210216094454.82106-11-sgarzare@redhat.com>
 <4d682ff2-9663-d6ac-d5bf-616b2bf96e1a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d682ff2-9663-d6ac-d5bf-616b2bf96e1a@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 12:05:35PM +0800, Jason Wang wrote:
>
>On 2021/2/16 5:44 下午, Stefano Garzarella wrote:
>>vdpa_get_config() and vdpa_set_config() now return the amount
>>of bytes read and written, so let's return them to the user space.
>>
>>We also modify vhost_vdpa_config_validate() to return 0 (bytes read
>>or written) instead of an error, when the buffer length is 0.
>>
>>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>---
>>  drivers/vhost/vdpa.c | 26 +++++++++++++++-----------
>>  1 file changed, 15 insertions(+), 11 deletions(-)
>>
>>diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>>index 21eea2be5afa..b754c53171a7 100644
>>--- a/drivers/vhost/vdpa.c
>>+++ b/drivers/vhost/vdpa.c
>>@@ -191,9 +191,6 @@ static ssize_t vhost_vdpa_config_validate(struct vhost_vdpa *v,
>>  	struct vdpa_device *vdpa = v->vdpa;
>>  	u32 size = vdpa->config->get_config_size(vdpa);
>>-	if (c->len == 0)
>>-		return -EINVAL;
>>-
>>  	return min(c->len, size);
>>  }
>>@@ -204,6 +201,7 @@ static long vhost_vdpa_get_config(struct vhost_vdpa *v,
>>  	struct vhost_vdpa_config config;
>>  	unsigned long size = offsetof(struct vhost_vdpa_config, buf);
>>  	ssize_t config_size;
>>+	long ret;
>>  	u8 *buf;
>>  	if (copy_from_user(&config, c, size))
>>@@ -217,15 +215,18 @@ static long vhost_vdpa_get_config(struct vhost_vdpa *v,
>>  	if (!buf)
>>  		return -ENOMEM;
>>-	vdpa_get_config(vdpa, config.off, buf, config_size);
>>-
>>-	if (copy_to_user(c->buf, buf, config_size)) {
>>-		kvfree(buf);
>>-		return -EFAULT;
>>+	ret = vdpa_get_config(vdpa, config.off, buf, config_size);
>>+	if (ret < 0) {
>>+		ret = -EFAULT;
>>+		goto out;
>>  	}
>>+	if (copy_to_user(c->buf, buf, config_size))
>>+		ret = -EFAULT;
>>+
>>+out:
>>  	kvfree(buf);
>>-	return 0;
>>+	return ret;
>>  }
>>  static long vhost_vdpa_set_config(struct vhost_vdpa *v,
>>@@ -235,6 +236,7 @@ static long vhost_vdpa_set_config(struct vhost_vdpa *v,
>>  	struct vhost_vdpa_config config;
>>  	unsigned long size = offsetof(struct vhost_vdpa_config, buf);
>>  	ssize_t config_size;
>>+	long ret;
>>  	u8 *buf;
>>  	if (copy_from_user(&config, c, size))
>>@@ -248,10 +250,12 @@ static long vhost_vdpa_set_config(struct vhost_vdpa *v,
>>  	if (IS_ERR(buf))
>>  		return PTR_ERR(buf);
>>-	vdpa_set_config(vdpa, config.off, buf, config_size);
>>+	ret = vdpa_set_config(vdpa, config.off, buf, config_size);
>>+	if (ret < 0)
>>+		ret = -EFAULT;
>>  	kvfree(buf);
>>-	return 0;
>>+	return ret;
>>  }
>
>
>So I wonder whether it's worth to return the number of bytes since we 
>can't propogate the result to driver or driver doesn't care about 
>that.

Okay, but IIUC user space application that issue VHOST_VDPA_GET_CONFIG 
ioctl can use the return value.

Should we change also 'struct virtio_config_ops' to propagate this value 
also to virtio drivers?

Thanks,
Stefano

