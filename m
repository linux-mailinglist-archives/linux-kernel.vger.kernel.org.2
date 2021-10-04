Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65623421252
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 17:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbhJDPJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 11:09:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53233 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235511AbhJDPJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 11:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633360062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=985LDnfzYRs2ce2VWBJ5EWrnvqpFRI7lu5SFcPvp2wc=;
        b=YAY8fhM7LCWRaBI4D/XKFQNxnL2YmC0NI6+bAa7+pLsVBMZ7JG2kr5H/BsihY8OenTK7Bt
        Z59RBAcxBiXpcCRVTCZ6sBGauMQP4gAab3D2l/reWglMALa6ZGmtkk9NvECwQFgF8hvkcM
        JcmWtQt33jdnDY3ntotGbgA8U9D32Ak=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-Va6AejwgMVGKAQr73MXdRw-1; Mon, 04 Oct 2021 11:07:41 -0400
X-MC-Unique: Va6AejwgMVGKAQr73MXdRw-1
Received: by mail-ed1-f72.google.com with SMTP id 1-20020a508741000000b003da559ba1eeso17580101edv.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 08:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=985LDnfzYRs2ce2VWBJ5EWrnvqpFRI7lu5SFcPvp2wc=;
        b=FyHQT4bTy5KoUMnAXJzqNkJ4VaO9xeKlmt6BhvOLl17Ie9L9liQjLyB7Cs4Q/RTQ5c
         0lnhah11NbOBqCKF28YXCIGcZPfx0SfxO07MUJ7FgQwQWuYlY5LvmR2/yumm8/8rI6mU
         AVbnU+2nty0Rb55/itJSG2V6L5zIn+thb3jM/gTgjwdx+uHbJjeVt0pwCufUSP33mGlt
         8esv3251M5kr+JyHEVcVcsBwKOcFMkfNk8zETIpoUr6cJAQOCJBvGs81J23J0qbviLOu
         T8gDXYoxXT2NGvbvG0KLRx6xv6x8xT3VlDgjqa3b2Wj1cZiXQMClRt86RCRVuPEnMepX
         ANWw==
X-Gm-Message-State: AOAM533510kcBoGioSLMxdK/Tx80juM2aNa7GdZJfKIErPnt5GVBLMni
        /dMidJ5jda7/epqVmcO52CZaZiNZ9TgEK5qfpQFyHPZPlxSgE6sJcTZ9ahxoQWqYImP1zaFiTtx
        cUZemGes37/ylw3GqyXfwMilE
X-Received: by 2002:a50:cf02:: with SMTP id c2mr19027262edk.325.1633360060384;
        Mon, 04 Oct 2021 08:07:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2R3Yw9rloBmg/pn4N4NgpeHLThvy4ibN5NrAyU9aRc3amYe7O7XoVjZkHq3LcnnrMqExsaQ==
X-Received: by 2002:a50:cf02:: with SMTP id c2mr19027231edk.325.1633360060137;
        Mon, 04 Oct 2021 08:07:40 -0700 (PDT)
Received: from redhat.com (93-172-224-64.bb.netvision.net.il. [93.172.224.64])
        by smtp.gmail.com with ESMTPSA id j22sm6750947ejt.11.2021.10.04.08.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 08:07:39 -0700 (PDT)
Date:   Mon, 4 Oct 2021 11:07:37 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, markver@us.ibm.com,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
Message-ID: <20211004110537-mutt-send-email-mst@kernel.org>
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
 <20210930070444-mutt-send-email-mst@kernel.org>
 <20211001092125.64fef348.pasic@linux.ibm.com>
 <20211002055605-mutt-send-email-mst@kernel.org>
 <87bl452d90.fsf@redhat.com>
 <20211004090018-mutt-send-email-mst@kernel.org>
 <875yuc3ln2.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875yuc3ln2.fsf@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 04:33:21PM +0200, Cornelia Huck wrote:
> On Mon, Oct 04 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Mon, Oct 04, 2021 at 02:19:55PM +0200, Cornelia Huck wrote:
> >> 
> >> [cc:qemu-devel]
> >> 
> >> On Sat, Oct 02 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> 
> >> > On Fri, Oct 01, 2021 at 09:21:25AM +0200, Halil Pasic wrote:
> >> >> On Thu, 30 Sep 2021 07:12:21 -0400
> >> >> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> >> 
> >> >> > On Thu, Sep 30, 2021 at 03:20:49AM +0200, Halil Pasic wrote:
> >> >> > > This patch fixes a regression introduced by commit 82e89ea077b9
> >> >> > > ("virtio-blk: Add validation for block size in config space") and
> >> >> > > enables similar checks in verify() on big endian platforms.
> >> >> > > 
> >> >> > > The problem with checking multi-byte config fields in the verify
> >> >> > > callback, on big endian platforms, and with a possibly transitional
> >> >> > > device is the following. The verify() callback is called between
> >> >> > > config->get_features() and virtio_finalize_features(). That we have a
> >> >> > > device that offered F_VERSION_1 then we have the following options
> >> >> > > either the device is transitional, and then it has to present the legacy
> >> >> > > interface, i.e. a big endian config space until F_VERSION_1 is
> >> >> > > negotiated, or we have a non-transitional device, which makes
> >> >> > > F_VERSION_1 mandatory, and only implements the non-legacy interface and
> >> >> > > thus presents a little endian config space. Because at this point we
> >> >> > > can't know if the device is transitional or non-transitional, we can't
> >> >> > > know do we need to byte swap or not.  
> >> >> > 
> >> >> > Hmm which transport does this refer to?
> >> >> 
> >> >> It is the same with virtio-ccw and virtio-pci. I see the same problem
> >> >> with both on s390x. I didn't try with virtio-blk-pci-non-transitional
> >> >> yet (have to figure out how to do that with libvirt) for pci I used
> >> >> virtio-blk-pci.
> >> >> 
> >> >> > Distinguishing between legacy and modern drivers is transport
> >> >> > specific.  PCI presents
> >> >> > legacy and modern at separate addresses so distinguishing
> >> >> > between these two should be no trouble.
> >> >> 
> >> >> You mean the device id? Yes that is bolted down in the spec, but
> >> >> currently we don't exploit that information. Furthermore there
> >> >> is a fat chance that with QEMU even the allegedly non-transitional
> >> >> devices only present a little endian config space after VERSION_1
> >> >> was negotiated. Namely get_config for virtio-blk is implemented in
> >> >> virtio_blk_update_config() which does virtio_stl_p(vdev,
> >> >> &blkcfg.blk_size, blk_size) and in there we don't care
> >> >> about transitional or not:
> >> >> 
> >> >> static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
> >> >> {
> >> >> #if defined(LEGACY_VIRTIO_IS_BIENDIAN)
> >> >>     return virtio_is_big_endian(vdev);
> >> >> #elif defined(TARGET_WORDS_BIGENDIAN)
> >> >>     if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> >> >>         /* Devices conforming to VIRTIO 1.0 or later are always LE. */
> >> >>         return false;
> >> >>     }
> >> >>     return true;
> >> >> #else
> >> >>     return false;
> >> >> #endif
> >> >> }
> >> >> 
> >> >
> >> > ok so that's a QEMU bug. Any virtio 1.0 and up
> >> > compatible device must use LE.
> >> > It can also present a legacy config space where the
> >> > endian depends on the guest.
> >> 
> >> So, how is the virtio core supposed to determine this? A
> >> transport-specific callback?
> >
> > I'd say a field in VirtIODevice is easiest.
> 
> The transport needs to set this as soon as it has figured out whether
> we're using legacy or not.

Basically on each device config access?

> I guess we also need to fence off any
> accesses respectively error out the device if the driver tries any
> read/write operations that would depend on that knowledge?
> 
> And using a field in VirtIODevice would probably need some care when
> migrating. Hm...

It's just a shorthand to minimize changes. No need to migrate I think.

-- 
MST

