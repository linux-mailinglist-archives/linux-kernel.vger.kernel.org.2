Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 040F932790E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 09:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbhCAITH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 03:19:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57029 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232832AbhCAITD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 03:19:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614586656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tKTcoC9836gUjKa05XhBkB41/zp/zhab93GjDyMxI/c=;
        b=PTtyxhMcrDX5Y83ZmkDX9hNNk+YJdCtrV7kbRVFxqcrZmPOttn2LdPtyIcbeHPUxoCuxu1
        Jxy7dOqqOg8k6K5H6NfzUTE74veyr00lSKNIrUPid8zCNaP9uBmbInrlciCBzlRs+Smqys
        H3kYLm1rOwdEGmAmjFYKnuJ2VArtNi4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-bo76s9i1Nri0IP80zFNcMQ-1; Mon, 01 Mar 2021 03:17:33 -0500
X-MC-Unique: bo76s9i1Nri0IP80zFNcMQ-1
Received: by mail-ej1-f70.google.com with SMTP id hx26so6215342ejc.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 00:17:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tKTcoC9836gUjKa05XhBkB41/zp/zhab93GjDyMxI/c=;
        b=cEGGBkSr5gxx37BlfYtd2zL/sjruQFjZt8PUffoAtMqw1X4w32cgxEzxGia/xShAeV
         U4xcvLuJPwhd86lq5kXrDy4xdF171Kzk+wyoqkYZH+jyDphexY21+4I3j2T7pOYIp1hC
         6SIZBDdTJZkowP+jI0TynwxpoC144XE4LXqCj3MuY1CtUuQPHafcnN/1bNU/DrrSDIdn
         tXi2ab0lmrrz0PiqtYjL8vvRzD8y6HY/joEm1BXux82Pw2BGwMRgS/ihH6pt2RwmCPgm
         AgrBAMYZg3iojhTm0yGb6D0TEszcGfKvgtu1KqZGzHT2tBGQ9WjWOmbZjetIrJh+zRnP
         g+4g==
X-Gm-Message-State: AOAM532FaNh2HvRuVUwr9qYkdVdnNVsLRmrUV56zkFDn0Qe6Umltfeos
        EQLDR4EikWEBbbpFkVNMRX1cv6tVS5wnTqPLF+k85UNvOzL/7nduJNfgGa/aLsL1k53F1gFgKzF
        bQ/8okI0Xnb+9O55sBCWdr/cX
X-Received: by 2002:a17:907:9863:: with SMTP id ko3mr4754990ejc.543.1614586652778;
        Mon, 01 Mar 2021 00:17:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwOJQF4XmlN9Kj2YNp2sgq/OJTqRNjmmF1UykY+KaTBK5B08lVVp1Se9T8pnZHi1l/9eMb5kg==
X-Received: by 2002:a17:907:9863:: with SMTP id ko3mr4754977ejc.543.1614586652538;
        Mon, 01 Mar 2021 00:17:32 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it. [79.34.249.199])
        by smtp.gmail.com with ESMTPSA id 35sm14542379edp.85.2021.03.01.00.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 00:17:32 -0800 (PST)
Date:   Mon, 1 Mar 2021 09:17:30 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [RFC PATCH 00/10] vdpa: get/set_config() rework
Message-ID: <20210301081730.45cqbq7s6fbrdkhw@steredhat>
References: <20210216094454.82106-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210216094454.82106-1-sgarzare@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nice ping :-)

On Tue, Feb 16, 2021 at 10:44:44AM +0100, Stefano Garzarella wrote:
>Following the discussion with Michael and Jason [1], I reworked a bit
>get/set_config() in vdpa.
>
>I changed vdpa_get_config() to check the boundaries and added vdpa_set_config().
>When 'offset' or 'len' parameters exceed boundaries, we limit the reading to
>the available configuration space in the device, and we return the amount of
>bytes read/written.
>
>In this way the user space can pass buffers bigger than config space.
>I also returned the amount of bytes read and written to user space.
>
>Patches also available here:
>https://github.com/stefano-garzarella/linux/tree/vdpa-get-set-config-refactoring
>
>Thanks for your comments,
>Stefano
>
>[1] https://lkml.org/lkml/2021/2/10/350
>
>Stefano Garzarella (10):
>  vdpa: add get_config_size callback in vdpa_config_ops
>  vdpa: check vdpa_get_config() parameters and return bytes read
>  vdpa: add vdpa_set_config() helper
>  vdpa: remove param checks in the get/set_config callbacks
>  vdpa: remove WARN_ON() in the get/set_config callbacks
>  virtio_vdpa: use vdpa_set_config()
>  vhost/vdpa: use vdpa_set_config()
>  vhost/vdpa: allow user space to pass buffers bigger than config space
>  vhost/vdpa: use get_config_size callback in
>    vhost_vdpa_config_validate()
>  vhost/vdpa: return configuration bytes read and written to user space
>
> include/linux/vdpa.h              | 22 ++++-------
> drivers/vdpa/ifcvf/ifcvf_base.c   |  3 +-
> drivers/vdpa/ifcvf/ifcvf_main.c   |  8 +++-
> drivers/vdpa/mlx5/net/mlx5_vnet.c |  9 ++++-
> drivers/vdpa/vdpa.c               | 51 ++++++++++++++++++++++++
> drivers/vdpa/vdpa_sim/vdpa_sim.c  | 15 +++++---
> drivers/vhost/vdpa.c              | 64 ++++++++++++++++---------------
> drivers/virtio/virtio_vdpa.c      |  3 +-
> 8 files changed, 116 insertions(+), 59 deletions(-)
>
>-- 
>2.29.2
>
>_______________________________________________
>Virtualization mailing list
>Virtualization@lists.linux-foundation.org
>https://lists.linuxfoundation.org/mailman/listinfo/virtualization
>

