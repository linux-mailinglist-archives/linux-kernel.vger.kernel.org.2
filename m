Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECEB4469A3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 21:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbhKEU2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 16:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbhKEU2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 16:28:54 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D44C061205
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 13:26:14 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id q203so11943899iod.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 13:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uw0GAODwRueFvBOQE2OGWsggM53Zcuqt3yCcWbHWgkA=;
        b=ZDCN/m0tmqnKaMhe26FXs3xZ5Si8fvJfzleOAKObY1a/TB05o9H4RU9PduYZUA8Ri/
         bRLZ77CghW64RM1dj3p2bmSYjZU4v6wqLhkQcNTMlCTsLe5+9QXsX3dRNmrdyjFIUm27
         ngqeVF/UcylsMcCudABfAf4UBFkDA06ibJIaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uw0GAODwRueFvBOQE2OGWsggM53Zcuqt3yCcWbHWgkA=;
        b=NXUpWGFmhbeGUr/4BnjU6unKaNYMkCfggllW7A1qF/ALzcitSggljvR2NThUxTHoXB
         lQgH/WJy9cXqhmmIWaSVLcIarT57jbanVEsdxneZdtzxHkyOwnI0MtXDsiFly+ayO0Xu
         dXCjevcOTxHLtg4h/TvT4RAxXNgxu/or2VhTuhOMqBrMNs8N7Vfd3qKEKpUY4ug3p5fF
         M3WmwS+ioN1wpJb69ARnIIJwCNikZdYvMLI4plpbDVarBOt/QivzLKEYAJfoB/k9mm6+
         sNsQE6ixuoXoZhdAWAYO/IhV0izxaaRYIIhKa+uz7YS04sdaFUZpBaOyn7qa4llk5Wm2
         ci3g==
X-Gm-Message-State: AOAM532qrZ190iqoHurr0VXDMEiUKF86VRLltWnN/WLOYEbf2jj71fR4
        hv2re4t6er897cRXLfQi8bgCGzilOHykbw==
X-Google-Smtp-Source: ABdhPJy1YkbBVnHPQkw8p8yvonZL9WCvRcnKKaPaHxEzrMEpTGU5VtWXkpt4CjHMmTm7xNVSnXUp4g==
X-Received: by 2002:a05:6602:14cd:: with SMTP id b13mr1132369iow.17.1636143973384;
        Fri, 05 Nov 2021 13:26:13 -0700 (PDT)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com. [209.85.166.44])
        by smtp.gmail.com with ESMTPSA id t14sm5941733ilu.63.2021.11.05.13.26.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Nov 2021 13:26:12 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id f9so11937812ioo.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 13:26:12 -0700 (PDT)
X-Received: by 2002:a05:6602:24da:: with SMTP id h26mr1098936ioe.168.1636143971873;
 Fri, 05 Nov 2021 13:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <20211105202021.181092-1-robdclark@gmail.com>
In-Reply-To: <20211105202021.181092-1-robdclark@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 5 Nov 2021 13:26:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wz0bDNUVdbsjsPv-CU-4WF1ngXT5tODSRpG9qtUqs70w@mail.gmail.com>
Message-ID: <CAD=FV=Wz0bDNUVdbsjsPv-CU-4WF1ngXT5tODSRpG9qtUqs70w@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm/devfreq: Fix OPP refcnt leak
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        Steev Klimaszewski <steev@kali.org>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 5, 2021 at 1:15 PM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> Reported-by: Douglas Anderson <dianders@chromium.org>
> Fixes: 9bc95570175a ("drm/msm: Devfreq tuning")
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/msm_gpu_devfreq.c | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
