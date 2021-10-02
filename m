Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5BB341FDA2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 20:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbhJBSPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 14:15:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39030 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233779AbhJBSPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 14:15:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633198425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3oSEK/nQsdZlU+yYMpXszg2Kp8d5WMgwuTa52Aw2D3Y=;
        b=I8PsR+DgGuOe1K9hlg6YjY22aR5Q3e7Ss+hf0JhsEsvBw8KhKOQl8wwofCop3rYD9rw05z
        i5jXyuChArjpBK80ERj3mzsiF/HfAj4X1I5h8pfFsW2baxt/IIhhjvfOCDh48jSwdlbQ1x
        FM56uT5HnB3echT77ZAsr+x24o/MtO0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-W9b_4sT9OuKyyKzkwZU3qw-1; Sat, 02 Oct 2021 14:13:44 -0400
X-MC-Unique: W9b_4sT9OuKyyKzkwZU3qw-1
Received: by mail-ed1-f71.google.com with SMTP id 14-20020a508e4e000000b003d84544f33eso13290801edx.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Oct 2021 11:13:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3oSEK/nQsdZlU+yYMpXszg2Kp8d5WMgwuTa52Aw2D3Y=;
        b=cAsOmg+1DPldJ5P8iOmPd0KL0+ShFSWygKS0VpUr8cPT2VfnKyVe3uaczlX179SA5R
         Wn20y2vZnp0qGRUeCjuquKQsYEBrDecKrjh6JwkP6E/obemsMIvkoPzJs/jTLiZBUBy/
         8Cgixp82/2YzTMWuGXNtomh+EWQnDaZnq2voTJ5ydqk+bR4EvXYltnTXIXKY/Exmhjdz
         09/Gj7pHkA7bcQJmbJPU1jNaw9QtqSF9QcGsAcfTBCvQ7du4XimK+F8731HxTnp2G9Vc
         aJI8AoBtO5eTP2UytkRvMZ7L/L5UnXZQcHoZ/SISC2WAhF5qiyXEr7XwNfOQ1YpCuD77
         rabg==
X-Gm-Message-State: AOAM531RLizvGb1XQ/Wg4WC1MFRJxuFo4kpA4kddyo3FhvvKCpqwtohJ
        b9G94CWR4UhlS79oB5bIMtCQvJPNMPcyvGrD4JlAEYEmS+gX/IdFPO1sowD2olAJDbl/rO0gutw
        G+x5SrRBEa3TwkGAYtJbKJG7T
X-Received: by 2002:a17:906:3148:: with SMTP id e8mr5549042eje.240.1633198422786;
        Sat, 02 Oct 2021 11:13:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRv0l7yLWVghnzKaRjGETRmZdWUznHgB707hsC9MH/6Nu9SV2dEEHSsiG1hSfbsv5Yq/RsSA==
X-Received: by 2002:a17:906:3148:: with SMTP id e8mr5549025eje.240.1633198422593;
        Sat, 02 Oct 2021 11:13:42 -0700 (PDT)
Received: from redhat.com ([2.55.22.213])
        by smtp.gmail.com with ESMTPSA id d10sm4409791eja.81.2021.10.02.11.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 11:13:41 -0700 (PDT)
Date:   Sat, 2 Oct 2021 14:13:37 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, markver@us.ibm.com,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
Message-ID: <20211002082128-mutt-send-email-mst@kernel.org>
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
 <87r1d64dl4.fsf@redhat.com>
 <20210930130350.0cdc7c65.pasic@linux.ibm.com>
 <87ilyi47wn.fsf@redhat.com>
 <20211001162213.18d7375e.pasic@linux.ibm.com>
 <87v92g3h9l.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v92g3h9l.fsf@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2021 at 05:18:46PM +0200, Cornelia Huck wrote:
> I'd say we need a hack here so that we assume little-endian config space
> if VERSION_1 has been offered; if your patch here works, I assume QEMU
> does what we expect (assmuming little-endian as well.) I'm mostly
> wondering what happens if you use a different VMM; can we expect it to
> work similar to QEMU?

Hard to say of course ... hopefully other VMMs are actually
implementing the spec. E.g. IIUC rust vmm is modern only.


> Even if it helps for s390, we should double-check
> what happens for other architectures.
> 
> >
> >> 
> >> Anyone have any better suggestions?
> >> 
> >
> > There is the conditional compile, as an option but I would not say it is
> > better.
> 
> Yes, I agree.
> 
> Anyone else have an idea? This is a nasty regression; we could revert the
> patch, which would remove the symptoms and give us some time, but that
> doesn't really feel right, I'd do that only as a last resort.

Well we have Halil's hack (except I would limit it
to only apply to BE, only do devices with validate,
and only in modern mode), and we will fix QEMU to be spec compliant.
Between these why do we need any conditional compiles?

-- 
MST

