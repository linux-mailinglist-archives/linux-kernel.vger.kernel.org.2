Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A2F3D56A5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 11:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbhGZItq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 04:49:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31305 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233196AbhGZItS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 04:49:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627291787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VpxBo3UczXFpVeP5pHdpdgsu9E4RieUqE2581sjbAzU=;
        b=Ctv4AXlMEtEs6Iy/manF1QdxNYJ3J26iZ30Db91LT199OuVFekGoB89Wbo0YAm5wl8qBYX
        JXJVlO18G105FtlGoxQMMaDnNl+DbD7Xm54rEvW3Qxi9t6cGv7hLug8scybik7j7POxrsM
        0uA6DkXDlb+GqRl8TXkeb3Jw/xwEB0Q=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-ZE9_BJJ_P7C8wBIx5qQlNA-1; Mon, 26 Jul 2021 05:29:46 -0400
X-MC-Unique: ZE9_BJJ_P7C8wBIx5qQlNA-1
Received: by mail-ed1-f72.google.com with SMTP id eg50-20020a05640228b2b02903a2e0d2acb7so3227668edb.16
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 02:29:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VpxBo3UczXFpVeP5pHdpdgsu9E4RieUqE2581sjbAzU=;
        b=hmjMgdR88F/PlEfYQKTzgC6I3j2Ph+wiiXLDS2Hs2o/sC92PHmFdA95OJK+C4xMqWf
         JbXtJ5aH4RkO5skH5LpWwzBW4NznRivgCJJF7WLEuIL2J+U1P02O64pexFUiJOjV5cct
         qB1MB2EKijowvH0VD3FB9KeJV6h7lmLXoJj2rTB0h3X50fO6RRnu9kiUoF/QHGUKLRC8
         AJ8N64UHOkMtvourgI1eStAhiUB2zovyBas+y6iFxrS9LE/xS2uupjoKEXMRhOGor2jB
         j+ygL77+ihh2/SIsAlHcSY5F2YUm+CJhBgOiEG6MnvS96vUcBKvy4SYQKboX1M0TEdjw
         UZ9w==
X-Gm-Message-State: AOAM533fJXd7ZhgNnOmPNToFbzaaZxwTmf8k4HN1sdBOkNklNGTUDNp+
        xLP21bTsLE2bDrSbbSiYWbCb0TFn0yBdIT2RznN0WYFQPZrKKBmh02L4ofVsCeAysYaxIs/Ir9f
        5jMR8wn6MckwDvFOEaQiEDhbf
X-Received: by 2002:a17:906:f84a:: with SMTP id ks10mr15772497ejb.537.1627291785056;
        Mon, 26 Jul 2021 02:29:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMEmdi8xJQjU6oStMXxQAZgGekDcKyG8uDyL0mkKdYpwEsm87S+Jh2cnw64hwZeitbYlDynQ==
X-Received: by 2002:a17:906:f84a:: with SMTP id ks10mr15772483ejb.537.1627291784923;
        Mon, 26 Jul 2021 02:29:44 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it. [79.18.148.79])
        by smtp.gmail.com with ESMTPSA id d4sm13887040ejy.86.2021.07.26.02.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 02:29:44 -0700 (PDT)
Date:   Mon, 26 Jul 2021 11:29:42 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     mst@redhat.com, jasowang@redhat.com, dan.carpenter@oracle.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] vdpa: Add documentation for vdpa_alloc_device() macro
Message-ID: <20210726092942.cyh4djfevy7vcgjc@steredhat>
References: <20210715080026.242-1-xieyongji@bytedance.com>
 <20210715080026.242-4-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210715080026.242-4-xieyongji@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:00:26PM +0800, Xie Yongji wrote:
>The return value of vdpa_alloc_device() macro is not very
>clear, so that most of callers did the wrong check. Let's
>add some comments to better document it.
>
>Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
>---
> include/linux/vdpa.h | 11 +++++++++++
> 1 file changed, 11 insertions(+)
>
>diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>index 3357ac98878d..8cfe49d201dd 100644
>--- a/include/linux/vdpa.h
>+++ b/include/linux/vdpa.h
>@@ -277,6 +277,17 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
> 					const struct vdpa_config_ops *config,
> 					size_t size, const char *name);
>
>+/**
>+ * vdpa_alloc_device - allocate and initilaize a vDPA device
>+ *
>+ * @dev_struct: the type of the parent structure
>+ * @member: the name of struct vdpa_device within the @dev_struct
>+ * @parent: the parent device
>+ * @config: the bus operations that is supported by this device
>+ * @name: name of the vdpa device
>+ *
>+ * Return allocated data structure or ERR_PTR upon error
>+ */
> #define vdpa_alloc_device(dev_struct, member, parent, config, name)   \
> 			  container_of(__vdpa_alloc_device( \
> 				       parent, config, \
>-- 
>2.11.0
>

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

