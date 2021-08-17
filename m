Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4706B3EEEEC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238209AbhHQPHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbhHQPHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:07:20 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87AAC061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 08:06:46 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id fa24-20020a17090af0d8b0290178bfa69d97so6904713pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 08:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LpkZBa2fI/bYsQxq9sk9M9KeuouMiRNZFmA74yYIQV0=;
        b=j0i8qQ9XUBeROPzmbWZw8vWTpBvY6xEiHt0KyVbvUrEiaHyP/EQhmKs4jYwkxLLCN8
         6ODYJvPsdpazSb2gIEI1HXlm3/a/6iD5HJpBOImFOgHGhMWB+AhyGKy4M3iAs3K3PXSv
         nELNq/5EegfdGmDkooXCaV0bHgRrtXJKLTlwxBdtidFTZeTXkeLtkw16Y6Cml3A2FPVb
         LNYh2NoZu4a71V/ihGAmRqwbewO2lEa5xu+AIBH5w4N2KmzLadZcEjhWYnuxtrq8tRwP
         bmxIRLc1tUXwbt1I13k2ijZkXLlsDxm0Od2W5VrRP1rvG9czHbguhwNx0n39M+rprriW
         OY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LpkZBa2fI/bYsQxq9sk9M9KeuouMiRNZFmA74yYIQV0=;
        b=F/nAVRLb6OgvgGsgHJGPC2Tus+aH4j2jE+0oO6d1BGwiledtrqPfBLK491/X6Bx2tM
         jwcuXxSmLeL0b1XNFsVQuUONLK7UP8r7iFl/bWTx5QxjKPc4ApRBWm/fxLJop63rq0Ej
         8ebXZb9O8IjUsSx6Ga59j0Cn5/7GJ1S00r0w24cUBIGlpuev1AA5mNipXt/xT/Q1iZA8
         M9FIvgVyIthQiUMofD5HQjloPko67KXfQfgRKBk8KGVRMPoUP+x8rtw4CAq7sBl7AAB1
         bSTtxTSTtU87+Whr7Z8T1NmkM/uap/LXq0oWiV4S0FqR1yPEEXwemjPaEKKr6k5HPvpD
         G8Fw==
X-Gm-Message-State: AOAM530X69RWfKJe/9bFBDmf5qOQbFCTCfKhVax6r87jdYQAbAruJ1JI
        DvU/js2E1nH0silXqS2NWIY=
X-Google-Smtp-Source: ABdhPJzpTJOaj86+5qk5L1FiVyrjb9elmIqw7HVimJVxm3/WttTK8stT0Fip8y/bEPPMu3YfDpbSyQ==
X-Received: by 2002:a63:798f:: with SMTP id u137mr3893376pgc.321.1629212806292;
        Tue, 17 Aug 2021 08:06:46 -0700 (PDT)
Received: from [192.168.1.237] ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id f24sm2666833pjh.15.2021.08.17.08.06.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 08:06:45 -0700 (PDT)
Subject: Re: [PATCH v2] drm: avoid races with modesetting rights
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     kernel test robot <lkp@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dave Airlie <airlied@linux.ie>, kbuild-all@lists.01.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210815153740.195330-1-desmondcheongzx@gmail.com>
 <202108160208.ONHHWxXy-lkp@intel.com>
 <f88fe698-b40c-b309-96c2-32b314280aad@gmail.com>
 <CAKMK7uEWMjaDEuMpc1__EwD5rpaouJ-dhahQBEQ5rsBz3VV=qg@mail.gmail.com>
 <3a5ffd83-3d91-73dc-0cae-e822ba381b2b@gmail.com>
 <CAKMK7uFe6y5W7ZuTGV1rc8vPmpLdDd-rN4aC=1CXWjZLOAOQsQ@mail.gmail.com>
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Message-ID: <82ff2e78-7d52-8d4e-03a6-3ad52427261e@gmail.com>
Date:   Tue, 17 Aug 2021 23:06:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAKMK7uFe6y5W7ZuTGV1rc8vPmpLdDd-rN4aC=1CXWjZLOAOQsQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/8/21 9:59 pm, Daniel Vetter wrote:
> On Mon, Aug 16, 2021 at 12:31 PM Desmond Cheong Zhi Xi
> <desmondcheongzx@gmail.com> wrote:
>>
>> On 16/8/21 5:04 pm, Daniel Vetter wrote:
>>> On Mon, Aug 16, 2021 at 10:53 AM Desmond Cheong Zhi Xi
>>> <desmondcheongzx@gmail.com> wrote:
>>>> On 16/8/21 2:47 am, kernel test robot wrote:
>>>>> Hi Desmond,
>>>>>
>>>>> Thank you for the patch! Yet something to improve:
>>>>>
>>>>> [auto build test ERROR on next-20210813]
>>>>> [also build test ERROR on v5.14-rc5]
>>>>> [cannot apply to linus/master v5.14-rc5 v5.14-rc4 v5.14-rc3]
>>>>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>>>>> And when submitting patch, we suggest to use '--base' as documented in
>>>>> https://git-scm.com/docs/git-format-patch]
>>>>>
>>>>> url:    https://github.com/0day-ci/linux/commits/Desmond-Cheong-Zhi-Xi/drm-avoid-races-with-modesetting-rights/20210815-234145
>>>>> base:    4b358aabb93a2c654cd1dcab1a25a589f6e2b153
>>>>> config: i386-randconfig-a004-20210815 (attached as .config)
>>>>> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
>>>>> reproduce (this is a W=1 build):
>>>>>            # https://github.com/0day-ci/linux/commit/cf6d8354b7d7953cd866fad004cbb189adfa074f
>>>>>            git remote add linux-review https://github.com/0day-ci/linux
>>>>>            git fetch --no-tags linux-review Desmond-Cheong-Zhi-Xi/drm-avoid-races-with-modesetting-rights/20210815-234145
>>>>>            git checkout cf6d8354b7d7953cd866fad004cbb189adfa074f
>>>>>            # save the attached .config to linux build tree
>>>>>            make W=1 ARCH=i386
>>>>>
>>>>> If you fix the issue, kindly add following tag as appropriate
>>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>>
>>>>> All errors (new ones prefixed by >>, old ones prefixed by <<):
>>>>>
>>>>>>> ERROR: modpost: "task_work_add" [drivers/gpu/drm/drm.ko] undefined!
>>>>>
>>>>
>>>> I'm a bit uncertain about this. Looking into the .config used, this
>>>> error seems to happen because task_work_add isn't an exported symbol,
>>>> but DRM is being compiled as a loadable kernel module (CONFIG_DRM=m).
>>>>
>>>> One way to deal with this is to export the symbol, but there was a
>>>> proposed patch to do this a few months back that wasn't picked up [1],
>>>> so I'm not sure what to make of this.
>>>>
>>>> I'll export the symbol as part of a v3 series, and check in with the
>>>> task-work maintainers.
>>>>
>>>> Link:
>>>> https://lore.kernel.org/lkml/20210127150029.13766-3-joshi.k@samsung.com/ [1]
>>>
>>> Yeah that sounds best. I have two more thoughts on the patch:
>>> - drm_master_flush isn't used by any modules outside of drm.ko, so we
>>> can unexport it and drop the kerneldoc (the comment is still good).
>>> These kind of internal functions have their declaration in
>>> drm-internal.h - there's already a few there from drm_auth.c
>>>
>>
>> Sounds good, I'll do that and move the declaration from drm_auth.h to
>> drm_internal.h.
>>
>>> - We know have 3 locks for master state, that feels a bit like
>>> overkill. The spinlock I think we need to keep due to lock inversions,
>>> but the master_mutex and master_rwsem look like we should be able to
>>> merge them? I.e. anywhere we currently grab the master_mutex we could
>>> instead grab the rwsem in either write mode (when we change stuff) or
>>> read mode (when we just check, like in master_internal_acquire).
>>>
>>> Thoughts?
>>> -Daniel
>>>
>>
>> Using rwsem in the places where we currently hold the mutex seems pretty
>> doable.
>>
>> There are some tricky bits once we add rwsem read locks to the ioctl
>> handler. Some ioctl functions like drm_authmagic need a write lock.
> 
> Ah yes, I only looked at the dropmaster/setmaster ioctl, and those
> don't have the DRM_MASTER bit set.
> 
>> In this particular case, it might make sense to break master_mutex down
>> into finer-grained locks, since the function doesn't change master
>> permissions. It just needs to prevent concurrent writes to the
>> drm_master.magic_map idr.
> 
> Yeah for authmagic we could perhaps just reuse the spinlock to protect
> ->magic_map?
> 

Yup, I had to move the spinlock from struct drm_file to struct 
drm_device, but I think that should work.

>> For other ioctls, I'll take a closer look on a case-by-case basis.
> 
> If it's too much shuffling then I think totally fine to leave things
> as-is. Just feels a bit silly to have 3 locks, on of which is an
> rwlock itself, for this fairly small amount of state.
> -Daniel
> 

Agreed, there's a lot of overlap between the master_mutex and rwsem so 
this a good opportunity to refactor things.

I'm cleaning up a v3 series now. There's some movement, but most of it 
are fixes to potential bugs that I saw while refactoring. We can see if 
the new version is a better design.

>>
>>>>
>>>>> ---
>>>>> 0-DAY CI Kernel Test Service, Intel Corporation
>>>>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>>>>>
>>>>
>>>
>>>
>>
> 
> 

