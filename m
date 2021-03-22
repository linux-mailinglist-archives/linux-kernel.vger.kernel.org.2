Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB2B343E09
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 11:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhCVKfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 06:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbhCVKe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 06:34:58 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFB9C061756
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 03:34:57 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id y1so20332392ljm.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 03:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=3iZ83wrJcOhLq+9AEEqHtbfmd5vKDvwy7fZ8JGK0D6o=;
        b=K2ynuvxw9K0nNL6zMVIZvBTqkaK7wpyXGF8NSNNscoyTzZ3lKfAxKob0F/wRufqzi3
         Q+1oa2pjiv8UXW0UQq0MQbZK958T7XtSO5wUJyI43US2+X6l7eRaOeY5T8vOtTqkc6zH
         +WKDZwQ3IrtUpXVDeVPul2r06bitKCobM5vzVDuFr9jJwPOsS1pm8Lbs1lGIUHR+0igS
         yWCLThIQYmyUGZrc9GhLAR01KI6a3wsmX33qO3QtPWY1u0y0SIUXx0by68Y0E495QRFr
         qFY73w7knCirqhfuNrL9fpvWyD/GGkhmBG5iPuqBvWECIK1uGFpL0PUS35DpEYrvKCnu
         IF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3iZ83wrJcOhLq+9AEEqHtbfmd5vKDvwy7fZ8JGK0D6o=;
        b=DV4hwb79fvJUHoWDYv59vmh6QgknR7wZZ8y2z16NNcqicgAbjb8iRv6hzi3dT4LFU9
         Sn7y5kXf/+s0sygqSmoHMCp758csX49Uim4aJfGw4gBs3gbIr6Dckmn6fqO6xu2Y/lXb
         9kssoia4u6wM9dx3a0H2KrH5uYz83I6JNE+NnX+auMT/cdeADnOYaQ9ERlHUKBe0BznW
         A9g1//bXuhqxlvVYvDhhn1iDV0JJRU4w9vQWBpDBbVnPb4j8VzQdGgbEntjagBsR9WqZ
         TN8CPzd9dXDLeqnPAGKh4puPXOQgQZhRk8bfhbiejEYE/NR7YMzT1Mn5HneK+JkrVx2A
         9xQw==
X-Gm-Message-State: AOAM533avd7ykpQJ4FewhOwpOz+AFvW1TQff7cSMtF5ebmGHU+sYvS+2
        APjRCikwh05G7WwJ+fqjZq8=
X-Google-Smtp-Source: ABdhPJzSq5d29KhjKKXJpjuImReKF0MWJl2GyHgCR6Ec1hYGyfS96gj1XCL4J+LO88Zc1ifuZl3RQw==
X-Received: by 2002:a2e:9b4a:: with SMTP id o10mr9322436ljj.485.1616409296394;
        Mon, 22 Mar 2021 03:34:56 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:e345:6f8e:fa4b:2c52? ([2a02:908:1252:fb60:e345:6f8e:fa4b:2c52])
        by smtp.gmail.com with ESMTPSA id 188sm1570869lfo.0.2021.03.22.03.34.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 03:34:55 -0700 (PDT)
Subject: Re: [PATCH] drm/radeon/ttm: Fix memory leak userptr pages
To:     Daniel Gomez <daniel@qtec.com>,
        Felix Kuehling <felix.kuehling@amd.com>
Cc:     David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexdeucher@gmail.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "dagmcr@gmail.com" <dagmcr@gmail.com>
References: <20210318083236.43578-1-daniel@qtec.com>
 <MN2PR12MB37755DAAB03FC0065E98EF1183699@MN2PR12MB3775.namprd12.prod.outlook.com>
 <CADnq5_MMTBXt50sqJvYmXWn0uBALz2fNvpSrCfjSuMa99VLa=w@mail.gmail.com>
 <375f0915-83b3-c729-b95f-939d828d24d0@amd.com>
 <CAH1Ww+TNMpk-LYYaM=SG9XGK4wcGY3+w8rJzihUw=4EpzVV9EQ@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <aae87a0a-d643-8ee9-d0f8-e983f8613a88@gmail.com>
Date:   Mon, 22 Mar 2021 11:34:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAH1Ww+TNMpk-LYYaM=SG9XGK4wcGY3+w8rJzihUw=4EpzVV9EQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Am 22.03.21 um 10:38 schrieb Daniel Gomez:
> On Fri, 19 Mar 2021 at 21:29, Felix Kuehling <felix.kuehling@amd.com> wrote:
>> This caused a regression in kfdtest in a large-buffer stress test after
>> memory allocation for user pages fails:
> I'm sorry to hear that. BTW, I guess you meant amdgpu leak patch and
> not this one.
> Just some background for the mem leak patch if helps to understand this:
> The leak was introduce here:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0b988ca1c7c4c73983b4ea96ef7c2af2263c87eb
> where the bound status was introduced for all drm drivers including
> radeon and amdgpu. So this patch just reverts the logic to the
> original code but keeping the bound status. In my case, the binding
> code allocates the user pages memory and returns without bounding (at
> amdgpu_gtt_mgr_has_gart_addr). So,
> when the unbinding happens, the memory needs to be cleared to prevent the leak.

Ah, now I understand what's happening here. Daniel your patch is not 
really correct.

The problem is rather that we don't set the tt object to bound if it 
doesn't have a GTT address.

Going to provide a patch for this.

Regards,
Christian.

>
>> [17359.536303] amdgpu: init_user_pages: Failed to get user pages: -16
>> [17359.543746] BUG: kernel NULL pointer dereference, address: 0000000000000000
>> [17359.551494] #PF: supervisor read access in kernel mode
>> [17359.557375] #PF: error_code(0x0000) - not-present page
>> [17359.563247] PGD 0 P4D 0
>> [17359.566514] Oops: 0000 [#1] SMP PTI
>> [17359.570728] CPU: 8 PID: 5944 Comm: kfdtest Not tainted 5.11.0-kfd-fkuehlin #193
>> [17359.578760] Hardware name: ASUS All Series/X99-E WS/USB 3.1, BIOS 3201 06/17/2016
>> [17359.586971] RIP: 0010:amdgpu_ttm_backend_unbind+0x52/0x110 [amdgpu]
>> [17359.594075] Code: 48 39 c6 74 1b 8b 53 0c 48 8d bd 80 a1 ff ff e8 24 62 00 00 85 c0 0f 85 ab 00 00 00 c6 43 54 00 5b 5d c3 48 8b 46 10 8b 4e 50 <48> 8b 30 48 85 f6 74 ba 8b 50 0c 48 8b bf 80 a1 ff ff 83 e1 01 45
>> [17359.614340] RSP: 0018:ffffa4764971fc98 EFLAGS: 00010206
>> [17359.620315] RAX: 0000000000000000 RBX: ffff950e8d4edf00 RCX: 0000000000000000
>> [17359.628204] RDX: 0000000000000000 RSI: ffff950e8d4edf00 RDI: ffff950eadec5e80
>> [17359.636084] RBP: ffff950eadec5e80 R08: 0000000000000000 R09: 0000000000000000
>> [17359.643958] R10: 0000000000000246 R11: 0000000000000001 R12: ffff950c03377800
>> [17359.651833] R13: ffff950eadec5e80 R14: ffff950c03377858 R15: 0000000000000000
>> [17359.659701] FS:  00007febb20cb740(0000) GS:ffff950ebfc00000(0000) knlGS:0000000000000000
>> [17359.668528] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [17359.675012] CR2: 0000000000000000 CR3: 00000006d700e005 CR4: 00000000001706e0
>> [17359.682883] Call Trace:
>> [17359.686063]  amdgpu_ttm_backend_destroy+0x12/0x70 [amdgpu]
>> [17359.692349]  ttm_bo_cleanup_memtype_use+0x37/0x60 [ttm]
>> [17359.698307]  ttm_bo_release+0x278/0x5e0 [ttm]
>> [17359.703385]  amdgpu_bo_unref+0x1a/0x30 [amdgpu]
>> [17359.708701]  amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu+0x7e5/0x910 [amdgpu]
>> [17359.716307]  kfd_ioctl_alloc_memory_of_gpu+0x11a/0x220 [amdgpu]
>> [17359.723036]  kfd_ioctl+0x223/0x400 [amdgpu]
>> [17359.728017]  ? kfd_dev_is_large_bar+0x90/0x90 [amdgpu]
>> [17359.734152]  __x64_sys_ioctl+0x8b/0xd0
>> [17359.738796]  do_syscall_64+0x2d/0x40
>> [17359.743259]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> [17359.749205] RIP: 0033:0x7febb083b6d7
>> [17359.753681] Code: b3 66 90 48 8b 05 b1 47 2d 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 81 47 2d 00 f7 d8 64 89 01 48
>> [17359.774340] RSP: 002b:00007ffdb5522cd8 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
>> [17359.782668] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007febb083b6d7
>> [17359.790566] RDX: 00007ffdb5522d60 RSI: 00000000c0284b16 RDI: 0000000000000003
>> [17359.798459] RBP: 00007ffdb5522d10 R08: 00007ffdb5522dd0 R09: 00000000c4000004
>> [17359.806352] R10: 0000000000000000 R11: 0000000000000202 R12: 0000559416e4e2aa
>> [17359.814251] R13: 0000000000000000 R14: 0000000000000021 R15: 0000000000000000
>> [17359.822140] Modules linked in: ip6table_filter ip6_tables iptable_filter amdgpu x86_pkg_temp_thermal drm_ttm_helper ttm iommu_v2 gpu_sched ip_tables x_tables
>> [17359.837776] CR2: 0000000000000000
>> [17359.841888] ---[ end trace a6f27d64475b28c8 ]---
>> [17359.847318] RIP: 0010:amdgpu_ttm_backend_unbind+0x52/0x110 [amdgpu]
>> [17359.854479] Code: 48 39 c6 74 1b 8b 53 0c 48 8d bd 80 a1 ff ff e8 24 62 00 00 85 c0 0f 85 ab 00 00 00 c6 43 54 00 5b 5d c3 48 8b 46 10 8b 4e 50 <48> 8b 30 48 85 f6 74 ba 8b 50 0c 48 8b bf 80 a1 ff ff 83 e1 01 45
>> [17359.874929] RSP: 0018:ffffa4764971fc98 EFLAGS: 00010206
>> [17359.881014] RAX: 0000000000000000 RBX: ffff950e8d4edf00 RCX: 0000000000000000
>> [17359.889007] RDX: 0000000000000000 RSI: ffff950e8d4edf00 RDI: ffff950eadec5e80
>> [17359.897008] RBP: ffff950eadec5e80 R08: 0000000000000000 R09: 0000000000000000
>> [17359.905020] R10: 0000000000000246 R11: 0000000000000001 R12: ffff950c03377800
>> [17359.913034] R13: ffff950eadec5e80 R14: ffff950c03377858 R15: 0000000000000000
>> [17359.921050] FS:  00007febb20cb740(0000) GS:ffff950ebfc00000(0000) knlGS:0000000000000000
>> [17359.930047] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [17359.936674] CR2: 0000000000000000 CR3: 00000006d700e005 CR4: 00000000001706e0
>  From what I understand, the init_user_pages fails (returns EBUSY) and
> the code goes to allocate_init_user_pages_failed where the unbind and
> the userptr clear occurs.
> Can we prevent this if we save the bounding status + userptr alloc? so
> the function amdgpu_ttm_backend_unbind returns without trying to clear
> the userptr memory?
>
> Something like:
>
> amdgpu_ttm_backend_bind:
>      if (gtt->userptr) {
>          r = amdgpu_ttm_tt_pin_userptr(bdev, ttm);
>          if (r) ...
>         gtt->sg_table = true;
>     }
>
> amdgpu_ttm_backend_unbind:
> if (gtt->sg_table) {
>          if (gtt->user_ptr) ...
> }
>
> If you agree, I'll send a v2 patch. Otherwise, maybe we could return
> within amdgpu_ttm_tt_unpin_userptr if memory hasn't been allocated.
>
> Any other ideas?
>
> Regards,
> Daniel
>
>> Reverting this patch fixes the problem for me.
>>
>> Regards,
>>     Felix
>>
>> On 2021-03-18 10:57 p.m., Alex Deucher wrote:
>>> Applied.  Thanks!
>>>
>>> Alex
>>>
>>> On Thu, Mar 18, 2021 at 5:00 AM Koenig, Christian
>>> <Christian.Koenig@amd.com> wrote:
>>>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>>> ________________________________
>>>> Von: Daniel Gomez <daniel@qtec.com>
>>>> Gesendet: Donnerstag, 18. März 2021 09:32
>>>> Cc: dagmcr@gmail.com <dagmcr@gmail.com>; Daniel Gomez <daniel@qtec.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; David Airlie <airlied@linux.ie>; Daniel Vetter <daniel@ffwll.ch>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; dri-devel@lists.freedesktop.org <dri-devel@lists.freedesktop.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
>>>> Betreff: [PATCH] drm/radeon/ttm: Fix memory leak userptr pages
>>>>
>>>> If userptr pages have been pinned but not bounded,
>>>> they remain uncleared.
>>>>
>>>> Signed-off-by: Daniel Gomez <daniel@qtec.com>
>>>> ---
>>>>    drivers/gpu/drm/radeon/radeon_ttm.c | 5 +++--
>>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
>>>> index e8c66d10478f..bbcc6264d48f 100644
>>>> --- a/drivers/gpu/drm/radeon/radeon_ttm.c
>>>> +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
>>>> @@ -485,13 +485,14 @@ static void radeon_ttm_backend_unbind(struct ttm_bo_device *bdev, struct ttm_tt
>>>>            struct radeon_ttm_tt *gtt = (void *)ttm;
>>>>            struct radeon_device *rdev = radeon_get_rdev(bdev);
>>>>
>>>> +       if (gtt->userptr)
>>>> +               radeon_ttm_tt_unpin_userptr(bdev, ttm);
>>>> +
>>>>            if (!gtt->bound)
>>>>                    return;
>>>>
>>>>            radeon_gart_unbind(rdev, gtt->offset, ttm->num_pages);
>>>>
>>>> -       if (gtt->userptr)
>>>> -               radeon_ttm_tt_unpin_userptr(bdev, ttm);
>>>>            gtt->bound = false;
>>>>    }
>>>>
>>>> --
>>>> 2.30.2
>>>>
>>>> _______________________________________________
>>>> dri-devel mailing list
>>>> dri-devel@lists.freedesktop.org
>>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>> _______________________________________________
>>> dri-devel mailing list
>>> dri-devel@lists.freedesktop.org
>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

