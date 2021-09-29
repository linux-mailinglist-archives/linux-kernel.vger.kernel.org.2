Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF56841C0FB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 10:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244911AbhI2Ixw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 04:53:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40169 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244897AbhI2Ixv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 04:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632905530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2IuDph5pgXKhZLx55AOzdRIaR0YtM8hQePA5+y0Dae8=;
        b=PY1sbZAkUKZ2kHeGD2/NDQeHtIb2yfD988eNhXZ2F4X+FCCy/+7uVFYKh9uZsazFChywEQ
        tEDVhjcME3ZwTJgxFzD8RcqGXIBQCaXZh5YghnlpnadTKfHpjfRkGCr2MnfjLAuYsql8iP
        EW68D+Rs2s+U9KaAiUjc9pDcqE0x3Ko=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-uMwxyBWgMcuBZQfkDYTaMQ-1; Wed, 29 Sep 2021 04:52:08 -0400
X-MC-Unique: uMwxyBWgMcuBZQfkDYTaMQ-1
Received: by mail-ed1-f71.google.com with SMTP id e7-20020a50d4c7000000b003d871ecccd8so1628670edj.18
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 01:52:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2IuDph5pgXKhZLx55AOzdRIaR0YtM8hQePA5+y0Dae8=;
        b=Oiqkps0Pf0RFxkINAEGkk65GT1ay1410lwCLkPILQj9EyoxfDhP5v+WUqpxA37n5pb
         A1TD7jbpu1AHdENHk3tHzOnyQqbWNlUopvpkEKnYCTVTmemkj1eP/zIe7D3Sg8ntDhL9
         0mNKFb0o6ZvLtDlgshvmm+LUieaR28pW+5aNjj+vrB2wMRhEnV7ExUb7Xu2v0iRWRMjg
         JMl/YHyBzcMIQF0VSHc0oJ2bEm0PkWKEUpkVqk0eMfZkLyftua+QUtqitTJnyTi2LWB8
         qVRzLBhf/2Qvvex73qapcIK6RH1+mEIYBsoIsntzgDURTLPx5ch7nbcYe5O4kL0+fHYd
         XeUQ==
X-Gm-Message-State: AOAM531wO6vO53qlOnL/fKpsnNAdXsK8RV5KyK4esKpZc/l9KM23OZn7
        1ylr9xKY2fjVzc0g/eK5BkE21mL+EdfdvnhNzuEhtOTjyy3Y6N/In0tcE5gQkjMxTQRgEfWCPuM
        cMKIkj2ZovgZ/wHU/TJtVcXBM37BqvpVL1zVMbzTb
X-Received: by 2002:a17:906:840f:: with SMTP id n15mr12381701ejx.336.1632905527363;
        Wed, 29 Sep 2021 01:52:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtqxbpW9CaUe0Zk3O9ATbb6SACyGDKbqk1vQT4Q7fBlmtOJCKDORBVyAo1j/qBryhevc0gJzRnOU81x+LCRFw=
X-Received: by 2002:a17:906:840f:: with SMTP id n15mr12381683ejx.336.1632905527171;
 Wed, 29 Sep 2021 01:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210929075437.12985-1-lulu@redhat.com> <20210929043142-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210929043142-mutt-send-email-mst@kernel.org>
From:   Cindy Lu <lulu@redhat.com>
Date:   Wed, 29 Sep 2021 16:51:29 +0800
Message-ID: <CACLfguX3TPD0VOUngNVDzB_JYPY6AnPP+Jd7bAKTq5egXw93sA@mail.gmail.com>
Subject: Re: [PATCH] vhost-vdpa:fix the worng input in config_cb
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 4:32 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Sep 29, 2021 at 03:54:37PM +0800, Cindy Lu wrote:
> > Fix the worng input in for config_cb,
> > in function vhost_vdpa_config_cb, the input
> > cb.private was used as struct vhost_vdpa,
> > So the inuput was worng here, fix this issue
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
>
> Maybe add
>
> Fixes: 776f395004d8 ("vhost_vdpa: Support config interrupt in vdpa")
>
> and fix typos in the commit log.
>
thanks Michael, I will post a new version
> > ---
> >  drivers/vhost/vdpa.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > index 942666425a45..e532cbe3d2f7 100644
> > --- a/drivers/vhost/vdpa.c
> > +++ b/drivers/vhost/vdpa.c
> > @@ -322,7 +322,7 @@ static long vhost_vdpa_set_config_call(struct vhost_vdpa *v, u32 __user *argp)
> >       struct eventfd_ctx *ctx;
> >
> >       cb.callback = vhost_vdpa_config_cb;
> > -     cb.private = v->vdpa;
> > +     cb.private = v;
> >       if (copy_from_user(&fd, argp, sizeof(fd)))
> >               return  -EFAULT;
> >
> > --
> > 2.21.3
>

