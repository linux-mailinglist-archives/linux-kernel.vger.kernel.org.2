Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3339033C58D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 19:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhCOS0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 14:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbhCOS0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 14:26:06 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160E3C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 11:26:06 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id p24so7431176ota.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 11:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YsO66aKCLruG+OQDzYO3UaHdDnPWEUf3gpDAl+0qUto=;
        b=H3h8N00QtJBq6aCINRl2EmY80P2fXpk1NSs4P2th2wZyJLtIUcDiJy4k4Uge7GxCkF
         LFfLkL93r8trVbjfB7e6LOPG8fcNdZmjDc1sPCZBFQqVgED0PAXDYXCsATgJAXhxmlCG
         NM5+kIxQgEBuORUv/GLo/9XjsXP3nri8OdjYdAddjbR+qJLgb3XMsnEXzj/ZFJzKXpPb
         HQL8yEiN+D3YS2eNQwgMJYPF52K2Yp7mmlPfOFgusDiYHpX5ZmrUWGs3PXbWrL+8Q8Yf
         OVNNn6iLRlBKvuSa+my2Tsx0Lq2Byy9Eg6GPKSVipyjlFvGHBafP/Z+qegao1pjcbz8L
         JQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YsO66aKCLruG+OQDzYO3UaHdDnPWEUf3gpDAl+0qUto=;
        b=NgTXADrqaC6C2P/bbk2Qa2SE8/IM7qaf06z9lrMetmt/EHrDVkNd/Xse6CvTWPXqlV
         YGIpwa5kzpzQZHK5/adw2gBA93xXtFl1Q2fr56WPxdk71fv7vduvcidCdR1JI/j+dRit
         EZclOatNGdfXBY9bzU4OKvOOHaF4bA2oSOOuh2y7lc+cFs3XcP7uOTXQMdnl4L+RNREJ
         dnC7kR+m8TkCW2F4fgJdH5wHVarVhHUuSNx0lEnK8n3gFqMDrMPKhEYgKYjkGtgPa3oE
         wtxxUSAxhGOBTLXvHmNZfioEewqnmavYPSZ1wEjfuGUUdMWVE9rZfaKQHwbysPm/f+PN
         DH1g==
X-Gm-Message-State: AOAM531QZ7lc0aKh6lkmMN2Lup9tjBz5gpt1DOo4xv+tF8ygmfgc9K8+
        22AaPSDoIDNHQMR5eJE00upug5rGyT0h1pR9Q5s=
X-Google-Smtp-Source: ABdhPJyUsTSW+BdKCvvTEcH5LcoX2K3PQpaJSRRXDSD8bvVou3k3bo3Hoj1OOOnXWMdVMMVSkGuKYBfmEdyyeBKg/vQ=
X-Received: by 2002:a9d:20c3:: with SMTP id x61mr324341ota.311.1615832765510;
 Mon, 15 Mar 2021 11:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210315032136.3669883-1-unixbhaskar@gmail.com>
In-Reply-To: <20210315032136.3669883-1-unixbhaskar@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 15 Mar 2021 14:25:54 -0400
Message-ID: <CADnq5_Mu=WrBZURETB_+7R=sStY6-vNN9OQ5B8whDTwsuk2tdQ@mail.gmail.com>
Subject: Re: [PATCH V2] drm: amd: pm: Mundane typo fixes in the file amdgpu_pm.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Quan, Evan" <evan.quan@amd.com>, Nirmoy Das <nirmoy.das@amd.com>,
        Kevin Wang <kevin1.wang@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, 2021 at 11:22 PM Bhaskar Chowdhury
<unixbhaskar@gmail.com> wrote:
>
>
> s/"an minimum"/"a minimum"/
> s/"an maxmum"/"a maximum"/
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Applied.  Thanks!

Alex

> ---
>  Changes from V1:
>   Randy's suggestion to adjust the subject line text
>   And missed out a spell too,which now included
>
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 5fa65f191a37..308249ae1a22 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -3315,9 +3315,9 @@ static ssize_t amdgpu_hwmon_show_mclk_label(struct device *dev,
>   *
>   * - pwm1_max: pulse width modulation fan control maximum level (255)
>   *
> - * - fan1_min: an minimum value Unit: revolution/min (RPM)
> + * - fan1_min: a minimum value Unit: revolution/min (RPM)
>   *
> - * - fan1_max: an maxmum value Unit: revolution/max (RPM)
> + * - fan1_max: a maximum value Unit: revolution/max (RPM)
>   *
>   * - fan1_input: fan speed in RPM
>   *
> --
> 2.30.2
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
