Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB65E33FA03
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 21:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbhCQUdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 16:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbhCQUcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 16:32:52 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30806C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 13:32:50 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id m21-20020a9d7ad50000b02901b83efc84a0so3062551otn.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 13:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IHCnunVxEHDcq+HTDx4ulePq7olKHfoa4KrEracuGEE=;
        b=F3jWDKeZzOEZZV+TtU/QAqYOuYjLzlwHXLJOUphmL/VTnC00lws/xyjCQFL1MFzEIq
         cOmU8WIgXcWr8H47lTCo4CJ6guTqcA2xR8IVXUiA4RT0KOFJNwKrTI7IziG13bdXuDmh
         1mV45jQA3sCOkiQ18AaiLVLPMdYLhTJRLR/3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IHCnunVxEHDcq+HTDx4ulePq7olKHfoa4KrEracuGEE=;
        b=FCi7c5+uK+Ce+g4wwuPgn7CpXzuSDRwYVFisiulKwq/4KeZaz6IVKWyXYtsmD8tJ1v
         xwcMzSH64ZGlsz2urwhXQ23t9UvmVBocvWjS7Hvd2z/DbIHxfBkt2Ib1+pAlMe6DSq10
         bQdXn0r2FDQMxBJYYCSPoGqdU9zoRChhiUfwoejMZcPt9KGmsMtNs25pqHn+qzDuGMIv
         aRnE32XcCNvD0YYOzPJv/6oAgCP39a4yiixeeZ4C1taDWJ9ViImgepHNQUxA2ja2wn69
         fNnlijmFsM04SjS2AQ17uyeX03PwFDTm5F6aXgQl1DaZxu5pWKvTQ2iBCQBloR/mHOGo
         rIXQ==
X-Gm-Message-State: AOAM531jLWoPM1hlFVO/qgtvraMF/tYF6GjmJEESLl6dW3CAQIWkmd4t
        Typhmrg9Q9lc9yVtMyUv34qXTSrlzg2wJrrIG0KSXA==
X-Google-Smtp-Source: ABdhPJwpaKtWZD5ndm43ILhNLn5AjG91euFm+8cd3zhFc4Jg9VKRXCNzX5CQhv6Shjqegj6++qTq+qWnq/5dHW2jDuI=
X-Received: by 2002:a9d:6481:: with SMTP id g1mr4590503otl.303.1616013169521;
 Wed, 17 Mar 2021 13:32:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210303134319.3160762-1-lee.jones@linaro.org>
 <16d4300e-bf29-1e85-317b-53d257890cb9@vmware.com> <20210308091932.GB4931@dell>
 <YEobySvG0zPs9xhc@phenom.ffwll.local> <20210311135152.GT701493@dell> <20210317081729.GH701493@dell>
In-Reply-To: <20210317081729.GH701493@dell>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 17 Mar 2021 21:32:38 +0100
Message-ID: <CAKMK7uEibsgXXTEM1d2CGSswp-koouPSouseP_rwLHTdpxfRpw@mail.gmail.com>
Subject: Re: [RESEND 00/53] Rid GPU from W=1 warnings
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Roland Scheidegger <sroland@vmware.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Anthony Koo <Anthony.Koo@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Harry Wentland <harry.wentland@amd.com>,
        Jeremy Kolb <jkolb@brandeis.edu>,
        Kuogee Hsieh <khsieh@codeaurora.org>,
        Leo Li <sunpeng.li@amd.com>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>, Lyude Paul <lyude@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Nouveau Dev <nouveau@lists.freedesktop.org>,
        Qinglang Miao <miaoqinglang@huawei.com>,
        Rob Clark <rob.clark@linaro.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Zack Rusin <zackr@vmware.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 9:17 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Thu, 11 Mar 2021, Lee Jones wrote:
>
> > On Thu, 11 Mar 2021, Daniel Vetter wrote:
> >
> > > On Mon, Mar 08, 2021 at 09:19:32AM +0000, Lee Jones wrote:
> > > > On Fri, 05 Mar 2021, Roland Scheidegger wrote:
> > > >
> > > > > The vmwgfx ones look all good to me, so for
> > > > > 23-53: Reviewed-by: Roland Scheidegger <sroland@vmware.com>
> > > > > That said, they were already signed off by Zack, so not sure what
> > > > > happened here.
> > > >
> > > > Yes, they were accepted at one point, then dropped without a reason.
> > > >
> > > > Since I rebased onto the latest -next, I had to pluck them back out of
> > > > a previous one.
> > >
> > > They should show up in linux-next again. We merge patches for next merge
> > > window even during the current merge window, but need to make sure they
> > > don't pollute linux-next. Occasionally the cut off is wrong so patches
> > > show up, and then get pulled again.
> > >
> > > Unfortunately especially the 5.12 merge cycle was very wobbly due to some
> > > confusion here. But your patches should all be in linux-next again (they
> > > are queued up for 5.13 in drm-misc-next, I checked that).
> > >
> > > Sorry for the confusion here.
> >
> > Oh, I see.  Well so long as they don't get dropped, I'll be happy.
> >
> > Thanks for the explanation Daniel
>
> After rebasing today, all of my GPU patches have remained.  Would
> someone be kind enough to check that everything is still in order
> please?

It's still broken somehow. I've kiced Maxime and Maarten again,
they're also on this thread.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
