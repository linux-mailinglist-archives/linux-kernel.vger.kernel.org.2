Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF6F3E8598
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 23:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbhHJVpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 17:45:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36668 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234103AbhHJVpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 17:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628631916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lx2uWYFZRkWia4mHYWRkdZx8DwSlvSdbBOWfMTQd9Bk=;
        b=jQ36H/0RtXvnY/tkGhY2alSZW0kmGRygk3OG5Bqe8B0suyW8i78D0O+TMTnqxz2LuHxiBd
        UAq/TJh2stu9bAZU98jiBji5MmHGC2MJtiPED2n3FiUffEKl1rtpz7tnNeIWU0TfHkw0y8
        PsxpIwS2lRhDovjVr668Pw++Pdsft/Q=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-7_2n8VtwPAuUb39eY11-Xw-1; Tue, 10 Aug 2021 17:45:14 -0400
X-MC-Unique: 7_2n8VtwPAuUb39eY11-Xw-1
Received: by mail-oi1-f198.google.com with SMTP id a14-20020a056808128eb029022053bcedd7so331858oiw.17
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 14:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lx2uWYFZRkWia4mHYWRkdZx8DwSlvSdbBOWfMTQd9Bk=;
        b=hHocFjb4A99jGAe3/T73JDuQ/HS1EYV4L6LVILW8QkvJHqreNo1bo74YP/y160ayYw
         JWYkfFE9K0mB0Qr/pJmLmtkkTnOhdAc3U5L/61a0J8AcahOfdQ04eU/L/H4zuVkBZcPg
         hfjZv6VRc2jUCTWMDYCMaLkg16qUM4+Mm4vWGNd5PZU8qs0IXFSVHrYu5Vw1i1yJtrnc
         I/5/OSMPyabMbWMa6uIzAIM6F1EML3vw61fn8GjVAgiUmvnuYsnu9ecFT8GrNh3LvxC8
         Fo+2BLKaY4bq2Nio6DiVwaPs+PcAwmhNpWE2orIthG6rtcLTVC9v2SyKKB+eKJ4FTzXG
         CVYw==
X-Gm-Message-State: AOAM533SHkJKTcPxQ+ZxVVvb3ynmGsUiOA9UIZbe7rJgLCeceBowS+VZ
        83AwZ8tHIp85riroB6BlEyr+ySd20mYLFB6CjzKSac+HXDdyWfO6SKelA1UP5xM3XIcMGjfK/AO
        NDD+I0tqblDp90S4AlQJS8n8W
X-Received: by 2002:a9d:84c:: with SMTP id 70mr12855825oty.344.1628631914187;
        Tue, 10 Aug 2021 14:45:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6Ary8a1ESo9zoHrr/4X7svWaGu5Lqsi/I+gg1HHwrs8HuQtFwcEHHfgHpn5voCQdKzkbzAQ==
X-Received: by 2002:a9d:84c:: with SMTP id 70mr12855815oty.344.1628631913982;
        Tue, 10 Aug 2021 14:45:13 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id r137sm3455476oie.17.2021.08.10.14.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 14:45:13 -0700 (PDT)
Date:   Tue, 10 Aug 2021 15:45:12 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH 7/7] vfio/pci: Remove map-on-fault behavior
Message-ID: <20210810154512.5aa8eeb3.alex.williamson@redhat.com>
In-Reply-To: <YRLne7/S1euppJQr@t490s>
References: <162818167535.1511194.6614962507750594786.stgit@omen>
        <162818330190.1511194.10498114924408843888.stgit@omen>
        <YRLne7/S1euppJQr@t490s>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2021 16:54:19 -0400
Peter Xu <peterx@redhat.com> wrote:

> On Thu, Aug 05, 2021 at 11:08:21AM -0600, Alex Williamson wrote:
> > diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
> > index 0aa542fa1e26..9aedb78a4ae3 100644
> > --- a/drivers/vfio/pci/vfio_pci_private.h
> > +++ b/drivers/vfio/pci/vfio_pci_private.h
> > @@ -128,6 +128,7 @@ struct vfio_pci_device {
> >  	bool			needs_reset;
> >  	bool			nointx;
> >  	bool			needs_pm_restore;
> > +	bool			zapped_bars;  
> 
> Would it be nicer to invert the meaning of "zapped_bars" and rename it to
> "memory_enabled"?  Thanks,

I think this has it's own down sides, for example is this really less
confusing?:

  if (!vdev->memory_enabled && __vfio_pci_memory_enabled(vdev))

Are you specifically trying to invert the polarity or just get away
from the name proposed here?  We could use something like
"bars_unmapped", which would have the same polarity (OTOH,
"bars_mapped" suggests something to me about whether the user has
performed any mmaps of BARs).

I do wish there was a more elegant solution than an @var tracking this
state in general, but I haven't come up with such a solution yet.
Thanks,

Alex

