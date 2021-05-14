Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA658380448
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 09:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbhENHc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 03:32:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43971 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230462AbhENHc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 03:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620977477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qEwXortYNaxldB+sCYne8sqnUUpZSsLp70/SckpgE3s=;
        b=R9AyFejiWPzfw8MvZfhImgAY1fhqGcfyoj0AYBWCXpx4jDlkasYVKhirI5F3EMxju16FoK
        oIKdUVPbaNlF7Q33lSKEaVREKfbBc4mASmNabLkfLFDUTdsstkrvKacwwfoPTvjOWs7aDp
        lQk/paMXyCjMTJ/tdDq790DTOZi+/8I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-3TUcTjVlPJWIq_bO95hhPw-1; Fri, 14 May 2021 03:31:15 -0400
X-MC-Unique: 3TUcTjVlPJWIq_bO95hhPw-1
Received: by mail-wr1-f72.google.com with SMTP id r12-20020adfc10c0000b029010d83323601so12359055wre.22
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 00:31:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qEwXortYNaxldB+sCYne8sqnUUpZSsLp70/SckpgE3s=;
        b=o+IvgtgiI693VqW9d2rw56u9q566EPZFEAS66QpUCgG4I3G7y9OCj1niJ/cYt30Jxk
         sT81n6/AryohnE/H41oX4mPGMw2qOeOBAkD+cbHUA+afMsBbOhTi0njukKv5ZBO82wRx
         2tszFSgPylpQyEysv8WKZk2KOI5tYmOLburWd3JGrNLJeKpSXE4Cv9J/T05oSqCd/FO1
         K7+NNgNvDq3RkLVfC6T4f7GCmvTyuAGL+hoeVahG4SeGp2B6CfOXeGHJaoB7RAQsm3mz
         fYE2IswYRtcOn2mifq//fHNOKte5Sh+MRHzACqq6/res9MGWF5Z9LnIYCdNStWr63YVE
         ExyA==
X-Gm-Message-State: AOAM530MF96tSlrpMDW+qr+U/lQXUWYv+C92aH2aa5lhc76Eoe9I74iM
        0tD4pLjAOKX74GD9la3ouzIrTl4VbPpx77AmuXIL8T4N/5DzRhIT/YSw6xV5iGjkD4PcfizL0dZ
        vgfrFAX1dwmLnGWOlix38t7DG+LzadMVJhQ38ml+b
X-Received: by 2002:adf:ef8f:: with SMTP id d15mr56793933wro.326.1620977474226;
        Fri, 14 May 2021 00:31:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxG8avBVDLQcb88RwIjGEcI7lLXFcOmFPlv7+LK8Qxs01/mzkmQtnLTZTqGoCS/1yMev77rExPJWWaCKvsQL7A=
X-Received: by 2002:a2e:9c91:: with SMTP id x17mr24353676lji.385.1620977463809;
 Fri, 14 May 2021 00:31:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210423080942.2997-1-jasowang@redhat.com> <YJ1TgoFSwOkQrC+1@stefanha-x1.localdomain>
 <CACycT3v-2naEaXEtPqaKcGz8qpfnmp4VzrHefqLNhO=9=57jdQ@mail.gmail.com>
In-Reply-To: <CACycT3v-2naEaXEtPqaKcGz8qpfnmp4VzrHefqLNhO=9=57jdQ@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 14 May 2021 15:30:52 +0800
Message-ID: <CACGkMEvKByPZFwN8bU6_SfRbS9i43am7X5WGJQtE=Yh+YKWOHw@mail.gmail.com>
Subject: Re: Re: [RFC PATCH V2 0/7] Do not read from descripto ring
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        file@sect.tu-berlin.de, ashish.kalra@amd.com,
        konrad.wilk@oracle.com, kvm <kvm@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 2:07 PM Yongji Xie <xieyongji@bytedance.com> wrote:
>
> On Fri, May 14, 2021 at 12:27 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
> >
> > On Fri, Apr 23, 2021 at 04:09:35PM +0800, Jason Wang wrote:
> > > Sometimes, the driver doesn't trust the device. This is usually
> > > happens for the encrtpyed VM or VDUSE[1].
> >
> > Thanks for doing this.
> >
> > Can you describe the overall memory safety model that virtio drivers
> > must follow? For example:
> >
> > - Driver-to-device buffers must be on dedicated pages to avoid
> >   information leaks.
> >
> > - Driver-to-device buffers must be on dedicated pages to avoid memory
> >   corruption.
> >
> > When I say "pages" I guess it's the IOMMU page size that matters?
> >
> > What is the memory access granularity of VDUSE?
> >
>
> Now we use PAGE_SIZE as the access granularity. I think it should be
> safe to access the Driver-to-device buffers in VDUSE case because we
> also use bounce-buffering mechanism like swiotlb does.
>
> Thanks,
> Yongji
>

Yes, while at this, I wonder it's possible the re-use the swiotlb
codes for VDUSE, or having some common library for this. Otherwise
there would be duplicated codes (bugs).

Thanks

