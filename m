Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4256B3530DA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 23:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235307AbhDBVpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 17:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbhDBVpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 17:45:42 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40C1C061788
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 14:45:40 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id g24so4541422qts.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 14:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w/ZFqdPtGzDkqCBMP4OyjhCVZaJFf+dBQBfj22hpRiE=;
        b=fR/uwETGDlv7x2KneEGWioUh5GnHXl6COTEbAPvUEKXqSO6DcbFhq6GmsakFHFfQb1
         wliBhr4E8MsNOCDNkBhlQKCaO4VIM69RBeM5lAhTDxR2PyRbPdXlccDmkWf3i+hZ36ZY
         wDCOxhUkM9o0Ddesn2NSw1F02JXvkyONIIoMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w/ZFqdPtGzDkqCBMP4OyjhCVZaJFf+dBQBfj22hpRiE=;
        b=BfUK3v/wB0RDJ6lHIBoPqHsrdtGb8qQEgThl2NkCpR4J5IvoLu64tzqjb7uTkBRpWG
         /3Emg3a1fLK+aKQlbW9O1xczeqCeKeSIgLSJgFphoTqL+OBC7XP3Fex8+PY7Wu28IarD
         yTDrAtn2uvl/vWn+2ZBXmmSWyHzcHxcb3S3OP0vqAfKaOvJGzOFsd3P3YB83z9Q+/SYQ
         lfGmgJi6JpOYtnvIucaacRvhislRM4UKfHrFBrhmUrVa69ur7kbGTFWik64N0a/3XUDa
         JEzUUHeXSmsZ/yqwY4V90Ci9imECthCEOhlsbH85mOYJwjypq4WR0eepR3/g0zQnL4fO
         Hm/w==
X-Gm-Message-State: AOAM5334MFksIScVsRVCqoSQyRVBst9J2vx3sHVjhfS58myysYByOIEH
        sJtZzyMxolesW5DfDi0m4r1TuC2fH1V2uA==
X-Google-Smtp-Source: ABdhPJyx9dtyuOsTkdxkdBlGfdJCtkyZ9mx7U8zixITpG80p+0UL3Z7AfeLjl44YG6i4pU4Z8XyCjw==
X-Received: by 2002:ac8:499a:: with SMTP id f26mr13056101qtq.162.1617399939894;
        Fri, 02 Apr 2021 14:45:39 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id j18sm8061605qtl.83.2021.04.02.14.45.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 14:45:39 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id g38so6270832ybi.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 14:45:38 -0700 (PDT)
X-Received: by 2002:a25:8712:: with SMTP id a18mr14891430ybl.79.1617399938583;
 Fri, 02 Apr 2021 14:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210402211226.875726-1-robdclark@gmail.com>
In-Reply-To: <20210402211226.875726-1-robdclark@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 2 Apr 2021 14:45:27 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vm9CTmayrKjUoLNyObtQgejhBacvvP5aK5tFULmPWeNw@mail.gmail.com>
Message-ID: <CAD=FV=Vm9CTmayrKjUoLNyObtQgejhBacvvP5aK5tFULmPWeNw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm: Drop mm_lock in scan loop
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
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

On Fri, Apr 2, 2021 at 2:08 PM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> lock_stat + mmm_donut[1] say that this reduces contention on mm_lock
> significantly (~350x lower waittime-max, and ~100x lower waittime-avg)
>
> [1] https://chromium.googlesource.com/chromiumos/platform/microbenchmarks/+/refs/heads/main/mmm_donut.py
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/msm_drv.h          |  3 +-
>  drivers/gpu/drm/msm/msm_gem.c          |  2 +-
>  drivers/gpu/drm/msm/msm_gem_shrinker.c | 48 ++++++++++++++++++++++----
>  3 files changed, 45 insertions(+), 8 deletions(-)

Looks good to me now!

Reviewed-by: Douglas Anderson <dianders@chromium.org>
