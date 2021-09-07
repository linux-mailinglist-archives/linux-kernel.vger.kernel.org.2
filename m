Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8714402D54
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 18:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345367AbhIGRAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 13:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbhIGRAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 13:00:20 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACABC061575;
        Tue,  7 Sep 2021 09:59:13 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id b5-20020a4ac285000000b0029038344c3dso3120128ooq.8;
        Tue, 07 Sep 2021 09:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yGhlEcWAmkOIUP0KcWj+kobRkgQf1kC9BN+bCXhgInU=;
        b=nlLEhmuIw37kyWO+W+izNA5oEpC//ZXt13F33/D9ZojjKBXu73jbv61UPIGkmMgC0Q
         cqi/3dW9asI+eDILJr4YhiagPZRYuvXqJBQaGqDuw13uX5tZjt5Yotki/TL+OGsKV0WZ
         PdHoZtrACfkVJXMmm3NyxzI6yE2TzHF+RSaCXPpHoObGjlJw5sL1aF3gFqRhX9Hf55cr
         eGBb+pO4tUabBBFmO7F5jaHGVzhj+4KgykGgEBLWghNS5E8XpNROulgLRXRv3HM5RwUR
         0PANTYfuyEEh+VfW95UX8p93dEnGnb+JQm8tVRLliu5Gg06/pZC7tz+i7RXXZGgYXelH
         XLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yGhlEcWAmkOIUP0KcWj+kobRkgQf1kC9BN+bCXhgInU=;
        b=IqrLWKTTxcIl5MA5M6bip8OQ138JYBsglDcYUu9L3czg1+hT/eYLB8MfRUaRmiqZxu
         7XY0ypriTJxQMepeUu8hUwhLZM3jW7ybBhhBsmlmFBZ02UnRKeRHK/yBd1/B9aT1V1J4
         BRuLxtdNzHgQqgOJiZaoTSjA5eunN1TebVpHx1DJzcL/1f1SRo28Ptefn6ERuQ7YT0gN
         yjaS6GJRZ7k8HOYyP/WQwChbcHXA7ikCutVUm7n941A9MmR6EaqysZKwUfOzLv03wIwx
         gLAR3hE5L0KR4qQPlBFJgdlmNFkN7BtW8idUPsiSMExO8dOfsVBg64GdgS25Gp3fxBqX
         O0wQ==
X-Gm-Message-State: AOAM532xDJ7NtiqUqfs6QoIPCpBv3m0cVUZgvxzUXR+W1vx1B8UTNELG
        oepK6UeaP+KVolO7dtwb710i1FQxsOtEfgMv+XA=
X-Google-Smtp-Source: ABdhPJztexkmO6F4hC0uTaplz22vYnXIkvWMVIv6HMvkULpmAknxRcB9k8FShKGIQZf3yT5nYu9/1rtbZGwuoyMMmrA=
X-Received: by 2002:a4a:d794:: with SMTP id c20mr692176oou.23.1631033953123;
 Tue, 07 Sep 2021 09:59:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210902215127.55330-1-colin.king@canonical.com> <bb5105f8-2ec6-e494-8764-3dcc5fc0681b@amd.com>
In-Reply-To: <bb5105f8-2ec6-e494-8764-3dcc5fc0681b@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 7 Sep 2021 12:59:02 -0400
Message-ID: <CADnq5_Psv9HG5C=9OwaXY64uRLnmJ4NjnsbviG6zwvpdmuNcRA@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amdgpu: sdma: clean up identation
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Colin King <colin.king@canonical.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Fri, Sep 3, 2021 at 2:31 AM Christian K=C3=B6nig <christian.koenig@amd.c=
om> wrote:
>
> Am 02.09.21 um 23:51 schrieb Colin King:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > There is a statement that is indented incorrectly. Clean it up.
> >
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v5_2.c
> > index 779f5c911e11..e4a96e7e386d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > @@ -375,10 +375,10 @@ static void sdma_v5_2_ring_emit_ib(struct amdgpu_=
ring *ring,
> >    */
> >   static void sdma_v5_2_ring_emit_mem_sync(struct amdgpu_ring *ring)
> >   {
> > -    uint32_t gcr_cntl =3D
> > -                 SDMA_GCR_GL2_INV | SDMA_GCR_GL2_WB | SDMA_GCR_GLM_INV=
 |
> > -                     SDMA_GCR_GL1_INV | SDMA_GCR_GLV_INV | SDMA_GCR_GL=
K_INV |
> > -                     SDMA_GCR_GLI_INV(1);
> > +     uint32_t gcr_cntl =3D SDMA_GCR_GL2_INV | SDMA_GCR_GL2_WB |
> > +                         SDMA_GCR_GLM_INV | SDMA_GCR_GL1_INV |
> > +                         SDMA_GCR_GLV_INV | SDMA_GCR_GLK_INV |
> > +                         SDMA_GCR_GLI_INV(1);
> >
> >       /* flush entire cache L0/L1/L2, this can be optimized by performa=
nce requirement */
> >       amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_GCR_REQ));
>
