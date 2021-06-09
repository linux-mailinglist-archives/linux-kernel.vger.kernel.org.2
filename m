Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE573A1749
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 16:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235794AbhFIOde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 10:33:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34839 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234734AbhFIOdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 10:33:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623249098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tKs4cxUwdZYTDh0jeAao9VZnEeCHbGVX5Jimoj8fR6o=;
        b=S3Z+TveI8z2k9mAwKuMH2DVfkrLgjoj0S4PD4LG0IsUMRbE/1KNwzBzzsV/lxXqa/2lt8R
        QL+gdcN1Md6bhMZ7Ia6s06/Bdw29cZ02z/f2sapeh8GlPOvs/cY7uuO4k++GEBOWaQMAoN
        nN0w7OUUlntFeWZ7ePWatqDzKEwhPGM=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-dNf_a73EP-aV7Exbuq398g-1; Wed, 09 Jun 2021 10:31:37 -0400
X-MC-Unique: dNf_a73EP-aV7Exbuq398g-1
Received: by mail-oo1-f72.google.com with SMTP id f5-20020a4ab0050000b029023e3bd79e80so15628358oon.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 07:31:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=tKs4cxUwdZYTDh0jeAao9VZnEeCHbGVX5Jimoj8fR6o=;
        b=Vs8MwpWpoaJZZp8JmxInCTDBL/KajtIItMI6OxxVjw4apFszOuRgKA/2d+j8isTHD8
         ZLwtWHCsiUoAaoV7iKiJnw7YfaT920TyGNbF93n8A24RzyMw1Ba8O4RObAKqVj+3yl0T
         gWww95t7HRSe399GwXBgJyJH9DER4HmRG4+K1pCPy7IwQY+aFAX6nEob8wT2QRXlsRPK
         JdvfvZYANW00HFiJ2GvryYzxV1DEixablFFGx9B4BCxnWJg9C3v6eDhAB42Q+Ne/af5y
         bE3XipuJ7KGPi64sva8nCvJGjWfKcpx/SnmlIladz3CoUHSsy3v11JfvjOE2RPLIYKCj
         qqVg==
X-Gm-Message-State: AOAM533Fs0WEOWynuAcO4tCgrRTGByvd6Q8FDt4Zs1E3b4WoLlLGo5vz
        5lcr6rwvNMppqPFbUtrms+dNQrDMMvHtRndVv7xVCc7UWg29Jb4ivT0l8vuMIv/RXeND+szth9W
        olqQ3jiFFTar/djbisl6/pSPn
X-Received: by 2002:a9d:6054:: with SMTP id v20mr13240729otj.39.1623249096587;
        Wed, 09 Jun 2021 07:31:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAM19Ewy08wPKi3QBA6QQ1RgaDDfMkc/aSlgAItOhMLGMzwR7RPxVpUCrWoFK5Tkcq4qSUxQ==
X-Received: by 2002:a9d:6054:: with SMTP id v20mr13240702otj.39.1623249096396;
        Wed, 09 Jun 2021 07:31:36 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id u26sm24144ote.53.2021.06.09.07.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 07:31:35 -0700 (PDT)
Date:   Wed, 9 Jun 2021 08:31:34 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Robin Murphy <robin.murphy@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210609083134.396055e3.alex.williamson@redhat.com>
In-Reply-To: <20210609115445.GX1002214@nvidia.com>
References: <20210604172207.GT1002214@nvidia.com>
        <2d1ad075-bec6-bfb9-ce71-ed873795e973@redhat.com>
        <20210607175926.GJ1002214@nvidia.com>
        <fdb2f38c-da1f-9c12-af44-22df039fcfea@redhat.com>
        <20210608131547.GE1002214@nvidia.com>
        <89d30977-119c-49f3-3bf6-d3f7104e07d8@redhat.com>
        <20210608124700.7b9aa5a6.alex.williamson@redhat.com>
        <20210608190022.GM1002214@nvidia.com>
        <ec0b1ef9-ae2f-d6c7-99b7-4699ced146e4@metux.net>
        <671efe89-2430-04fa-5f31-f52589276f01@redhat.com>
        <20210609115445.GX1002214@nvidia.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jun 2021 08:54:45 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Jun 09, 2021 at 11:11:17AM +0200, Paolo Bonzini wrote:
> > On 09/06/21 10:51, Enrico Weigelt, metux IT consult wrote:  
> > > On 08.06.21 21:00, Jason Gunthorpe wrote:
> > >   
> > > > Eg I can do open() on a file and I get to keep that FD. I get to keep
> > > > that FD even if someone later does chmod() on that file so I can't
> > > > open it again.
> > > > 
> > > > There are lots of examples where a one time access control check
> > > > provides continuing access to a resource. I feel the ongoing proof is
> > > > the rarity in Unix.. 'revoke' is an uncommon concept in Unix..  
> > > 
> > > Yes, it's even possible that somebody w/ privileges opens an fd and
> > > hands it over to somebody unprivileged (eg. via unix socket). This is
> > > a very basic unix concept. If some (already opened) fd now suddenly
> > > behaves differently based on the current caller, that would be a break
> > > with traditional unix semantics.  

That's not the scenario here, this would work as expected.  It's not a
matter of who uses the fd it's that a property of the fd that provided
elevated access has been removed.  I only need to look as far as sudo
to find examples of protocols where having access at some point in time
does not guarantee ongoing access.

If we go back to the wbinvd ioctl mechanism, if I call that ioctl with
an ioasidfd that contains no devices, then I shouldn't be able to
generate a wbinvd on the processor, right?  If I add a device,
especially in a configuration that can generate non-coherent DMA, now
that ioctl should work.  If I then remove all devices from that ioasid,
what then is the difference from the initial state.  Should the ioctl
now work because it worked once in the past?

If we equate KVM to the process access to the ioctl, then a reference
or notification method should be used to retain or mark the end of that
access.  This is no different than starting a shell via sudo (ie. an
ongoing reference) or having the previous authentication time out, or
in our case be notified it has expired.

> > That's already more or less meaningless for both KVM and VFIO, since they
> > are tied to an mm.  
> 
> vfio isn't supposed to be tied to a mm.

vfio does accounting against an mm, why shouldn't it be tied to an mm?
Maybe you mean in the new model where vfio is just a device driver?
Thanks,

Alex

