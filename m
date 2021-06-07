Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883D539DDEB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 15:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbhFGNoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 09:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbhFGNoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 09:44:54 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EC0C061766
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 06:42:52 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id t40so5058093oiw.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 06:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PBl1oQb0REvQQKwpKMpTQoTdXm5nunxZT4Ar8PjX/i4=;
        b=APbMb91gD1zIPIZTawQsDQLPOx+rb2op11WQRTpSn+xBFsVowr7scb7WdSPA9hWZUJ
         AC3VYMUhRCmedN6If9GhtwC5ZFepZqexOxHytKONlL57LU+YqPMVe9JDo76vt/rCiSlp
         CISlolqHTQk5Cp5lXyaOOYYWvKUziDDRZjPuNqB1kBGJAS2RsIgBk2peV+42ra2UrUtQ
         ald8PqhSl2dM3avyYWumR/QZAxFySDdVsO4oymrNMw2G3RPfo+17GEO2vynXMaY1Dbs9
         eBdxr8vFkVqYhcjNXLIaf1HuVgHtOz6qmoNKVQ0fmcBIbKGQeEXA9py239srn67H+ntB
         7yRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PBl1oQb0REvQQKwpKMpTQoTdXm5nunxZT4Ar8PjX/i4=;
        b=dj/kBpPpa7qKInuXKF+O8L+FXgrR0KV8WClBQgc7PHh7gl0jTf1hQ0nRNwZg2noYhX
         FcUGk58/VRe+WboQdFpTjQhtLgM1GO3kFrbl+4RFlsXvoqYkD9fWYsIgGQX3QltASMrX
         KkMdF9NZPtPJQCTRGYbBu/rtQH+ajcJuAXag28kU+cdy17NZ1P7sD9md2ybHKKzMhkGb
         V7oy9zbuFM2n/h6QIMwAobTh3atrMTq6Q+cxp3lPg+UfIHnldmY8WwRTsM8RumMbR7eE
         qEQckoXeWTJsnxNU+En1mxJ6Cy+4bJK6wJ68SIK9F53nyDk4oP50ZGl6ZrjPxkYetrEG
         dJqg==
X-Gm-Message-State: AOAM532zrbE933BNoEWbSIEnCVZUz41aGZS3Gb6tAz8Et3Cx6c8yubb7
        zTz+yY+4NEjxk0J0yArIR3kS5tNGrsFvcW207O07P6hC
X-Google-Smtp-Source: ABdhPJyJai1JHNwwk+/qjkmNo3l3kzPLjZMtG9Ot8j4cMwfxFgwzzQTR0Mg4g027PYF+cdH5DFhuKuTjlhKOBZkQvTE=
X-Received: by 2002:a05:6808:c3:: with SMTP id t3mr2097628oic.5.1623073370050;
 Mon, 07 Jun 2021 06:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <1623068820-2479-1-git-send-email-yangtiezhu@loongson.cn> <0d1b517f-797f-e87d-4edd-8474b16993ed@amd.com>
In-Reply-To: <0d1b517f-797f-e87d-4edd-8474b16993ed@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Jun 2021 09:42:39 -0400
Message-ID: <CADnq5_PvZRu0h60dn-=4v0aXBOaNy=s0KjmeuSndDzU3C8qFog@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Always call radeon_suspend_kms() in radeon_pci_shutdown()
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 7, 2021 at 8:30 AM Christian K=C3=B6nig <christian.koenig@amd.c=
om> wrote:
>
> Am 07.06.21 um 14:27 schrieb Tiezhu Yang:
> > radeon_suspend_kms() puts the hw in the suspend state (all asics),
> > it should always call radeon_suspend_kms() in radeon_pci_shutdown(),
> > this is a normal cleanup process to avoid more operations on radeon,
> > just remove #ifdef CONFIG_PPC64 and the related comments.
>
> Well NAK.
>
> Alex knows more about the details but suspending should not be part of
> the pci shotdown process at all.
>
> We just add that here to enforce a GPU reset on PPC64 boards for some
> reason.

Everything in the comment still applies.

Alex

>
> Regards,
> Christian.
>
> >
> > Co-developed-by: Jianmin Lv <lvjianmin@loongson.cn>
> > Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > ---
> >   drivers/gpu/drm/radeon/radeon_drv.c | 9 ---------
> >   1 file changed, 9 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/rade=
on/radeon_drv.c
> > index efeb115..0b1f43d 100644
> > --- a/drivers/gpu/drm/radeon/radeon_drv.c
> > +++ b/drivers/gpu/drm/radeon/radeon_drv.c
> > @@ -386,16 +386,7 @@ radeon_pci_shutdown(struct pci_dev *pdev)
> >       if (radeon_device_is_virtual())
> >               radeon_pci_remove(pdev);
> >
> > -#ifdef CONFIG_PPC64
> > -     /*
> > -      * Some adapters need to be suspended before a
> > -      * shutdown occurs in order to prevent an error
> > -      * during kexec.
> > -      * Make this power specific becauase it breaks
> > -      * some non-power boards.
> > -      */
> >       radeon_suspend_kms(pci_get_drvdata(pdev), true, true, false);
> > -#endif
> >   }
> >
> >   static int radeon_pmops_suspend(struct device *dev)
>
