Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 049F138B79A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 21:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239529AbhETTa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 15:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239841AbhETTaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 15:30:25 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E7FC0613CE;
        Thu, 20 May 2021 12:29:03 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso15916580ote.1;
        Thu, 20 May 2021 12:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4fQz3E7M09dHnT8r4F5QnQfFKZss577wKaQEpCbDtOM=;
        b=nUbCn/keUGZM2MN9ZviCD70uZR2tfctAWAxg9NkRdooySE3ikR4oSy2cfft9I5Kc5T
         UQgg/6GJzrEn9cL9TAqk4yNU9eZwJpriTvNG+FYFvchQhZ3Ae0tMvMQX0rQSkGPa+kDF
         0vCDNYRXLVcpzBVQsI1QS3FQuNO2z8Pu9lfh6LWgyOFqs4rO2AjYCzfJIKO/tGbup/U5
         QsLKbMh1NpGPlGZx8nqLtLgctXfvTcE7s7/WNWd4ODqGIoMnlbwweRchtWrkHzVTOWIL
         hidaYQr3fBgJkNDw5ocYzLgj0vneOTdbTnBNJb2SglSzOm6SHDNC96tiVazVZqO0qN3z
         bAlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4fQz3E7M09dHnT8r4F5QnQfFKZss577wKaQEpCbDtOM=;
        b=WxdxC+/O6GIhnytOJwu8a25P9ydkqKKbZJ0vjMhbL5GThacBLMrNVP5IVWVlw5bxTN
         OtZk2P6sh0p9OeFgWAakYxh02zlOam5w1CnncZwps4SMdQUJ5mW85f2hlXPzGgBibaCl
         fmh/YkBIQPz0x2Ze5tHo8nATk5br9IRvKLF0Xy1AeGD1TBWJpj5aYuqFIodPQByW2PcO
         leJptE4OCQHy8kC+mldO/ZWoNNFGYMGkoFF92DgfBQJiKJmexTo2z5jKWinzFBAQheQE
         CyuT3YrlEHvTQ2f3OTi5FdKxm1foQjZkE/2KlzlOa1lE1DpbVqsBMtHi1FsROqcDcaR3
         eA1g==
X-Gm-Message-State: AOAM5338byW7taJUMwuMWg4TK9D/tEIfd15YUo0JINDXLlSc5Dm+DAV3
        qSKRzykM4BLzyqCjUp/He0vfKaEggkfSKzgUfdc=
X-Google-Smtp-Source: ABdhPJxdfepUBcqlsCo+5kGey7uP00jgQgS3D+dTpQK6p4pByzdOPTLVy+qT1BuGsghVxFJQ4daDjgV9NZli/E2enq4=
X-Received: by 2002:a9d:74c6:: with SMTP id a6mr5166412otl.132.1621538943068;
 Thu, 20 May 2021 12:29:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210520134159.1665467-1-weiyongjun1@huawei.com>
In-Reply-To: <20210520134159.1665467-1-weiyongjun1@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 20 May 2021 15:28:52 -0400
Message-ID: <CADnq5_O-7r-zsRechjuy2NatJ=kRVnRiq5366RDdvMfbGB9u+g@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amdgpu: fix unused-but-set-variable warnings
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Leo Liu <leo.liu@amd.com>,
        James Zhu <James.Zhu@amd.com>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Hulk Robot <hulkci@huawei.com>,
        kernel-janitors@vger.kernel.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Thu, May 20, 2021 at 9:32 AM Wei Yongjun <weiyongjun1@huawei.com> wrote:
>
> GCC reports the following warnings with W=1:
>
> drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c:190:22: warning:
>  variable 'ring' set but not used [-Wunused-but-set-variable]
>   190 |  struct amdgpu_ring *ring;
>       |                      ^~~~
> drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c:162:22: warning:
>  variable 'ring' set but not used [-Wunused-but-set-variable]
>   162 |  struct amdgpu_ring *ring;
>       |                      ^~~~
> drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c:383:22: warning:
>  variable 'ring' set but not used [-Wunused-but-set-variable]
>   383 |  struct amdgpu_ring *ring;
>       |                      ^~~~
>
> Those variables are not really used, so remove them
> to fix the warnings.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 2 --
>  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 2 --
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c  | 3 ---
>  3 file changed, 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> index 938ef4ce5b76..af6f45c3f6fc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> @@ -187,14 +187,12 @@ static int jpeg_v2_5_hw_init(void *handle)
>  static int jpeg_v2_5_hw_fini(void *handle)
>  {
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -       struct amdgpu_ring *ring;
>         int i;
>
>         for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>                 if (adev->jpeg.harvest_config & (1 << i))
>                         continue;
>
> -               ring = &adev->jpeg.inst[i].ring_dec;
>                 if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
>                       RREG32_SOC15(JPEG, i, mmUVD_JRBC_STATUS))
>                         jpeg_v2_5_set_powergating_state(adev, AMD_PG_STATE_GATE);
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> index 94be35357f7d..b4d53d1a6123 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> @@ -159,9 +159,7 @@ static int jpeg_v3_0_hw_init(void *handle)
>  static int jpeg_v3_0_hw_fini(void *handle)
>  {
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -       struct amdgpu_ring *ring;
>
> -       ring = &adev->jpeg.inst->ring_dec;
>         if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
>               RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))
>                 jpeg_v3_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 946335d0f19c..d60358767d10 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -380,15 +380,12 @@ static int vcn_v3_0_hw_init(void *handle)
>  static int vcn_v3_0_hw_fini(void *handle)
>  {
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -       struct amdgpu_ring *ring;
>         int i;
>
>         for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>                 if (adev->vcn.harvest_config & (1 << i))
>                         continue;
>
> -               ring = &adev->vcn.inst[i].ring_dec;
> -
>                 if (!amdgpu_sriov_vf(adev)) {
>                         if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>                                         (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
