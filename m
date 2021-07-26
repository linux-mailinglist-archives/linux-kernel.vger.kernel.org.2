Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2454B3D5294
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 06:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhGZEBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 00:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhGZEBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 00:01:18 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD86C061760
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 21:41:47 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id a4-20020a17090aa504b0290176a0d2b67aso9498375pjq.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 21:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8ZBSCcsGTJdG/1v5hzEBkqxUow23YkweSoQTFwIhEd4=;
        b=Gb6poVgwq1pZisbIC+XwJw6buiieuGrjwv15EYmPWOTch/AZJLX5cuYUOi3U65Zb5o
         p1Y0YK6pXoAkT9TfWb74UBG9HNT5ee7KKbdfWoreJ+5FXFXqheZrn08qseyjC33c0ew6
         mfnvBOI6HNcs9LErXwIMULrY0+TfWgKTrGwxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8ZBSCcsGTJdG/1v5hzEBkqxUow23YkweSoQTFwIhEd4=;
        b=jxhjIheyCulqD3ZiIk6OxWlFEojeeRfXGrjiBlTRWW1rq+/ppI6WaWtXRsx/29Uvaz
         6C0tq2sy4HXq1Gp7hUUqo99z0YAqlsrCqK5lf6wrW7NBZoA/dWIKpXBPRLVjqTrac6+d
         t0Qa36rIjeEiYKN5/jxN6HsZCwAykpfLhc/29EtiRN5M6CTu+isKlc+qNVFNELRnkec0
         H6nusGSwMud0S9MR3uGgAgq3OvSONVrItcxSzSQ2hh3jrlQ9g/An/2u71tKdy7ZT6WRZ
         HHfjgLEml+JYn+RJxp8Abpu9wU4k2ffep1C/g/R9SjetqOIi0xsqfsrEggRxYNcvHWIi
         D1tg==
X-Gm-Message-State: AOAM532LQ1dGUX/12anJqWEhYgrvBZ4sB/0wumjr2cMQTcpizYOKkTuu
        PpYURVFunbyCCPoAn0rtc9gRTQ==
X-Google-Smtp-Source: ABdhPJzUzFlQ+Pjqwtmir6LrcOIhi/ohkiCuiR+1AP+9NfHy/jk8BIiQPQ7546FqmO2u/IIYfIu7Rw==
X-Received: by 2002:a62:30c5:0:b029:31e:fa6d:1738 with SMTP id w188-20020a6230c50000b029031efa6d1738mr15771176pfw.55.1627274506887;
        Sun, 25 Jul 2021 21:41:46 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:d699:4331:827:4150])
        by smtp.gmail.com with ESMTPSA id k198sm43382679pfd.148.2021.07.25.21.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 21:41:46 -0700 (PDT)
Date:   Mon, 26 Jul 2021 13:41:41 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>
Subject: Re: [PATCHv3 7/8] videobuf2: handle V4L2_MEMORY_FLAG_NON_COHERENT
 flag
Message-ID: <YP49BYMHoea202u6@google.com>
References: <20210709092027.1050834-1-senozhatsky@chromium.org>
 <20210709092027.1050834-8-senozhatsky@chromium.org>
 <0c89ef1e-8abb-8749-bbce-c7e5a2e2f304@collabora.com>
 <YP4Sfo0PjLokYi3B@google.com>
 <YP40paMcGjlfofi8@google.com>
 <YP439RUKhVeAm945@google.com>
 <CAAFQd5D=7Ao_gaxLamf8rv_QWxdemh=KZKdGU-1HFfY7L8A3MQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAFQd5D=7Ao_gaxLamf8rv_QWxdemh=KZKdGU-1HFfY7L8A3MQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/07/26 13:22), Tomasz Figa wrote:
> > > I guess ->flags can become u8 for both create-bufs and req-bufs.
> > > We had ->flags in both structs as u32, but then decided to leave
> > > some reserved[] space in req-bufs and switched to u8 there.
> >
> > diff --git a/Documentation/userspace-api/media/v4l/vidioc-create-bufs.rst b/Documentation/userspace-api/media/v4l/vidioc-create-bufs.rst
> > index a048a9f6b7b6..cf633b5a4919 100644
> > --- a/Documentation/userspace-api/media/v4l/vidioc-create-bufs.rst
> > +++ b/Documentation/userspace-api/media/v4l/vidioc-create-bufs.rst
> > @@ -112,13 +112,13 @@ than the number requested.
> >         other changes, then set ``count`` to 0, ``memory`` to
> >         ``V4L2_MEMORY_MMAP`` and ``format.type`` to the buffer type.
> >
> > -    * - __u32
> > +    * - __u8
> >        - ``flags``
> >        - Specifies additional buffer management attributes.
> >         See :ref:`memory-flags`.
> >
> > -    * - __u32
> > -      - ``reserved``\ [6]
> > +    * - __u8
> > +      - ``reserved``\ [27]
> >        - A place holder for future extensions. Drivers and applications
> >         must set the array to zero.
> >
> > diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> > index 6edf4508c636..2ae949ec0afa 100644
> > --- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
> > +++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> > @@ -694,7 +694,7 @@ static void fill_buf_caps(struct vb2_queue *q, u32 *caps)
> >
> >  static void validate_memory_flags(struct vb2_queue *q,
> >                                   int memory,
> > -                                 u32 *flags)
> > +                                 u8 *flags)
> >  {
> >         if (!q->allow_cache_hints || memory != V4L2_MEMORY_MMAP) {
> >                 /*
> > @@ -711,11 +711,9 @@ static void validate_memory_flags(struct vb2_queue *q,
> >  int vb2_reqbufs(struct vb2_queue *q, struct v4l2_requestbuffers *req)
> >  {
> >         int ret = vb2_verify_memory_type(q, req->memory, req->type);
> > -       u32 flags = req->flags;
> >
> >         fill_buf_caps(q, &req->capabilities);
> > -       validate_memory_flags(q, req->memory, &flags);
> > -       req->flags = flags;
> > +       validate_memory_flags(q, req->memory, &req->flags);
> >         return ret ? ret : vb2_core_reqbufs(q, req->memory,
> >                                             req->flags, &req->count);
> >  }
> > @@ -990,11 +988,9 @@ int vb2_ioctl_reqbufs(struct file *file, void *priv,
> >  {
> >         struct video_device *vdev = video_devdata(file);
> >         int res = vb2_verify_memory_type(vdev->queue, p->memory, p->type);
> > -       u32 flags = p->flags;
> >
> >         fill_buf_caps(vdev->queue, &p->capabilities);
> > -       validate_memory_flags(vdev->queue, p->memory, &flags);
> > -       p->flags = flags;
> > +       validate_memory_flags(vdev->queue, p->memory, &p->flags);
> >         if (res)
> >                 return res;
> >         if (vb2_queue_is_busy(vdev, file))
> > diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> > index 7973aa0465d2..ad4f7cee53f2 100644
> > --- a/include/uapi/linux/videodev2.h
> > +++ b/include/uapi/linux/videodev2.h
> > @@ -2513,8 +2513,8 @@ struct v4l2_create_buffers {
> >         __u32                   memory;
> >         struct v4l2_format      format;
> >         __u32                   capabilities;
> > -       __u32                   flags;
> > -       __u32                   reserved[6];
> > +       __u8                    flags;
> > +       __u8                    reserved[27];
> >  };
> >
> >  /*
> 
> I don't think we want this UABI churn anymore for a trivial
> simplification in the implementation.

OK, I can scratch it. I thought that for API symmetry we can have
::memory-flags of the same type/size in create-bufs and req-bufs,
but don't have any strong opinion on this.
