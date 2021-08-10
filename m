Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4812C3E833F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 20:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbhHJSuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 14:50:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52322 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229774AbhHJSuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 14:50:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628621394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sIY2+IC7WL45hNaXWA0mNkNCzPB+K2jEa8Wry58PE/U=;
        b=fJqlEPwCjNtyRH3F7Rx5DbUd0oZprZR51q62a5OrXRi0gq16aKYLbPm9dHTLsDecZMRxO5
        vNogN6hX8p75kPcXcZURvxr7wI99QlxAwGQGkJEVg4n2nlRQDja6eBQKE0ucxiW8aAlLIc
        63n8meoIL31zHABjSBwBdNotgjZkuMc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-rYZw8K4tN5eV_Y1JzAKK2A-1; Tue, 10 Aug 2021 14:49:47 -0400
X-MC-Unique: rYZw8K4tN5eV_Y1JzAKK2A-1
Received: by mail-qv1-f69.google.com with SMTP id a2-20020a0562141302b02903303839b843so17454726qvv.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 11:49:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sIY2+IC7WL45hNaXWA0mNkNCzPB+K2jEa8Wry58PE/U=;
        b=DiGQF81rzULbl7Y4xwE33PJLJEzQsFGR5dl9hHSt9w8Xyim62emZrBrPKF5G6yM4To
         kVBUU/3yLHqaH9kbypSCiz/quyVPogDptY7x6zFgkQRrBJZzVqI9/dpxnp7eZKdVC31F
         astvIeP1zZdSyUO0a6xWbBVAJhdDn8HH+EtxZbbKsFY8subWipbi/dilfF+hmyZ5rriT
         Jz9jMTRZUEQAL7bW1FyVQfbSqc4mv2DA2yj8mMXNJYTNba2M53/qD/2/K9p+A0yk1GbU
         Wp7a5CX/SM3olk7PL5VsRN0udPdOtVMeNgobIdptsH5lhQ6E5VW9+/hOpW2cTGMNLMfu
         xpdA==
X-Gm-Message-State: AOAM531nXNlWjoQe4gTqw+pNin771Ssmsq4eXmm74awwwJ37EeGnWy+C
        N1JzDl5viOvSQkoUIDFFfaGO0KOk1y+DBL4uJdcYjgZ7eYQiqlYXpVPG08vBaMNQt3ewQcuDAQY
        83ZJuGKmzKejP/MsZ78rDLzdU
X-Received: by 2002:a05:620a:4495:: with SMTP id x21mr29960406qkp.468.1628621387550;
        Tue, 10 Aug 2021 11:49:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQvFRashIBFVzGhqhv5sdxbxzhHektVx1wjA60NW0CdiaAdHl2bwdx2KS9QwBp6XM60FSi5Q==
X-Received: by 2002:a05:620a:4495:: with SMTP id x21mr29960386qkp.468.1628621387352;
        Tue, 10 Aug 2021 11:49:47 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-92-76-70-75-133.dsl.bell.ca. [76.70.75.133])
        by smtp.gmail.com with ESMTPSA id c68sm11756909qkf.48.2021.08.10.11.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 11:49:46 -0700 (PDT)
Date:   Tue, 10 Aug 2021 14:49:45 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH 1/7] vfio: Create vfio_fs_type with inode per device
Message-ID: <YRLKSYQL8VvTr3gc@t490s>
References: <162818167535.1511194.6614962507750594786.stgit@omen>
 <162818322947.1511194.6035266132085405252.stgit@omen>
 <YRI8Mev5yfeAXsrj@infradead.org>
 <20210810085254.51da01d6.alex.williamson@redhat.com>
 <YRKT2UhgjfWBmwuJ@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YRKT2UhgjfWBmwuJ@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 03:57:29PM +0100, Christoph Hellwig wrote:
> On Tue, Aug 10, 2021 at 08:52:54AM -0600, Alex Williamson wrote:
> > On Tue, 10 Aug 2021 10:43:29 +0200
> > Christoph Hellwig <hch@infradead.org> wrote:
> > 
> > > > + * XXX Adopt the following when available:
> > > > + * https://lore.kernel.org/lkml/20210309155348.974875-1-hch@lst.de/  
> > > 
> > > No need for this link.
> > 
> > Is that effort dead?  I've used the link several times myself to search
> > for progress, so it's been useful to me.  Thanks,
> 
> No, but it seems odd to have reference to an old patchset in the kernel
> tree.

I learn from the reference too.  Maybe move into commit message?  Thanks,

-- 
Peter Xu

