Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 072DC37B914
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 11:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhELJZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 05:25:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21423 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230037AbhELJZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 05:25:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620811479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Je1KS7YOVHavoIfQ7KtY7zo/B1WdAVPfu1SGQbtiGY8=;
        b=QsiXQtT1tqwI6YxWC/hz7FfwPGv/IMF/8GO5ftIkPxi2+vbmyZJ14+4EEqU8fGYPLZu3BE
        IGp9VS1cJlijL/DZZDAHVQ8L/naO4CkWfMigOgOG7wrfLLSCeO7x4/zAv4Qe6ALFkTGlgV
        Qa8xXGjw7X1hA+ssL5TnWW+szNqnCaE=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-P9AaH0hjPYCm3aAgi9OueQ-1; Wed, 12 May 2021 05:24:37 -0400
X-MC-Unique: P9AaH0hjPYCm3aAgi9OueQ-1
Received: by mail-pf1-f200.google.com with SMTP id a8-20020a62d4080000b029028db7db58adso14543626pfh.22
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 02:24:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Je1KS7YOVHavoIfQ7KtY7zo/B1WdAVPfu1SGQbtiGY8=;
        b=gCEbX+6mRpdu3838Akp4qcmJosa8vdvdgMesUXsd9q6bjEf3le9gPKP/hRp+lqI3OS
         u1cx5gt2CeJNcXupWOeLumien9CAAs/TblowwiWgL41Myc+MPLFDNM0Pq65h1FBkowhv
         K9GgbSe+i6k7vJJb3gI3tGf0n0MzhQL+uCP6g4bEHFHxL3ZtoGsaa+rUWzJxsWd82Ck0
         zeSe+CAEns/NK+UelpBDURBJuZBEw/D3gIV33qUuSjQm7VMwR91Y/bY0TseaqYZHb2Rn
         ZqBYk0sQD8JPyQY4EiIh05CG2xrnjltM3gtxxqr2yQQZFJ3yIPEIKnLpJL6BdB8uCB8A
         /7aA==
X-Gm-Message-State: AOAM5317LczGlo5I4k+4H7WuTDBtI1/pBTEn/+s+9I0u0K4nBF6NWR3d
        RIKHRGvtnOLQ2wwiEJLI87BqGmX4FyK4AuWtqGWUsZhaGIrYJYHFxR0aGmZ4b8hf4h2ZhGwYRZK
        TrgTAddugKPVjUgVhetlEx1H5P0OaHWa+vGWcSrlS
X-Received: by 2002:a17:902:c211:b029:ed:7a6b:d4bf with SMTP id 17-20020a170902c211b02900ed7a6bd4bfmr34388968pll.63.1620811476413;
        Wed, 12 May 2021 02:24:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwp7t4oeA7z4E29TZxB0ETdgquSHL87LpVC0igXsRjg2A9wiZeFn/i7AV+3FbTEtsIJ/UcsQpCgZn71OZpTMTs=
X-Received: by 2002:a17:902:c211:b029:ed:7a6b:d4bf with SMTP id
 17-20020a170902c211b02900ed7a6bd4bfmr34388944pll.63.1620811476008; Wed, 12
 May 2021 02:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210408082648.20145-1-jasowang@redhat.com> <20210409115343-mutt-send-email-mst@kernel.org>
 <42891807-cb24-5352-f8cb-798e9d1a1854@redhat.com> <20210412050730-mutt-send-email-mst@kernel.org>
 <01918e14-7f7a-abf2-5864-292a32f0233c@redhat.com> <d5632a4d-4d0b-b08d-06f9-c56f16734607@redhat.com>
 <20210421035331-mutt-send-email-mst@kernel.org> <3d5754f3-c012-67ad-5f01-fc16ec53df4e@redhat.com>
 <529543956.24692551.1620722593826.JavaMail.zimbra@redhat.com> <20210511061740-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210511061740-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 12 May 2021 17:24:21 +0800
Message-ID: <CACGkMEuvqUL04_wHqSKPUufu5O6ydhytHAx0NryLODNHkEO+Fw@mail.gmail.com>
Subject: Re: [RFC PATCH] vdpa: mandate 1.0 device
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, parav@nvidia.com,
        Eli Cohen <elic@nvidia.com>,
        Lingshan Zhu <lingshan.zhu@intel.com>, mapfelba@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 3:54 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, May 11, 2021 at 04:43:13AM -0400, Jason Wang wrote:
> >
> >
> > ----- =E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6 -----
> > >
> > > =E5=9C=A8 2021/4/21 =E4=B8=8B=E5=8D=884:03, Michael S. Tsirkin =E5=86=
=99=E9=81=93:
> > > > On Wed, Apr 21, 2021 at 03:41:36PM +0800, Jason Wang wrote:
> > > >> =E5=9C=A8 2021/4/12 =E4=B8=8B=E5=8D=885:23, Jason Wang =E5=86=99=
=E9=81=93:
> > > >>> =E5=9C=A8 2021/4/12 =E4=B8=8B=E5=8D=885:09, Michael S. Tsirkin =
=E5=86=99=E9=81=93:
> > > >>>> On Mon, Apr 12, 2021 at 02:35:07PM +0800, Jason Wang wrote:
> > > >>>>> =E5=9C=A8 2021/4/10 =E4=B8=8A=E5=8D=8812:04, Michael S. Tsirkin=
 =E5=86=99=E9=81=93:
> > > >>>>>> On Fri, Apr 09, 2021 at 12:47:55PM +0800, Jason Wang wrote:
> > > >>>>>>> =E5=9C=A8 2021/4/8 =E4=B8=8B=E5=8D=8811:59, Michael S. Tsirki=
n =E5=86=99=E9=81=93:
> > > >>>>>>>> On Thu, Apr 08, 2021 at 04:26:48PM +0800, Jason Wang wrote:
> > > >>>>>>>>> This patch mandates 1.0 for vDPA devices. The goal is to ha=
ve the
> > > >>>>>>>>> semantic of normative statement in the virtio
> > > >>>>>>>>> spec and eliminate the
> > > >>>>>>>>> burden of transitional device for both vDPA bus and vDPA pa=
rent.
> > > >>>>>>>>>
> > > >>>>>>>>> uAPI seems fine since all the vDPA parent mandates
> > > >>>>>>>>> VIRTIO_F_ACCESS_PLATFORM which implies 1.0 devices.
> > > >>>>>>>>>
> > > >>>>>>>>> For legacy guests, it can still work since Qemu will mediat=
e when
> > > >>>>>>>>> necessary (e.g doing the endian conversion).
> > > >>>>>>>>>
> > > >>>>>>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > >>>>>>>> Hmm. If we do this, don't we still have a problem with
> > > >>>>>>>> legacy drivers which don't ack 1.0?
> > > >>>>>>> Yes, but it's not something that is introduced in this
> > > >>>>>>> commit. The legacy
> > > >>>>>>> driver never work ...
> > > >>>>>> My point is this neither fixes or prevents this.
> > > >>>>>>
> > > >>>>>> So my suggestion is to finally add ioctls along the lines
> > > >>>>>> of PROTOCOL_FEATURES of vhost-user.
> > > >>>>>>
> > > >>>>>> Then that one can have bits for legacy le, legacy be and moder=
n.
> > > >>>>>>
> > > >>>>>> BTW I looked at vhost-user and it does not look like that
> > > >>>>>> has a solution for this problem either, right?
> > > >>>>> Right.
> > > >>>>>
> > > >>>>>
> > > >>>>>>>> Note 1.0 affects ring endianness which is not mediated in QE=
MU
> > > >>>>>>>> so QEMU can't pretend to device guest is 1.0.
> > > >>>>>>> Right, I plan to send patches to do mediation in the
> > > >>>>>>> Qemu to unbreak legacy
> > > >>>>>>> drivers.
> > > >>>>>>>
> > > >>>>>>> Thanks
> > > >>>>>> I frankly think we'll need PROTOCOL_FEATURES anyway, it's
> > > >>>>>> too useful ...
> > > >>>>>> so why not teach drivers about it and be done with it? You
> > > >>>>>> can't emulate
> > > >>>>>> legacy on modern in a cross endian situation because of vring
> > > >>>>>> endian-ness ...
> > > >>>>> So the problem still. This can only work when the hardware can =
support
> > > >>>>> legacy vring endian-ness.
> > > >>>>>
> > > >>>>> Consider:
> > > >>>>>
> > > >>>>> 1) the leagcy driver support is non-normative in the spec
> > > >>>>> 2) support a transitional device in the kenrel may requires the
> > > >>>>> hardware
> > > >>>>> support and a burden of kernel codes
> > > >>>>>
> > > >>>>> I'd rather simply drop the legacy driver support
> > > >>>> My point is this patch does not drop legacy support. It merely m=
andates
> > > >>>> modern support.
> > > >>>
> > > >>> I am not sure I get here. This patch fails the set_feature if VER=
SION_1
> > > >>> is not negotiated. This means:
> > > >>>
> > > >>> 1) vDPA presents a modern device instead of transitonal device
> > > >>> 2) legacy driver can't be probed
> > > >>>
> > > >>> What I'm missing?
> > > >>
> > > >> Hi Michael:
> > > >>
> > > >> Do you agree to find the way to present modern device? We need a
> > > >> conclusion
> > > >> to make the netlink API work to move forward.
> > > >>
> > > >> Thanks
> > > > I think we need a way to support legacy with no data path overhead.=
 qemu
> > > > setting VERSION_1 for a legacy guest affects the ring format so it =
does
> > > > not really work. This seems to rule out emulating config space enti=
rely
> > > > in userspace.
> > >
> > >
> > > So I'd rather drop the legacy support in this case. It never work for
> > > vDPA in the past and virtio-vDPA doesn't even need that. Note that
> > > ACCESS_PLATFORM is mandated for all the vDPA parents right now which
> > > implies modern device and LE. I wonder what's the value for supportin=
g
> > > legacy in this case or do we really encourage vendors to ship card wi=
th
> > > legacy support (e.g endian support in the hardware)?
> >
> > Hi Michael:
> >
> > Any thoughts on this approach?
> >
> > My understanding is that dropping legacy support will simplify a lot of=
 stuffs.
> >
> > Thanks
>
> So basically the main condition is that strong memory barriers aren't
> needed for virtio, smp barriers are enough.
> Are there architectures besides x86 (where it's kind of true - as long as
> one does not use non-temporals) where that is true?
> If all these architectures are LE then we don't need to worry
> about endian support in the hardware.

So I agree it's better not to add those stuffs in either qemu or
kernel. See below.

>
> In other words I guess yes we could have qemu limit things to x86 and
> then just pretend to the card that it's virtio 1.
> So endian-ness we can address.
>
> Problem is virtio 1 has effects beyond this. things like header size
> with mergeable buffers off for virtio net.
>
> So I am inclined to say let us not do the "pretend it's virtio 1" game
> in qemu.

I fully agree.

  Let us be honest to the card about what happens.
> But if you want to limit things to x86 either in kernel or in qemu,
> that's ok by me.

So what I want to do is:

1) mandate 1.0 device on the kernel
2) don't try to pretend transitional or legacy device on top of modern
device in Qemu, so qemu will fail to start if vhost-vDPA is started
with a legacy or transitional device

And this simply the management API which can assume LE for
pre-configuration via config space.

So if I'm not misunderstanding, we can merge this patch and I can do
the Qemu work on top?

Thanks

>
> >
> > >
> > >
> > > >
> > > > So I think we should add an ioctl along the lines of
> > > > protocol features. Then I think we can reserve feature bits
> > > > for config space format: legacy LE, legacy BE, modern.
> > >
> > >
> > > We had VHOST_SET_VRING_ENDIAN but this will complicates both the vDPA
> > > parent and management. What's more important, legacy behaviour is not
> > > restrictied by the spec.
> > >
> > >
> > > >
> > > > Querying the feature bits will provide us with info about
> > > > what does the device support. Acking them will tell device
> > > > what does guest need.
> > >
> > >
> > > I think this can work, but I wonder how much we can gain from such
> > > complexitiy.
> > >
> > > Thanks
> > >
> > >
> > > >
> > > >
> > > >
> > > >
> > > >
> > > >>>
> > > >>>>> to have a simple and easy
> > > >>>>> abstarction in the kenrel. For legacy driver in the guest,
> > > >>>>> hypervisor is in
> > > >>>>> charge of the mediation:
> > > >>>>>
> > > >>>>> 1) config space access endian conversion
> > > >>>>> 2) using shadow virtqueue to change the endian in the vring
> > > >>>>>
> > > >>>>> Thanks
> > > >>>> I'd like to avoid shadow virtqueue hacks if at all possible.
> > > >>>> Last I checked performance wasn't much better than just emulatin=
g
> > > >>>> virtio in software.
> > > >>>
> > > >>> I think the legacy driver support is just a nice to have. Or do y=
ou see
> > > >>> any value to that? I guess for mellanox and intel, only modern de=
vice is
> > > >>> supported in the hardware.
> > > >>>
> > > >>> Thanks
> > > >>>
> > > >>>
> > > >>>>>>>>
> > > >>>>>>>>
> > > >>>>>>>>> ---
> > > >>>>>>>>>      include/linux/vdpa.h | 6 ++++++
> > > >>>>>>>>>      1 file changed, 6 insertions(+)
> > > >>>>>>>>>
> > > >>>>>>>>> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> > > >>>>>>>>> index 0fefeb976877..cfde4ec999b4 100644
> > > >>>>>>>>> --- a/include/linux/vdpa.h
> > > >>>>>>>>> +++ b/include/linux/vdpa.h
> > > >>>>>>>>> @@ -6,6 +6,7 @@
> > > >>>>>>>>>      #include <linux/device.h>
> > > >>>>>>>>>      #include <linux/interrupt.h>
> > > >>>>>>>>>      #include <linux/vhost_iotlb.h>
> > > >>>>>>>>> +#include <uapi/linux/virtio_config.h>
> > > >>>>>>>>>      /**
> > > >>>>>>>>>       * vDPA callback definition.
> > > >>>>>>>>> @@ -317,6 +318,11 @@ static inline int
> > > >>>>>>>>> vdpa_set_features(struct vdpa_device *vdev, u64
> > > >>>>>>>>> features)
> > > >>>>>>>>>      {
> > > >>>>>>>>>              const struct vdpa_config_ops *ops =3D vdev->co=
nfig;
> > > >>>>>>>>> +        /* Mandating 1.0 to have semantics of
> > > >>>>>>>>> normative statements in
> > > >>>>>>>>> +         * the spec. */
> > > >>>>>>>>> +        if (!(features & BIT_ULL(VIRTIO_F_VERSION_1)))
> > > >>>>>>>>> +        return -EINVAL;
> > > >>>>>>>>> +
> > > >>>>>>>>>          vdev->features_valid =3D true;
> > > >>>>>>>>>              return ops->set_features(vdev, features);
> > > >>>>>>>>>      }
> > > >>>>>>>>> --
> > > >>>>>>>>> 2.25.1
> > >
> > >
>

