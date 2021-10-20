Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619874345F5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 09:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhJTHjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 03:39:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35254 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229491AbhJTHjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 03:39:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634715458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mQZkGZkcMT/9X7rY2JQAT2AeWtRw1pbaqZYCol/GOQU=;
        b=IzOgxOZ7bBcsSYiGWVWl+m9nwJMQ/nIi/CGhRez+KavTuJppxCeJaoSYT4L7FstwWhcSMz
        Y/hML+vfAn8GhI2Qq1R/YHlspl/3qigd6U5UFzgqweEgesB68RncG415/iR1pQERacN46u
        N/wlNdPTx60LoZE7c/A7Hp+k7e/x0VM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-Li-uowFhOYuTwuTItpCdGg-1; Wed, 20 Oct 2021 03:37:37 -0400
X-MC-Unique: Li-uowFhOYuTwuTItpCdGg-1
Received: by mail-ed1-f69.google.com with SMTP id u10-20020a50d94a000000b003dc51565894so13441686edj.21
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 00:37:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mQZkGZkcMT/9X7rY2JQAT2AeWtRw1pbaqZYCol/GOQU=;
        b=feBI1wovwKhZ2IA8ckdCc3Nd/5357mKnFZXBmCLbBnszj+N24oauJD5yGEnyL2MOA9
         c1FcCbzEE2sSEUv2vcoan5mHEbzY7Ho4qk/yJCGYJvjnVCL0oN+4nF9jai+psR1Nnsj5
         /h7bjYoTOUneYJUSDYCN3pGFcVTSf5RekAoKdUCHnYnO9XUOzbpRkTxPY6jnlQidSgjF
         5dPsTseMG3oqCdTvydhdYeWel5G8k6R+TJ3YGrQFW2kpuDlrYqN1FNU1cVkSPdt61VdK
         sNjmH+BCa5wS3Sm1ObCdqHbyw0dEIhdoQuUNRnhArXturiMUgGmJE7pa6jbgMxZ8gDW0
         v0JA==
X-Gm-Message-State: AOAM532RHDwHFvNz+IswamP/tWPSFh7dMdb3GNsBD3arxgCBQPn2Tj/I
        qtN2Ihi3C5BJIQN4O/UXWW+vDfLZOU4ZfXempYQ0tTo5YXaXJAh7PUiTOfrk3NMI7DpPR/W2Kdw
        9uJNNqNkrAaSkQV8x4XWAj+0+
X-Received: by 2002:a17:906:1381:: with SMTP id f1mr43248922ejc.547.1634715455984;
        Wed, 20 Oct 2021 00:37:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYP92GI73PEyOGZcTemC9Rxpc30vMRPxmbLU0eSsAdtYdXxiWNMDWTzMUSLLYSAn9LeHeIWA==
X-Received: by 2002:a17:906:1381:: with SMTP id f1mr43248904ejc.547.1634715455815;
        Wed, 20 Oct 2021 00:37:35 -0700 (PDT)
Received: from redhat.com ([2.55.24.172])
        by smtp.gmail.com with ESMTPSA id l25sm686190edc.31.2021.10.20.00.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 00:37:35 -0700 (PDT)
Date:   Wed, 20 Oct 2021 03:37:31 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH V3 01/10] virtio-blk: validate num_queues during probe
Message-ID: <20211020032849-mutt-send-email-mst@kernel.org>
References: <20211019070152.8236-1-jasowang@redhat.com>
 <20211019070152.8236-2-jasowang@redhat.com>
 <20211020071817.pzyfploxlryvdf3p@steredhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020071817.pzyfploxlryvdf3p@steredhat>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 09:18:17AM +0200, Stefano Garzarella wrote:
> On Tue, Oct 19, 2021 at 03:01:43PM +0800, Jason Wang wrote:
> > If an untrusted device neogitates BLK_F_MQ but advertises a zero
> 
> s/neogitates/negotiates
> 
> > num_queues, the driver may end up trying to allocating zero size
> > buffers where ZERO_SIZE_PTR is returned which may pass the checking
> > against the NULL. This will lead unexpected results.
> > 
> > Fixing this by failing the probe in this case.
> > 
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > Cc: Stefano Garzarella <sgarzare@redhat.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> > drivers/block/virtio_blk.c | 4 ++++
> > 1 file changed, 4 insertions(+)
> 
> Should we CC stable?
> 
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

No IMO - I don't think we can reasonably expect stable to become
protected against attacks on encrypted guests. That's
a new feature, not a bugfix.

-- 
MST

