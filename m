Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F553BD8CB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 16:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbhGFOrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 10:47:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56577 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232577AbhGFOrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 10:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625582671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pxHexuMc60Pqv4E4hjuhvf1rTK57cAPn3g1/NdAGS2s=;
        b=PtClT/d/gXCt6hf07mnt+s6JkRwtqYMKZpLye00uhblt+AktvVEm7TtoZl4WvXxTuWTDoz
        ncI4tEG/6unTGU00yQJ34hMll/d7PmN3wz285DfpMh00Gn5i6zEm/8ZIapXC8GNKI4bzI8
        JADbsLzP/V6lkzR9wmM0GAJVO/s5arw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-B5ye1H5bNCi20EZrSDfQ6w-1; Tue, 06 Jul 2021 10:44:30 -0400
X-MC-Unique: B5ye1H5bNCi20EZrSDfQ6w-1
Received: by mail-ed1-f72.google.com with SMTP id u13-20020aa7d88d0000b0290397eb800ae3so6936557edq.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 07:44:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pxHexuMc60Pqv4E4hjuhvf1rTK57cAPn3g1/NdAGS2s=;
        b=JJCEFLHYZLUuPLqjYh8FNkAs5CaSB+OIlLCBwBRoSu0PPAHxRVFASj3zbgBE9Qq7R7
         bG9bGar40jFfYoRzwydjZ3K7mFCDxwLySIl/Z5ajyaK3jWyE90qP55w0BvAPyoYndmGl
         DnTxMsPlRQsCX7Il0Dlojyc7X3zLIlQ8IqkPA884RaGr0dwS7rxB0cDxO/AO4lxV75Xp
         FQ9GRKgV4lCd8kJtnxDzX74JeB5EVr+msS+RwtwoLbUhr4IvV2DzDe9wXCiQHkAbOQUH
         ni44odUVjOdnTsOY6kwOov9mC/57G0gU8qv3a4rRFxLtPSIeK+z2IF32zi3nmtkPQdZ8
         XChQ==
X-Gm-Message-State: AOAM5314EIsbB3x8FvT2KwvFCGJEfj97AtZzlJMWGJ8VjczoBjnQX0B2
        sny5eUQEG5F+hdqcnaLuaD2NA6htJn3UQELKgugkdZ1XtdEOW+QJ0ZuCIh72mqt8LMrkmTxpwSs
        rIvrpP/htVcFUeBQHi7iyNs/x
X-Received: by 2002:a05:6402:10c7:: with SMTP id p7mr6022427edu.159.1625582669381;
        Tue, 06 Jul 2021 07:44:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLXHrfP0lnLSmflcHGg7WcL9eK2kyxw1wyqYcu5Y53b9jlpo883LPFR5eN7ttaDJhgxWLHaQ==
X-Received: by 2002:a05:6402:10c7:: with SMTP id p7mr6022391edu.159.1625582669033;
        Tue, 06 Jul 2021 07:44:29 -0700 (PDT)
Received: from steredhat ([109.52.250.49])
        by smtp.gmail.com with ESMTPSA id y17sm1189035ejd.16.2021.07.06.07.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 07:44:28 -0700 (PDT)
Date:   Tue, 6 Jul 2021 16:44:25 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Cc:     mst@redhat.com, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Jason Wang <jasowang@redhat.com>,
        Yunsheng Lin <linyunsheng@huawei.com>
Subject: Re: [PATCH 2/2] vringh: Include spinlock.h
Message-ID: <20210706144425.cp3yzdinmosqftjr@steredhat>
References: <20210706142632.670483-1-eperezma@redhat.com>
 <20210706142632.670483-3-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210706142632.670483-3-eperezma@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2021 at 04:26:32PM +0200, Eugenio Pérez wrote:
>Commit f53d9910d009 ("vringh: add 'iotlb_lock' to synchronize iotlb
>accesses") introduces this dependency, but does not include spinlock.h.
>While kernel seems to compile as usual, tools/virtio cannot do the
>same.
>
>Fixes: f53d9910d009 ("vringh: add 'iotlb_lock' to synchronize iotlb accesses")
>
>Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
>---
> include/linux/vringh.h | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/include/linux/vringh.h b/include/linux/vringh.h
>index 84db7b8f912f..212892cf9822 100644
>--- a/include/linux/vringh.h
>+++ b/include/linux/vringh.h
>@@ -14,6 +14,7 @@
> #include <linux/virtio_byteorder.h>
> #include <linux/uio.h>
> #include <linux/slab.h>
>+#include <linux/spinlock.h>
> #if IS_REACHABLE(CONFIG_VHOST_IOTLB)
> #include <linux/dma-direction.h>
> #include <linux/vhost_iotlb.h>
>-- 
>2.27.0
>

Ooops, thanks for fixing this!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

