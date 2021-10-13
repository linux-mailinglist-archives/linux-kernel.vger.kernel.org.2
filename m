Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED35342BFCB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 14:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbhJMMXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 08:23:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51360 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230236AbhJMMXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 08:23:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634127693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aI/a1CuIplLBzfM7K3SKE+P3jJtMmkhDmL35+rhqKP0=;
        b=C4LauQ+o9aqPqS48sQDqIGOFb3fS8HOAbMFB29oMK8POZgiuOaYWLRuebzXGiGK8AmR/XG
        AuWoBsNVLkljQaCkEAVHvBG4Gm0snKVtKB7fKY6RKopb4UC3dqsYCW47oNIg++IY9rYAzC
        ybbeuJnS8h8TdT7821V4Iz7rA8q863M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-tuALkpf8NCG9-SPeCijViw-1; Wed, 13 Oct 2021 08:21:32 -0400
X-MC-Unique: tuALkpf8NCG9-SPeCijViw-1
Received: by mail-wr1-f71.google.com with SMTP id 10-20020a5d47aa000000b001610cbda93dso1788341wrb.23
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 05:21:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aI/a1CuIplLBzfM7K3SKE+P3jJtMmkhDmL35+rhqKP0=;
        b=bUeRSH40GCWRf8o6dGMrBCsVFIhyHUUd3/WXXeLk+IpjoXUQl5kSvFCTaHKEFUK2Dd
         Z2C533yARz60cTvpxfJiarauFKdPF7CpB73tQBCNfDNfPmJFkcXREYQgaxmVL6H/x1ao
         CB+70l1CkyIN8GhGD+3RLF2PRdCpeF62saFqf4Qa7RD69oVo6VihYoWCIaeQca2DWd2s
         RbE3TErIO66Ksr03MSb595K9SXvctJqAKNkNnDs/uGbSjQjXVo16mtZmCWVR6Ym/Jbyd
         PdsH8MR07zqG49PV9evrbxblUknTd4XPHIg834ftdPVrISHBk1IoJbohZ7MQlyPTLrHq
         2lMQ==
X-Gm-Message-State: AOAM531TtD8EmWpJ9QI1c/8ALIruuysY+PJ0ns3iBTWAvGqxA5gLSE0o
        DllXWXUGFWMglDHLQ/A56u7LUkuUC6vkbxn4/VZPKTnkh1xkYKM+fz+0F+F4LIKHNBcAIVr77lZ
        vx+ca3s/IsI/1a7f1YCO7YFuW
X-Received: by 2002:adf:a390:: with SMTP id l16mr39148256wrb.291.1634127691196;
        Wed, 13 Oct 2021 05:21:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTkyD1UVKzRrFV61FHdBE4Y7buV45IeIqTmyybPN8AIOWvYr+YRHziMwJhfqqGLO65loliiQ==
X-Received: by 2002:adf:a390:: with SMTP id l16mr39148230wrb.291.1634127690995;
        Wed, 13 Oct 2021 05:21:30 -0700 (PDT)
Received: from redhat.com ([2.55.30.112])
        by smtp.gmail.com with ESMTPSA id q14sm5174087wmq.4.2021.10.13.05.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 05:21:30 -0700 (PDT)
Date:   Wed, 13 Oct 2021 08:21:26 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Xie Yongji <xieyongji@bytedance.com>, jasowang@redhat.com,
        stefanha@redhat.com, virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kevin Wolf <kwolf@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v5] virtio-blk: Add validation for block size in config
 space
Message-ID: <20211013082025-mutt-send-email-mst@kernel.org>
References: <20210809101609.148-1-xieyongji@bytedance.com>
 <20211004112623-mutt-send-email-mst@kernel.org>
 <20211005062359-mutt-send-email-mst@kernel.org>
 <20211011114041.GB16138@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211011114041.GB16138@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 01:40:41PM +0200, Christoph Hellwig wrote:
> On Tue, Oct 05, 2021 at 06:42:43AM -0400, Michael S. Tsirkin wrote:
> > Stefan also pointed out this duplicates the logic from 
> > 
> >         if (blksize < 512 || blksize > PAGE_SIZE || !is_power_of_2(blksize))
> >                 return -EINVAL;
> > 
> > 
> > and a bunch of other places.
> > 
> > 
> > Would it be acceptable for blk layer to validate the input
> > instead of having each driver do it's own thing?
> > Maybe inside blk_queue_logical_block_size?
> 
> I'm pretty sure we want down that before.  Let's just add a helper
> just for that check for now as part of this series.  Actually validating
> in in blk_queue_logical_block_size seems like a good idea, but returning
> errors from that has a long tail.

Xie Yongji, I think I will revert this patch for now - can you
please work out adding that helper and using it in virtio?

Thanks,

-- 
MST

