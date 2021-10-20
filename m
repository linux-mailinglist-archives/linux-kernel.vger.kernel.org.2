Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B934345CC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 09:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhJTHUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 03:20:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44797 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229842AbhJTHUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 03:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634714303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xdgj6SdvLhFwHBvEbV5KY24EzQ2wsW3+msXZfewzZ28=;
        b=Pm72XrXVY3AWPhzSZSd02Dw0R6FLuf4twOba3C51MmtcPA4zq9ysrGbID2P0nuXvH/T5h/
        wL9HbNhl530pyEv2VqNGb9muhLHAqCYAgmRYnqHE5K5pg8oXZIw9OpV6cfNib4Op11ucY4
        72ilHw6TFTiGgYprNitGW6CubHiTHcA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-eRdnDaPKMeiE6Fc09Iys2A-1; Wed, 20 Oct 2021 03:18:21 -0400
X-MC-Unique: eRdnDaPKMeiE6Fc09Iys2A-1
Received: by mail-ed1-f69.google.com with SMTP id v9-20020a50d849000000b003dcb31eabaaso2379590edj.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 00:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xdgj6SdvLhFwHBvEbV5KY24EzQ2wsW3+msXZfewzZ28=;
        b=3JVu1At9Z1FvkdlIKlXjqYAzntpdKzRS/XA5H4Xe0Nt2J8rsxrNgKTeaeQqQaJYjWj
         6S/hjTxWSbSNxJtX6WHHz9uRpPUpJN8SDU4BhjL8WFKZZ1M0iO1BfWLBdasDu/CIkMVU
         Z4nHIxWDIxczShO4kuIqq+bFB6urRr+usa+Iu9FtZ5imHIvcaN9Q4LoeNy4f6B1iUw0V
         AVYY6mUbINkPy49ug8RsVDJLhOoyX5mnJcoWmstVp9tevfypHv5uLb3wwWHut7TPO8yi
         DKuEl36BRQMDzEWQbqpBJ0c523tGr3w+7L3qCTLfcvkrv8pqhx3oSlPpzxbvQ6wX5IxM
         3B3Q==
X-Gm-Message-State: AOAM533Js6N0LHgAsizHaBifhW2tXRB0XM9IC2DPydh50TfFSOVaQnj1
        A5CgBsWXvU7CpMVo68C8ClIIxJMawTCjnvZMF7MrfOUqDCS7oaPC8xgBHc+VIoGsauggCFkgg21
        3DkVwCvfRZWkQcenhV//IhANx
X-Received: by 2002:a05:6402:1c94:: with SMTP id cy20mr60372410edb.144.1634714300326;
        Wed, 20 Oct 2021 00:18:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxHtowpIQurYGdY2Ipfvn7cEUWyB9V830NvZof3v0pUEFTKdE9/01f6TbWLuJvV0UND3sbbFQ==
X-Received: by 2002:a05:6402:1c94:: with SMTP id cy20mr60372386edb.144.1634714300083;
        Wed, 20 Oct 2021 00:18:20 -0700 (PDT)
Received: from steredhat (host-79-34-250-211.business.telecomitalia.it. [79.34.250.211])
        by smtp.gmail.com with ESMTPSA id u23sm655460edr.97.2021.10.20.00.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 00:18:19 -0700 (PDT)
Date:   Wed, 20 Oct 2021 09:18:17 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH V3 01/10] virtio-blk: validate num_queues during probe
Message-ID: <20211020071817.pzyfploxlryvdf3p@steredhat>
References: <20211019070152.8236-1-jasowang@redhat.com>
 <20211019070152.8236-2-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20211019070152.8236-2-jasowang@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 03:01:43PM +0800, Jason Wang wrote:
>If an untrusted device neogitates BLK_F_MQ but advertises a zero

s/neogitates/negotiates

>num_queues, the driver may end up trying to allocating zero size
>buffers where ZERO_SIZE_PTR is returned which may pass the checking
>against the NULL. This will lead unexpected results.
>
>Fixing this by failing the probe in this case.
>
>Cc: Paolo Bonzini <pbonzini@redhat.com>
>Cc: Stefan Hajnoczi <stefanha@redhat.com>
>Cc: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Jason Wang <jasowang@redhat.com>
>---
> drivers/block/virtio_blk.c | 4 ++++
> 1 file changed, 4 insertions(+)

Should we CC stable?

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

