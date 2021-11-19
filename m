Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9C74579A5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 00:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236081AbhKSXld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 18:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235960AbhKSXla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 18:41:30 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0208C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 15:38:27 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id k21so14867582ioh.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 15:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wxVf84QwnEj8Uc7joyd4EzO/U0Oo8kpz6vj1F+hcMLk=;
        b=JoaU0znIPwQg4L/KYolJbJCVzydlY40vwNvIaoWmJqcQcJ8eG1h8jr3q4as59wc+1i
         sKIlfZ78zXnJFtr3OoqfN1viwrus/BmPq/Y6dYdUzqH6wclOo+fktpZoRnWrKKMylQ97
         8D4ReJ3enlh7d4svPfS8hp3F0IZsEnpSYjVFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wxVf84QwnEj8Uc7joyd4EzO/U0Oo8kpz6vj1F+hcMLk=;
        b=S4AEyrOnPmKy9qcVCIGa6uCMdmW0dfpeGM5CHwvEP2TM5O/oVbAuzzlvVGYwSIx45T
         kbxTNS644dnckKOHrqTh8qKdUcS1Dz9ysIDrPUWmmRN0Ax7UAtHva47HKSVaRfFX+Vd0
         bgbKVi94H820Sjx60j5v2qslZEvX/C+OIJ4lxb0oT1VhNueeshEoXF+BkK4pXDN+TYb4
         2ddsve1rsXDjsRX2QtDKMcwjqLkhURdfNuBEv/jKQXV2BUV1r7BiiaMl6QE4zq4oX4kO
         5lDkwcYJlfDzgm8Vf9a58SxmyHSBw2hIBPmRuhYAHh7FwmB5XLWcraw527au8bjTSAcH
         haGA==
X-Gm-Message-State: AOAM533zrBI7sGYm5czUMav4ZRjM5X6ZtGmVfmNpyehobPd+XZPc798/
        NG3zyA7BT1zieuSNBoztM/+5VGhhieM4Ww==
X-Google-Smtp-Source: ABdhPJyMvKBvKJApVB6G6K0ED2kkXFuYOonH4p3INXmb3Zr0yvbI64lFtTWUtgxD8Y7Ldl862ONj7w==
X-Received: by 2002:a02:9609:: with SMTP id c9mr31838309jai.118.1637365106865;
        Fri, 19 Nov 2021 15:38:26 -0800 (PST)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com. [209.85.166.54])
        by smtp.gmail.com with ESMTPSA id l18sm610290iob.17.2021.11.19.15.38.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 15:38:26 -0800 (PST)
Received: by mail-io1-f54.google.com with SMTP id f9so14729161ioo.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 15:38:26 -0800 (PST)
X-Received: by 2002:a05:6638:190f:: with SMTP id p15mr31409196jal.82.1637365106040;
 Fri, 19 Nov 2021 15:38:26 -0800 (PST)
MIME-Version: 1.0
References: <20211119225157.984706-1-robdclark@gmail.com>
In-Reply-To: <20211119225157.984706-1-robdclark@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 19 Nov 2021 15:38:14 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XiaMAeTj24zg0bPfSK5hGCjuap0ZDa6ixAKrSUQgJtVQ@mail.gmail.com>
Message-ID: <CAD=FV=XiaMAeTj24zg0bPfSK5hGCjuap0ZDa6ixAKrSUQgJtVQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/msm/gpu: Fix idle_work time
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 19, 2021 at 2:47 PM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> This was supposed to be a relative timer, not absolute.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/msm_gpu_devfreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
