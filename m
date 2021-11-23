Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15447459DB3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 09:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbhKWIWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 03:22:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53364 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231821AbhKWIWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 03:22:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637655575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DB5J6o56aoD8qmKsx2+0tQdowaBmrwF9mBpHda0JqSk=;
        b=PVwvJ1r7JFhp4Rla+fa7IZQhxBxhWTkRljMkiJphgD1TB56dBWA7Xy2VTGPdX6j/OqThPv
        69fuK8GUmFU0Uupk2rJlmb5YU2A+XNMl6G+8KRqzgmpK8ZJ6kL6qeV+rG1fehRvHUnHCS7
        lOmQj5/BzHNV6+qmeRMLW8mmJWmYzVU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-389-QvQBf7hbM-GK8X7ALdxgxg-1; Tue, 23 Nov 2021 03:19:33 -0500
X-MC-Unique: QvQBf7hbM-GK8X7ALdxgxg-1
Received: by mail-ed1-f72.google.com with SMTP id r16-20020a056402019000b003e6cbb77ed2so17118814edv.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 00:19:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DB5J6o56aoD8qmKsx2+0tQdowaBmrwF9mBpHda0JqSk=;
        b=eJs98jaHa65D+zveRp/aZrQdr9DFyxdN8fA+k6Bp5DA4CbgUq1IA8TIrSl8bAqEyEJ
         uXjPzWO8BypfR5JBg2QlKva9hFIzKONUGg1gNzm2RZ+ojXYvZ5QoLsw28X/+QMTEokEO
         V2/bbdUGE332A9kCDHUtHsuEN0HEC43z7P2I/YVbMl8lZknKfKbY4/Muflq3eaEntfsb
         v90nVYIsUFeK+zxGWRcgum8brXp4nyrLeyuRknERQjn1qVQMt7GSZP0HjrV8gryMuS3C
         ozxtLQJTJiIQiITIzzt1GsI8+CknHovJUQcYbCJdS83j+crMTFCGmdJHEjJifFs38Adw
         dMdQ==
X-Gm-Message-State: AOAM5326Ym3lRUJ7mPY75c4VDErsXumIp8oGAEHJ0eWeqffoHnAO/vhQ
        tZ5bRbU+2xi3KfMsuwSFCXG2a9vkFjw6Nw/nNfCzLcwyLy4MXIJHuRHCQfnX1+bTs5u1ctvGGXO
        9Ish0BZ37DVIrPi5iGItB/LQk
X-Received: by 2002:a17:907:7f2a:: with SMTP id qf42mr5436089ejc.388.1637655572331;
        Tue, 23 Nov 2021 00:19:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxRz2QfWedQwOSAAZ8IRUzi/jx1YDNZdeXP8Oohael6RR8amwpDFZd2lFJY3yoiPhevjQBh6A==
X-Received: by 2002:a17:907:7f2a:: with SMTP id qf42mr5436067ejc.388.1637655572156;
        Tue, 23 Nov 2021 00:19:32 -0800 (PST)
Received: from steredhat (host-87-10-72-39.retail.telecomitalia.it. [87.10.72.39])
        by smtp.gmail.com with ESMTPSA id v13sm4705134ejo.36.2021.11.23.00.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 00:19:31 -0800 (PST)
Date:   Tue, 23 Nov 2021 09:19:29 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Longpeng(Mike)" <longpeng2@huawei.com>
Cc:     mst@redhat.com, jasowang@redhat.com, mgurtovoy@nvidia.com,
        parav@nvidia.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, arei.gonglei@huawei.com
Subject: Re: [PATCH] vdpa_sim: avoid putting an uninitialized iova_domain
Message-ID: <20211123081929.6wa3jes3rnm5hh63@steredhat>
References: <20211122122221.56-1-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20211122122221.56-1-longpeng2@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 08:22:21PM +0800, Longpeng(Mike) wrote:
>From: Longpeng <longpeng2@huawei.com>
>
>The system will crash if we put an uninitialized iova_domain, this
>could happen when an error occurs before initializing the iova_domain
>in vdpasim_create().
>
>BUG: kernel NULL pointer dereference, address: 0000000000000000
>...
>RIP: 0010:__cpuhp_state_remove_instance+0x96/0x1c0
>...
>Call Trace:
> <TASK>
> put_iova_domain+0x29/0x220
> vdpasim_free+0xd1/0x120 [vdpa_sim]
> vdpa_release_dev+0x21/0x40 [vdpa]
> device_release+0x33/0x90
> kobject_release+0x63/0x160
> vdpasim_create+0x127/0x2a0 [vdpa_sim]
> vdpasim_net_dev_add+0x7d/0xfe [vdpa_sim_net]
> vdpa_nl_cmd_dev_add_set_doit+0xe1/0x1a0 [vdpa]
> genl_family_rcv_msg_doit+0x112/0x140
> genl_rcv_msg+0xdf/0x1d0
> ...
>
>So we must make sure the iova_domain is already initialized before
>put it.
>
>In addition, we may get the following warning in this case:
>WARNING: ... drivers/iommu/iova.c:344 iova_cache_put+0x58/0x70
>
>So we must make sure the iova_cache_put() is invoked only if the
>iova_cache_get() is already invoked. Let's fix it together.
>
>Signed-off-by: Longpeng <longpeng2@huawei.com>
>---
> drivers/vdpa/vdpa_sim/vdpa_sim.c | 7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)

Ooops, thanks for fixing this :-)

With the Fixes tag as suggested:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

