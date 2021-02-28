Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD7C7327495
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 22:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhB1V0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 16:26:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35478 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230019AbhB1V0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 16:26:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614547518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3yMfUwMSMlLzTtYBioGpjaiH9NykZNmNU2hz5aZaT5Q=;
        b=Z8SekN/YB+8RH7h/PwsyaX890VyBxQPySf5BvG68OTE1XMmN6Uw/YhhKhj6PUGZNi3EeBu
        290V2OceBBqmQrqn5rwqzt4r9q6bCXLXOc+RcKJ1mRd7Cwem6Ec+R4bzilomgBl76zOI67
        Z8iYeT8yD2sSZiPmyUCy/yi5iM6mohk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-xUyjLNxKOdaMLCDyu-XKcQ-1; Sun, 28 Feb 2021 16:25:17 -0500
X-MC-Unique: xUyjLNxKOdaMLCDyu-XKcQ-1
Received: by mail-ed1-f71.google.com with SMTP id i4so7877401edt.11
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 13:25:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3yMfUwMSMlLzTtYBioGpjaiH9NykZNmNU2hz5aZaT5Q=;
        b=ejne7V3YrJPA23lzfSgV6d/HacX9lp2joBkHiHef+6tXiTZYhN5rb+zDL9WPgH7+tj
         OyonddkpDc648YCSZRm60CrZbRJaAhoFGzi8KiS12Y0zpNB9/amwpbS2lP1nOCNAQeXy
         hudoNJOQOEyAnjRrF9C8o4ISZ2ndspzowMEwZHmVCBbFw7wVuFMs+blCNS+SIvCZCeRe
         TDbO0oCUtQqVeZCWVHPD63ve3913Y7i8U5myZ9kZksPbC4ydkHXRiASeEy2HsR4Lv6XZ
         opA/lKmYPJlpycbpz0d9oeHxC7+2xx65Rp7LPn6r7J/+4meOFz+ngM0KpIY2Svz12NSL
         bVTw==
X-Gm-Message-State: AOAM530/4oNOG2FfU62dBw3WuAqlzF3y0jZ8084t/2pOdlTKrpl3hzFz
        gQ45hdNdhgcTOPsLuzFeHkP0a9gi9tohqthbPpOtGynNDa7KDyzrGSiXPiAIm9wobu9HNoYOA7q
        Et6dJwvX4StKFI1Vov0ZIFC98
X-Received: by 2002:aa7:c403:: with SMTP id j3mr13466256edq.137.1614547515828;
        Sun, 28 Feb 2021 13:25:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwRcQQYvlSJ36Xy6Hj8V4Z8794sGOmtN+bAL8Csgl0n1MU5SKaQ7rs0ucHXpwyqFI/lJoxhzw==
X-Received: by 2002:aa7:c403:: with SMTP id j3mr13466237edq.137.1614547515530;
        Sun, 28 Feb 2021 13:25:15 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
        by smtp.gmail.com with ESMTPSA id a14sm12258393edu.13.2021.02.28.13.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 13:25:14 -0800 (PST)
Date:   Sun, 28 Feb 2021 16:25:11 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>, elic@nvidia.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org
Subject: Re: [virtio-dev] Re: [PATCH] vdpa/mlx5: set_features should allow
 reset to zero
Message-ID: <20210228162306-mutt-send-email-mst@kernel.org>
References: <20210223041740-mutt-send-email-mst@kernel.org>
 <788a0880-0a68-20b7-5bdf-f8150b08276a@redhat.com>
 <20210223110430.2f098bc0.cohuck@redhat.com>
 <bbb0a09e-17e1-a397-1b64-6ce9afe18e44@redhat.com>
 <20210223115833.732d809c.cohuck@redhat.com>
 <8355f9b3-4cda-cd2e-98df-fed020193008@redhat.com>
 <20210224121234.0127ae4b.cohuck@redhat.com>
 <be6713d3-ac98-bbbf-1dc1-a003ed06a156@redhat.com>
 <20210225135229-mutt-send-email-mst@kernel.org>
 <0f8eb381-cc98-9e05-0e35-ccdb1cbd6119@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f8eb381-cc98-9e05-0e35-ccdb1cbd6119@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 04:19:16PM +0800, Jason Wang wrote:
> 
> On 2021/2/26 2:53 上午, Michael S. Tsirkin wrote:
> > On Thu, Feb 25, 2021 at 12:36:07PM +0800, Jason Wang wrote:
> > > On 2021/2/24 7:12 下午, Cornelia Huck wrote:
> > > > On Wed, 24 Feb 2021 17:29:07 +0800
> > > > Jason Wang <jasowang@redhat.com> wrote:
> > > > 
> > > > > On 2021/2/23 6:58 下午, Cornelia Huck wrote:
> > > > > > On Tue, 23 Feb 2021 18:31:07 +0800
> > > > > > Jason Wang <jasowang@redhat.com> wrote:
> > > > > > > On 2021/2/23 6:04 下午, Cornelia Huck wrote:
> > > > > > > > On Tue, 23 Feb 2021 17:46:20 +0800
> > > > > > > > Jason Wang <jasowang@redhat.com> wrote:
> > > > > > > > > On 2021/2/23 下午5:25, Michael S. Tsirkin wrote:
> > > > > > > > > > On Mon, Feb 22, 2021 at 09:09:28AM -0800, Si-Wei Liu wrote:
> > > > > > > > > > > On 2/21/2021 8:14 PM, Jason Wang wrote:
> > > > > > > > > > > > On 2021/2/19 7:54 下午, Si-Wei Liu wrote:
> > > > > > > > > > > > > Commit 452639a64ad8 ("vdpa: make sure set_features is invoked
> > > > > > > > > > > > > for legacy") made an exception for legacy guests to reset
> > > > > > > > > > > > > features to 0, when config space is accessed before features
> > > > > > > > > > > > > are set. We should relieve the verify_min_features() check
> > > > > > > > > > > > > and allow features reset to 0 for this case.
> > > > > > > > > > > > > 
> > > > > > > > > > > > > It's worth noting that not just legacy guests could access
> > > > > > > > > > > > > config space before features are set. For instance, when
> > > > > > > > > > > > > feature VIRTIO_NET_F_MTU is advertised some modern driver
> > > > > > > > > > > > > will try to access and validate the MTU present in the config
> > > > > > > > > > > > > space before virtio features are set.
> > > > > > > > > > > > This looks like a spec violation:
> > > > > > > > > > > > 
> > > > > > > > > > > > "
> > > > > > > > > > > > 
> > > > > > > > > > > > The following driver-read-only field, mtu only exists if
> > > > > > > > > > > > VIRTIO_NET_F_MTU is set. This field specifies the maximum MTU for the
> > > > > > > > > > > > driver to use.
> > > > > > > > > > > > "
> > > > > > > > > > > > 
> > > > > > > > > > > > Do we really want to workaround this?
> > > > > > > > > > > Isn't the commit 452639a64ad8 itself is a workaround for legacy guest?
> > > > > > > > > > > 
> > > > > > > > > > > I think the point is, since there's legacy guest we'd have to support, this
> > > > > > > > > > > host side workaround is unavoidable. Although I agree the violating driver
> > > > > > > > > > > should be fixed (yes, it's in today's upstream kernel which exists for a
> > > > > > > > > > > while now).
> > > > > > > > > > Oh  you are right:
> > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > static int virtnet_validate(struct virtio_device *vdev)
> > > > > > > > > > {
> > > > > > > > > >              if (!vdev->config->get) {
> > > > > > > > > >                      dev_err(&vdev->dev, "%s failure: config access disabled\n",
> > > > > > > > > >                              __func__);
> > > > > > > > > >                      return -EINVAL;
> > > > > > > > > >              }
> > > > > > > > > > 
> > > > > > > > > >              if (!virtnet_validate_features(vdev))
> > > > > > > > > >                      return -EINVAL;
> > > > > > > > > > 
> > > > > > > > > >              if (virtio_has_feature(vdev, VIRTIO_NET_F_MTU)) {
> > > > > > > > > >                      int mtu = virtio_cread16(vdev,
> > > > > > > > > >                                               offsetof(struct virtio_net_config,
> > > > > > > > > >                                                        mtu));
> > > > > > > > > >                      if (mtu < MIN_MTU)
> > > > > > > > > >                              __virtio_clear_bit(vdev, VIRTIO_NET_F_MTU);
> > > > > > > > > I wonder why not simply fail here?
> > > > > > > > I think both failing or not accepting the feature can be argued to make
> > > > > > > > sense: "the device presented us with a mtu size that does not make
> > > > > > > > sense" would point to failing, "we cannot work with the mtu size that
> > > > > > > > the device presented us" would point to not negotiating the feature.
> > > > > > > > > >              }
> > > > > > > > > > 
> > > > > > > > > >              return 0;
> > > > > > > > > > }
> > > > > > > > > > 
> > > > > > > > > > And the spec says:
> > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > The driver MUST follow this sequence to initialize a device:
> > > > > > > > > > 1. Reset the device.
> > > > > > > > > > 2. Set the ACKNOWLEDGE status bit: the guest OS has noticed the device.
> > > > > > > > > > 3. Set the DRIVER status bit: the guest OS knows how to drive the device.
> > > > > > > > > > 4. Read device feature bits, and write the subset of feature bits understood by the OS and driver to the
> > > > > > > > > > device. During this step the driver MAY read (but MUST NOT write) the device-specific configuration
> > > > > > > > > > fields to check that it can support the device before accepting it.
> > > > > > > > > > 5. Set the FEATURES_OK status bit. The driver MUST NOT accept new feature bits after this step.
> > > > > > > > > > 6. Re-read device status to ensure the FEATURES_OK bit is still set: otherwise, the device does not
> > > > > > > > > > support our subset of features and the device is unusable.
> > > > > > > > > > 7. Perform device-specific setup, including discovery of virtqueues for the device, optional per-bus setup,
> > > > > > > > > > reading and possibly writing the device’s virtio configuration space, and population of virtqueues.
> > > > > > > > > > 8. Set the DRIVER_OK status bit. At this point the device is “live”.
> > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > Item 4 on the list explicitly allows reading config space before
> > > > > > > > > > FEATURES_OK.
> > > > > > > > > > 
> > > > > > > > > > I conclude that VIRTIO_NET_F_MTU is set means "set in device features".
> > > > > > > > > So this probably need some clarification. "is set" is used many times in
> > > > > > > > > the spec that has different implications.
> > > > > > > > Before FEATURES_OK is set by the driver, I guess it means "the device
> > > > > > > > has offered the feature";
> > > > > > > For me this part is ok since it clarify that it's the driver that set
> > > > > > > the bit.
> > > > > > > 
> > > > > > > 
> > > > > > > > during normal usage, it means "the feature
> > > > > > > > has been negotiated".
> > > > > > > /?
> > > > > > > 
> > > > > > > It looks to me the feature negotiation is done only after device set
> > > > > > > FEATURES_OK, or FEATURES_OK could be read from device status?
> > > > > > I'd consider feature negotiation done when the driver reads FEATURES_OK
> > > > > > back from the status.
> > > > > I agree.
> > > > > 
> > > > > 
> > > > > > > >      (This is a bit fuzzy for legacy mode.)
> > > > > > ...because legacy does not have FEATURES_OK.
> > > > > > > The problem is the MTU description for example:
> > > > > > > 
> > > > > > > "The following driver-read-only field, mtu only exists if
> > > > > > > VIRTIO_NET_F_MTU is set."
> > > > > > > 
> > > > > > > It looks to me need to use "if VIRTIO_NET_F_MTU is set by device".
> > > > > > "offered by the device"? I don't think it should 'disappear' from the
> > > > > > config space if the driver won't use it. (Same for other config space
> > > > > > fields that are tied to feature bits.)
> > > > > But what happens if e.g device doesn't offer VIRTIO_NET_F_MTU? It looks
> > > > > to according to the spec there will be no mtu field.
> > > > I think so, yes.
> > > > 
> > > > > And a more interesting case is VIRTIO_NET_F_MQ is not offered but
> > > > > VIRTIO_NET_F_MTU offered. To me, it means we don't have
> > > > > max_virtqueue_pairs but it's not how the driver is wrote today.
> > > > That would be a bug, but it seems to me that the virtio-net driver
> > > > reads max_virtqueue_pairs conditionally and handles absence of the
> > > > feature correctly?
> > > 
> > > Yes, see the avove codes:
> > > 
> > >          if (virtio_has_feature(vdev, VIRTIO_NET_F_MTU)) {
> > >                  int mtu = virtio_cread16(vdev,
> > >                                           offsetof(struct virtio_net_config,
> > >                                                    mtu));
> > >                  if (mtu < MIN_MTU)
> > >                          __virtio_clear_bit(vdev, VIRTIO_NET_F_MTU);
> > >          }
> > > 
> > > So it's probably too late to fix the driver.
> > > 
> > Confused. What is wrong with the above? It never reads the
> > field unless the feature has been offered by device.
> 
> 
> So the spec said:
> 
> "
> 
> The following driver-read-only field, max_virtqueue_pairs only exists if
> VIRTIO_NET_F_MQ is set.
> 
> "
> 
> If I read this correctly, there will be no max_virtqueue_pairs field if the
> VIRTIO_NET_F_MQ is not offered by device? If yes the offsetof() violates
> what spec said.
> 
> Thanks

I think that's a misunderstanding. This text was never intended to
imply that field offsets change beased on feature bits.
We had this pain with legacy and we never wanted to go back there.

This merely implies that without VIRTIO_NET_F_MQ the field
should not be accessed. Exists in the sense "is accessible to driver".

Let's just clarify that in the spec, job done.




> 
> > 
> > 
> > > > > > > Otherwise readers (at least for me), may think the MTU is only valid
> > > > > > > if driver set the bit.
> > > > > > I think it would still be 'valid' in the sense that it exists and has
> > > > > > some value in there filled in by the device, but a driver reading it
> > > > > > without negotiating the feature would be buggy. (Like in the kernel
> > > > > > code above; the kernel not liking the value does not make the field
> > > > > > invalid.)
> > > > > See Michael's reply, the spec allows read the config before setting
> > > > > features.
> > > > Yes, the period prior to finishing negotiation is obviously special.
> > > > 
> > > > > > Maybe a statement covering everything would be:
> > > > > > 
> > > > > > "The following driver-read-only field mtu only exists if the device
> > > > > > offers VIRTIO_NET_F_MTU and may be read by the driver during feature
> > > > > > negotiation and after VIRTIO_NET_F_MTU has been successfully
> > > > > > negotiated."
> > > > > > > > Should we add a wording clarification to the spec?
> > > > > > > I think so.
> > > > > > Some clarification would be needed for each field that depends on a
> > > > > > feature; that would be quite verbose. Maybe we can get away with a
> > > > > > clarifying statement?
> > > > > > 
> > > > > > "Some config space fields may depend on a certain feature. In that
> > > > > > case, the field exits if the device has offered the corresponding
> > > > > > feature,
> > > > > So this implies for !VIRTIO_NET_F_MQ && VIRTIO_NET_F_MTU, the config
> > > > > will look like:
> > > > > 
> > > > > struct virtio_net_config {
> > > > >            u8 mac[6];
> > > > >            le16 status;
> > > > >            le16 mtu;
> > > > > };
> > > > > 
> > > > I agree.
> > > 
> > > So consider it's probably too late to fix the driver which assumes some
> > > field are always persent, it looks to me need fix the spec do declare the
> > > fields are always existing instead.
> > > 
> > > 
> > > > > >     and may be read by the driver during feature negotiation, and
> > > > > > accessed by the driver after the feature has been successfully
> > > > > > negotiated. A shorthand for this is a statement that a field only
> > > > > > exists if a certain feature bit is set."
> > > > > I'm not sure using "shorthand" is good for the spec, at least we can
> > > > > limit the its scope only to the configuration space part.
> > > > Maybe "a shorthand expression"?
> > > 
> > > So the questions is should we use this for all over the spec or it will be
> > > only used in this speicifc part (device configuration).
> > > 
> > > Thanks
> > > 

