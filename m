Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23EC322FAB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 18:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbhBWRcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 12:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbhBWRcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 12:32:01 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677F1C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 09:31:21 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id s107so16367986otb.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 09:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=8uFUfcDAGQuyiOOAUNMEu1W5IdifFS+X/i4/NHqgFv8=;
        b=p65W4AzofaCWLNPvk8TQ7TW//GqxIGLX3viSLR4pfTGrJQYowFMK4+Q4YLOGfd99IJ
         E+3RD0NF4G0aDwjqM+AI2rIeaRifBpMojw164J3z7sCMg9lSlHSQIblpnNZNBJjAP+jL
         wF954K25dDWdAbOryuNKDKHoZezCeivUeGxlGW/XjrLHQ6E2wkSF1oUkJHVV/RbajPVA
         xzhs2+bALYFExrzOjvb8jCcMzMC0cjDSAjjSgYsdcIsSu1hG4V1l0VBfMi62E9J7Rgz6
         MQ1rdrwp2wVnyZbSw2lREZsnkqJQLEEPARgPfdb6eAWOJy29yRILOjQfpzmoh4w7KfeC
         eZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=8uFUfcDAGQuyiOOAUNMEu1W5IdifFS+X/i4/NHqgFv8=;
        b=ThQVOVYrhicTqgEsZYbhk9FRRyEWmwiS8DTJ2w6d8JA0zuxrOthhbZdAhNv07Z6rjX
         KowhaKhf1Hy2Pafbfq9zftgYoYqNGBaYnqVxBu4Qx9q2O3GNIaoyngahZvSI3m3IFxEh
         n06ptqnow9Bcn8D4MU/65BexsiwOmCqWXnOHIMeKY2uhBjOX8fC2nbp+K+iqZWAJ+Poi
         5LIQnfoSXEspJRLUgvAIKLEvbaBJioQqnnn8aph9gE29jwSpOGb6FUSsoWb/GUy1PIEt
         WKqiV6E388tV3HMPeFnPE8JqZh7MFHo99iTgL+OPvWrec7Zg/y2v7tY6TBymssaDg7Wy
         dKaA==
X-Gm-Message-State: AOAM530XmrboQM/HLEVoqM7Hq4HRUJ1II/Pm2ext+BclrgEZD/PbpWcF
        wb2t7s2cO+zpNBvVJdu1i4U2JmQKHRzDgfrTgo8=
X-Google-Smtp-Source: ABdhPJwPuucHJsM2rLxL3mAp8wKOzrd6YftWru7XfVMFIQkiEc24Gyvo33iX5kVHKp8nm9sL1/QaaJuBJYPZrNL41wI=
X-Received: by 2002:a9d:760a:: with SMTP id k10mr21224821otl.23.1614101480861;
 Tue, 23 Feb 2021 09:31:20 -0800 (PST)
MIME-Version: 1.0
References: <20210209234817.55112-1-rikard.falkeborn@gmail.com>
 <e819cb08-98b6-c87d-4d95-338e06f88a48@amd.com> <YCPcIwxso67M3VqR@phenom.ffwll.local>
In-Reply-To: <YCPcIwxso67M3VqR@phenom.ffwll.local>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 23 Feb 2021 12:31:09 -0500
Message-ID: <CADnq5_PPeNxBSryxJbT1sX=n_m_3HxKtGk5QRxtczU9qdae3cw@mail.gmail.com>
Subject: Re: [PATCH 0/3] drm/ttm: constify static vm_operations_structs
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Alex Deucher <alexander.deucher@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Likun Gao <Likun.Gao@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        nouveau <nouveau@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 8:14 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Wed, Feb 10, 2021 at 08:45:56AM +0100, Christian K=C3=B6nig wrote:
> > Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com> for the se=
ries.
>
> Smash it into -misc?

@Christian Koenig did these ever land?  I don't see them in drm-misc.

Alex

> -Daniel
>
> >
> > Am 10.02.21 um 00:48 schrieb Rikard Falkeborn:
> > > Constify a few static vm_operations_struct that are never modified. T=
heir
> > > only usage is to assign their address to the vm_ops field in the
> > > vm_area_struct, which is a pointer to const vm_operations_struct. Mak=
e them
> > > const to allow the compiler to put them in read-only memory.
> > >
> > > With this series applied, all static struct vm_operations_struct in t=
he
> > > kernel tree are const.
> > >
> > > Rikard Falkeborn (3):
> > >    drm/amdgpu/ttm: constify static vm_operations_struct
> > >    drm/radeon/ttm: constify static vm_operations_struct
> > >    drm/nouveau/ttm: constify static vm_operations_struct
> > >
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
> > >   drivers/gpu/drm/nouveau/nouveau_ttm.c   | 2 +-
> > >   drivers/gpu/drm/radeon/radeon_ttm.c     | 2 +-
> > >   3 files changed, 3 insertions(+), 3 deletions(-)
> > >
> >
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
