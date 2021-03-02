Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E40532A7CD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1839704AbhCBQh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 11:37:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27512 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351389AbhCBORX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 09:17:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614694523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rjOoUYxeG19DT5eJ2WuZnRhWzkvWoRa4HG3rYru+1nk=;
        b=TARHDRKxTcMj23Ok+2Ue2h34m0Or4hNvqr5wYCSrEogVGb6ZEih1dqQ1EZHQayfT86n6JE
        7AzPiq9hhLfRYpCtyrtr69m1Ww6p6E7CBPmiXu9SqAFAS6rOgEW2LY/MI1Cj3+2HaLmVql
        xSwDW6xoum85NZDzoeoBWeEXQZ+cag8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-IqxeBnOwM9Cz7dCHYLynaQ-1; Tue, 02 Mar 2021 09:15:21 -0500
X-MC-Unique: IqxeBnOwM9Cz7dCHYLynaQ-1
Received: by mail-ed1-f70.google.com with SMTP id h5so598681edf.17
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 06:15:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rjOoUYxeG19DT5eJ2WuZnRhWzkvWoRa4HG3rYru+1nk=;
        b=jAfesyjiUlPRBm0YKC+I207QEW8hYr8whlPJAFsGv5rVHRB5xecgN0T94JavyBgkTo
         SBYYWfZCBYRASTli+xNWFeOy1ohy4SqxTBvl+bK4NsG2TR+2+C9vzqgVfJS1wE89fXzb
         sNbv2pZ/4DPk3ntyxSc9MnXl/bRnzWGVyNdPkPjZbMREJgSWfrVpNyx1/CltWeMIIWAS
         i/CV4kZBnNq9HlSCm5BZSJfm29okpUFGlt7njhppp83XuhNbFJJ9+yaJptLj6u/KyYEp
         zpE9OjCsbty1XV2dfzexHnQWUbX1eJkIuh+N2PUuG79DjaUSlDtsC45bdo8aQmikZXND
         UxNg==
X-Gm-Message-State: AOAM532IXsH0xR802I35LJpBXUHCRmfmueX7i0nMEwyPaVhOD3gMahnC
        AfG8GfRe8P/QiL2rjBOomxQ2GheYJZ5a++KEdIdH8TX4XS/qylLkKN7YPdZPUUx4mus0KwRhppx
        ITWT8sb3vDb98tEeRbojcfOlE
X-Received: by 2002:a17:906:f891:: with SMTP id lg17mr21120906ejb.69.1614694520479;
        Tue, 02 Mar 2021 06:15:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJygE29SnX3D3HuuzIHfSkf8dbUaigd8KEMZKU0eY9r+w462+eOcRfQHeat9otGJbyl2OKaNyA==
X-Received: by 2002:a17:906:f891:: with SMTP id lg17mr21120877ejb.69.1614694520244;
        Tue, 02 Mar 2021 06:15:20 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it. [79.34.249.199])
        by smtp.gmail.com with ESMTPSA id c17sm18013380edw.32.2021.03.02.06.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 06:15:19 -0800 (PST)
Date:   Tue, 2 Mar 2021 15:15:16 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH 01/10] vdpa: add get_config_size callback in
 vdpa_config_ops
Message-ID: <20210302141516.oxsdb7jogrvu75yc@steredhat>
References: <20210216094454.82106-1-sgarzare@redhat.com>
 <20210216094454.82106-2-sgarzare@redhat.com>
 <5de4cd5b-04cb-46ca-1717-075e5e8542fd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5de4cd5b-04cb-46ca-1717-075e5e8542fd@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 12:14:13PM +0800, Jason Wang wrote:
>
>On 2021/2/16 5:44 下午, Stefano Garzarella wrote:
>>This new callback is used to get the size of the configuration space
>>of vDPA devices.
>>
>>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>---
>>  include/linux/vdpa.h              | 4 ++++
>>  drivers/vdpa/ifcvf/ifcvf_main.c   | 6 ++++++
>>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 6 ++++++
>>  drivers/vdpa/vdpa_sim/vdpa_sim.c  | 9 +++++++++
>>  4 files changed, 25 insertions(+)
>>
>>diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>>index 4ab5494503a8..fddf42b17573 100644
>>--- a/include/linux/vdpa.h
>>+++ b/include/linux/vdpa.h
>>@@ -150,6 +150,9 @@ struct vdpa_iova_range {
>>   * @set_status:			Set the device status
>>   *				@vdev: vdpa device
>>   *				@status: virtio device status
>>+ * @get_config_size:		Get the size of the configuration space
>>+ *				@vdev: vdpa device
>>+ *				Returns size_t: configuration size
>
>
>Rethink about this, how much we could gain by introducing a dedicated 
>ops here? E.g would it be simpler if we simply introduce a 
>max_config_size to vdpa device?

Mainly because in this way we don't have to add new parameters to the 
vdpa_alloc_device() function.

We do the same for example for 'get_device_id', 'get_vendor_id', 
'get_vq_num_max'. All of these are usually static, but we have ops.
I think because it's easier to extend.

I don't know if it's worth adding a new structure for these static 
values at this point, like 'struct vdpa_config_params'.

Thanks,
Stefano

