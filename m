Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2E3036FFC0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 19:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbhD3RiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 13:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbhD3RiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 13:38:23 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47980C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 10:37:35 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id x20so81002295lfu.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 10:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IyZoGH+lT+P8SU23gcGGsIVn6bGEnFnAdvfYbbDN9to=;
        b=ryDFnWPDNEvnvXwTf0jcPPjjEXrVhjstRilHvsIA8HyK6O52T+H+wQ8OPQWWOwaWB8
         CE9qwQA0/2kiylTlZnPXkbNG4DrQxLyX8gS5wTYZX0aMkmGTeckUGp+xCUcixrb7nKv0
         z+mzVNUzvNKMXuro8JYl2HXNj2O20xvQLqllwQ5eYrlTm/Z/lpyJeVqbqW/9JsK2knKU
         5LNmpveMyCCZbDUYFU695phQaFMgAMzzwWVCO2vUFO8DQAzgYvMxBI2ItJcnSrY6OYxp
         SuRvUyWbEJIA/FcRCNQ5QW1ydXUp1tjV7ZyQmbNjtaVj15WO2SnS3LgH1s7CCIG1SPbZ
         eMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IyZoGH+lT+P8SU23gcGGsIVn6bGEnFnAdvfYbbDN9to=;
        b=staX2P9IlB4c1UTSiP8sD+8G0lUdiPC1gCGc1VP34gIGIZFtE15jj69hnKoceVMNSF
         0S2DKB4plcIkgTt6BjlfOpBMYa+1qcDSjwFkZ517yPVH3eMVEG5JJvRZZI3HkqKqatHi
         30UqMUFMkD9CDm3P+zQx4Svtu4TYinWgWZfSXbT7/m97JSRI4i7zHgp89UDl8mIZJTvH
         EbEUzu8bfNk08YSt63lEGrYhe1/Vx+Wt0N+3orSjtthYzGrtFi8Ef2vFRqy5wo9RJlUC
         7Sj70DvuSsgNnQ+Oe/9cDvdvmOg1pcFMQrPMFFZlmnVfHS/xaDAgxFiuBDju7UZ2/dpM
         KDJQ==
X-Gm-Message-State: AOAM532s8QDJPqiGdAwTk0xSE9d7fXbnsuO3cm4zvblic3e55yivyCSK
        gyqBP3+qhI0vm9XHm0m9L96P4N3jTNZ8e0JpKkoZWA==
X-Google-Smtp-Source: ABdhPJyrJphBLygkbPOqBlyI3KGd158lA8+tnQCVqwm0BWpVup5VBgWBQRQB0f1PP1xd/VB51Pqr4tiWIdyHtQCG6fQ=
X-Received: by 2002:ac2:593b:: with SMTP id v27mr3358056lfi.204.1619804253808;
 Fri, 30 Apr 2021 10:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210430171744.1721408-1-robdclark@gmail.com>
In-Reply-To: <20210430171744.1721408-1-robdclark@gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 30 Apr 2021 10:37:22 -0700
Message-ID: <CALAqxLU=zsaMuBikeEzjtgNFAcxZGdqMhETBHvveNC_JZ=B7JA@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dpu: Delete bonkers code
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Clark <robdclark@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Stephen Boyd <swboyd@chromium.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Hongbo Yao <yaohongbo@huawei.com>,
        Qinglang Miao <miaoqinglang@huawei.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <freedreno@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 10:14 AM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> dpu_crtc_atomic_flush() was directly poking it's attached planes in a
> code path that ended up in dpu_plane_atomic_update(), even if the plane
> was not involved in the current atomic update.  While a bit dubious,
> this worked before because plane->state would always point to something
> valid.  But now using drm_atomic_get_new_plane_state() we could get a
> NULL state pointer instead, leading to:
>
>    [   20.873273] Call trace:
>    [   20.875740]  dpu_plane_atomic_update+0x5c/0xed0
>    [   20.880311]  dpu_plane_restore+0x40/0x88
>    [   20.884266]  dpu_crtc_atomic_flush+0xf4/0x208
>    [   20.888660]  drm_atomic_helper_commit_planes+0x150/0x238
>    [   20.894014]  msm_atomic_commit_tail+0x1d4/0x7a0
>    [   20.898579]  commit_tail+0xa4/0x168
>    [   20.902102]  drm_atomic_helper_commit+0x164/0x178
>    [   20.906841]  drm_atomic_commit+0x54/0x60
>    [   20.910798]  drm_atomic_connector_commit_dpms+0x10c/0x118
>    [   20.916236]  drm_mode_obj_set_property_ioctl+0x1e4/0x440
>    [   20.921588]  drm_connector_property_set_ioctl+0x60/0x88
>    [   20.926852]  drm_ioctl_kernel+0xd0/0x120
>    [   20.930807]  drm_ioctl+0x21c/0x478
>    [   20.934235]  __arm64_sys_ioctl+0xa8/0xe0
>    [   20.938193]  invoke_syscall+0x64/0x130
>    [   20.941977]  el0_svc_common.constprop.3+0x5c/0xe0
>    [   20.946716]  do_el0_svc+0x80/0xa0
>    [   20.950058]  el0_svc+0x20/0x30
>    [   20.953145]  el0_sync_handler+0x88/0xb0
>    [   20.957014]  el0_sync+0x13c/0x140
>
> The reason for the codepath seems dubious, the atomic suspend/resume
> heplers should handle the power-collapse case.  If not, the CRTC's
> atomic_check() should be adding the planes to the atomic update.

Thanks! This patch gets things booting again!

Tested-by: John Stultz <john.stultz@linaro.org>

thanks
-john
