Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F39E3C6CB8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 10:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbhGMI6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 04:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234599AbhGMI6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 04:58:17 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08F0C0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 01:55:27 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id y8so26204813iop.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 01:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8N5vxZ+XOSZKbHdolxGC0+lxunV1DuxqjzH0fWfK6pg=;
        b=Ea/lB5m0qpzAGNCrLW9/eTdpJ7fn5dESxi0iIvMUhhUK2sxTbNryT7fLdpsZXugZFg
         XjYS9dPFFEQVnQHtkmx0ZzReho38PIyLQycr1pfiKaPA/CG0ixp7jlObGt/hJE0vrbaU
         ZaJfrlRKnEAVO9o4Fc3k1TM7wAEYcTf7xB0y1IqqvmZYOhUc8iIXZIMy+gakPO20WqzD
         VnCaove9rBf4m99Wa4nrM22HnkP1gCmTpCYt+QIjpHgPI1x8IYui/sV11kDUBtQIc8wH
         RIc9nhoeM05hl6Xk01iGKgFPsCER7Z44FNNgTIBkWW86Oengfug0Tk3ZP9DAnsOrd7K8
         vjlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8N5vxZ+XOSZKbHdolxGC0+lxunV1DuxqjzH0fWfK6pg=;
        b=jOKhGjKCv7TQjAgHDutNkJk2Tt4HomS8wuDZf8MQzdG0bwTNXYjx8eozlrLncME8l6
         Qmdi8MaUeJZVVYzMq+fYKXKrIq0BC62XOZyNg91wdUDeUBvuPAeaMv97OucTbSO6gNjf
         RwXelqcirX7z2KcAidDRupsZWDbSgvU7Z6aGTzDBllPCNdiDU3znRvISQ0R9o8vn44nd
         4ATEQl+pv1hhQ2noA/GtOiSPLUb4zuzzWO3bCgD1RaMoyF5HiMGDLPJfRo3ia4qRdnYQ
         QdWPYasTPqgay7UJt1qL5noE+gqJcR1ftxQ/1plHjhI0g5QzJPelKVL38nUs3vnVcFka
         JBhA==
X-Gm-Message-State: AOAM531RddmOqZpcESQ6fzn5T/RvZyofhRSJ99HGn7I3MeOqPCqVlSG7
        uiHjg8PaH/aZR8QRdUM33lzYyATbQ5KN81ceTLQA1A==
X-Google-Smtp-Source: ABdhPJwQFi0gughVz6hGyUli3OcpQDysiaCpxIUKrfimeC3Iqz/Ng2CI6wAEyfv1x/QZryBR/5jbWzTe3QxDljMJNNg=
X-Received: by 2002:a5d:87d0:: with SMTP id q16mr2438017ios.109.1626166527031;
 Tue, 13 Jul 2021 01:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210707062157.21176-1-yunfei.dong@mediatek.com>
 <20210707062157.21176-8-yunfei.dong@mediatek.com> <CA+Px+wUjJwksVfU6N8VZ9WMw-F-DHu67XwvDvMoiMcUBKF=P6Q@mail.gmail.com>
 <1626074875.7221.15.camel@mhfsdcap03>
In-Reply-To: <1626074875.7221.15.camel@mhfsdcap03>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Tue, 13 Jul 2021 16:55:16 +0800
Message-ID: <CA+Px+wUK=4iAk+OG1wCFHMdi5+japOngCEoY9g9bSbNNLKca2Q@mail.gmail.com>
Subject: Re: [PATCH v1, 07/14] media: mtk-vcodec: Add msg queue feature for
 lat and core architecture
To:     mtk12024 <Yunfei.Dong@mediatek.com>
Cc:     Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Irui Wang <irui.wang@mediatek.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 3:28 PM mtk12024 <yunfei.dong@mediatek.com> wrote:
> On Fri, 2021-07-09 at 17:39 +0800, Tzung-Bi Shih wrote:
> > On Wed, Jul 7, 2021 at 2:22 PM Yunfei Dong <yunfei.dong@mediatek.com> wrote:
> > Doesn't it need to call mtk_vcodec_mem_free() and kfree() for any failure paths?
> When allocate memory fail, will call deinit function auto, then free all allocated memory.
I guess you mean: if vdec_msg_queue_init() fails,
vdec_msg_queue_deinit() should be called?

If so:
- It is not "auto".  It depends on callers to invoke _deinit() if _init() fails.
- The API usage would be a bit weird: if the object hasn't been
initialized, shall we de-initialize it?

> > > +struct vdec_lat_buf *vdec_msg_queue_get_core_buf(
> > > +       struct mtk_vcodec_dev *dev)
> > > +{
> > > +       struct vdec_lat_buf *buf;
> > > +       int ret;
> > > +
> > > +       spin_lock(&dev->core_lock);
> > > +       if (list_empty(&dev->core_queue)) {
> > > +               mtk_v4l2_debug(3, "core queue is NULL, num_core = %d", dev->num_core);
> > > +               spin_unlock(&dev->core_lock);
> > > +               ret = wait_event_freezable(dev->core_read,
> > > +                       !list_empty(&dev->core_queue));
> > > +               if (ret)
> > > +                       return NULL;
> > Should be !ret?
> According the definidtion, when condition is true, return value is 0.
Yeah, you're right.  I was confused a bit with wait_event_timeout().

> > > +bool vdec_msg_queue_wait_lat_buf_full(struct vdec_msg_queue *msg_queue)
> > > +{
> > > +       long timeout_jiff;
> > > +       int ret, i;
> > > +
> > > +       for (i = 0; i < NUM_BUFFER_COUNT + 2; i++) {
> > > +              timeout_jiff = msecs_to_jiffies(1000);
> > > +              ret = wait_event_timeout(msg_queue->lat_read,
> > > +                    msg_queue->num_lat == NUM_BUFFER_COUNT, timeout_jiff);
> > > +              if (ret) {
> > > +                     mtk_v4l2_debug(3, "success to get lat buf: %d",
> > > +                            msg_queue->num_lat);
> > > +                     return true;
> > > +              }
> > > +       }
> > Why does it need the loop?  i is unused.
> Core maybe decode timeout, need to wait all core buffer process
> completely.
The point is: the i is unused.  If it needs more time to complete,
could it just wait for (NUM_BUFFER_COUNT + 2) * 1000 msecs?

> > > +       msg_queue->init_done = false;
> > Have no idea what init_done does in the code.  It is not included in
> > any branch condition.
> When call vdec_msg_queue_init will set this parameter to true.
The point is: if init_done doesn't change any code branch but just a
flag, does it really need the flag?

For example usages:
- If see the msg_queue->init_done has already been set to true in
vdec_msg_queue_init(), return errors.
- If see the msg_queue->init_done has already been set to false in
vdec_msg_queue_deinit(), return errors.

In the cases, I believe it brings very limited benefit (i.e. the
msg_queue is likely to _init and _deinit only once).

> > > +/**
> > > + * vdec_msg_queue_get_core_buf - get used core buffer for lat decode.
> > > + * @dev: mtk vcodec device
> > > + */
> > > +struct vdec_lat_buf *vdec_msg_queue_get_core_buf(
> > > +       struct mtk_vcodec_dev *dev);
> > This is weird: vdec_msg_queue's operator but manipulating mtk_vcodec_dev?
> vdec_msg_queue is used to share message between lat and core, for each
> instance has its lat msg queue list, but all instance share one core msg
> queue list. When try to get core buffer need to get it from core queue
> list. Then queue it to lat queue list when core decode done.
I guess you mean: during runtime, it has n lat queues and 1 core queue.

If so, would it be intuitive and simple by:

msg_queue *core_q;
msg_queue *lat_q[LAT_N];

vdec_msg_queue_dequeue(core_q) if it wants to get from core queue.
vdec_msg_queue_enqueue(lat_q[X], data) if it wants to put data to lat queue X.

> > > +/**
> > > + * vdec_msg_queue_buf_to_lat - queue buf to lat for lat decode.
> > > + * @buf: current lat buffer
> > > + */
> > > +void vdec_msg_queue_buf_to_lat(struct vdec_lat_buf *buf);
> > It should at least accept a struct vdec_msg_queue argument (or which
> > msg queue should the buf put into?).
> All buffer is struct vdec_lat_buf, used to share info between lat and core queue list.
The API semantic needs to provide a way to specify which msg_queue the
buf would put into.

> > The position of struct vdec_msg_queue is weird.  It looks like the msg
> > queue is only for struct vdec_lat_buf.  If so, would vdec_msg_queue be
> > better to call vdec_lat_queue or something similar?
> >
> > It shouldn't touch the core queue in mtk_vcodec_dev anyway.  Is it
> > possible to generalize the queue-related code for both lat and core
> > queues?
> Lat queue list is separately for each instance, but only has one core
> queue list.
Suggested to generalize the vdec_msg_queue to handle both lat and core
(and maybe furthermore).  See comment above.
