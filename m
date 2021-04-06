Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9736355D49
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 22:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbhDFU4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 16:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhDFU4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 16:56:20 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49692C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 13:56:11 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id w70so16607127oie.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 13:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wRagIHaosNIHEhfT2SPEo4dj40rudVGNfuS3iTLJiJs=;
        b=FDcvFkYiTxGytZfWkZ/k3uyltkZeEdzaUIpd4sRae8HwQtx9gqbZxgo1GOMq3T2Oq4
         WSg+tjPy61Mc2oDxQuCI868kn0nh9uYOVl+OEYgUCRp5VdqsZSnnORx+l9u8Lz2VOH4K
         yFFBVj7O/9CtdmkxRldB/Hfe2bG42UrJaP0g8A6gERp9zhPwbyT5uObc4RpiQW3HrTap
         SF9BC3dBr5UxmvQ/cZRK/e+DD5883m8jNMaoIZtsUh5mIa2mqagqRQogLCR7U06iJk1P
         +xVGJpm7G6FH5U3mIpJAPMIuCRWAS6B54T+dum8TZY1hSeqEhvx1C8RVWcvWU+VE2B6B
         kAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wRagIHaosNIHEhfT2SPEo4dj40rudVGNfuS3iTLJiJs=;
        b=hXjkoPTMEyz30UNHhaW9Pz5aNfCvxdFw5uZ4NkTVgBHUy1uMDxasUPZmpW3ks77+a/
         FBi/0D7fPcxGa7G8nWxY2l6iXb+881kzK8Tewfm5o0iNvw1ImEtODWTKOMhsQmVyEP4Q
         FT3muNbgjBq/dK8fkb/bH3rC9rzEUOlfx53mpffVJZTpIFa9JfGwQ64KzpHHxdZ19iy3
         h2XUSGam0JYgHVq0bhfQz32WntG11xkJeqvUUHmj3fnoXmbbJ4p3va1nRiZG5beUTtF9
         0TgNutjhXBNu4ln0CyJEFAzjaCt3xVV2KAb+8vwX756hWQTCysWm8pEwy1EGE+seFUCc
         fVZA==
X-Gm-Message-State: AOAM533vNrYqESn/WF5SGeCHNM58wbYKY8uV4ssXKinsfsQVvYET1kHz
        YHNmftEGrX53uV/Mq7AXpAgjTdW3eD+Hd4x6Ynwww6MYobc=
X-Google-Smtp-Source: ABdhPJyIxkzR9iXk2TJeJjx8INAq6lcWj/lsXhbZ8Zt37b3nerhZv8IgQDSSsVlCh446Omp4ba6Rsm5a0Rvv/Oo2vKY=
X-Received: by 2002:aca:4284:: with SMTP id p126mr4692594oia.123.1617742570570;
 Tue, 06 Apr 2021 13:56:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210318083236.43578-1-daniel@qtec.com> <MN2PR12MB37755DAAB03FC0065E98EF1183699@MN2PR12MB3775.namprd12.prod.outlook.com>
 <CADnq5_MMTBXt50sqJvYmXWn0uBALz2fNvpSrCfjSuMa99VLa=w@mail.gmail.com>
 <375f0915-83b3-c729-b95f-939d828d24d0@amd.com> <CAH1Ww+TNMpk-LYYaM=SG9XGK4wcGY3+w8rJzihUw=4EpzVV9EQ@mail.gmail.com>
 <aae87a0a-d643-8ee9-d0f8-e983f8613a88@gmail.com>
In-Reply-To: <aae87a0a-d643-8ee9-d0f8-e983f8613a88@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 6 Apr 2021 16:55:59 -0400
Message-ID: <CADnq5_NbGz3UaXeTybZBeCSUwxaV8bNxKkaVwtLoZQGSvkbYYg@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon/ttm: Fix memory leak userptr pages
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc:     Daniel Gomez <daniel@qtec.com>,
        Felix Kuehling <felix.kuehling@amd.com>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "dagmcr@gmail.com" <dagmcr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 6:34 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Hi Daniel,
>
> Am 22.03.21 um 10:38 schrieb Daniel Gomez:
> > On Fri, 19 Mar 2021 at 21:29, Felix Kuehling <felix.kuehling@amd.com> w=
rote:
> >> This caused a regression in kfdtest in a large-buffer stress test afte=
r
> >> memory allocation for user pages fails:
> > I'm sorry to hear that. BTW, I guess you meant amdgpu leak patch and
> > not this one.
> > Just some background for the mem leak patch if helps to understand this=
:
> > The leak was introduce here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D0b988ca1c7c4c73983b4ea96ef7c2af2263c87eb
> > where the bound status was introduced for all drm drivers including
> > radeon and amdgpu. So this patch just reverts the logic to the
> > original code but keeping the bound status. In my case, the binding
> > code allocates the user pages memory and returns without bounding (at
> > amdgpu_gtt_mgr_has_gart_addr). So,
> > when the unbinding happens, the memory needs to be cleared to prevent t=
he leak.
>
> Ah, now I understand what's happening here. Daniel your patch is not
> really correct.
>
> The problem is rather that we don't set the tt object to bound if it
> doesn't have a GTT address.
>
> Going to provide a patch for this.

Did this patch ever land?

Alex

>
> Regards,
> Christian.
>
> >
> >> [17359.536303] amdgpu: init_user_pages: Failed to get user pages: -16
> >> [17359.543746] BUG: kernel NULL pointer dereference, address: 00000000=
00000000
> >> [17359.551494] #PF: supervisor read access in kernel mode
> >> [17359.557375] #PF: error_code(0x0000) - not-present page
> >> [17359.563247] PGD 0 P4D 0
> >> [17359.566514] Oops: 0000 [#1] SMP PTI
> >> [17359.570728] CPU: 8 PID: 5944 Comm: kfdtest Not tainted 5.11.0-kfd-f=
kuehlin #193
> >> [17359.578760] Hardware name: ASUS All Series/X99-E WS/USB 3.1, BIOS 3=
201 06/17/2016
> >> [17359.586971] RIP: 0010:amdgpu_ttm_backend_unbind+0x52/0x110 [amdgpu]
> >> [17359.594075] Code: 48 39 c6 74 1b 8b 53 0c 48 8d bd 80 a1 ff ff e8 2=
4 62 00 00 85 c0 0f 85 ab 00 00 00 c6 43 54 00 5b 5d c3 48 8b 46 10 8b 4e 5=
0 <48> 8b 30 48 85 f6 74 ba 8b 50 0c 48 8b bf 80 a1 ff ff 83 e1 01 45
> >> [17359.614340] RSP: 0018:ffffa4764971fc98 EFLAGS: 00010206
> >> [17359.620315] RAX: 0000000000000000 RBX: ffff950e8d4edf00 RCX: 000000=
0000000000
> >> [17359.628204] RDX: 0000000000000000 RSI: ffff950e8d4edf00 RDI: ffff95=
0eadec5e80
> >> [17359.636084] RBP: ffff950eadec5e80 R08: 0000000000000000 R09: 000000=
0000000000
> >> [17359.643958] R10: 0000000000000246 R11: 0000000000000001 R12: ffff95=
0c03377800
> >> [17359.651833] R13: ffff950eadec5e80 R14: ffff950c03377858 R15: 000000=
0000000000
> >> [17359.659701] FS:  00007febb20cb740(0000) GS:ffff950ebfc00000(0000) k=
nlGS:0000000000000000
> >> [17359.668528] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> [17359.675012] CR2: 0000000000000000 CR3: 00000006d700e005 CR4: 000000=
00001706e0
> >> [17359.682883] Call Trace:
> >> [17359.686063]  amdgpu_ttm_backend_destroy+0x12/0x70 [amdgpu]
> >> [17359.692349]  ttm_bo_cleanup_memtype_use+0x37/0x60 [ttm]
> >> [17359.698307]  ttm_bo_release+0x278/0x5e0 [ttm]
> >> [17359.703385]  amdgpu_bo_unref+0x1a/0x30 [amdgpu]
> >> [17359.708701]  amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu+0x7e5/0x910 [a=
mdgpu]
> >> [17359.716307]  kfd_ioctl_alloc_memory_of_gpu+0x11a/0x220 [amdgpu]
> >> [17359.723036]  kfd_ioctl+0x223/0x400 [amdgpu]
> >> [17359.728017]  ? kfd_dev_is_large_bar+0x90/0x90 [amdgpu]
> >> [17359.734152]  __x64_sys_ioctl+0x8b/0xd0
> >> [17359.738796]  do_syscall_64+0x2d/0x40
> >> [17359.743259]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >> [17359.749205] RIP: 0033:0x7febb083b6d7
> >> [17359.753681] Code: b3 66 90 48 8b 05 b1 47 2d 00 64 c7 00 26 00 00 0=
0 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 0=
5 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 81 47 2d 00 f7 d8 64 89 01 48
> >> [17359.774340] RSP: 002b:00007ffdb5522cd8 EFLAGS: 00000202 ORIG_RAX: 0=
000000000000010
> >> [17359.782668] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f=
ebb083b6d7
> >> [17359.790566] RDX: 00007ffdb5522d60 RSI: 00000000c0284b16 RDI: 000000=
0000000003
> >> [17359.798459] RBP: 00007ffdb5522d10 R08: 00007ffdb5522dd0 R09: 000000=
00c4000004
> >> [17359.806352] R10: 0000000000000000 R11: 0000000000000202 R12: 000055=
9416e4e2aa
> >> [17359.814251] R13: 0000000000000000 R14: 0000000000000021 R15: 000000=
0000000000
> >> [17359.822140] Modules linked in: ip6table_filter ip6_tables iptable_f=
ilter amdgpu x86_pkg_temp_thermal drm_ttm_helper ttm iommu_v2 gpu_sched ip_=
tables x_tables
> >> [17359.837776] CR2: 0000000000000000
> >> [17359.841888] ---[ end trace a6f27d64475b28c8 ]---
> >> [17359.847318] RIP: 0010:amdgpu_ttm_backend_unbind+0x52/0x110 [amdgpu]
> >> [17359.854479] Code: 48 39 c6 74 1b 8b 53 0c 48 8d bd 80 a1 ff ff e8 2=
4 62 00 00 85 c0 0f 85 ab 00 00 00 c6 43 54 00 5b 5d c3 48 8b 46 10 8b 4e 5=
0 <48> 8b 30 48 85 f6 74 ba 8b 50 0c 48 8b bf 80 a1 ff ff 83 e1 01 45
> >> [17359.874929] RSP: 0018:ffffa4764971fc98 EFLAGS: 00010206
> >> [17359.881014] RAX: 0000000000000000 RBX: ffff950e8d4edf00 RCX: 000000=
0000000000
> >> [17359.889007] RDX: 0000000000000000 RSI: ffff950e8d4edf00 RDI: ffff95=
0eadec5e80
> >> [17359.897008] RBP: ffff950eadec5e80 R08: 0000000000000000 R09: 000000=
0000000000
> >> [17359.905020] R10: 0000000000000246 R11: 0000000000000001 R12: ffff95=
0c03377800
> >> [17359.913034] R13: ffff950eadec5e80 R14: ffff950c03377858 R15: 000000=
0000000000
> >> [17359.921050] FS:  00007febb20cb740(0000) GS:ffff950ebfc00000(0000) k=
nlGS:0000000000000000
> >> [17359.930047] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> [17359.936674] CR2: 0000000000000000 CR3: 00000006d700e005 CR4: 000000=
00001706e0
> >  From what I understand, the init_user_pages fails (returns EBUSY) and
> > the code goes to allocate_init_user_pages_failed where the unbind and
> > the userptr clear occurs.
> > Can we prevent this if we save the bounding status + userptr alloc? so
> > the function amdgpu_ttm_backend_unbind returns without trying to clear
> > the userptr memory?
> >
> > Something like:
> >
> > amdgpu_ttm_backend_bind:
> >      if (gtt->userptr) {
> >          r =3D amdgpu_ttm_tt_pin_userptr(bdev, ttm);
> >          if (r) ...
> >         gtt->sg_table =3D true;
> >     }
> >
> > amdgpu_ttm_backend_unbind:
> > if (gtt->sg_table) {
> >          if (gtt->user_ptr) ...
> > }
> >
> > If you agree, I'll send a v2 patch. Otherwise, maybe we could return
> > within amdgpu_ttm_tt_unpin_userptr if memory hasn't been allocated.
> >
> > Any other ideas?
> >
> > Regards,
> > Daniel
> >
> >> Reverting this patch fixes the problem for me.
> >>
> >> Regards,
> >>     Felix
> >>
> >> On 2021-03-18 10:57 p.m., Alex Deucher wrote:
> >>> Applied.  Thanks!
> >>>
> >>> Alex
> >>>
> >>> On Thu, Mar 18, 2021 at 5:00 AM Koenig, Christian
> >>> <Christian.Koenig@amd.com> wrote:
> >>>> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> >>>> ________________________________
> >>>> Von: Daniel Gomez <daniel@qtec.com>
> >>>> Gesendet: Donnerstag, 18. M=C3=A4rz 2021 09:32
> >>>> Cc: dagmcr@gmail.com <dagmcr@gmail.com>; Daniel Gomez <daniel@qtec.c=
om>; Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chr=
istian.Koenig@amd.com>; David Airlie <airlied@linux.ie>; Daniel Vetter <dan=
iel@ffwll.ch>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org=
>; dri-devel@lists.freedesktop.org <dri-devel@lists.freedesktop.org>; linux=
-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
> >>>> Betreff: [PATCH] drm/radeon/ttm: Fix memory leak userptr pages
> >>>>
> >>>> If userptr pages have been pinned but not bounded,
> >>>> they remain uncleared.
> >>>>
> >>>> Signed-off-by: Daniel Gomez <daniel@qtec.com>
> >>>> ---
> >>>>    drivers/gpu/drm/radeon/radeon_ttm.c | 5 +++--
> >>>>    1 file changed, 3 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/r=
adeon/radeon_ttm.c
> >>>> index e8c66d10478f..bbcc6264d48f 100644
> >>>> --- a/drivers/gpu/drm/radeon/radeon_ttm.c
> >>>> +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
> >>>> @@ -485,13 +485,14 @@ static void radeon_ttm_backend_unbind(struct t=
tm_bo_device *bdev, struct ttm_tt
> >>>>            struct radeon_ttm_tt *gtt =3D (void *)ttm;
> >>>>            struct radeon_device *rdev =3D radeon_get_rdev(bdev);
> >>>>
> >>>> +       if (gtt->userptr)
> >>>> +               radeon_ttm_tt_unpin_userptr(bdev, ttm);
> >>>> +
> >>>>            if (!gtt->bound)
> >>>>                    return;
> >>>>
> >>>>            radeon_gart_unbind(rdev, gtt->offset, ttm->num_pages);
> >>>>
> >>>> -       if (gtt->userptr)
> >>>> -               radeon_ttm_tt_unpin_userptr(bdev, ttm);
> >>>>            gtt->bound =3D false;
> >>>>    }
> >>>>
> >>>> --
> >>>> 2.30.2
> >>>>
> >>>> _______________________________________________
> >>>> dri-devel mailing list
> >>>> dri-devel@lists.freedesktop.org
> >>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >>> _______________________________________________
> >>> dri-devel mailing list
> >>> dri-devel@lists.freedesktop.org
> >>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
