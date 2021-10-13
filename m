Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4C642C095
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 14:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbhJMMxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 08:53:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32526 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232486AbhJMMxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 08:53:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634129503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T/7FiCB1ISKOEoQmv0h0vU/4qoNS1mIBBsK6BA/38aI=;
        b=eQS7Da+meQrkDunshiehhtY1ofFpXtpZtF/twq99yQcJcmUJMxuoTZ2UJsa0BHsLHc8jj/
        ZHCTLf0Ko/8V4tFPq3QoU4wsxJ2TWm1Isj2B8XxVKp/xSLwGWxUy/RKoFQlTWKnwGYkTK7
        Xyfex4ajtKs1xhO/X87muA8CgVTcxv4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-344-8gWyMqKmd-56IGmDXw-1; Wed, 13 Oct 2021 08:51:41 -0400
X-MC-Unique: 344-8gWyMqKmd-56IGmDXw-1
Received: by mail-wr1-f69.google.com with SMTP id d13-20020adf9b8d000000b00160a94c235aso1916324wrc.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 05:51:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T/7FiCB1ISKOEoQmv0h0vU/4qoNS1mIBBsK6BA/38aI=;
        b=VU1umoWIPVQORbIPzMZk1q9SwZOk96tTjxfWNsLpbHNRIWX8/h2JvqnrT50tvmcVTt
         HFR4UbRzbV+3ImrlFvBpi/PMtaK06hYEiqX7ZlzpmMm6/M9aq5tnENS9XHjzdtzwscFp
         NGXR+9DbzMkKEtcrR4HCBZWmsVI7tL8KvktPGON8KBQZGH99W8Ka8wwOnU5jpEykLQqK
         VFm6izIRiID57ZzZ1aZ6kOFUd1RnN4dISGwiS3cx7wWdUnvHgv9wL/JU/lQLf2Oow6P6
         F7gAwh1RICuiYnec9UOAVlKSb3Z+gBVnGfQH89XizXPkK8FXN2i9zDgbZG/ifvF7zNVp
         F+zQ==
X-Gm-Message-State: AOAM5311b1hanjxGM7BFvdtVhOkfig6FfeyXU0e+pyV9urdDPJIo1wo3
        hiXrmd3k2ZVGHzQ8Kk9tllp0IEmOauotV2MtRpiNekede0nPRifmBsjTtxEPWooBtfnzTWYIRmU
        tAT+PRWmNskhk/eKun6ggw/0y
X-Received: by 2002:a1c:29c7:: with SMTP id p190mr12443695wmp.65.1634129500756;
        Wed, 13 Oct 2021 05:51:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxXShSsCgY6/PDbrJUPITVtStrZWvnffqdaNuTNNoDSChn1zbY5sZOccceeIhneM0FjogR/A==
X-Received: by 2002:a1c:29c7:: with SMTP id p190mr12443682wmp.65.1634129500615;
        Wed, 13 Oct 2021 05:51:40 -0700 (PDT)
Received: from redhat.com ([2.55.30.112])
        by smtp.gmail.com with ESMTPSA id j1sm16548759wrb.56.2021.10.13.05.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 05:51:40 -0700 (PDT)
Date:   Wed, 13 Oct 2021 08:51:36 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kevin Wolf <kwolf@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v5] virtio-blk: Add validation for block size in config
 space
Message-ID: <20211013084711-mutt-send-email-mst@kernel.org>
References: <20210809101609.148-1-xieyongji@bytedance.com>
 <20211004112623-mutt-send-email-mst@kernel.org>
 <20211005062359-mutt-send-email-mst@kernel.org>
 <20211011114041.GB16138@lst.de>
 <20211013082025-mutt-send-email-mst@kernel.org>
 <CACycT3skLJp1HfovKP8AvQmdxhyJNG6YFrb6kXjd48qaztHBNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACycT3skLJp1HfovKP8AvQmdxhyJNG6YFrb6kXjd48qaztHBNQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 08:34:22PM +0800, Yongji Xie wrote:
> On Wed, Oct 13, 2021 at 8:21 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Oct 11, 2021 at 01:40:41PM +0200, Christoph Hellwig wrote:
> > > On Tue, Oct 05, 2021 at 06:42:43AM -0400, Michael S. Tsirkin wrote:
> > > > Stefan also pointed out this duplicates the logic from
> > > >
> > > >         if (blksize < 512 || blksize > PAGE_SIZE || !is_power_of_2(blksize))
> > > >                 return -EINVAL;
> > > >
> > > >
> > > > and a bunch of other places.
> > > >
> > > >
> > > > Would it be acceptable for blk layer to validate the input
> > > > instead of having each driver do it's own thing?
> > > > Maybe inside blk_queue_logical_block_size?
> > >
> > > I'm pretty sure we want down that before.  Let's just add a helper
> > > just for that check for now as part of this series.  Actually validating
> > > in in blk_queue_logical_block_size seems like a good idea, but returning
> > > errors from that has a long tail.
> >
> > Xie Yongji, I think I will revert this patch for now - can you
> > please work out adding that helper and using it in virtio?
> >
> 
> Fine, I will do it.
> 
> Thanks,
> Yongji

Great, thanks! And while at it, pls research a bit more and mention
in the commit log what is the result of an illegal blk size?
Is it memory corruption? A catastrophic failure?
If it's one of these cases, then it's ok to just fail probe.

-- 
MST

