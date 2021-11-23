Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478CA45A0DD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 12:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbhKWLI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 06:08:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53797 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230134AbhKWLI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 06:08:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637665549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J2pF2xlsDfDRvXe40093H51IzqjgOI072FHOrB5mwiw=;
        b=C9FCvrcHQ3j/th8biXBTON2RfK2VEFshiYVmbLWjELTNAM5hzgXG9rr5hal1Xxp2ISsDih
        IMZDhqXZNhTcJCKttjSSbI0mtH+1A2K6Ft8lmYuv6p1/17a0FvYYR7StfYKokYbX6ilIEA
        5hfA+X84gU4VDvKHjC+jOYI+N+tD7aw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-323-x-5UoNXePieRwiBgroqu_g-1; Tue, 23 Nov 2021 06:05:47 -0500
X-MC-Unique: x-5UoNXePieRwiBgroqu_g-1
Received: by mail-wm1-f71.google.com with SMTP id p12-20020a05600c1d8c00b0033a22e48203so1332045wms.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 03:05:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J2pF2xlsDfDRvXe40093H51IzqjgOI072FHOrB5mwiw=;
        b=ABreZ3X28R9b41Hjk0wCVwR1ahton15CP70JZu1dJnmNh/a2190w/7JZP0OUybBa/0
         Xs6BR8WcWkf2gIlj6DkE2POuQu4ncHFsAgzoZ7jWYOQAvQBPcUAjI1PzIoJpsWtbvW+U
         uFTuHDXWkOgvVfsKfc8QKwg7VlnSJrzoaAUoiMLVtObSqdNv670/yET0ACy17nIAwS9U
         vXKDZAIHoo24guhOThFAlA1KYSnETz/iIasLw6nM+4XCbjxP4DnU39VXy0sE+NWoDN1T
         +ZEsydNQfM32OznmD+CBBY+HUOkl8BDIInIpMbsW6mh9Ft7ZmA2rYCJ0Yu4oesRdiXPv
         f6FA==
X-Gm-Message-State: AOAM531Wy878UY1M2una7EYL/HQEPfVXTta8AGjce23L9ajH9JbFSr7Q
        aRgumnnPkgpFE5t0o/4+YBANc1U+4UKdgwmqrCjdQ82+LXvJ9N3gFEBe3MasxVd/8bzfC+PFcv9
        dMuU+IutC6kugFzWNs14nEof+
X-Received: by 2002:adf:fe4f:: with SMTP id m15mr5996794wrs.81.1637665546164;
        Tue, 23 Nov 2021 03:05:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxZvNK6RUtZqSW4AaPPqR0sfacFsPcXF+7OGnDvQsAeun5lKv75/Is6lcDnTi7n+0Q0I8rkew==
X-Received: by 2002:adf:fe4f:: with SMTP id m15mr5996705wrs.81.1637665545555;
        Tue, 23 Nov 2021 03:05:45 -0800 (PST)
Received: from redhat.com ([45.15.16.143])
        by smtp.gmail.com with ESMTPSA id o5sm11507325wrx.83.2021.11.23.03.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 03:05:44 -0800 (PST)
Date:   Tue, 23 Nov 2021 06:05:39 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        "Hetzelt, Felicitas" <f.hetzelt@tu-berlin.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "kaplan, david" <david.kaplan@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH V5 1/4] virtio_ring: validate used buffer length
Message-ID: <20211123055906-mutt-send-email-mst@kernel.org>
References: <20211027022107.14357-1-jasowang@redhat.com>
 <20211027022107.14357-2-jasowang@redhat.com>
 <20211119160951.5f2294c8.pasic@linux.ibm.com>
 <CACGkMEtja2TPC=ujgMrpaPmdsy+zHowbBTvPj8k7nm_+zB8vig@mail.gmail.com>
 <20211122063518.37929c01.pasic@linux.ibm.com>
 <20211122064922.51b3678e.pasic@linux.ibm.com>
 <CACGkMEu+9FvMsghyi55Ee5BxetP-YK9wh2oaT8OgLiY5+tV0QQ@mail.gmail.com>
 <20211122212352.4a76232d.pasic@linux.ibm.com>
 <CACGkMEtmhwDEAvMuMhQEUB-b+=n713pVvjyct8QAqMUk1H-A-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEtmhwDEAvMuMhQEUB-b+=n713pVvjyct8QAqMUk1H-A-g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 10:25:20AM +0800, Jason Wang wrote:
> On Tue, Nov 23, 2021 at 4:24 AM Halil Pasic <pasic@linux.ibm.com> wrote:
> >
> > On Mon, 22 Nov 2021 14:25:26 +0800
> > Jason Wang <jasowang@redhat.com> wrote:
> >
> > > I think the fixes are:
> > >
> > > 1) fixing the vhost vsock
> > > 2) use suppress_used_validation=true to let vsock driver to validate
> > > the in buffer length
> > > 3) probably a new feature so the driver can only enable the validation
> > > when the feature is enabled.
> >
> > I'm not sure, I would consider a F_DEV_Y_FIXED_BUG_X a perfectly good
> > feature. Frankly the set of such bugs is device implementation
> > specific and it makes little sense to specify a feature bit
> > that says the device implementation claims to adhere to some
> > aspect of the specification. Also what would be the semantic
> > of not negotiating F_DEV_Y_FIXED_BUG_X?
> 
> Yes, I agree. Rethink of the feature bit, it seems unnecessary,
> especially considering the driver should not care about the used
> length for tx.
> 
> >
> > On the other hand I see no other way to keep the validation
> > permanently enabled for fixed implementations, and get around the problem
> > with broken implementations. So we could have something like
> > VHOST_USED_LEN_STRICT.
> 
> It's more about a choice of the driver's knowledge. For vsock TX it
> should be fine. If we introduce a parameter and disable it by default,
> it won't be very useful.
> 
> >
> > Maybe, we can also think of 'warn and don't alter behavior' instead of
> > 'warn' and alter behavior. Or maybe even not having such checks on in
> > production, but only when testing.
> 
> I think there's an agreement that virtio drivers need more hardening,
> that's why a lot of patches were merged. Especially considering the
> new requirements came from confidential computing, smart NIC and
> VDUSE. For virtio drivers, enabling the validation may help to
> 
> 1) protect the driver from the buggy and malicious device
> 2) uncover the bugs of the devices (as vsock did, and probably rpmsg)
> 3) force the have a smart driver that can do the validation itself
> then we can finally remove the validation in the core
> 
> So I'd like to keep it enabled.
> 
> Thanks

Let's see how far we can get. But yes, maybe we were too aggressive in
breaking things by default, a warning might be a better choice for a
couple of cycles.

> >
> > Regards,
> > Halil
> >

