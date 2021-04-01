Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C44E351DAC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240759AbhDASbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238599AbhDASJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:09:41 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE58C0225AA
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 08:34:42 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id g20so2606798qkk.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 08:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bgQ3XZ5ITKRGojF0eSgHx7BZvQ88/ghBhXwnDbKAV2I=;
        b=YhJ7jkjScY7JdQhF/7Tt22mZk21tl8MbMM81VDTVwMeS/bumy1w9WGLvBQENfwcpeB
         2ljIOmE/0b06jnmE6dkboTDAy94ze0X9i8gyWwaN4XMFw6NveMfupfnjzjWCFGiD4kIO
         Z5Pg/KYuMKdSJP55scpo50bf+0976bJPooquI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bgQ3XZ5ITKRGojF0eSgHx7BZvQ88/ghBhXwnDbKAV2I=;
        b=I7iCAoJfoUYqAoNJiH9qgfaBFON30i4yB/whdiM19ar4HU6FwMa+wgy8oaZXrU97pf
         PoGZXo/EKkizn41sABJL00MG6fWy81tCimAbMCW8zhlC/lQrE4agVN5dQjXOVhM6IOB7
         qXPEwnItcu9fr5cwf+FjVrAcxb9zbWZM3/nySvqOEgriiHOaRJOJ8t29pEL8hI3DfrD6
         fAJoxRxQLjxGH0PTaNFY9Ca5UW4k4qFR3YjTI+/nrwhsUIBi+/RXxLgjML1RTG0aQ988
         T53DzyHWMk+T5nsL6033ZREBDLsxBAL1xlqiC7Nfhak2F8l6z4ylaj8uz15jyJZD0ccR
         W8ZQ==
X-Gm-Message-State: AOAM531XktHnP36VOGeElGyQ6ZJCW7B84QjMwCKRiF7pC/Z5Agqri+SW
        GU7qlvERybYvMW86JdT2ad7PHYYLzP3yuw==
X-Google-Smtp-Source: ABdhPJxMHyfSsq1+ikYRD2tgfYBjLo/HargnONILGge8MOzO8ZHmyJFDAZDuAU7Cm8vF2xrSOdeIxg==
X-Received: by 2002:a05:620a:6b5:: with SMTP id i21mr9050972qkh.93.1617291281099;
        Thu, 01 Apr 2021 08:34:41 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id k28sm4259130qki.101.2021.04.01.08.34.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 08:34:40 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id o66so2190888ybg.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 08:34:40 -0700 (PDT)
X-Received: by 2002:a5b:54a:: with SMTP id r10mr12794123ybp.476.1617291280047;
 Thu, 01 Apr 2021 08:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210331221630.488498-1-robdclark@gmail.com> <20210401012722.527712-1-robdclark@gmail.com>
 <20210401012722.527712-2-robdclark@gmail.com>
In-Reply-To: <20210401012722.527712-2-robdclark@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 1 Apr 2021 08:34:28 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V1QUHYw-QkZO-bn+sS_K=KYRe83DfSqVow2RGFXu6nqg@mail.gmail.com>
Message-ID: <CAD=FV=V1QUHYw-QkZO-bn+sS_K=KYRe83DfSqVow2RGFXu6nqg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] drm/msm: Remove unused freed llist node
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

On Wed, Mar 31, 2021 at 6:23 PM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> Unused since commit c951a9b284b9 ("drm/msm: Remove msm_gem_free_work")
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> Tested-by: Douglas Anderson <dianders@chromium.org>
> ---
>  drivers/gpu/drm/msm/msm_gem.h | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
