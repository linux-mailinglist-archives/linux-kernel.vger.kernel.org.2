Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEBEE36E094
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 22:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbhD1Uya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 16:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhD1Uy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 16:54:28 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71C3C06138A
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 13:53:41 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e5so35850795wrg.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 13:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F01dWG387l+l2oQAv3AlnSccDc9oKMZDHg8elg+ZIjs=;
        b=DRhtAVvq3xQyEQerqYxxjMKa0Ei7risYYXOBYMoHUUmytmcpk/oBooBnRkyuZ5fqcl
         5xuIeBmfZU4bXAAAkkbsxlSExcWKtBeFHzbuTOxCcuAB8g7y6VL5lJDqUkSSvoZlJ/Rm
         R/JNDI2Fge6T1DQy/YP5SRYQMyLcx/Lw2HBLoYFnsOw+3tnx7WFsZCsOQ4hr14IsmDys
         /pARt2qA90/CFSWH2s2m1DJcKCiS8WkcDXdvJ3Q1atz2LudVMULkMCO7YCeqQkKnPMqV
         MnzH848h1IF4YjG8mbqLIpHRcXFMtSVrevHJJdwz8TjquLp4kXRLv9RIEQPlT9SqSSrb
         8e4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F01dWG387l+l2oQAv3AlnSccDc9oKMZDHg8elg+ZIjs=;
        b=ncby+IbMLfjK8Ys4iebJOHuvBIlC2VKBAMKTG6P2CM8vlm3yUfVNC80SynigPE+My9
         wDUILdpqwMZVD6Jf7FM3IXdWbHMrfG3UbipWQ9nQomLinAnv/VmixV9aKCv1YB60/0af
         TR4iVz9+ESh2V9Ast4/3DWh1PyBWavL+xE77f9GVOu1q+8rLVU4GSA7DYaVfVnw3WZfo
         Z+qS0LA0LqgqkPLKEDhxPCty2BxZWcI0W+UiAuKRFuxRT49qHI/kdKfOfbYExNLDMwKT
         qk7JWOSXbHf6HsBb4MzYeXt96D2+c8zyaFWv7gEixqNkM6hbq6dkQRc9ZuOmSgLSBKzS
         in5Q==
X-Gm-Message-State: AOAM530/2v6cWeEEYtYC+dBkBlGRAZXEnirRWw1+UxDjkteN7V2yNaVW
        vOh+qWwyZhb44dsyJ0kajqZsZY9xmMPqGEEki9I=
X-Google-Smtp-Source: ABdhPJyCtCffym+esvys1aq9ecSJ0iWjwRY9hgXRbC1Rwk/G1PiN0eSFvphLqTSYRmM1PaGvnrBrutxasTjlh0cPw1o=
X-Received: by 2002:a5d:51d2:: with SMTP id n18mr38089280wrv.69.1619643220521;
 Wed, 28 Apr 2021 13:53:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210421104145.115907-1-elic@nvidia.com> <e1885255-34f2-9e90-6478-ff0850a5a3d4@redhat.com>
 <20210422060358.GA140698@mtl-vdi-166.wap.labs.mlnx> <20210422080725.GB140698@mtl-vdi-166.wap.labs.mlnx>
 <9d3d8976-800d-bb14-0a4a-c4b008f6872c@redhat.com> <20210422083902.GA146406@mtl-vdi-166.wap.labs.mlnx>
 <bdf10e38-8746-51cf-b460-a904a133329c@redhat.com> <20210425132523.GA43506@mtl-vdi-166.wap.labs.mlnx>
 <086936c8-adff-d4c2-469f-2df58c4db858@redhat.com>
In-Reply-To: <086936c8-adff-d4c2-469f-2df58c4db858@redhat.com>
From:   Si-Wei Liu <siwliu.kernel@gmail.com>
Date:   Wed, 28 Apr 2021 13:53:28 -0700
Message-ID: <CAPWQSg35eGLr0jKEy0uVQVB0OOT7nUs_JaW2e_L9oME54nLvzQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: Add support for doorbell bypassing
To:     Jason Wang <jasowang@redhat.com>
Cc:     Eli Cohen <elic@nvidia.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "Zhu, Lingshan" <lingshan.zhu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 25, 2021 at 7:38 PM Jason Wang <jasowang@redhat.com> wrote:
>
>
> =E5=9C=A8 2021/4/25 =E4=B8=8B=E5=8D=889:25, Eli Cohen =E5=86=99=E9=81=93:
> > On Thu, Apr 22, 2021 at 04:59:11PM +0800, Jason Wang wrote:
> >> =E5=9C=A8 2021/4/22 =E4=B8=8B=E5=8D=884:39, Eli Cohen =E5=86=99=E9=81=
=93:
> >>> On Thu, Apr 22, 2021 at 04:21:45PM +0800, Jason Wang wrote:
> >>>> =E5=9C=A8 2021/4/22 =E4=B8=8B=E5=8D=884:07, Eli Cohen =E5=86=99=E9=
=81=93:
> >>>>> On Thu, Apr 22, 2021 at 09:03:58AM +0300, Eli Cohen wrote:
> >>>>>> On Thu, Apr 22, 2021 at 10:37:38AM +0800, Jason Wang wrote:
> >>>>>>> =E5=9C=A8 2021/4/21 =E4=B8=8B=E5=8D=886:41, Eli Cohen =E5=86=99=
=E9=81=93:
> >>>>>>>> Implement mlx5_get_vq_notification() to return the doorbell addr=
ess.
> >>>>>>>> Size is set to one system page as required.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Eli Cohen <elic@nvidia.com>
> >>>>>>>> ---
> >>>>>>>>      drivers/vdpa/mlx5/core/mlx5_vdpa.h | 1 +
> >>>>>>>>      drivers/vdpa/mlx5/core/resources.c | 1 +
> >>>>>>>>      drivers/vdpa/mlx5/net/mlx5_vnet.c  | 6 ++++++
> >>>>>>>>      3 files changed, 8 insertions(+)
> >>>>>>>>
> >>>>>>>> diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/m=
lx5/core/mlx5_vdpa.h
> >>>>>>>> index b6cc53ba980c..49de62cda598 100644
> >>>>>>>> --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> >>>>>>>> +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> >>>>>>>> @@ -41,6 +41,7 @@ struct mlx5_vdpa_resources {
> >>>>>>>>        u32 pdn;
> >>>>>>>>        struct mlx5_uars_page *uar;
> >>>>>>>>        void __iomem *kick_addr;
> >>>>>>>> +      u64 phys_kick_addr;
> >>>>>>>>        u16 uid;
> >>>>>>>>        u32 null_mkey;
> >>>>>>>>        bool valid;
> >>>>>>>> diff --git a/drivers/vdpa/mlx5/core/resources.c b/drivers/vdpa/m=
lx5/core/resources.c
> >>>>>>>> index 6521cbd0f5c2..665f8fc1710f 100644
> >>>>>>>> --- a/drivers/vdpa/mlx5/core/resources.c
> >>>>>>>> +++ b/drivers/vdpa/mlx5/core/resources.c
> >>>>>>>> @@ -247,6 +247,7 @@ int mlx5_vdpa_alloc_resources(struct mlx5_vd=
pa_dev *mvdev)
> >>>>>>>>                goto err_key;
> >>>>>>>>        kick_addr =3D mdev->bar_addr + offset;
> >>>>>>>> +      res->phys_kick_addr =3D kick_addr;
> >>>>>>>>        res->kick_addr =3D ioremap(kick_addr, PAGE_SIZE);
> >>>>>>>>        if (!res->kick_addr) {
> >>>>>>>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/ml=
x5/net/mlx5_vnet.c
> >>>>>>>> index 10c5fef3c020..680751074d2a 100644
> >>>>>>>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> >>>>>>>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> >>>>>>>> @@ -1865,8 +1865,14 @@ static void mlx5_vdpa_free(struct vdpa_de=
vice *vdev)
> >>>>>>>>      static struct vdpa_notification_area mlx5_get_vq_notificati=
on(struct vdpa_device *vdev, u16 idx)
> >>>>>>>>      {
> >>>>>>>> +      struct mlx5_vdpa_dev *mvdev =3D to_mvdev(vdev);
> >>>>>>>>        struct vdpa_notification_area ret =3D {};
> >>>>>>>> +      struct mlx5_vdpa_net *ndev;
> >>>>>>>> +
> >>>>>>>> +      ndev =3D to_mlx5_vdpa_ndev(mvdev);
> >>>>>>>> +      ret.addr =3D (phys_addr_t)ndev->mvdev.res.phys_kick_addr;
> >>>>>>>> +      ret.size =3D PAGE_SIZE;
> >>>>>>> Note that the page will be mapped in to guest, so it's only safe =
if the
> >>>>>>> doorbeel exclusively own the page. This means if there're other r=
egisters in
> >>>>>>> the page, we can not let the doorbell bypass to work.
> >>>>>>>
> >>>>>>> So this is suspicious at least in the case of subfunction where w=
e calculate
> >>>>>>> the bar length in mlx5_sf_dev_table_create() as:
> >>>>>>>
> >>>>>>> table->sf_bar_length =3D 1 << (MLX5_CAP_GEN(dev, log_min_sf_size)=
 + 12);
> >>>>>>>
> >>>>>>> It looks to me this can only work for the arch with PAGE_SIZE =3D=
 4096,
> >>>>>>> otherwise we can map more into the userspace(guest).
> >>>>>>>
> >>>>>> Correct, so I guess I should return here 4096.
> >>>> I'm not quite sure but since the calculation of the sf_bar_length is=
 doen
> >>>> via a shift of 12, it might be correct.
> >>>>
> >>>> And please double check if the doorbell own the page exclusively.
> >>> I am checking if it is safe to map the any part of the SF's BAR to
> >>> userspace without harming other functions. If this is true, I will ch=
eck
> >>> if I can return PAGE_SIZE without compromising security.
> >>
> >> It's usally not safe and a layer violation if other registers are plac=
ed at
> >> the same page.
> >>
> >>
> >>>    I think we may
> >>> need to extend struct vdpa_notification_area to contain another field
> >>> offset which indicates the offset from addr where the actual doorbell
> >>> resides.
> >>
> >> The movitiaton of the current design is to be fit seamless into how Qe=
mu
> >> model doorbell layouts currently:
> >>
> >> 1) page-per-vq, each vq has its own page aligned doorbell
> >> 2) 2 bytes doorbell, each vq has its own 2 byte aligend doorbell
> >>
> >> Only 1) is support in vhost-vDPA (and vhost-user) since it's rather si=
mple
> >> and secure (page aligned) to be modelled and implemented via mmap().
> >>
> >> Exporting a complex layout is possbile but requires careful design.
> >>
> >> Actually, we had antoher option
> >>
> >> 3) shared doorbell: all virtqueue shares a single page aligned doorbel=
l
> >>
> > This nearly matches we have in ConnectX devices. All the doorbells are
> > located at the same place. For 4K page size atchitectures it is aligned
> > to the start of the page. For larger page sizes it is not aligned.
> > If we don't allow to some offset within the page, it means that direct
> > doorbells will not work for 64K page size archs over ConnectX.
>
>
> Right, just to clarify. This can still be model by the current
> page-per-vq model. It means the doorbell will be mapped into different
> pages for each virtqueue by Qemu. So from the view of Qemu or guest,
> each virtqueue has its own doorbell in this case.

So this is the proposed model for mlx5 vdpa with doorbell per-instance
(rather than per-vq), assuming the exclusive ownership of mapped
doorbell page?

>
>
> >
> >> This is not yet supported by Qemu.
>
>
> For "not supported" I meant present this (doorbells sharing) layout to
> guest.

So it means this new layout perhaps will have to introduce new virtio
features to guest thus not compatible with eixsting driver?

-Siwei
>
> Thanks
>
>
> >>
> >> Thanks
> >>
> >>
> >>>>>> I also think that the check in vhost_vdpa_mmap() should verify tha=
t the
> >>>>>> returned size is not smaller than PAGE_SIZE because the returned a=
ddress
> >>>>> Actually I think it's ok since you verify the size equals vma->vm_e=
nd -
> >>>>> vma->vm_start which must be at least PAGE_SIZE.
> >>>> Yes.
> >>>>
> >>>> Thanks
> >>>>
> >>>>
> >>>>>> might just be aligned to PAGE_SIZE. I think this should be enoght =
but
> >>>>>> maybe also use the same logic in vhost_vdpa_fault().
>
