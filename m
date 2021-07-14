Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86AC63C7DEA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 07:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237925AbhGNF1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 01:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237910AbhGNF1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 01:27:06 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C42C0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 22:24:14 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id hc15so1296994ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 22:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IR3H7P/Qqdz0+z7mAz+4BcJc0mjzsggsr8mNH8312vk=;
        b=J2IDtTc5DxsvAMq/DAkPuYqj0Y7dNpRgm5w+Q5Mo3F1Au3zIy957DexG4xM3ot9TeB
         gz7qUXOBffxs7ZJq8NwJJx3+F2yWdVty637g3WtUU13nzkMXjdWWulrIly/TOJxD+Hyy
         /NqXLpxJ8/rX9zvF4onj7kuKA/hY855NC/q2nDjsHgyYw3/sSLkn4POQUtEcySzhEGrh
         CDn9h5b45a/ov20IIHnvFDOFr1x5Vomj6Ve9ZjPNFGa6QG+3p9U0VzK3a00J7z6C/fWK
         eWV/SVtA1pGWD7wh4Q6+tQY/Bv7Ble6R8AihTwasCDJOPdVPj+NAufXpshOEW+KCfFKO
         W7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IR3H7P/Qqdz0+z7mAz+4BcJc0mjzsggsr8mNH8312vk=;
        b=sh5fdB94Odic56NnJM9WVXBmh8+JWlYps7M/AK6JhnOsKuIUCCQhYX3roKxJ5t7ohc
         anUmwnurfOqp8rCMBdc2YbC89sdEMYmfjKgV+aZbu8XgJUsW12aIrSqlUSmbQ45lE+sx
         JqXp6gS8jCwtPufTOy53s68QLEzvo+VMTagq1Wps+7iabpvMCUiNUbuNB6r8fo+xIGZP
         RKaPVA9HKhx/KjMsb/qTBTusjF3a8gmOZPdRlSkS9D2UYJbVWMA2KIMUPlhTvhakmbMJ
         IBYMhYRv4IP+7s6/UEVwZ5tuoUjzTZBXwPohSZbGbeVaPaaDmCMUGfTnQN8XpJ65RNju
         yDsQ==
X-Gm-Message-State: AOAM530LNUGbPauCnAkw2HJnA5Hb2opq3qVTkStJIaAKk4hzuSWZH2RV
        O2VXRkVgoPQsNCy5SIfSIDLH9vvrAi99Uda9C/GJ
X-Google-Smtp-Source: ABdhPJwiVScNvW759FNHFZbUm6bF1Hh8xD+5SHXF+XpeC6RBKLMlly39eCK/TlQciP+Rhit5f+SlsKPq8Beb+93M0R0=
X-Received: by 2002:a17:906:4b46:: with SMTP id j6mr10270164ejv.247.1626240253024;
 Tue, 13 Jul 2021 22:24:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210713084656.232-1-xieyongji@bytedance.com> <20210713084656.232-14-xieyongji@bytedance.com>
 <20210713113114.GL1954@kadam>
In-Reply-To: <20210713113114.GL1954@kadam>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Wed, 14 Jul 2021 13:24:02 +0800
Message-ID: <CACycT3uKwu5xzj2ynWH5njCKHaYyOPkDb8BVLTHE5NJ-qpD3xQ@mail.gmail.com>
Subject: Re: [PATCH v9 13/17] vdpa: factor out vhost_vdpa_pa_map() and vhost_vdpa_pa_unmap()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Parav Pandit <parav@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <christian.brauner@canonical.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, bcrl@kvack.org,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>,
        joro@8bytes.org, Greg KH <gregkh@linuxfoundation.org>,
        He Zhe <zhe.he@windriver.com>,
        Liu Xiaodong <xiaodong.liu@intel.com>,
        songmuchun@bytedance.com,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev@vger.kernel.org, kvm <kvm@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 7:31 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Tue, Jul 13, 2021 at 04:46:52PM +0800, Xie Yongji wrote:
> > @@ -613,37 +618,28 @@ static void vhost_vdpa_unmap(struct vhost_vdpa *v, u64 iova, u64 size)
> >       }
> >  }
> >
> > -static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
> > -                                        struct vhost_iotlb_msg *msg)
> > +static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
> > +                          u64 iova, u64 size, u64 uaddr, u32 perm)
> >  {
> >       struct vhost_dev *dev = &v->vdev;
> > -     struct vhost_iotlb *iotlb = dev->iotlb;
> >       struct page **page_list;
> >       unsigned long list_size = PAGE_SIZE / sizeof(struct page *);
> >       unsigned int gup_flags = FOLL_LONGTERM;
> >       unsigned long npages, cur_base, map_pfn, last_pfn = 0;
> >       unsigned long lock_limit, sz2pin, nchunks, i;
> > -     u64 iova = msg->iova;
> > +     u64 start = iova;
> >       long pinned;
> >       int ret = 0;
> >
> > -     if (msg->iova < v->range.first ||
> > -         msg->iova + msg->size - 1 > v->range.last)
> > -             return -EINVAL;
>
> This is not related to your patch, but can the "msg->iova + msg->size"
> addition can have an integer overflow.  From looking at the callers it
> seems like it can.  msg comes from:
>   vhost_chr_write_iter()
>   --> dev->msg_handler(dev, &msg);
>       --> vhost_vdpa_process_iotlb_msg()
>          --> vhost_vdpa_process_iotlb_update()
>
> If I'm thinking of the right thing then these are allowed to overflow to
> 0 because of the " - 1" but not further than that.  I believe the check
> needs to be something like:
>
>         if (msg->iova < v->range.first ||
>             msg->iova - 1 > U64_MAX - msg->size ||
>             msg->iova + msg->size - 1 > v->range.last)
>

Make sense.

> But writing integer overflow check correctly is notoriously difficult.
> Do you think you could send a fix for that which is separate from the
> patcheset?  We'd want to backport it to stable.
>

OK, I will send a patch to fix it.

Thanks,
Yongji
