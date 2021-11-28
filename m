Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D31460528
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 08:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356007AbhK1HvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 02:51:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:45806 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234028AbhK1Hs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 02:48:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638085543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z08EGI7tQBLg65GMt02gA8JynjRy6lC2as9YkmM/wdI=;
        b=FGyh5+Px/aIJtRFPADLRi8zLtZKnoz/ILIqD94K9uag99Vimk8o//DTCEYM9EYthQbpPeX
        jIwlxQOAZd4a+pJBZVnNhyQw/7sF9YWD9g19eGLGsNscwlYsV4pZGSUW8pMZFE5E//nLB2
        LgFAWmTgTauQDGdAeHI6qKx7wSAFOnE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-82lr-RWqP8i8a6sPxIDPKw-1; Sun, 28 Nov 2021 02:45:33 -0500
X-MC-Unique: 82lr-RWqP8i8a6sPxIDPKw-1
Received: by mail-ed1-f70.google.com with SMTP id m17-20020aa7d351000000b003e7c0bc8523so11105654edr.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 23:45:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z08EGI7tQBLg65GMt02gA8JynjRy6lC2as9YkmM/wdI=;
        b=1y+j6w4bKbDM2u9jx3/df1HaQEws+dEH/mDqgx0cGYaifuiB8B3+iM3VFXXzTEwAt8
         mS7w6si+8uSoGMWbST1hPjq+0LoqPE8ZaWhsZrAE6y4uNr++NG8yQObScJ/poETIignt
         RdJoQKpJ30GHuRfPpvQyzZ+knWXe8JXHf5U1A3svMsIVXjR7uc3Mx9Mx/RtlVBLwCuhS
         kODTstllLS9knpMb8OXsUkqTDkIkU3m6a7/K035JwtLnhhRzmCEzamUuN37gk0MzyHCI
         W6g5qHAPBOnag4yt0OIdeJ1nyneR+63NuAmgnT+eovoq2NE5pEJPtTTl7lm9yk6nLwvK
         VCIA==
X-Gm-Message-State: AOAM530BBgXvc1iHjAlnIOrueiul3AQxbLufJVzbATD8OjKdF6BVXVka
        iUm1sgnFDi5XJS0uVZfmvt9e1IvTHQwcYmDyxqWJ8CSTBEJVmRteKCChlXrwlf63Phb1E7T4BlC
        SYLOnMmyMgKK1rvIVXlB1jkk5
X-Received: by 2002:a17:906:128d:: with SMTP id k13mr52481725ejb.517.1638085531875;
        Sat, 27 Nov 2021 23:45:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzkWlbeB6VAhnUWHCz1wbS9/RSFtufEB+7eUoN2h/ifaRlddcSii60fj/U2nHH4ps4pkXvriA==
X-Received: by 2002:a17:906:128d:: with SMTP id k13mr52481701ejb.517.1638085531669;
        Sat, 27 Nov 2021 23:45:31 -0800 (PST)
Received: from redhat.com ([2a03:c5c0:207f:33c6:2c25:1862:302e:8fc2])
        by smtp.gmail.com with ESMTPSA id w23sm6807390edr.19.2021.11.27.23.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 23:45:31 -0800 (PST)
Date:   Sun, 28 Nov 2021 02:45:26 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <elic@nvidia.com>
Cc:     Jason Wang <jasowang@redhat.com>, Parav Pandit <parav@nvidia.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Eric Dumazet <edumazet@google.com>, kbuild-all@lists.01.org,
        kernel test robot <lkp@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, kbuild@lists.01.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] vdpa: Consider device id larger than 31
Message-ID: <20211128024206-mutt-send-email-mst@kernel.org>
References: <20211125180915.649652-1-parav@nvidia.com>
 <CACGkMEtF+kjj_vryxXAo6PqeX3Puk-XxaaQMcu4mhB1WZRXEpw@mail.gmail.com>
 <20211128071435.GB99190@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211128071435.GB99190@mtl-vdi-166.wap.labs.mlnx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 28, 2021 at 09:14:35AM +0200, Eli Cohen wrote:
> On Fri, Nov 26, 2021 at 10:48:12AM +0800, Jason Wang wrote:
> > On Fri, Nov 26, 2021 at 2:09 AM Parav Pandit <parav@nvidia.com> wrote:
> > >
> > > virtio device id value can be more than 31. Hence, use BIT_ULL in
> > > assignment.
> > >
> > > Fixes: 33b347503f01 ("vdpa: Define vdpa mgmt device, ops and a netlink interface")
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > 
> > Acked-by: Jason Wang <jasowang@redhat.com>
> > 
> > > ---
> > >  drivers/vdpa/vdpa.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > > index 7332a74a4b00..e91c71aeeddf 100644
> > > --- a/drivers/vdpa/vdpa.c
> > > +++ b/drivers/vdpa/vdpa.c
> > > @@ -404,7 +404,7 @@ static int vdpa_mgmtdev_fill(const struct vdpa_mgmt_dev *mdev, struct sk_buff *m
> > >                 goto msg_err;
> > >
> > >         while (mdev->id_table[i].device) {
> > > -               supported_classes |= BIT(mdev->id_table[i].device);
> > > +               supported_classes |= BIT_ULL(mdev->id_table[i].device);
> > >                 i++;
> > >         }
> > >
> 
> type of mdev->id_table[i].device is __u32 so in theory you're limited
> to device ID's up to 63.
> Maybe add assert here?

I think 1 << 63 is illegal though.

> > > --
> > > 2.26.2
> > >
> > 

