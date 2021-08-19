Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDD03F1F6B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 19:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbhHSRzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 13:55:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27445 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232328AbhHSRzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 13:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629395678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XvMmHvYeHANESq7dk+/AFW6nVxG49eGLBlJTsJ/Yx9o=;
        b=Blc6C+1xaVlwRRZ0Ci6SRYCADw7l9QKYq5rxH34nOt1cZLFOe56K0h9lzHoy03rZQ3n2RE
        mcrlKfQHiJz2wePLzu033eQDBQu+Vgopej4l2QiCDSa7vcgQkQtDUD/rDoSvQDekQ2JASR
        bGi9g1FxSSt3/XitshHIEy3QW49CjPI=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-Ywh0l4z2PTaD3InebS7pmg-1; Thu, 19 Aug 2021 13:54:36 -0400
X-MC-Unique: Ywh0l4z2PTaD3InebS7pmg-1
Received: by mail-oi1-f197.google.com with SMTP id r7-20020acaf3070000b029026241cf3dbfso2479833oih.16
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 10:54:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XvMmHvYeHANESq7dk+/AFW6nVxG49eGLBlJTsJ/Yx9o=;
        b=EnaHrh9Hpww4YxMEQ0k7RKe2Sn38xRw8/SXqQ01sxj5UVpJ+aFKZ26p7wFjRj6rq/i
         LJidhTYN57bv5F7zUKzqaFhPUtsRiC8b3bYyj6JJlQBhawPyYJAyWi+nX/WfQnb2LblC
         gaEEwtVXwh+aJk8N1t5wvCfKaP32/CmF7SwZlAkwIOuQ5rY9RfjvpzOUh4ARW5pZj9W9
         dkJUlnXFe81UXjvX2YuQ9QrQ8PrVoyFNo5qogWf19qD/YTtKEasl3IKOTZd9x4bHCfNs
         ILGZEBER+pOpPjBbRp8Go/LNbMELLsPVNwjk2r/Vex2EGgdFDoiDzolLozszA4JKSQxY
         2h0g==
X-Gm-Message-State: AOAM533I5R/TGBMocmuihuSPuaCN9wNAdhVPy2vEtGpFXHbQELgZqUsB
        RcSuTLxLye7xT+ZGBPgmz1GeyC+HaDruz9x7OKlDp4fLPebS1BVRiG9+cBxkX8lvZtz95rIoUzy
        BVmTjhANubzK65Lje7mpYshkG
X-Received: by 2002:a9d:662:: with SMTP id 89mr12924537otn.24.1629395676141;
        Thu, 19 Aug 2021 10:54:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNTvvDgs6rPWtdrpqC0XlBdeMpuN/Bmb0hgePuq+eBsqpPpF9Le+1i3dxMG1dR2DJjO3IheQ==
X-Received: by 2002:a9d:662:: with SMTP id 89mr12924528otn.24.1629395675934;
        Thu, 19 Aug 2021 10:54:35 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id f33sm865244otf.0.2021.08.19.10.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 10:54:35 -0700 (PDT)
Date:   Thu, 19 Aug 2021 11:54:33 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        cohuck@redhat.com, pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        jgg@nvidia.com, kwankhede@nvidia.com, david@redhat.com
Subject: Re: [PATCH 1/2] s390/vfio-ap: r/w lock for PQAP interception
 handler function pointer
Message-ID: <20210819115433.76153ae4.alex.williamson@redhat.com>
In-Reply-To: <358b1052-c751-7417-1263-308b133325b6@linux.ibm.com>
References: <20210719193503.793910-1-akrowiak@linux.ibm.com>
        <20210719193503.793910-2-akrowiak@linux.ibm.com>
        <1a9f15d7-0f4d-00a0-0a8b-f1c08aa52eeb@de.ibm.com>
        <358b1052-c751-7417-1263-308b133325b6@linux.ibm.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Aug 2021 09:20:28 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> On 8/18/21 1:03 PM, Christian Borntraeger wrote:
> > On 19.07.21 21:35, Tony Krowiak wrote: =20
> >> The function pointer to the interception handler for the PQAP=20
> >> instruction
> >> can get changed during the interception process. Let's add a
> >> semaphore to struct kvm_s390_crypto to control read/write access to the
> >> function pointer contained therein.
> >>
> >> The semaphore must be locked for write access by the vfio_ap device=20
> >> driver
> >> when notified that the KVM pointer has been set or cleared. It must be
> >> locked for read access by the interception framework when the PQAP
> >> instruction is intercepted.
> >>
> >> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> >> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> >> ---
> >> =C2=A0 arch/s390/include/asm/kvm_host.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
|=C2=A0 8 +++-----
> >> =C2=A0 arch/s390/kvm/kvm-s390.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> >> =C2=A0 arch/s390/kvm/priv.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 ++++++----
> >> =C2=A0 drivers/s390/crypto/vfio_ap_ops.c=C2=A0=C2=A0=C2=A0=C2=A0 | 23 =
+++++++++++++++++------
> >> =C2=A0 drivers/s390/crypto/vfio_ap_private.h |=C2=A0 2 +-
> >> =C2=A0 5 files changed, 28 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/arch/s390/include/asm/kvm_host.h=20
> >> b/arch/s390/include/asm/kvm_host.h
> >> index 9b4473f76e56..f18849d259e6 100644
> >> --- a/arch/s390/include/asm/kvm_host.h
> >> +++ b/arch/s390/include/asm/kvm_host.h
> >> @@ -798,14 +798,12 @@ struct kvm_s390_cpu_model {
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned short ibc;
> >> =C2=A0 };
> >> =C2=A0 -struct kvm_s390_module_hook {
> >> -=C2=A0=C2=A0=C2=A0 int (*hook)(struct kvm_vcpu *vcpu);
> >> -=C2=A0=C2=A0=C2=A0 struct module *owner;
> >> -};
> >> +typedef int (*crypto_hook)(struct kvm_vcpu *vcpu);
> >> =C2=A0 =C2=A0 struct kvm_s390_crypto {
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct kvm_s390_crypto_cb *crycb;
> >> -=C2=A0=C2=A0=C2=A0 struct kvm_s390_module_hook *pqap_hook;
> >> +=C2=A0=C2=A0=C2=A0 struct rw_semaphore pqap_hook_rwsem;
> >> +=C2=A0=C2=A0=C2=A0 crypto_hook *pqap_hook;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u32 crycbd;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u8 aes_kw;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u8 dea_kw;
> >> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> >> index b655a7d82bf0..a08f242a9f27 100644
> >> --- a/arch/s390/kvm/kvm-s390.c
> >> +++ b/arch/s390/kvm/kvm-s390.c
> >> @@ -2630,6 +2630,7 @@ static void kvm_s390_crypto_init(struct kvm *kvm)
> >> =C2=A0 {
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kvm->arch.crypto.crycb =3D &kvm->arch.s=
ie_page2->crycb;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kvm_s390_set_crycb_format(kvm);
> >> +=C2=A0=C2=A0=C2=A0 init_rwsem(&kvm->arch.crypto.pqap_hook_rwsem);
> >> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!test_kvm_facility(kvm, 76))
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> >> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
> >> index 9928f785c677..6bed9406c1f3 100644
> >> --- a/arch/s390/kvm/priv.c
> >> +++ b/arch/s390/kvm/priv.c
> >> @@ -610,6 +610,7 @@ static int handle_io_inst(struct kvm_vcpu *vcpu)
> >> =C2=A0 static int handle_pqap(struct kvm_vcpu *vcpu)
> >> =C2=A0 {
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ap_queue_status status =3D {};
> >> +=C2=A0=C2=A0=C2=A0 crypto_hook pqap_hook;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long reg0;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t fc;
> >> @@ -657,15 +658,16 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Verify that the hook callback i=
s registered, lock the owner
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * and call the hook.
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> >> + down_read(&vcpu->kvm->arch.crypto.pqap_hook_rwsem);
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (vcpu->kvm->arch.crypto.pqap_hook) {
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!try_module_get(vcpu->=
kvm->arch.crypto.pqap_hook->owner))
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn -EOPNOTSUPP;
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D vcpu->kvm->arch.cr=
ypto.pqap_hook->hook(vcpu);
> >> - module_put(vcpu->kvm->arch.crypto.pqap_hook->owner);
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pqap_hook =3D *vcpu->kvm->=
arch.crypto.pqap_hook; =20
> >
> > Dont we have to check for NULL here? If not can you add a comment why? =
=20
>=20
> Take a look above the removed lines: if (vcpu->kvm->arch.crypto.pqap_hook)
>=20
> >
> > Otherwise this looks good. =20
>=20
> Also, in the cover letter I said this patch was already queued and was
> included here because it pre-reqs the second patch. Is this patch not
> already in Alex's tree?

Nope.  The only requests for merges through my tree that I'm aware of
were [1] and what I understand was the evolution of that here now [2].
Maybe you're thinking of [3], which I do see in mainline where this was
2/2 in that series but afaict only patch 1/2 was committed.  I guess
that explains why there was no respin based on comments for this patch.
Thanks,

Alex

[1]https://lore.kernel.org/linux-s390/9c50fb1b-4574-0cfc-487c-64108d97ed73@=
de.ibm.com/
[2]https://lore.kernel.org/linux-s390/6d64bd83-1519-6065-a4cd-9356c6be5d1a@=
de.ibm.com/
[3]https://lore.kernel.org/linux-s390/e809be5b-0b24-34dc-1eae-82b58dc54545@=
de.ibm.com/

