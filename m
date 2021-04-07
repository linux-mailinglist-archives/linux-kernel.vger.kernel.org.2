Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10E83565C0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 09:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346856AbhDGHsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 03:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346805AbhDGHsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 03:48:04 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD771C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 00:47:53 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id w23so8394034edx.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 00:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qtec.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=plCjkshfPYRJPx8mJ31yMaLutaXbhwBVGKKe4dKObKg=;
        b=SBNCdqNh5r5ZKz/pliBDgu/zjGwpff6X/nMMNlQmT7otug07Z6cKL91Q8eqijlggW1
         GIU4Zkpxf9PRcK+1jKgOYrph1WS/8B9detl2G+Zy0E3x6BQs3YQcuMZ3h8Zu+Od6FyDo
         yAaSC2CsjNIh8jstnXqh4/49PkqX+G1QvY9oi+8j8zsMHlhEmLHg3hDZptpOEOq98/WM
         5zXIMnL/POlJkAKeagAFrLAo3kNPu/xPJ7Pg8qS3ntuwMV7AH+qxamiHzrENUGdzIejJ
         kg8olDBaXWedrKL+0s0GV6BP57iWHHu0x2yQbfCclpx4iRguiHa770hQ4f9rXEQSPQXl
         p9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=plCjkshfPYRJPx8mJ31yMaLutaXbhwBVGKKe4dKObKg=;
        b=GWFZHvVttTi1ihLWdYkDufJEDGg1uYxtL+vhodmPov5izN83uj6CYwgj6PjfvBqLfG
         kW4VWWsqjtm5k3S272otz/TzVb230ImyBse8vhXBJ2QA1yfqgNLwsqbrBPlIOEkoLTj6
         LzKRVVZHuj6I+FmHtoQWF13YofO99RibE4v0xyz8Wl9Kz1h3Wy0Xv/Ke8rIu2nPTvLcj
         nW2gHrGeUrM+mSyEUtWyHc+fDqWiJ6YGcV26MudCI64WdN7qEtH1BfrRqZpFAr0jpG8r
         HtKtNvjltLuv/yHSP8eqjdTytdujxOgSyiebiNVzJrnBVX34mThfAh3AEjo77zWzIaZ0
         IZSQ==
X-Gm-Message-State: AOAM532sN9YTZii0RmimpxwagPJMq80KnHQDbCNtj5OMuUvgU0KcLHga
        zVP+BBDx6F/Sud7Cfjk2SazDZfxKOUkYrq/CQAffiA==
X-Google-Smtp-Source: ABdhPJwPE23Wtf/N+0juHMu9EwRg37dtZxIPr8lfT3fxHZ1SOMgqe8rN+97/ZzNABnWC5BIc4DkwMgO9e++sDpVmvu8=
X-Received: by 2002:aa7:c5c4:: with SMTP id h4mr2669994eds.375.1617781672421;
 Wed, 07 Apr 2021 00:47:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210318083236.43578-1-daniel@qtec.com> <MN2PR12MB37755DAAB03FC0065E98EF1183699@MN2PR12MB3775.namprd12.prod.outlook.com>
 <CADnq5_MMTBXt50sqJvYmXWn0uBALz2fNvpSrCfjSuMa99VLa=w@mail.gmail.com>
 <375f0915-83b3-c729-b95f-939d828d24d0@amd.com> <CAH1Ww+TNMpk-LYYaM=SG9XGK4wcGY3+w8rJzihUw=4EpzVV9EQ@mail.gmail.com>
 <aae87a0a-d643-8ee9-d0f8-e983f8613a88@gmail.com> <CADnq5_NbGz3UaXeTybZBeCSUwxaV8bNxKkaVwtLoZQGSvkbYYg@mail.gmail.com>
In-Reply-To: <CADnq5_NbGz3UaXeTybZBeCSUwxaV8bNxKkaVwtLoZQGSvkbYYg@mail.gmail.com>
From:   Daniel Gomez <daniel@qtec.com>
Date:   Wed, 7 Apr 2021 09:47:41 +0200
Message-ID: <CAH1Ww+TSv3_LR_sf6hm_-i27=1Wb8Aay5FjOQq2Csh9jvKheCA@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon/ttm: Fix memory leak userptr pages
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
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

On Tue, 6 Apr 2021 at 22:56, Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Mon, Mar 22, 2021 at 6:34 AM Christian K=C3=B6nig
> <ckoenig.leichtzumerken@gmail.com> wrote:
> >
> > Hi Daniel,
> >
> > Am 22.03.21 um 10:38 schrieb Daniel Gomez:
> > > On Fri, 19 Mar 2021 at 21:29, Felix Kuehling <felix.kuehling@amd.com>=
 wrote:
> > >> This caused a regression in kfdtest in a large-buffer stress test af=
ter
> > >> memory allocation for user pages fails:
> > > I'm sorry to hear that. BTW, I guess you meant amdgpu leak patch and
> > > not this one.
> > > Just some background for the mem leak patch if helps to understand th=
is:
> > > The leak was introduce here:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D0b988ca1c7c4c73983b4ea96ef7c2af2263c87eb
> > > where the bound status was introduced for all drm drivers including
> > > radeon and amdgpu. So this patch just reverts the logic to the
> > > original code but keeping the bound status. In my case, the binding
> > > code allocates the user pages memory and returns without bounding (at
> > > amdgpu_gtt_mgr_has_gart_addr). So,
> > > when the unbinding happens, the memory needs to be cleared to prevent=
 the leak.
> >
> > Ah, now I understand what's happening here. Daniel your patch is not
> > really correct.
> >
> > The problem is rather that we don't set the tt object to bound if it
> > doesn't have a GTT address.
> >
> > Going to provide a patch for this.
>
> Did this patch ever land?

I don't think so but I might send a v2 following Christian's comment
if you guys agree.

Also, the patch here is for radeon but the pagefault issue reported by
Felix is affected by the amdgpu one:

radeon patch: drm/radeon/ttm: Fix memory leak userptr pages
https://patchwork.kernel.org/project/dri-devel/patch/20210318083236.43578-1=
-daniel@qtec.com/

amdgpu patch: drm/amdgpu/ttm: Fix memory leak userptr pages
https://patchwork.kernel.org/project/dri-devel/patch/20210317160840.36019-1=
-daniel@qtec.com/

I assume both need to be fixed with the same approach.

Daniel
>
> Alex
>
> >
> > Regards,
> > Christian.
> >
> > >
> > >> [17359.536303] amdgpu: init_user_pages: Failed to get user pages: -1=
6
> > >> [17359.543746] BUG: kernel NULL pointer dereference, address: 000000=
0000000000
> > >> [17359.551494] #PF: supervisor read access in kernel mode
> > >> [17359.557375] #PF: error_code(0x0000) - not-present page
> > >> [17359.563247] PGD 0 P4D 0
> > >> [17359.566514] Oops: 0000 [#1] SMP PTI
> > >> [17359.570728] CPU: 8 PID: 5944 Comm: kfdtest Not tainted 5.11.0-kfd=
-fkuehlin #193
> > >> [17359.578760] Hardware name: ASUS All Series/X99-E WS/USB 3.1, BIOS=
 3201 06/17/2016
> > >> [17359.586971] RIP: 0010:amdgpu_ttm_backend_unbind+0x52/0x110 [amdgp=
u]
> > >> [17359.594075] Code: 48 39 c6 74 1b 8b 53 0c 48 8d bd 80 a1 ff ff e8=
 24 62 00 00 85 c0 0f 85 ab 00 00 00 c6 43 54 00 5b 5d c3 48 8b 46 10 8b 4e=
 50 <48> 8b 30 48 85 f6 74 ba 8b 50 0c 48 8b bf 80 a1 ff ff 83 e1 01 45
> > >> [17359.614340] RSP: 0018:ffffa4764971fc98 EFLAGS: 00010206
> > >> [17359.620315] RAX: 0000000000000000 RBX: ffff950e8d4edf00 RCX: 0000=
000000000000
> > >> [17359.628204] RDX: 0000000000000000 RSI: ffff950e8d4edf00 RDI: ffff=
950eadec5e80
> > >> [17359.636084] RBP: ffff950eadec5e80 R08: 0000000000000000 R09: 0000=
000000000000
> > >> [17359.643958] R10: 0000000000000246 R11: 0000000000000001 R12: ffff=
950c03377800
> > >> [17359.651833] R13: ffff950eadec5e80 R14: ffff950c03377858 R15: 0000=
000000000000
> > >> [17359.659701] FS:  00007febb20cb740(0000) GS:ffff950ebfc00000(0000)=
 knlGS:0000000000000000
> > >> [17359.668528] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > >> [17359.675012] CR2: 0000000000000000 CR3: 00000006d700e005 CR4: 0000=
0000001706e0
> > >> [17359.682883] Call Trace:
> > >> [17359.686063]  amdgpu_ttm_backend_destroy+0x12/0x70 [amdgpu]
> > >> [17359.692349]  ttm_bo_cleanup_memtype_use+0x37/0x60 [ttm]
> > >> [17359.698307]  ttm_bo_release+0x278/0x5e0 [ttm]
> > >> [17359.703385]  amdgpu_bo_unref+0x1a/0x30 [amdgpu]
> > >> [17359.708701]  amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu+0x7e5/0x910 =
[amdgpu]
> > >> [17359.716307]  kfd_ioctl_alloc_memory_of_gpu+0x11a/0x220 [amdgpu]
> > >> [17359.723036]  kfd_ioctl+0x223/0x400 [amdgpu]
> > >> [17359.728017]  ? kfd_dev_is_large_bar+0x90/0x90 [amdgpu]
> > >> [17359.734152]  __x64_sys_ioctl+0x8b/0xd0
> > >> [17359.738796]  do_syscall_64+0x2d/0x40
> > >> [17359.743259]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > >> [17359.749205] RIP: 0033:0x7febb083b6d7
> > >> [17359.753681] Code: b3 66 90 48 8b 05 b1 47 2d 00 64 c7 00 26 00 00=
 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f=
 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 81 47 2d 00 f7 d8 64 89 01 48
> > >> [17359.774340] RSP: 002b:00007ffdb5522cd8 EFLAGS: 00000202 ORIG_RAX:=
 0000000000000010
> > >> [17359.782668] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 0000=
7febb083b6d7
> > >> [17359.790566] RDX: 00007ffdb5522d60 RSI: 00000000c0284b16 RDI: 0000=
000000000003
> > >> [17359.798459] RBP: 00007ffdb5522d10 R08: 00007ffdb5522dd0 R09: 0000=
0000c4000004
> > >> [17359.806352] R10: 0000000000000000 R11: 0000000000000202 R12: 0000=
559416e4e2aa
> > >> [17359.814251] R13: 0000000000000000 R14: 0000000000000021 R15: 0000=
000000000000
> > >> [17359.822140] Modules linked in: ip6table_filter ip6_tables iptable=
_filter amdgpu x86_pkg_temp_thermal drm_ttm_helper ttm iommu_v2 gpu_sched i=
p_tables x_tables
> > >> [17359.837776] CR2: 0000000000000000
> > >> [17359.841888] ---[ end trace a6f27d64475b28c8 ]---
> > >> [17359.847318] RIP: 0010:amdgpu_ttm_backend_unbind+0x52/0x110 [amdgp=
u]
> > >> [17359.854479] Code: 48 39 c6 74 1b 8b 53 0c 48 8d bd 80 a1 ff ff e8=
 24 62 00 00 85 c0 0f 85 ab 00 00 00 c6 43 54 00 5b 5d c3 48 8b 46 10 8b 4e=
 50 <48> 8b 30 48 85 f6 74 ba 8b 50 0c 48 8b bf 80 a1 ff ff 83 e1 01 45
> > >> [17359.874929] RSP: 0018:ffffa4764971fc98 EFLAGS: 00010206
> > >> [17359.881014] RAX: 0000000000000000 RBX: ffff950e8d4edf00 RCX: 0000=
000000000000
> > >> [17359.889007] RDX: 0000000000000000 RSI: ffff950e8d4edf00 RDI: ffff=
950eadec5e80
> > >> [17359.897008] RBP: ffff950eadec5e80 R08: 0000000000000000 R09: 0000=
000000000000
> > >> [17359.905020] R10: 0000000000000246 R11: 0000000000000001 R12: ffff=
950c03377800
> > >> [17359.913034] R13: ffff950eadec5e80 R14: ffff950c03377858 R15: 0000=
000000000000
> > >> [17359.921050] FS:  00007febb20cb740(0000) GS:ffff950ebfc00000(0000)=
 knlGS:0000000000000000
> > >> [17359.930047] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > >> [17359.936674] CR2: 0000000000000000 CR3: 00000006d700e005 CR4: 0000=
0000001706e0
> > >  From what I understand, the init_user_pages fails (returns EBUSY) an=
d
> > > the code goes to allocate_init_user_pages_failed where the unbind and
> > > the userptr clear occurs.
> > > Can we prevent this if we save the bounding status + userptr alloc? s=
o
> > > the function amdgpu_ttm_backend_unbind returns without trying to clea=
r
> > > the userptr memory?
> > >
> > > Something like:
> > >
> > > amdgpu_ttm_backend_bind:
> > >      if (gtt->userptr) {
> > >          r =3D amdgpu_ttm_tt_pin_userptr(bdev, ttm);
> > >          if (r) ...
> > >         gtt->sg_table =3D true;
> > >     }
> > >
> > > amdgpu_ttm_backend_unbind:
> > > if (gtt->sg_table) {
> > >          if (gtt->user_ptr) ...
> > > }
> > >
> > > If you agree, I'll send a v2 patch. Otherwise, maybe we could return
> > > within amdgpu_ttm_tt_unpin_userptr if memory hasn't been allocated.
> > >
> > > Any other ideas?
> > >
> > > Regards,
> > > Daniel
> > >
> > >> Reverting this patch fixes the problem for me.
> > >>
> > >> Regards,
> > >>     Felix
> > >>
> > >> On 2021-03-18 10:57 p.m., Alex Deucher wrote:
> > >>> Applied.  Thanks!
> > >>>
> > >>> Alex
> > >>>
> > >>> On Thu, Mar 18, 2021 at 5:00 AM Koenig, Christian
> > >>> <Christian.Koenig@amd.com> wrote:
> > >>>> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > >>>> ________________________________
> > >>>> Von: Daniel Gomez <daniel@qtec.com>
> > >>>> Gesendet: Donnerstag, 18. M=C3=A4rz 2021 09:32
> > >>>> Cc: dagmcr@gmail.com <dagmcr@gmail.com>; Daniel Gomez <daniel@qtec=
.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <C=
hristian.Koenig@amd.com>; David Airlie <airlied@linux.ie>; Daniel Vetter <d=
aniel@ffwll.ch>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.o=
rg>; dri-devel@lists.freedesktop.org <dri-devel@lists.freedesktop.org>; lin=
ux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
> > >>>> Betreff: [PATCH] drm/radeon/ttm: Fix memory leak userptr pages
> > >>>>
> > >>>> If userptr pages have been pinned but not bounded,
> > >>>> they remain uncleared.
> > >>>>
> > >>>> Signed-off-by: Daniel Gomez <daniel@qtec.com>
> > >>>> ---
> > >>>>    drivers/gpu/drm/radeon/radeon_ttm.c | 5 +++--
> > >>>>    1 file changed, 3 insertions(+), 2 deletions(-)
> > >>>>
> > >>>> diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm=
/radeon/radeon_ttm.c
> > >>>> index e8c66d10478f..bbcc6264d48f 100644
> > >>>> --- a/drivers/gpu/drm/radeon/radeon_ttm.c
> > >>>> +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
> > >>>> @@ -485,13 +485,14 @@ static void radeon_ttm_backend_unbind(struct=
 ttm_bo_device *bdev, struct ttm_tt
> > >>>>            struct radeon_ttm_tt *gtt =3D (void *)ttm;
> > >>>>            struct radeon_device *rdev =3D radeon_get_rdev(bdev);
> > >>>>
> > >>>> +       if (gtt->userptr)
> > >>>> +               radeon_ttm_tt_unpin_userptr(bdev, ttm);
> > >>>> +
> > >>>>            if (!gtt->bound)
> > >>>>                    return;
> > >>>>
> > >>>>            radeon_gart_unbind(rdev, gtt->offset, ttm->num_pages);
> > >>>>
> > >>>> -       if (gtt->userptr)
> > >>>> -               radeon_ttm_tt_unpin_userptr(bdev, ttm);
> > >>>>            gtt->bound =3D false;
> > >>>>    }
> > >>>>
> > >>>> --
> > >>>> 2.30.2
> > >>>>
> > >>>> _______________________________________________
> > >>>> dri-devel mailing list
> > >>>> dri-devel@lists.freedesktop.org
> > >>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > >>> _______________________________________________
> > >>> dri-devel mailing list
> > >>> dri-devel@lists.freedesktop.org
> > >>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > > _______________________________________________
> > > amd-gfx mailing list
> > > amd-gfx@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> >
