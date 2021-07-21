Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A603D0BFB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 12:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237262AbhGUJEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 05:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238117AbhGUJAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 05:00:14 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6143C061574
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 02:40:51 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id f93-20020a9d03e60000b02904b1f1d7c5f4so1492627otf.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 02:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9jxXwVV+aN3Rmsz4UMzvrUtjRp7srjOGboK+OYH5Kdk=;
        b=LhPCk9YyyxbWlHb+cowVth1I1M2cCfTUqkyPp/DmxHuTijTiqeLfgLgB3he7N4ahyY
         SzP6z27w2Vca6UHnE0gLq2VLIbYpjKZcPIIxSXmbY3o7PuQ6vrnA8zueyvOE/PYa9xnW
         RTpOmb5mtmXZk3W7p5oIGUF9GHPij+4+2T9QQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9jxXwVV+aN3Rmsz4UMzvrUtjRp7srjOGboK+OYH5Kdk=;
        b=DmdfMQGMEFRExRcgGVwutWfPXxttl7pBpsWfN/kHKeRZCxW5ywaeuI15LBNR9/8NAx
         STRVLsONCcPZBzGaDX95+2dQD94jHDkjNMiPLbl2L1h5B7/Cf2yDk66j6cbbDma3fV7K
         Kv2tDX4f5zvB6swEXJBsevaQOyHhjavcmBKqKRsQXP69s0PlqDFVUun1MmCVKVn4RIVG
         jTs8QDyPlA4xaJBatNcYJspyhSBmHmQA0pt9WHeIadFzbk7u6Ek4AnkiitZrfFUGFj1/
         UxS8fbjFkFLhJ1jZFID43IlQabXNjMcO6CEbPDNfRxfF9krWIj2MYWxhv0Jd9AENqA5S
         XDhg==
X-Gm-Message-State: AOAM531hFhsflFCSznJOzVrIOzrZQxOgM4Z/E+GnVk4+lzpJ/odbIIQE
        hUl0UMxqo/ye4KHqx3rYht5jza12atBraWCukEKU9A==
X-Google-Smtp-Source: ABdhPJyqySVeOWrWftIeRooADmFBeof6NbpCffW0JVFgb69i4kcAx9TNZlp/PU0RIAEv3xq05jVx8xpvz+fgHjLB9VM=
X-Received: by 2002:a9d:27a4:: with SMTP id c33mr26204874otb.281.1626860451258;
 Wed, 21 Jul 2021 02:40:51 -0700 (PDT)
MIME-Version: 1.0
References: <1626432098-27626-1-git-send-email-xiyuyang19@fudan.edu.cn> <20210721020009.GG13928@zhen-hp.sh.intel.com>
In-Reply-To: <20210721020009.GG13928@zhen-hp.sh.intel.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 21 Jul 2021 11:40:40 +0200
Message-ID: <CAKMK7uHFarZMChcVNdxpP=1XKqc+WJCayELvpiAjmzO9YXk+hA@mail.gmail.com>
Subject: Re: [PATCH] drm/i915/gvt: Convert from atomic_t to refcount_t on intel_vgpu_ppgtt_spt->refcount
To:     Zhenyu Wang <zhenyuw@linux.intel.com>
Cc:     Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        intel-gvt-dev <intel-gvt-dev@lists.freedesktop.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xin Tan <tanxin.ctf@gmail.com>, yuanxzhang@fudan.edu.cn
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 4:21 AM Zhenyu Wang <zhenyuw@linux.intel.com> wrote:
> On 2021.07.16 18:41:38 +0800, Xiyu Yang wrote:
> > refcount_t type and corresponding API can protect refcounters from
> > accidental underflow and overflow and further use-after-free situations
> >
>
> Thanks for the patch. Is there any specific problem you run with current code?
> Any shadow ppgtt error?

refcount_t is just part of the kernel hardening project, and
recommeded to be used anywhere it's possible. It doesn't fix bugs
itself, but makes it impossible to exploit at least some of them and
warns in other cases, so easier to catch them if they do exist.
-Daniel

> > Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> > Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> > ---
> >  drivers/gpu/drm/i915/gvt/gtt.c | 11 ++++++-----
> >  drivers/gpu/drm/i915/gvt/gtt.h |  3 ++-
> >  2 files changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
> > index cc2c05e18206..62f3daff5a36 100644
> > --- a/drivers/gpu/drm/i915/gvt/gtt.c
> > +++ b/drivers/gpu/drm/i915/gvt/gtt.c
> > @@ -841,7 +841,7 @@ static struct intel_vgpu_ppgtt_spt *ppgtt_alloc_spt(
> >       }
> >
> >       spt->vgpu = vgpu;
> > -     atomic_set(&spt->refcount, 1);
> > +     refcount_set(&spt->refcount, 1);
> >       INIT_LIST_HEAD(&spt->post_shadow_list);
> >
> >       /*
> > @@ -927,18 +927,19 @@ static struct intel_vgpu_ppgtt_spt *ppgtt_alloc_spt_gfn(
> >
> >  static inline void ppgtt_get_spt(struct intel_vgpu_ppgtt_spt *spt)
> >  {
> > -     int v = atomic_read(&spt->refcount);
> > +     int v = refcount_read(&spt->refcount);
> >
> >       trace_spt_refcount(spt->vgpu->id, "inc", spt, v, (v + 1));
> > -     atomic_inc(&spt->refcount);
> > +     refcount_inc(&spt->refcount);
> >  }
> >
> >  static inline int ppgtt_put_spt(struct intel_vgpu_ppgtt_spt *spt)
> >  {
> > -     int v = atomic_read(&spt->refcount);
> > +     int v = refcount_read(&spt->refcount);
> >
> >       trace_spt_refcount(spt->vgpu->id, "dec", spt, v, (v - 1));
> > -     return atomic_dec_return(&spt->refcount);
> > +     refcount_dec(&spt->refcount);
> > +     return refcount_read(&spt->refcount);
> >  }
> >
> >  static int ppgtt_invalidate_spt(struct intel_vgpu_ppgtt_spt *spt);
> > diff --git a/drivers/gpu/drm/i915/gvt/gtt.h b/drivers/gpu/drm/i915/gvt/gtt.h
> > index 3bf45672ef98..944c2d0739df 100644
> > --- a/drivers/gpu/drm/i915/gvt/gtt.h
> > +++ b/drivers/gpu/drm/i915/gvt/gtt.h
> > @@ -38,6 +38,7 @@
> >  #include <linux/kref.h>
> >  #include <linux/mutex.h>
> >  #include <linux/radix-tree.h>
> > +#include <linux/refcount.h>
> >
> >  #include "gt/intel_gtt.h"
> >
> > @@ -243,7 +244,7 @@ struct intel_vgpu_oos_page {
> >
> >  /* Represent a vgpu shadow page table. */
> >  struct intel_vgpu_ppgtt_spt {
> > -     atomic_t refcount;
> > +     refcount_t refcount;
> >       struct intel_vgpu *vgpu;
> >
> >       struct {
> > --
> > 2.7.4
> >
> > _______________________________________________
> > intel-gvt-dev mailing list
> > intel-gvt-dev@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/intel-gvt-dev



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
