Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56AFE350B00
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 01:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbhCaXqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 19:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbhCaXqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 19:46:35 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40DEC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 16:46:35 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id y12so256457qtx.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 16:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LYa+AG9JR1t6qbABdQ1iCGfLaLvkJp9ZS13fKinSSac=;
        b=ctaBO5zR13LihBuEeHxc8Iu/QFRibysNpeKgX+kU2t+ibrAopqUh/O3Z5zJhzEYOLi
         WkpMisFcmDpdNyg8MIyTPoesZeAvkb7fNH+pnt2wcMh/PTFD+96gEIOvrHu7FMUWUjlK
         341Ow9vIocW+ba+vnYCmMKd3WL/8koWnxkGLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LYa+AG9JR1t6qbABdQ1iCGfLaLvkJp9ZS13fKinSSac=;
        b=NN9YsInXRI0wj242ZTOeMta6Ct+/2D0081HrGiJ+METuTC6WvgzirnbYmCfl1yVEwr
         /w/hstnN/T58DLAOvKlN8S92c+O5nsMVkbKy99ZWFjN4Om2841q/Iex00dcb2RUkwr7M
         QrzHCl+3/pOEBkL/Hqkj2KvtE0Je4lA1Cf4QRcAnNch9jJuAtRmGgyH4rQmjLGMialxT
         Ld1f+OLqQxW0M/P6bS7PhUZ0z+Z9yPg/NY+3T8DansXz29lZnBctTXKPWxs8KFsWNY9q
         8UpCdG9rIKGkyk/5MdezXg/GbZk22FAbOvzyNQXdPNhut/Gka8bxeWtLaoRP1gLQ3///
         RLJw==
X-Gm-Message-State: AOAM531/M2aoClnY0JHhhvhgTw5a3GrVK2EfM4c2J/VrjQjI2KtOILoK
        kFDhPXeH/h3Cl9y84o8EE9p61FSlRbwHuw==
X-Google-Smtp-Source: ABdhPJzuEr9UB+6HSt1M785JID+zsjM7j8NJzkZC7YRNHJJuHaoqY2FanW+t47x4wbn1PBVaCF2SyA==
X-Received: by 2002:ac8:5716:: with SMTP id 22mr4930402qtw.212.1617234394391;
        Wed, 31 Mar 2021 16:46:34 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id 85sm2642352qke.55.2021.03.31.16.46.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 16:46:34 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id w8so23039949ybt.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 16:46:33 -0700 (PDT)
X-Received: by 2002:a25:4092:: with SMTP id n140mr8176109yba.276.1617234393416;
 Wed, 31 Mar 2021 16:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210331221630.488498-1-robdclark@gmail.com> <20210331221630.488498-2-robdclark@gmail.com>
In-Reply-To: <20210331221630.488498-2-robdclark@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 31 Mar 2021 16:46:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WLjCFXi4cffyGqbF05nCFJr+wA_3+g2tkCVey5MxARcA@mail.gmail.com>
Message-ID: <CAD=FV=WLjCFXi4cffyGqbF05nCFJr+wA_3+g2tkCVey5MxARcA@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/msm: Remove unused freed llist node
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
> Unused since c951a9b284b907604759628d273901064c60d09f

Not terribly important, but checkpatch always yells at me when I don't
reference commits by saying:

commit c951a9b284b9 ("drm/msm: Remove msm_gem_free_work")


> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/msm_gem.h | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
