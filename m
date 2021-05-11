Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17D537A263
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 10:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhEKIo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 04:44:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46062 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230452AbhEKIoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 04:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620722597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VvW29x9kOh4HcSoVuHYOwNRxSG1C9s+951mnrkutiW4=;
        b=Q/5lV92wT4m+OxYxdSfnde0r+fg9PV+McZM8k7b0ywTBXP1HuYCvFK3w2tOyaoPxgRhcjo
        V+r1MX9bmhtBVqqonx7nWeshYKpnRgmb5SH3JJnFKV/nspUpRATrrc/ADvIpzkPEmuPoic
        Cr+AEcTkrOpOAMSwdQ6RUZhv+PvH+70=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-OclGWrxOPymuS58r5XS-Tg-1; Tue, 11 May 2021 04:43:15 -0400
X-MC-Unique: OclGWrxOPymuS58r5XS-Tg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26CCF100961D;
        Tue, 11 May 2021 08:43:14 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 139821037F25;
        Tue, 11 May 2021 08:43:14 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id EB3761806D0E;
        Tue, 11 May 2021 08:43:13 +0000 (UTC)
Date:   Tue, 11 May 2021 04:43:13 -0400 (EDT)
From:   Jason Wang <jasowang@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, parav@nvidia.com, elic@nvidia.com,
        Lingshan Zhu <lingshan.zhu@intel.com>
Message-ID: <529543956.24692551.1620722593826.JavaMail.zimbra@redhat.com>
In-Reply-To: <3d5754f3-c012-67ad-5f01-fc16ec53df4e@redhat.com>
References: <20210408082648.20145-1-jasowang@redhat.com> <20210409115343-mutt-send-email-mst@kernel.org> <42891807-cb24-5352-f8cb-798e9d1a1854@redhat.com> <20210412050730-mutt-send-email-mst@kernel.org> <01918e14-7f7a-abf2-5864-292a32f0233c@redhat.com> <d5632a4d-4d0b-b08d-06f9-c56f16734607@redhat.com> <20210421035331-mutt-send-email-mst@kernel.org> <3d5754f3-c012-67ad-5f01-fc16ec53df4e@redhat.com>
Subject: Re: [RFC PATCH] vdpa: mandate 1.0 device
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.72.13.219, 10.4.195.19]
Thread-Topic: vdpa: mandate 1.0 device
Thread-Index: Ak3WMaSgPuUzh6USV7wv4CzqC9hgTg==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- =E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6 -----
>=20
> =E5=9C=A8 2021/4/21 =E4=B8=8B=E5=8D=884:03, Michael S. Tsirkin =E5=86=99=
=E9=81=93:
> > On Wed, Apr 21, 2021 at 03:41:36PM +0800, Jason Wang wrote:
> >> =E5=9C=A8 2021/4/12 =E4=B8=8B=E5=8D=885:23, Jason Wang =E5=86=99=E9=81=
=93:
> >>> =E5=9C=A8 2021/4/12 =E4=B8=8B=E5=8D=885:09, Michael S. Tsirkin =E5=86=
=99=E9=81=93:
> >>>> On Mon, Apr 12, 2021 at 02:35:07PM +0800, Jason Wang wrote:
> >>>>> =E5=9C=A8 2021/4/10 =E4=B8=8A=E5=8D=8812:04, Michael S. Tsirkin =E5=
=86=99=E9=81=93:
> >>>>>> On Fri, Apr 09, 2021 at 12:47:55PM +0800, Jason Wang wrote:
> >>>>>>> =E5=9C=A8 2021/4/8 =E4=B8=8B=E5=8D=8811:59, Michael S. Tsirkin =
=E5=86=99=E9=81=93:
> >>>>>>>> On Thu, Apr 08, 2021 at 04:26:48PM +0800, Jason Wang wrote:
> >>>>>>>>> This patch mandates 1.0 for vDPA devices. The goal is to have t=
he
> >>>>>>>>> semantic of normative statement in the virtio
> >>>>>>>>> spec and eliminate the
> >>>>>>>>> burden of transitional device for both vDPA bus and vDPA parent=
.
> >>>>>>>>>
> >>>>>>>>> uAPI seems fine since all the vDPA parent mandates
> >>>>>>>>> VIRTIO_F_ACCESS_PLATFORM which implies 1.0 devices.
> >>>>>>>>>
> >>>>>>>>> For legacy guests, it can still work since Qemu will mediate wh=
en
> >>>>>>>>> necessary (e.g doing the endian conversion).
> >>>>>>>>>
> >>>>>>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
> >>>>>>>> Hmm. If we do this, don't we still have a problem with
> >>>>>>>> legacy drivers which don't ack 1.0?
> >>>>>>> Yes, but it's not something that is introduced in this
> >>>>>>> commit. The legacy
> >>>>>>> driver never work ...
> >>>>>> My point is this neither fixes or prevents this.
> >>>>>>
> >>>>>> So my suggestion is to finally add ioctls along the lines
> >>>>>> of PROTOCOL_FEATURES of vhost-user.
> >>>>>>
> >>>>>> Then that one can have bits for legacy le, legacy be and modern.
> >>>>>>
> >>>>>> BTW I looked at vhost-user and it does not look like that
> >>>>>> has a solution for this problem either, right?
> >>>>> Right.
> >>>>>
> >>>>>
> >>>>>>>> Note 1.0 affects ring endianness which is not mediated in QEMU
> >>>>>>>> so QEMU can't pretend to device guest is 1.0.
> >>>>>>> Right, I plan to send patches to do mediation in the
> >>>>>>> Qemu to unbreak legacy
> >>>>>>> drivers.
> >>>>>>>
> >>>>>>> Thanks
> >>>>>> I frankly think we'll need PROTOCOL_FEATURES anyway, it's
> >>>>>> too useful ...
> >>>>>> so why not teach drivers about it and be done with it? You
> >>>>>> can't emulate
> >>>>>> legacy on modern in a cross endian situation because of vring
> >>>>>> endian-ness ...
> >>>>> So the problem still. This can only work when the hardware can supp=
ort
> >>>>> legacy vring endian-ness.
> >>>>>
> >>>>> Consider:
> >>>>>
> >>>>> 1) the leagcy driver support is non-normative in the spec
> >>>>> 2) support a transitional device in the kenrel may requires the
> >>>>> hardware
> >>>>> support and a burden of kernel codes
> >>>>>
> >>>>> I'd rather simply drop the legacy driver support
> >>>> My point is this patch does not drop legacy support. It merely manda=
tes
> >>>> modern support.
> >>>
> >>> I am not sure I get here. This patch fails the set_feature if VERSION=
_1
> >>> is not negotiated. This means:
> >>>
> >>> 1) vDPA presents a modern device instead of transitonal device
> >>> 2) legacy driver can't be probed
> >>>
> >>> What I'm missing?
> >>
> >> Hi Michael:
> >>
> >> Do you agree to find the way to present modern device? We need a
> >> conclusion
> >> to make the netlink API work to move forward.
> >>
> >> Thanks
> > I think we need a way to support legacy with no data path overhead. qem=
u
> > setting VERSION_1 for a legacy guest affects the ring format so it does
> > not really work. This seems to rule out emulating config space entirely
> > in userspace.
>=20
>=20
> So I'd rather drop the legacy support in this case. It never work for
> vDPA in the past and virtio-vDPA doesn't even need that. Note that
> ACCESS_PLATFORM is mandated for all the vDPA parents right now which
> implies modern device and LE. I wonder what's the value for supporting
> legacy in this case or do we really encourage vendors to ship card with
> legacy support (e.g endian support in the hardware)?

Hi Michael:

Any thoughts on this approach?

My understanding is that dropping legacy support will simplify a lot of stu=
ffs.

Thanks


>=20
>=20
> >
> > So I think we should add an ioctl along the lines of
> > protocol features. Then I think we can reserve feature bits
> > for config space format: legacy LE, legacy BE, modern.
>=20
>=20
> We had VHOST_SET_VRING_ENDIAN but this will complicates both the vDPA
> parent and management. What's more important, legacy behaviour is not
> restrictied by the spec.
>=20
>=20
> >
> > Querying the feature bits will provide us with info about
> > what does the device support. Acking them will tell device
> > what does guest need.
>=20
>=20
> I think this can work, but I wonder how much we can gain from such
> complexitiy.
>=20
> Thanks
>=20
>=20
> >
> >
> >
> >
> >
> >>>
> >>>>> to have a simple and easy
> >>>>> abstarction in the kenrel. For legacy driver in the guest,
> >>>>> hypervisor is in
> >>>>> charge of the mediation:
> >>>>>
> >>>>> 1) config space access endian conversion
> >>>>> 2) using shadow virtqueue to change the endian in the vring
> >>>>>
> >>>>> Thanks
> >>>> I'd like to avoid shadow virtqueue hacks if at all possible.
> >>>> Last I checked performance wasn't much better than just emulating
> >>>> virtio in software.
> >>>
> >>> I think the legacy driver support is just a nice to have. Or do you s=
ee
> >>> any value to that? I guess for mellanox and intel, only modern device=
 is
> >>> supported in the hardware.
> >>>
> >>> Thanks
> >>>
> >>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>> ---
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0 include/linux/vdpa.h | 6 ++++++
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0 1 file changed, 6 insertions(+)
> >>>>>>>>>
> >>>>>>>>> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> >>>>>>>>> index 0fefeb976877..cfde4ec999b4 100644
> >>>>>>>>> --- a/include/linux/vdpa.h
> >>>>>>>>> +++ b/include/linux/vdpa.h
> >>>>>>>>> @@ -6,6 +6,7 @@
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0 #include <linux/device.h>
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0 #include <linux/interrupt.h>
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0 #include <linux/vhost_iotlb.h>
> >>>>>>>>> +#include <uapi/linux/virtio_config.h>
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0 /**
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 * vDPA callback definition.
> >>>>>>>>> @@ -317,6 +318,11 @@ static inline int
> >>>>>>>>> vdpa_set_features(struct vdpa_device *vdev, u64
> >>>>>>>>> features)
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0 {
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 const struct vdpa_config_ops *ops =3D vdev->config;
> >>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Mandating 1.0 to=
 have semantics of
> >>>>>>>>> normative statements in
> >>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the spec. *=
/
> >>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!(features & BI=
T_ULL(VIRTIO_F_VERSION_1)))
> >>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
> >>>>>>>>> +
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vdev->features_vali=
d =3D true;
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return ops->set_features(vdev, features);
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0 }
> >>>>>>>>> --
> >>>>>>>>> 2.25.1
>=20
>=20

