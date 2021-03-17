Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D2233F985
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 20:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbhCQTne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 15:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbhCQTn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 15:43:26 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC972C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 12:43:25 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id m186so23541362qke.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 12:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5M2o/5txOfVVkT2R7LQazFbw4Qc4fveGxpdbp198xYU=;
        b=RKgCDWdDwNcrvndpEPh2z1A5LONc8q/kcoUvZhZMJbRafeyUDCMPQ9APb5VdSlrvO0
         M/apv7bxCnuXge+S6JbVEtTH/JvPNl2yiQQep2q7mXRp8oEs7rTo4fjJbDAvv3Ior9C9
         MoY4YdsqiJ0l8rOupxYVQbv4QcMBsxNfXvG20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5M2o/5txOfVVkT2R7LQazFbw4Qc4fveGxpdbp198xYU=;
        b=I2CAE9Qa7/Jg5s+9EmWaI3FujF0MvoABm5z094ZW5hlBOJoKTkMXq2biFBCta1elLJ
         34bMwAz9SYvFOJEFRyZ8oAdau1m4QFRiYjHz7I8u5lM82QLo5S4VCEYioUDTi8487g4S
         CxU4PrP0CXth52wdcJp2FooVV4vVA/ETapEkLM82eY2ZRZ5Hv4CROTAzVHgfDMHd9IlC
         fUTmUcRe+wH/ehBSx6suF/4EV2aSo6Z0ljLXBuFada684bcgFdwPPdPWkLGM4SoPU53Y
         DlwX5XcYS2Y+aVCvSfhXOYN/AqKmtcM2R+lGXiWFFD2booBAOsVuSJzO4O9saB9Da8/o
         Q7WA==
X-Gm-Message-State: AOAM530jrManGfEf4g3VO1BaS6DIN0hK80tp0mHzjkFeWPW4Bu+kiHx4
        5qymrw5mwiUOKLkOpjWGroW/tqVbJG/Hog==
X-Google-Smtp-Source: ABdhPJxAaDEY7YVwkXPclA4m3txDq5CLUdhMGMVpGOhC4EGue2p7VXHaJVCUZlJDok8Gq6VazXvo3Q==
X-Received: by 2002:a37:de14:: with SMTP id h20mr931162qkj.34.1616010204618;
        Wed, 17 Mar 2021 12:43:24 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id m17sm18980362qkh.82.2021.03.17.12.43.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 12:43:23 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id y133so103462ybe.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 12:43:23 -0700 (PDT)
X-Received: by 2002:a25:2654:: with SMTP id m81mr6485146ybm.405.1616010202994;
 Wed, 17 Mar 2021 12:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210317164239.1007776-1-robdclark@gmail.com>
In-Reply-To: <20210317164239.1007776-1-robdclark@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 17 Mar 2021 12:43:11 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WRXqtYNeqXZfSnhSRJcOS5QGauM=vg=XVQ6=EbWkdkDw@mail.gmail.com>
Message-ID: <CAD=FV=WRXqtYNeqXZfSnhSRJcOS5QGauM=vg=XVQ6=EbWkdkDw@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: Ratelimit invalid-fence message
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

On Wed, Mar 17, 2021 at 9:40 AM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> We have seen a couple cases where low memory situations cause something
> bad to happen, followed by a flood of these messages obscuring the root
> cause.  Lets ratelimit the dmesg spam so that next time it happens we
> don't loose the kernel traces leading up to this.

s/loose/lose


> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/msm_fence.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
