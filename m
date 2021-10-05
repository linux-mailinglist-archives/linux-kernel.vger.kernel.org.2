Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 732DF422CE0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 17:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236229AbhJEPr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 11:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236196AbhJEPrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 11:47:23 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2378CC061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 08:45:33 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id b8so553761edk.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 08:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K2e0futlAUbG+ZdLC/9LMtsaBsYQ0WPqxpYvW+YkyEo=;
        b=VRCTSDdGeAGVvNS1RUoTz5PszOfL72feK18/dfZnw9XHNt+6kQUg80oHAV7pKyB4yT
         AWZC5ymtzB39r5pB8ciNshfO6VEtHwvOS/gRieB40iZnMAUKRumhOabt3IYkHfbuMlws
         LqTSE5POXxu7Csyv+DCju2OliIXZM9am8CZMlHPnP0lkKbf8h5zaDnPgGkYkyGWlwH6s
         VQ6/TbjksPZgUh4cZGq1c1vfDJCu7CjxlF/U9JMSoE+3SwMTaRwsI9RI12aPOrjWxaK2
         7on9qeQptckV/kDe8Awtzs6rA/wLBNDl4ZsWXSpuYgbXNNUhiAYTZ2AP3Q3BtzK+qSzL
         OdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K2e0futlAUbG+ZdLC/9LMtsaBsYQ0WPqxpYvW+YkyEo=;
        b=FeqW+xCuYetGQjbj8/2zcLkRO6WwIwEKNtob7cpYJKY7c5JSbrzyjbkG0DpgNcQ6Be
         y0pIsVdXaoKvGLNULLlFyLTnxNQuqmbjH6Unur1VCCK+q6dhftrJu7CHKcBUmoOVy9Bh
         BQGInJximCEcyupe9Isf3SWVkgF0DqR8R7yrvtvcOkhQt0T6wiWI6QbpeK5ERql9AHxE
         gIYEoEm8L6rWbQ6a3Fylp9RPaCePsNCcZR2Npi9Z4jVdLFJVZpR/S9ocGPH6gBp+OQcJ
         u2EI1xg3lEXRXNIvoAsq/MIt2HCfi9TMFiGXgjHWW4hMM/FOhboCQolqKuo85OC4uZhd
         JUDA==
X-Gm-Message-State: AOAM530OHjy3xV5/RJaptCyoubQtBH67mbN++B7GjqdcNwM/nA+I8iYB
        KfTrH9AkEacTUqKS/KIf2pBNVXYSFWCFTl8Hps2a
X-Google-Smtp-Source: ABdhPJwSAmk0A7TVnFboIgJpdzqg4ajMWT69rrynDmD428vE3IVUAInjGd+MJVcv0aCPu2UuQlLCg1XO4RvUZ0WzUhY=
X-Received: by 2002:a17:906:2cd6:: with SMTP id r22mr24839647ejr.398.1633448731742;
 Tue, 05 Oct 2021 08:45:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210809101609.148-1-xieyongji@bytedance.com> <20211004112623-mutt-send-email-mst@kernel.org>
 <20211005062359-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211005062359-mutt-send-email-mst@kernel.org>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Tue, 5 Oct 2021 23:45:31 +0800
Message-ID: <CACycT3tUSem1ovOjykmg2Y5+uUaqsiDkFAjrt7SFkJCc9LGbAA@mail.gmail.com>
Subject: Re: [PATCH v5] virtio-blk: Add validation for block size in config space
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kevin Wolf <kwolf@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 5, 2021 at 6:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Oct 04, 2021 at 11:27:29AM -0400, Michael S. Tsirkin wrote:
> > On Mon, Aug 09, 2021 at 06:16:09PM +0800, Xie Yongji wrote:
> > > An untrusted device might presents an invalid block size
> > > in configuration space. This tries to add validation for it
> > > in the validate callback and clear the VIRTIO_BLK_F_BLK_SIZE
> > > feature bit if the value is out of the supported range.
> > >
> > > And we also double check the value in virtblk_probe() in
> > > case that it's changed after the validation.
> > >
> > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> >
> > So I had to revert this due basically bugs in QEMU.
> >
> > My suggestion at this point is to try and update
> > blk_queue_logical_block_size to BUG_ON when the size
> > is out of a reasonable range.
> >
> > This has the advantage of fixing more hardware, not just virtio.
> >
>
> Stefan also pointed out this duplicates the logic from
>
>         if (blksize < 512 || blksize > PAGE_SIZE || !is_power_of_2(blksize))
>                 return -EINVAL;
>
>
> and a bunch of other places.
>
>
> Would it be acceptable for blk layer to validate the input
> instead of having each driver do it's own thing?
> Maybe inside blk_queue_logical_block_size?
>

Now the nbd and loop driver will validate the blksize and return error
if it's invalid. But the nvme and null_blk driver just corrects the
blksize to a reasonable range without returning any error. I'm not
sure which way the block layer should follow. Or just simplify the
logic in nbd and loop driver?

Thanks,
Yongji
