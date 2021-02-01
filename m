Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F79C30A544
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 11:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbhBAKW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 05:22:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38780 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232742AbhBAKWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 05:22:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612174886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=76s0xuNfIMYw2Zjhat6XiJ6WTlVIEyZzd1HMUW58qTQ=;
        b=f+JEU8TezlIsDUfDZabQ3/XDaKYPHzyAqOnzyBMmJEQFkmnb8Lv8bRtvOAyhgfXoAoSH1R
        rxti3UjtA9+hGh+t5JNIc34pc4Dfz6SZh308NZX4rs0QiTFTnMgskBvRN438dvlwoxUztk
        mQiNrSQ+NqCArOhsutimPJgMxOqtX4I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-V96rxaLaNMOnFxHZpgbzCg-1; Mon, 01 Feb 2021 05:21:25 -0500
X-MC-Unique: V96rxaLaNMOnFxHZpgbzCg-1
Received: by mail-wm1-f72.google.com with SMTP id l21so4360495wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 02:21:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=76s0xuNfIMYw2Zjhat6XiJ6WTlVIEyZzd1HMUW58qTQ=;
        b=QFPTrfjAuu6ayOwhjs/oHO+eYpzByMaLYpV9XguXoqWWMZFt+rFzSLxGrci+75CdAU
         kYGphVrYaVq5IA70Ojx1zvMwaR+zyFzfWPH7fvoiuW4egjcMCfl3gpUPVMIHe+BRgyMX
         D2ZB/+8z33KiOfgF+S8bhgGwkSeEpeIdL0HJIhlmcujKm9C+m07qvSY856eUGVeWCmP0
         BT5GZ6fEz5noAZ/Fot9sxrJrRnUKybNajOrUwaM9LUam9JdPvdtQAjKYiZmiNLaaGL7g
         HsWqQyYCNRMdH3uuKf7prSqb0bOUT05RnxwrOg0wiT42HpD2FTKz/as1Au0h2+pTrqmj
         l9Jw==
X-Gm-Message-State: AOAM530EKEodOz4kMh/yzBDPMI4xlJ+WR+5Zrx9a6/xkvpkzKTA6TPrW
        9busygxAqwiwxJny3vSlwwLfbwttPnt0ccTxtSZU+0a+zyLg3LfG1hjsqahcWekHfBejSsxU9SC
        Orh60Rg6TI7/Pn+XhK82NdpkV
X-Received: by 2002:a7b:ce11:: with SMTP id m17mr14042897wmc.158.1612174884000;
        Mon, 01 Feb 2021 02:21:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzLJ3fELTf0uO9C4XANpCrWi3BAnIjUJpj+2gUWkb8bzvrz1rKoHjP1RKX8FAajUrd4qAIQvw==
X-Received: by 2002:a7b:ce11:: with SMTP id m17mr14042885wmc.158.1612174883799;
        Mon, 01 Feb 2021 02:21:23 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it. [79.34.249.199])
        by smtp.gmail.com with ESMTPSA id e4sm26994287wrw.96.2021.02.01.02.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 02:21:23 -0800 (PST)
Date:   Mon, 1 Feb 2021 11:21:20 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Xie Yongji <xieyongji@bytedance.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, Max Gurtovoy <mgurtovoy@nvidia.com>,
        kvm@vger.kernel.org
Subject: Re: [PATCH RFC v2 03/10] vringh: reset kiov 'consumed' field in
 __vringh_iov()
Message-ID: <20210201102120.kvbpbne3spaqv6yz@steredhat>
References: <20210128144127.113245-1-sgarzare@redhat.com>
 <20210128144127.113245-4-sgarzare@redhat.com>
 <62bb2e93-4ac3-edf5-2baa-4c2be8257cf0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62bb2e93-4ac3-edf5-2baa-4c2be8257cf0@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 01:40:01PM +0800, Jason Wang wrote:
>
>On 2021/1/28 下午10:41, Stefano Garzarella wrote:
>>__vringh_iov() overwrites the contents of riov and wiov, in fact it
>>resets the 'i' and 'used' fields, but also the consumed field should
>>be reset to avoid an inconsistent state.
>>
>>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>
>
>I had a question(I remember we had some discussion like this but I 
>forget the conclusion):

Sorry, I forgot to update you.

>
>I see e.g in vringh_getdesc_kern() it has the following comment:
>
>/*
> * Note that you may need to clean up riov and wiov, even on error!
> */
>
>So it looks to me the correct way is to call vringh_kiov_cleanup() 
>before?

Looking at the code the right pattern should be:

     vringh_getdesc_*(..., &out_iov, &in_iov, ...);

     // use out_iov and in_iov

     vringh_kiov_cleanup(&out_iov);
     vringh_kiov_cleanup(&in_iov);

This because vringh_getdesc_*() calls __vringh_iov() where 
resize_iovec() is called to allocate the iov wrapped by 'struct 
vringh_kiov' and vringh_kiov_cleanup() frees that memory.

Looking better, __vringh_iov() is able to extend a 'vringh_kiov' 
pre-allocated, so in order to avoid to allocate and free the iov for 
each request we can avoid to call vringh_kiov_cleanup(), but this patch 
is needed to avoid an inconsistent state.

And also patch "vdpa_sim: cleanup kiovs in vdpasim_free()" is required 
to free the iov when the device is going away.

Does that make sense to you?

Maybe I should add a comment in vringh.c to explain this better.

Thanks,
Stefano

>
>Thanks
>
>
>>---
>>  drivers/vhost/vringh.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>>diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
>>index f68122705719..bee63d68201a 100644
>>--- a/drivers/vhost/vringh.c
>>+++ b/drivers/vhost/vringh.c
>>@@ -290,9 +290,9 @@ __vringh_iov(struct vringh *vrh, u16 i,
>>  		return -EINVAL;
>>  	if (riov)
>>-		riov->i = riov->used = 0;
>>+		riov->i = riov->used = riov->consumed = 0;
>>  	if (wiov)
>>-		wiov->i = wiov->used = 0;
>>+		wiov->i = wiov->used = wiov->consumed = 0;
>>  	for (;;) {
>>  		void *addr;
>

