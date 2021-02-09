Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484B9315992
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 23:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbhBIWeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 17:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbhBITnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 14:43:08 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6102AC061A31
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 11:42:07 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id o12so18532528ote.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 11:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iIXI5cwCPG4jYC5gF0Gmq9cATGqxVntBOzHncU3t7tE=;
        b=TLf5KsxTI1BJBzl/ZWallpRTaNDOdA01qtwpLejJgNfsvmMLvgnIzouPp4EjPhFR/g
         FSouBQpXh8+ikgMawIBpgKvcVlk2UuEkABK2TJWKpfQm4DLIrURzGlwkyIb/vvUGZdIh
         PS/5P3EhlxvRGQIIj73LF8z3y1+GJ4valW3jgvnN81D92ILHYRQ9IIA3CAHtkQpuR9d4
         YahI8eS2UVlx8e5JREnt/YfhA5Y794L/m5eqXJrE6Me1UPRvMBlwVaKWHHt47514Vo1M
         EQcfzpEyYdmmnP5Rg0bficRPfLRc5QrljWa7n3grS5ovQWib6Te3cm5GSc4Scpz8bZNZ
         eewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iIXI5cwCPG4jYC5gF0Gmq9cATGqxVntBOzHncU3t7tE=;
        b=fSbVwW6mWZaDp4FsZrGAOLf3MOFfDU3BnMp1kxbjATPOn4+kEmj7Xyf+ghVl89Lxub
         B0TqrL6S7u1XVte9eeZ91ObXNM/lGpVjOjBft0DstiJst/x9biDymfMOtkN1Zx97IQhy
         32XRAdVBlGSBQ65nKtOTGh1HOQU2oPY3wN8jQUQlPjw7lFd2jSrToFItXUZowvSALBW2
         qBUryyXlh2kQapEBnR9pxwMhyFiPgsaVfcbeY/WYFS+1te4gH/E1F56OC6CwxUobq8I4
         0YNTBTqZcdhjqqR5pfOeeP6CxnotUbQl6G+TTmvPxDuYPs0TVKY/9PXAZGHpsTlNASm9
         ppVA==
X-Gm-Message-State: AOAM530G+iQffODgluePqLTuF2VQWfLtZ8kjUdhfiEjLIEILT7scyT6m
        fH/upv31BRrQmdGlQ+IX33in6sdvPY2Kfn/ppAk=
X-Google-Smtp-Source: ABdhPJxe/LbNTDwz6oVoyO1velECOYaLooQth4WxT9G2lnxcCf8k4s9YX8aMa9AupKhej92nv+x3xyBrWRnU26DhHT0=
X-Received: by 2002:a9d:6003:: with SMTP id h3mr10447185otj.23.1612899726866;
 Tue, 09 Feb 2021 11:42:06 -0800 (PST)
MIME-Version: 1.0
References: <1612779458-70938-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1612779458-70938-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 9 Feb 2021 14:41:55 -0500
Message-ID: <CADnq5_MBY3nx+RmzgigfbBQ05KLRq6UHyCW0eoqfNQRAwd6g_A@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Simplify bool comparison
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Feb 8, 2021 at 5:17 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Fix the following coccicheck warning:
>
> ./drivers/gpu/drm/radeon/rs690.c:190:6-35: WARNING: Comparison to bool.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/radeon/rs690.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/rs690.c b/drivers/gpu/drm/radeon/rs690.c
> index c296f94..7bc302a 100644
> --- a/drivers/gpu/drm/radeon/rs690.c
> +++ b/drivers/gpu/drm/radeon/rs690.c
> @@ -187,7 +187,7 @@ static void rs690_mc_init(struct radeon_device *rdev)
>                 /* FastFB shall be used with UMA memory. Here it is simply disabled when sideport
>                  * memory is present.
>                  */
> -               if (rdev->mc.igp_sideport_enabled == false && radeon_fastfb == 1) {
> +               if (!rdev->mc.igp_sideport_enabled && radeon_fastfb == 1) {
>                         DRM_INFO("Direct mapping: aper base at 0x%llx, replaced by direct mapping base 0x%llx.\n",
>                                         (unsigned long long)rdev->mc.aper_base, k8_addr);
>                         rdev->mc.aper_base = (resource_size_t)k8_addr;
> --
> 1.8.3.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
