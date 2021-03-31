Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE62350ADB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 01:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbhCaXeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 19:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbhCaXdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 19:33:50 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CC7C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 16:33:49 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id q26so542637qkm.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 16:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ryw7Sly4csIxLLkV0t8RVlRi+I4oygJP2r682A3Ebsg=;
        b=XSlzP164vpMabm8VK7gOUDGLcC28VMJkHMTe3WUhvTPmB2LjegZ4XUUKpBnAI+VfX/
         VRJtqvfUH0LXbIQVHPaQmE2CVoSwf73vC7/C2yAl6xriPwSE1pIYCMVoqb6ADYKZtt1H
         ma9YyWtCHNW6GLqQqFMelk3JxyalMU266gNcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ryw7Sly4csIxLLkV0t8RVlRi+I4oygJP2r682A3Ebsg=;
        b=SC6H/0mDObFk2o/bVYy7ZZz8mYpXkhyAex5kBS7t4LFFmwmZ9KCJOdhIrYukofK1uv
         rRGsXu8LFuZSxer7UACWwTsALItqc9pswqhjdsAGBW2sepCMNN8DN6g3RpHGHHbbAvHA
         AzRpcI4Dg3nZBTo9EnfgLLCrkXXAV8p263v1O5q/a2vL1f6jFf9nZ0pDtG1MvAwR4+RB
         13/5ejhRb1o9cTqBKMO6A4Z00m12Ole5hSWRjkgrrwhBNZx3rKGNfcANDq0tI4SMhOky
         yCg0Fm+MM05UlEy0MGDCyeVMj5rWoYHxH/6T0PDQeOqHrB1Pnh+0Z0T1DOux5y7YylFV
         UOlA==
X-Gm-Message-State: AOAM530S1i5ITP5qeGn18+CrTR9tjqFmr7mFy0dhLDxW1tXLoqcHwWQU
        MrxYIH6hwsaM5I0zHAG7lF3EQMUes3d+EA==
X-Google-Smtp-Source: ABdhPJwKGblSr54otUhpOuKj/HtAwtvNN9DFak5mv85HSgfi+hrj/Udxj+PMX74IfR2oG7QzSGfM3A==
X-Received: by 2002:a37:9fd2:: with SMTP id i201mr5453554qke.435.1617233628718;
        Wed, 31 Mar 2021 16:33:48 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id 73sm2541267qkk.131.2021.03.31.16.33.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 16:33:48 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id g38so22950407ybi.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 16:33:47 -0700 (PDT)
X-Received: by 2002:a5b:54a:: with SMTP id r10mr8190661ybp.476.1617233627357;
 Wed, 31 Mar 2021 16:33:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210331221630.488498-1-robdclark@gmail.com> <20210331221630.488498-5-robdclark@gmail.com>
In-Reply-To: <20210331221630.488498-5-robdclark@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 31 Mar 2021 16:33:35 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UXoE-UsbfS1zOoKyaiVXPUBAnOr7T2ON4m6-i_43Dm6A@mail.gmail.com>
Message-ID: <CAD=FV=UXoE-UsbfS1zOoKyaiVXPUBAnOr7T2ON4m6-i_43Dm6A@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/msm: Improved debugfs gem stats
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <freedreno@lists.freedesktop.org>,
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
> The last patch lost the breakdown of active vs inactive GEM objects in
> $debugfs/gem.  But we can add some better stats to summarize not just
> active vs inactive, but also purgable/purged to make up for that.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/msm_fb.c  |  3 ++-
>  drivers/gpu/drm/msm/msm_gem.c | 31 ++++++++++++++++++++++++-------
>  drivers/gpu/drm/msm/msm_gem.h | 11 ++++++++++-
>  3 files changed, 36 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_fb.c b/drivers/gpu/drm/msm/msm_fb.c
> index d42f0665359a..887172a10c9a 100644
> --- a/drivers/gpu/drm/msm/msm_fb.c
> +++ b/drivers/gpu/drm/msm/msm_fb.c
> @@ -33,6 +33,7 @@ static const struct drm_framebuffer_funcs msm_framebuffer_funcs = {
>  #ifdef CONFIG_DEBUG_FS
>  void msm_framebuffer_describe(struct drm_framebuffer *fb, struct seq_file *m)
>  {
> +       struct msm_gem_stats stats = {{0}};

nit: instead of "{{0}}", can't you just do:

struct msm_gem_stats stats = {};

...both here and for the other usage.

Other than that this seems good to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
