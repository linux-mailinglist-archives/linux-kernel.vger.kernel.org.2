Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E058C36E0AE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 23:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhD1VGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 17:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbhD1VGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 17:06:22 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9B9C06138A
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 14:05:37 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id r3so11010822oic.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 14:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o07/SUP4nzTl7XpZrZovn23mJDrYGsbElp62JCCkl+8=;
        b=oOwjNi4PRlBN6zzbtPBk9m482gM8fQiCuxCLR+vZ+CpzqMC6SM6KWezfy861ad91aP
         QFwHDA0agQwjx1DQ1vUOlu52yXic9kUbvDXEj/20G8qC2rdAOFVUdxB4jTB0udVp5sq+
         6m89LmpCoRUQJErCIY8TOOgxyLrUyqpcHCthR4mCEvclgGdOhdHyKVlV/S5OF8bV4J7A
         eJ6uE1++3hMXb7y3QwcebMZ9pZbQqm1B7VIEr8y6AcA7SxcksoexGYTVuXM0sd0JhF43
         EANnJdpiwcSB0NNOdAT2XXUwuugkX5iMAjpBubVJ1on/iZPcT/a6YCyI1rhUnLmI5avN
         VENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o07/SUP4nzTl7XpZrZovn23mJDrYGsbElp62JCCkl+8=;
        b=haRsBvmwVvpf4YuxCFZqRzddITXMWIXdtu6CyjEdMaa3XnvuvdeVD+Id78fIrhepeK
         8IMnEviVAhZB8364JRW77RIKIIgdXGSsdpbkZAEvwhVBpem/XBtb42dyJmgWFh/dxZap
         kBgZCzzmC/Bfmvf99bG4eZiU3Wj9gx53R1vLW8Yab6qlvPDqGnO7MDcm1JU5jTR0Pcxj
         BqdCFiIvB8yqSynfV7V3+ZKMGuK4DVoFkxT/1nD1FzyMDtX9DdVkADiYjGGhmwJweB/h
         AcqQB6tU6V+OH0rx5c3+MFZl7w3LdZRG9+RnHCxGUjMC0stPdaSUJuOB1CvT8Ptieemk
         zP1w==
X-Gm-Message-State: AOAM530XtiAQJ3CIgyG00z68PNRpMnznYhMdCHA2WanTD7QCxxjnSJYe
        BRdPh7PclVZR/uAkFK3fa6F4NB+Ot+DQNPJDibM=
X-Google-Smtp-Source: ABdhPJwDRHC7njHgsCqGzKsRnlmiqZnfbbVG4islV97MSBRa6zvDEeMKPddGJLm0QrK2IEHLWiubxCcpGi8sz0IBs+Q=
X-Received: by 2002:aca:4a4e:: with SMTP id x75mr13391186oia.123.1619643936647;
 Wed, 28 Apr 2021 14:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <1619211404-5022-1-git-send-email-jrdr.linux@gmail.com>
In-Reply-To: <1619211404-5022-1-git-send-email-jrdr.linux@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 28 Apr 2021 17:05:25 -0400
Message-ID: <CADnq5_Nhc=SUfuL7ibNTiw677sAnm9Dva-sj0PUwBnO6JXfGuQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove condition which is always set to True
To:     Souptick Joarder <jrdr.linux@gmail.com>,
        Harry Wentland <hwentlan@amd.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Lipski, Mikita" <mikita.lipski@amd.com>,
        Eryk Brol <eryk.brol@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
        Stylon Wang <stylon.wang@amd.com>,
        Wayne Lin <Wayne.Lin@amd.com>, Nirmoy Das <nirmoy.das@amd.com>,
        Bhanuprakash Modem <bhanuprakash.modem@intel.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 4:57 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> Kernel test robot throws below warning ->
>
> >> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:3015:53:
> >> warning: address of 'aconnector->mst_port->mst_mgr' will always
> >> evaluate to 'true' [-Wpointer-bool-conversion]
>                            if (!(aconnector->port &&
> &aconnector->mst_port->mst_mgr))
>                                                   ~~
> ~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
>
> Remove the condition which is always set to True.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> index 9a13f47..8f7df11 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> @@ -3012,7 +3012,7 @@ static int trigger_hpd_mst_set(void *data, u64 val)
>                         if (!aconnector->dc_link)
>                                 continue;
>
> -                       if (!(aconnector->port && &aconnector->mst_port->mst_mgr))
> +                       if (!aconnector->port)

@Harry Wentland any idea what this is supposed to be checking for?

Alex


>                                 continue;
>
>                         link = aconnector->dc_link;
> --
> 1.9.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
