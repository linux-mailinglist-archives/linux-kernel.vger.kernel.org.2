Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75EF3ED864
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 16:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236927AbhHPOBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 10:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbhHPOA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 10:00:28 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200DEC0612AB
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 06:59:38 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id u13-20020a9d4d8d0000b02905177c9e0a4aso10455163otk.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 06:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dbwBktY0sbcO1rcZRUJvSkw7JUJsCG0GF14rbQ+hXDY=;
        b=ZDBQvtC4gcpDSJ/zjRP7Qim0rPL3y+QlzC/UbTk+TiHF5bVNsrzXOcQMm7mTJ8hcOl
         RiwV5HJ+yVwopsPBOv87EaBlaIwnOB+bgqRuaeOr4tZ/1zLputbWdMag2TPmEapX1N1r
         vJ3jgsAgD2OGjDSk3vO7uX35BCtIq1TaMmDCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dbwBktY0sbcO1rcZRUJvSkw7JUJsCG0GF14rbQ+hXDY=;
        b=GGFo7Xs6iuc+pRocsyS63huU5CmWHKxZOf7Wtud2pZQaClStkTb68YjWIuhm0hBu7W
         ZEqdYP0flWwfd6Ki37WNE1jw0kBKqS4KklWgnqm6tdZCZnJ3jPec0NREhIKA3aQZGhUO
         Bkupqz+TYzLSRJRIMgWvhjd3edYFAiw6TwygQF93EyOOWOV536oVaxwYgAKoVCQoYwv+
         m4PPQOmzILERFhipeX7hX393Gb7UyA7SkLBdC6c2H6oy+v/74o15mPcCcmOgDdNWjmED
         Q6XvgixjWrU6u7zIutiYYdFN6WFM8asC0ZiX5UgCBvH3NDLbsPXBSyw3hBnAU0WpAm0U
         NJgg==
X-Gm-Message-State: AOAM5317WZEwxnNw6ii3FXKVRT1tv6a2khU1rI2/L1aC6ftgFHvsbf4U
        HuV771b3M4CMQB6s3yXJ2cW65cmrGi5qex+fwzW9VQ==
X-Google-Smtp-Source: ABdhPJxDpzI+0G3YC8pCkjgnpnIssqICkJMk5x03/FLDb/HE6D6TFRnOthRxJsGmzo1z5uiPr9EMZMGWAFiVdkWWSBI=
X-Received: by 2002:a9d:27a4:: with SMTP id c33mr13164173otb.281.1629122377396;
 Mon, 16 Aug 2021 06:59:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210815153740.195330-1-desmondcheongzx@gmail.com>
 <202108160208.ONHHWxXy-lkp@intel.com> <f88fe698-b40c-b309-96c2-32b314280aad@gmail.com>
 <CAKMK7uEWMjaDEuMpc1__EwD5rpaouJ-dhahQBEQ5rsBz3VV=qg@mail.gmail.com> <3a5ffd83-3d91-73dc-0cae-e822ba381b2b@gmail.com>
In-Reply-To: <3a5ffd83-3d91-73dc-0cae-e822ba381b2b@gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Mon, 16 Aug 2021 15:59:26 +0200
Message-ID: <CAKMK7uFe6y5W7ZuTGV1rc8vPmpLdDd-rN4aC=1CXWjZLOAOQsQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm: avoid races with modesetting rights
To:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Cc:     kernel test robot <lkp@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dave Airlie <airlied@linux.ie>, kbuild-all@lists.01.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 12:31 PM Desmond Cheong Zhi Xi
<desmondcheongzx@gmail.com> wrote:
>
> On 16/8/21 5:04 pm, Daniel Vetter wrote:
> > On Mon, Aug 16, 2021 at 10:53 AM Desmond Cheong Zhi Xi
> > <desmondcheongzx@gmail.com> wrote:
> >> On 16/8/21 2:47 am, kernel test robot wrote:
> >>> Hi Desmond,
> >>>
> >>> Thank you for the patch! Yet something to improve:
> >>>
> >>> [auto build test ERROR on next-20210813]
> >>> [also build test ERROR on v5.14-rc5]
> >>> [cannot apply to linus/master v5.14-rc5 v5.14-rc4 v5.14-rc3]
> >>> [If your patch is applied to the wrong git tree, kindly drop us a note.
> >>> And when submitting patch, we suggest to use '--base' as documented in
> >>> https://git-scm.com/docs/git-format-patch]
> >>>
> >>> url:    https://github.com/0day-ci/linux/commits/Desmond-Cheong-Zhi-Xi/drm-avoid-races-with-modesetting-rights/20210815-234145
> >>> base:    4b358aabb93a2c654cd1dcab1a25a589f6e2b153
> >>> config: i386-randconfig-a004-20210815 (attached as .config)
> >>> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> >>> reproduce (this is a W=1 build):
> >>>           # https://github.com/0day-ci/linux/commit/cf6d8354b7d7953cd866fad004cbb189adfa074f
> >>>           git remote add linux-review https://github.com/0day-ci/linux
> >>>           git fetch --no-tags linux-review Desmond-Cheong-Zhi-Xi/drm-avoid-races-with-modesetting-rights/20210815-234145
> >>>           git checkout cf6d8354b7d7953cd866fad004cbb189adfa074f
> >>>           # save the attached .config to linux build tree
> >>>           make W=1 ARCH=i386
> >>>
> >>> If you fix the issue, kindly add following tag as appropriate
> >>> Reported-by: kernel test robot <lkp@intel.com>
> >>>
> >>> All errors (new ones prefixed by >>, old ones prefixed by <<):
> >>>
> >>>>> ERROR: modpost: "task_work_add" [drivers/gpu/drm/drm.ko] undefined!
> >>>
> >>
> >> I'm a bit uncertain about this. Looking into the .config used, this
> >> error seems to happen because task_work_add isn't an exported symbol,
> >> but DRM is being compiled as a loadable kernel module (CONFIG_DRM=m).
> >>
> >> One way to deal with this is to export the symbol, but there was a
> >> proposed patch to do this a few months back that wasn't picked up [1],
> >> so I'm not sure what to make of this.
> >>
> >> I'll export the symbol as part of a v3 series, and check in with the
> >> task-work maintainers.
> >>
> >> Link:
> >> https://lore.kernel.org/lkml/20210127150029.13766-3-joshi.k@samsung.com/ [1]
> >
> > Yeah that sounds best. I have two more thoughts on the patch:
> > - drm_master_flush isn't used by any modules outside of drm.ko, so we
> > can unexport it and drop the kerneldoc (the comment is still good).
> > These kind of internal functions have their declaration in
> > drm-internal.h - there's already a few there from drm_auth.c
> >
>
> Sounds good, I'll do that and move the declaration from drm_auth.h to
> drm_internal.h.
>
> > - We know have 3 locks for master state, that feels a bit like
> > overkill. The spinlock I think we need to keep due to lock inversions,
> > but the master_mutex and master_rwsem look like we should be able to
> > merge them? I.e. anywhere we currently grab the master_mutex we could
> > instead grab the rwsem in either write mode (when we change stuff) or
> > read mode (when we just check, like in master_internal_acquire).
> >
> > Thoughts?
> > -Daniel
> >
>
> Using rwsem in the places where we currently hold the mutex seems pretty
> doable.
>
> There are some tricky bits once we add rwsem read locks to the ioctl
> handler. Some ioctl functions like drm_authmagic need a write lock.

Ah yes, I only looked at the dropmaster/setmaster ioctl, and those
don't have the DRM_MASTER bit set.

> In this particular case, it might make sense to break master_mutex down
> into finer-grained locks, since the function doesn't change master
> permissions. It just needs to prevent concurrent writes to the
> drm_master.magic_map idr.

Yeah for authmagic we could perhaps just reuse the spinlock to protect
->magic_map?

> For other ioctls, I'll take a closer look on a case-by-case basis.

If it's too much shuffling then I think totally fine to leave things
as-is. Just feels a bit silly to have 3 locks, on of which is an
rwlock itself, for this fairly small amount of state.
-Daniel

>
> >>
> >>> ---
> >>> 0-DAY CI Kernel Test Service, Intel Corporation
> >>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> >>>
> >>
> >
> >
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
