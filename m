Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964F73ED0CD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 11:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbhHPJFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 05:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbhHPJFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 05:05:35 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488CCC061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 02:05:04 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id e13-20020a9d63cd0000b02904fa42f9d275so20169539otl.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 02:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I0X8cjnS3exVhKOIPaaxhXaLTasft0jjNO1dDnir+M0=;
        b=WsrmEAbKR9Ea1DN08aTHGiAKPFqgbYhwc/9LS5oJ/HgSk5p3+zAIlUvaEE/ADQPgGI
         cbx68FP3RCl9hHQN2gqWFmFuSN6q5AvO1obN0fG5yDYwq1dbG2mdRJCH7IUPvuPyo4+N
         z0/O2WvILWTFfLPT83dMk2DaEY89r5CjM7/lE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I0X8cjnS3exVhKOIPaaxhXaLTasft0jjNO1dDnir+M0=;
        b=AlFZy3BoGxTfjj5IhEVOxgFb+ame+V25WIb5T8zKEnb4yD9GswCH7+HGiES9LUnncs
         L0foPtqx2P7u3NV7fegvsG6S0Mkn72u/mlN1ThmRx2kUZ/gd5kHlQ6F2cryV676nZlYL
         OalBAL7Cc8m7Tt9P1zElWLJsGKCcfzlUu8y4JYnwEql+ZaP/LTaNHRjPcyXVbO+b8fqf
         8bFYDssBycwlfWemzQY3RmCVAbGihDWt9ooywg7uCJCh4ofqEYOp9F2CbSZvncVkwyMk
         UL1NTTv3POrGzjOfbVayaqffiHJvHMmK0hcjQg+SnvKWwYPiHNicNesp5H5UMbf2bJ8d
         frkA==
X-Gm-Message-State: AOAM530YAfOeiWuZ9M00YZ97PYXTU7K+3ITvT+HKIW7EWRULzfDfDYBL
        SuwLhfoi4x6XRz2IcyLHqn6TdGUErY+CjNqp8q5VuA==
X-Google-Smtp-Source: ABdhPJwYfeYsTGTja3gdEWuUROrubaV5DSeozV6ZWk480EPEPOe0sNVBRHe913XVZngXT6YGFbGy1Z4ZGIwcRux0I0g=
X-Received: by 2002:a9d:27a4:: with SMTP id c33mr12175776otb.281.1629104703642;
 Mon, 16 Aug 2021 02:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210815153740.195330-1-desmondcheongzx@gmail.com>
 <202108160208.ONHHWxXy-lkp@intel.com> <f88fe698-b40c-b309-96c2-32b314280aad@gmail.com>
In-Reply-To: <f88fe698-b40c-b309-96c2-32b314280aad@gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Mon, 16 Aug 2021 11:04:52 +0200
Message-ID: <CAKMK7uEWMjaDEuMpc1__EwD5rpaouJ-dhahQBEQ5rsBz3VV=qg@mail.gmail.com>
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

On Mon, Aug 16, 2021 at 10:53 AM Desmond Cheong Zhi Xi
<desmondcheongzx@gmail.com> wrote:
> On 16/8/21 2:47 am, kernel test robot wrote:
> > Hi Desmond,
> >
> > Thank you for the patch! Yet something to improve:
> >
> > [auto build test ERROR on next-20210813]
> > [also build test ERROR on v5.14-rc5]
> > [cannot apply to linus/master v5.14-rc5 v5.14-rc4 v5.14-rc3]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch]
> >
> > url:    https://github.com/0day-ci/linux/commits/Desmond-Cheong-Zhi-Xi/drm-avoid-races-with-modesetting-rights/20210815-234145
> > base:    4b358aabb93a2c654cd1dcab1a25a589f6e2b153
> > config: i386-randconfig-a004-20210815 (attached as .config)
> > compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> > reproduce (this is a W=1 build):
> >          # https://github.com/0day-ci/linux/commit/cf6d8354b7d7953cd866fad004cbb189adfa074f
> >          git remote add linux-review https://github.com/0day-ci/linux
> >          git fetch --no-tags linux-review Desmond-Cheong-Zhi-Xi/drm-avoid-races-with-modesetting-rights/20210815-234145
> >          git checkout cf6d8354b7d7953cd866fad004cbb189adfa074f
> >          # save the attached .config to linux build tree
> >          make W=1 ARCH=i386
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>, old ones prefixed by <<):
> >
> >>> ERROR: modpost: "task_work_add" [drivers/gpu/drm/drm.ko] undefined!
> >
>
> I'm a bit uncertain about this. Looking into the .config used, this
> error seems to happen because task_work_add isn't an exported symbol,
> but DRM is being compiled as a loadable kernel module (CONFIG_DRM=m).
>
> One way to deal with this is to export the symbol, but there was a
> proposed patch to do this a few months back that wasn't picked up [1],
> so I'm not sure what to make of this.
>
> I'll export the symbol as part of a v3 series, and check in with the
> task-work maintainers.
>
> Link:
> https://lore.kernel.org/lkml/20210127150029.13766-3-joshi.k@samsung.com/ [1]

Yeah that sounds best. I have two more thoughts on the patch:
- drm_master_flush isn't used by any modules outside of drm.ko, so we
can unexport it and drop the kerneldoc (the comment is still good).
These kind of internal functions have their declaration in
drm-internal.h - there's already a few there from drm_auth.c

- We know have 3 locks for master state, that feels a bit like
overkill. The spinlock I think we need to keep due to lock inversions,
but the master_mutex and master_rwsem look like we should be able to
merge them? I.e. anywhere we currently grab the master_mutex we could
instead grab the rwsem in either write mode (when we change stuff) or
read mode (when we just check, like in master_internal_acquire).

Thoughts?
-Daniel

>
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> >
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
