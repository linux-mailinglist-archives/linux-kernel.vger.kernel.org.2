Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEAD0350AFF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 01:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbhCaXqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 19:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhCaXqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 19:46:24 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E308C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 16:46:24 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id g20so600712qkk.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 16:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QVJf2tl4IWyWeYZKzdmdiismF5Kwfs0DaiffQjbKvI0=;
        b=BftwgFsMkGP9DaHNw/lKk8TXRGWQNRqMweUE/JxfYD/LukTAV9f0zCZnvDePWoDTaK
         tL1WKtigi8C1pPAM83ka/lOXH90VqKkxd1zF+3nIyqhqrehUTO5lop7OcWJ72ZdECfG0
         qRVjROwVczkIp96dR5n8O3iJMgCKVXClY353M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QVJf2tl4IWyWeYZKzdmdiismF5Kwfs0DaiffQjbKvI0=;
        b=GkWJJ57vVx6Pau8qLyODq5PR3CWMJWnws6oyyn6zMeVw/EpqgjG3CGSbJKv02zGFIv
         wfVLHp/RgEZpycOq6H0Bs9Uc0uuhPzbTDa0n2krbf+fKbvdarLzAMC1MCJlhkv579iiv
         +PzNBMP6XgwWSQv13Ib1/h3Bnm1kuXbnSMIy+N1L6Cj69/qLCxKaKvSFPRNMsj+IMTQP
         IoHqPGyoYA6TjnSMAjCCDvnDjBP+EB/q8h3bBp+BrroiCcl4KEZYDd7rng5rxcu9iE6O
         I38YJzmB8Cy26LeTC2KNagfCqL52qeUpnYVEJOzjasDZYFjC6kPHtZ+qIggUEmCrVB3/
         UP1w==
X-Gm-Message-State: AOAM532DzJ3H0f+6ONhGxfzOGix1M5Z7xxK0h2sFv9oF1XR5xsSNFVQC
        k0zisqyJ1DJ5Qg3Fm+WYg/uY/T6et2gYTA==
X-Google-Smtp-Source: ABdhPJxmhk/IVKSP6767RzkcepcdzvsyTHOOeWqrEMDFcwRi8DcQv6ZXG46Gf+566P+8evk3lRahmg==
X-Received: by 2002:a05:620a:2046:: with SMTP id d6mr5918215qka.116.1617234382916;
        Wed, 31 Mar 2021 16:46:22 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id w12sm2461096qto.2.2021.03.31.16.46.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 16:46:22 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id j2so23016750ybj.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 16:46:22 -0700 (PDT)
X-Received: by 2002:a25:8712:: with SMTP id a18mr2298312ybl.79.1617234382025;
 Wed, 31 Mar 2021 16:46:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210331221630.488498-1-robdclark@gmail.com>
In-Reply-To: <20210331221630.488498-1-robdclark@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 31 Mar 2021 16:46:10 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VJ_4ufZdCu0uh2J+WTgz2=naZNrjZDMnxjjOH-COfzJQ@mail.gmail.com>
Message-ID: <CAD=FV=VJ_4ufZdCu0uh2J+WTgz2=naZNrjZDMnxjjOH-COfzJQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] drm/msm: Shrinker (and related) fixes
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@chromium.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <freedreno@lists.freedesktop.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        "Kristian H. Kristensen" <hoegsberg@google.com>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 31, 2021 at 3:14 PM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> I've been spending some time looking into how things behave under high
> memory pressure.  The first patch is a random cleanup I noticed along
> the way.  The second improves the situation significantly when we are
> getting shrinker called from many threads in parallel.  And the last
> two are $debugfs/gem fixes I needed so I could monitor the state of GEM
> objects (ie. how many are active/purgable/purged) while triggering high
> memory pressure.
>
> We could probably go a bit further with dropping the mm_lock in the
> shrinker->scan() loop, but this is already a pretty big improvement.
> The next step is probably actually to add support to unpin/evict
> inactive objects.  (We are part way there since we have already de-
> coupled the iova lifetime from the pages lifetime, but there are a
> few sharp corners to work through.)
>
> Rob Clark (4):
>   drm/msm: Remove unused freed llist node
>   drm/msm: Avoid mutex in shrinker_count()
>   drm/msm: Fix debugfs deadlock
>   drm/msm: Improved debugfs gem stats
>
>  drivers/gpu/drm/msm/msm_debugfs.c      | 14 ++----
>  drivers/gpu/drm/msm/msm_drv.c          |  4 ++
>  drivers/gpu/drm/msm/msm_drv.h          | 10 ++++-
>  drivers/gpu/drm/msm/msm_fb.c           |  3 +-
>  drivers/gpu/drm/msm/msm_gem.c          | 61 +++++++++++++++++++++-----
>  drivers/gpu/drm/msm/msm_gem.h          | 58 +++++++++++++++++++++---
>  drivers/gpu/drm/msm/msm_gem_shrinker.c | 17 +------
>  7 files changed, 122 insertions(+), 45 deletions(-)

This makes a pretty big reduction in jankiness when under memory
pressure and seems to work well for me.

Tested-by: Douglas Anderson <dianders@chromium.org>
