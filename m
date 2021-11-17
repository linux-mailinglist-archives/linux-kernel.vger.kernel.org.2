Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0364454F66
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 22:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239889AbhKQViL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 16:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236717AbhKQViJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 16:38:09 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA8CC061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 13:35:10 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id w6-20020a9d77c6000000b0055e804fa524so7143188otl.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 13:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fAbybk/45RMrbU0Skfo3o+U0FCBPe9DYKYw9nVsCH6w=;
        b=fKweHg3TLHziPsmWsqbhdDOV1FGG6kEzinrCY+1v3d9tspMmDzxj3Re/rzdnH3c/gw
         x9pIpqt1WHJFueNn31tXiqptzSZUGpJDSpQJ9G3pp54rarSptb9pUw9X6MhSGnkSWdnQ
         rDL5Wm5rFqCVWA5U+Sn6RBfoOpz9/vaNQp7zv9MMOp7M5c8yknsqNwm6zZioW9yqGTos
         XszLFSkdrl4t2yAad8UQx9nJGq8umisWu5dXG7nmCq7xVyXYLmK2qUCAjxBLSa96lWFC
         hrUaVh8Nqq2di0f3SxcDismOoq1iShPhnzCdHl1KF9DgKLSSFXe5ovyAfpkiU86FIKBS
         EwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fAbybk/45RMrbU0Skfo3o+U0FCBPe9DYKYw9nVsCH6w=;
        b=VMEXbfPNVmYSwhs4cVDf55mjCwgU9hi+Ku/Pd3eBsUBWX7EIylUERMD98I4p2AtTyN
         xxOWQIt/UQxF+hXJLWdYFjOOUPqmp717zu6aWSANoti6hp0l/zS5REgmNx/StrZk/vyJ
         F6kFobMA0SvHSmbTNMp7IpEi/23nJTb7wxzCnv8Le3WtroJY+n8u/gcXezzPxP1zrtVj
         PuDDxK8HPO/dOHk+Ba2LJVAYC9FHjQkiMuRDVxRdOTwKDdXnBYSTL/h01S/uFbCnBfkR
         YsBRjbFfGWOnzl/0Q1Ag3bjbV0RNOXWBLfrtbiifo2K/RYYgnUTPOY4UhUMhJk6HtsJV
         MjTQ==
X-Gm-Message-State: AOAM532aayuhyh37WeCCkhzKtkB71tSFAGWzBnQPNs3UOUdmcznDzdKE
        fQAeV4DT8t4jY3fEwgvciRfv0pe0nYvrQGNwwLs=
X-Google-Smtp-Source: ABdhPJzLmY8A8e/jlVJOZ7Zqz1RE/BWM17Kiian6tAwIVuY3frrTFqQLE7tb8ywG727pwGLElJ+afw1NKr2g5kdMgss=
X-Received: by 2002:a9d:67c1:: with SMTP id c1mr17029494otn.299.1637184909532;
 Wed, 17 Nov 2021 13:35:09 -0800 (PST)
MIME-Version: 1.0
References: <20211115025901.2598-1-bernard@vivo.com> <50ed4525-dbe6-1eac-5b83-4233a18a6176@amd.com>
In-Reply-To: <50ed4525-dbe6-1eac-5b83-4233a18a6176@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 17 Nov 2021 16:34:58 -0500
Message-ID: <CADnq5_NhZD7LLiGPDUOGZ60niANZjw6OEVJie_Otkpf0S-_2PA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: fix potential memleak
To:     Felix Kuehling <felix.kuehling@amd.com>
Cc:     Bernard Zhao <bernard@vivo.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        John Clements <john.clements@amd.com>,
        Jonathan Kim <jonathan.kim@amd.com>,
        Kevin Wang <kevin1.wang@amd.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        Evan Quan <evan.quan@amd.com>, shaoyunl <shaoyun.liu@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Nov 15, 2021 at 10:56 AM Felix Kuehling <felix.kuehling@amd.com> wrote:
>
> Am 2021-11-14 um 9:58 p.m. schrieb Bernard Zhao:
> > In function amdgpu_get_xgmi_hive, when kobject_init_and_add failed
> > There is a potential memleak if not call kobject_put.
> >
> > Signed-off-by: Bernard Zhao <bernard@vivo.com>
>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> > index 0fad2bf854ae..567df2db23ac 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> > @@ -386,6 +386,7 @@ struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev)
> >                       "%s", "xgmi_hive_info");
> >       if (ret) {
> >               dev_err(adev->dev, "XGMI: failed initializing kobject for xgmi hive\n");
> > +             kobject_put(&hive->kobj);
> >               kfree(hive);
> >               hive = NULL;
> >               goto pro_end;
