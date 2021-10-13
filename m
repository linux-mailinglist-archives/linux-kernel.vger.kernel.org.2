Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D30942C020
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 14:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbhJMMgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 08:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhJMMgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 08:36:40 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB466C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 05:34:36 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id a25so9557882edx.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 05:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=icmQtzGW1I9aNeYIPHd+HyscMc2NTbBX1tevUyNL3tU=;
        b=8F3RiOv1P1mDb3ddBj4vql6etzsVA/HQ8bcyDNuhobirPCXuxk5IXPSrQqZZkBo3A+
         SHKFL0Rv8ONqLvky2T3/RtxFWy4omkDz2DFJyIKLX8SIZmILoe+CflWW84y56fM0FxMe
         iP1X66dCzePfV57iNCKktzMjSPSlNgrsNosysu0GxfCJRdwwGJlbaFf/QGtQuSGyZWhr
         7BpwKeu7Cwh2MHRTm0ZAxQ245e6w3l48WzVwmsz+8G9sbiqCEcv561SGNgQmqHMtRaps
         OcZ3081EIdTBRNIHuSoOnvkgoZ+KvCUTNY+TADO4S+KxNDXYtr5dR8rfsY7+CP+Bu8Ch
         AbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=icmQtzGW1I9aNeYIPHd+HyscMc2NTbBX1tevUyNL3tU=;
        b=gFoStXbqwSowiPSq2xbzgGxKGnNlsbxz/7mEB6aHBwsqnHuJKE7TNdBg+QjLIbPBhK
         jMUVhpbwxgU5tW5A2zVsBf4H4WgujD5JaztBPOTR7PUpzLCO3WNZIG6Gahrbd6zyV0rL
         o4rd2jR4xh8kty+2zc3ksAYYSBvAiFPGNw7dLYJ1lH+1CBludIQpylw8djhOlen22hJW
         YTeLK9XA2iZLjnQChBv46+l1FswZWA2gQWNcklSYv+R6LKbXpJEsZFRX/VJd7L7ovnGl
         juhwBgRjt0xp1zvLzcbu/4W6eZskceMPR4Jf0EC+f3TI5rUlEGai4fo28/JWBugjqiTr
         Sn3A==
X-Gm-Message-State: AOAM532noTxSW8DI0/SOgycMwonrR5np5jUhVXGdnD/R6c02TORcQD6+
        jAkm5zclsuC1dgiKWlQqqfyTYqQQ9zjjJNd4MfFm
X-Google-Smtp-Source: ABdhPJyfYzVDUPCTtoyl0f5n4SxXJOTmC1gt1NZj33+zrO4ynP1olm0Bwx0j0M4Az/r6K1E6b9k1QSdeoXTTaK51Zfk=
X-Received: by 2002:a17:906:5590:: with SMTP id y16mr40139659ejp.286.1634128473086;
 Wed, 13 Oct 2021 05:34:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210809101609.148-1-xieyongji@bytedance.com> <20211004112623-mutt-send-email-mst@kernel.org>
 <20211005062359-mutt-send-email-mst@kernel.org> <20211011114041.GB16138@lst.de>
 <20211013082025-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211013082025-mutt-send-email-mst@kernel.org>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Wed, 13 Oct 2021 20:34:22 +0800
Message-ID: <CACycT3skLJp1HfovKP8AvQmdxhyJNG6YFrb6kXjd48qaztHBNQ@mail.gmail.com>
Subject: Re: [PATCH v5] virtio-blk: Add validation for block size in config space
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kevin Wolf <kwolf@redhat.com>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 8:21 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Oct 11, 2021 at 01:40:41PM +0200, Christoph Hellwig wrote:
> > On Tue, Oct 05, 2021 at 06:42:43AM -0400, Michael S. Tsirkin wrote:
> > > Stefan also pointed out this duplicates the logic from
> > >
> > >         if (blksize < 512 || blksize > PAGE_SIZE || !is_power_of_2(blksize))
> > >                 return -EINVAL;
> > >
> > >
> > > and a bunch of other places.
> > >
> > >
> > > Would it be acceptable for blk layer to validate the input
> > > instead of having each driver do it's own thing?
> > > Maybe inside blk_queue_logical_block_size?
> >
> > I'm pretty sure we want down that before.  Let's just add a helper
> > just for that check for now as part of this series.  Actually validating
> > in in blk_queue_logical_block_size seems like a good idea, but returning
> > errors from that has a long tail.
>
> Xie Yongji, I think I will revert this patch for now - can you
> please work out adding that helper and using it in virtio?
>

Fine, I will do it.

Thanks,
Yongji
