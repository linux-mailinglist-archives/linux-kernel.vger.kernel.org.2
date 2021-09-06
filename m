Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E7C401704
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 09:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240162AbhIFHfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 03:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239960AbhIFHfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 03:35:37 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E88C061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 00:34:33 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id q11-20020a9d4b0b000000b0051acbdb2869so7794280otf.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 00:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KLDv73P0F0QVUgxl+s78WI8WF2RJUO8K40NpRb3AqHQ=;
        b=AySEBLAeHsj5uVKS43yZ6s3q3C829S5+QMS0aYfinQTmdXtS7JbvxxOJcj6be0Ta0E
         ZqB32nk4+F7M0IwkVWOBwR7Tta9/EP/i9LsctRGtbHGfLF90/LyUlyOIzM5jSr0gTsyL
         ETmg1qXQwAEiNDF8NRPmhEXuM/iQRbQbOR00U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KLDv73P0F0QVUgxl+s78WI8WF2RJUO8K40NpRb3AqHQ=;
        b=D07O8znVllDBxh8Ka+a3rJlfT8vQK6N5nGHZTgu559Y1a0xoellnD1QsAAdYGrnyAY
         5NVsL06Okko4esUJEujWruHyTUf2w66OLHsAWUOs2aWRuRASlHYIDzATBoQpyJN6P/hu
         1PFhwQQbY5cYn/yNgwH++dvnF0v0W1gWLXMskpanDu6sk5TMvm+nHP3iXu0YXu89ANdC
         i21QOsTQk9VRnhDR+7EG1BD3uoDrvLBid/geDghxLFA5CbVTGpcQV4Ct4HGt/mB64Lty
         XlYrRUq6E+5mQWDHwkG4s1wt2wyi+gY/RStWqO/jvf2bJirClZ7/i1euJMkZcUf2nwsf
         7ZYQ==
X-Gm-Message-State: AOAM530uGrKMHmQejiKKfuv2+MoGFYgfbqsu7HWbmNNNdutbLvprjchv
        YM9Pl0T/E8nXNN5712WtdPARTC++ck4AOPqwr77HgA==
X-Google-Smtp-Source: ABdhPJx1IPLOWvU3juMO7W0BfSfAXxm8nc0F1B4hcn35OkdkhajuYdWFrNbDFUxrBcyUq7wkCAIMwhj7M36O42pmDvY=
X-Received: by 2002:a05:6830:156:: with SMTP id j22mr9487069otp.75.1630913673121;
 Mon, 06 Sep 2021 00:34:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210820123348.6535a87e@canb.auug.org.au> <CAK7LNASv-F1Y7kpaDF+_=TW0Jzvpo1uuNL1B5jUmCCRqv-45bA@mail.gmail.com>
 <20210902075038.7461d3c8@canb.auug.org.au> <20210906084947.4f65761d@canb.auug.org.au>
In-Reply-To: <20210906084947.4f65761d@canb.auug.org.au>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Mon, 6 Sep 2021 09:34:21 +0200
Message-ID: <CAKMK7uF6K+gdWVT09wL0sPBQs8RRixggk01e291veE0VecD=TQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the drm tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Nikula, Jani" <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>,
        John Harrison <John.C.Harrison@intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 6, 2021 at 12:49 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> On Thu, 2 Sep 2021 07:50:38 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > On Fri, 20 Aug 2021 15:23:34 +0900 Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >
> > > On Fri, Aug 20, 2021 at 11:33 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > >
>  > > After merging the drm tree, today's linux-next build (x86_64 allmodconfig)
> > > > failed like this:
> > > >
> > > > In file included from drivers/gpu/drm/i915/i915_debugfs.c:39:
> > > > drivers/gpu/drm/i915/gt/intel_gt_requests.h:9:10: fatal error: stddef.h: No such file or directory
> > > >     9 | #include <stddef.h>
> > > >       |          ^~~~~~~~~~
> > > >
> > > > Caused by commit
> > > >
> > > >   564f963eabd1 ("isystem: delete global -isystem compile option")
> > > >
> > > > from the kbuild tree interacting with commit
> > > >
> > > >   b97060a99b01 ("drm/i915/guc: Update intel_gt_wait_for_idle to work with GuC")
> > > >
> > > > I have applied the following patch for today.
> > >
> > >
> > > Thanks.
> > >
> > > This fix-up does not depend on my kbuild tree in any way.
> > >
> > > So, the drm maintainer can apply it to his tree.
> > >
> > > Perhaps with
> > >
> > > Fixes: b97060a99b01 ("drm/i915/guc: Update intel_gt_wait_for_idle to
> > > work with GuC")
> >
> > OK, so that didn't happen so I will now apply the merge fix up to the
> > merge of the kbuild tree.
> >
> > > > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > > > Date: Fri, 20 Aug 2021 12:24:19 +1000
> > > > Subject: [PATCH] drm/i915: use linux/stddef.h due to "isystem: trim/fixup stdarg.h and other headers"
> > > >
> > > > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > > ---
> > > >  drivers/gpu/drm/i915/gt/intel_gt_requests.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/i915/gt/intel_gt_requests.h b/drivers/gpu/drm/i915/gt/intel_gt_requests.h
> > > > index 51dbe0e3294e..d2969f68dd64 100644
> > > > --- a/drivers/gpu/drm/i915/gt/intel_gt_requests.h
> > > > +++ b/drivers/gpu/drm/i915/gt/intel_gt_requests.h
> > > > @@ -6,7 +6,7 @@
> > > >  #ifndef INTEL_GT_REQUESTS_H
> > > >  #define INTEL_GT_REQUESTS_H
> > > >
> > > > -#include <stddef.h>
> > > > +#include <linux/stddef.h>
> > > >
> > > >  struct intel_engine_cs;
> > > >  struct intel_gt;
> > > > --
> > > > 2.32.0
>
> Ping?  I am still applying this ...

Apologies, this fell through a lot of cracks. I applied this to drm-next now.

Matt/John, as author/committer it's your job to make sure issues and
fixes for the stuff you're pushing don't get lost. I'd have expected
John to apply this to at least drm-intel-gt-next (it's not even
there).

Joonas, I think this is the 2nd or 3rd or so issue this release cycle
where some compile fix got stuck a bit because drm-intel-gt-next isn't
in linux-next. Can we please fix that? It probably needs some changes
to the dim script.

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
