Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D656134EBEC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 17:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbhC3PPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 11:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbhC3PPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 11:15:05 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81AAC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 08:15:04 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id t5so8297625qvs.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 08:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cJ+YJYx4OZR4pIjZNdx26kpeAL+vxeQN6P+Ncit8r0s=;
        b=GbCYv1WSjk/ew5BC7x/ek5Wk2nKYhMN1fPHHdbT0dXhA8sLDDAsvmkroYbEa1UY8pV
         t325S1USzc4yVtmH5R+gvgAKF4w2om2JhomKV4Iaf538mB2Gfj/Jm/mw8aG8EVfwF/SD
         ZZthbDH/iclBvd6Stp0tcsKmZ3GOpPd77CGCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cJ+YJYx4OZR4pIjZNdx26kpeAL+vxeQN6P+Ncit8r0s=;
        b=QhJDMX5PZs6Dh7QJxSSufbi9zosJurm9URIOohImZ6MFmceHkvih8mRsgnpKcYb3Cz
         /kdhokXaAf59GHuCu7+EtDEkrrkTruBqLemYYVMiaxdkFlxXF3KLfpAV9P3TgUDImn7+
         AQPYzFOXFB4qgcBQ+nBuiz95AnA6Qeb1rpcEsfDESJFw+T20qHJdxsiVkpU0V6p/6/VW
         jvTa8swCKZ5RPiJ7Bgll3+6XyB/82ptElx5wsi4NT7rOnaSku62XN0+Ol/77YvDXVMnZ
         6neI9c9VlXmzeUGjRvJBFDF0S2LH2uEw9syWSUgBpWGuCyMgn68XmmK13w+IwSUBG4Wv
         YHoQ==
X-Gm-Message-State: AOAM531HKv0NcrydnEuhGl4NLCuNI9jiwTu3sZkTTp0+mHS/aU+2sFL0
        yIydw9mVbDo2jD4AbZfK1TvtFNMxfw8Rmw==
X-Google-Smtp-Source: ABdhPJzjgyeb3y2Wofi8WUPm3DGXlVo1GKbScYc8rUQCErw14zs6+R9DVM3FsQU4MZ+gosh3QSC0rg==
X-Received: by 2002:a05:6214:13b3:: with SMTP id h19mr31174739qvz.31.1617117303944;
        Tue, 30 Mar 2021 08:15:03 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id x10sm12678505qtw.17.2021.03.30.08.15.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 08:15:03 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id k3so7445181ybh.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 08:15:03 -0700 (PDT)
X-Received: by 2002:a25:4092:: with SMTP id n140mr36653500yba.276.1617117302924;
 Tue, 30 Mar 2021 08:15:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210330013408.2532048-1-john.stultz@linaro.org>
In-Reply-To: <20210330013408.2532048-1-john.stultz@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 30 Mar 2021 08:14:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XbwNmmeoZOSso3Kz1mP40ONo0hDvn6KP8zZsdg9uPcNg@mail.gmail.com>
Message-ID: <CAD=FV=XbwNmmeoZOSso3Kz1mP40ONo0hDvn6KP8zZsdg9uPcNg@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: Fix removal of valid error case when checking speed_bin
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Eric Anholt <eric@anholt.net>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        YongQin Liu <yongqin.liu@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 29, 2021 at 6:34 PM John Stultz <john.stultz@linaro.org> wrote:
>
> Commit 7bf168c8fe8c  ("drm/msm: Fix speed-bin support not to
> access outside valid memory"), reworked the nvmem reading of
> "speed_bin", but in doing so dropped handling of the -ENOENT
> case which was previously documented as "fine".
>
> That change resulted in the db845c board display to fail to
> start, with the following error:
>
> adreno 5000000.gpu: [drm:a6xx_gpu_init] *ERROR* failed to read speed-bin (-2). Some OPPs may not be supported by hardware
>
> Thus, this patch simply re-adds the ENOENT handling so the lack
> of the speed_bin entry isn't fatal for display, and gets things
> working on db845c.
>
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: Jordan Crouse <jcrouse@codeaurora.org>
> Cc: Eric Anholt <eric@anholt.net>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: freedreno@lists.freedesktop.org
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: YongQin Liu <yongqin.liu@linaro.org>
> Reported-by: YongQin Liu <yongqin.liu@linaro.org>
> Fixes: 7bf168c8fe8c  ("drm/msm: Fix speed-bin support not to access outside valid memory")
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
