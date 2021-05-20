Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44C7038B78A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 21:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238488AbhETT20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 15:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234538AbhETT2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 15:28:25 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41DDC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:27:02 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so15876430otg.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=R+7fnEf5+D7P9bpLMhivSuEMA6+dJMHLKzG/8S3WGrk=;
        b=nEhTq9xZXBPLnP+28MBTDWiVpvaDNpWS2ZczCd0MemXJVUJDan/EB/QsRfKAVgHtqk
         9nedqwj7u2ThftbxV3kJpB9OW8gj97IZqSFADRpdpIzl9HLYGeXI4dxnSvPPv2mSjEIw
         0Skpj/hMdFgEXs/rps5GO5c17N/bDNgorozvQVsNP6BT52pdghhkTLuFRiU1fNlvultR
         m6UPNyKCBP5ybL7fSglsonYILWwqbEcxt4bC2xslsC3YUeaNHWtoRwJCZSZBpyHTVqtb
         ILeKIYMHcxzh3G2SsDba2+szf1x8008VtB6zbIi7eIndnVQmP6qEUWbe0JAKbJpChE1R
         KGWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R+7fnEf5+D7P9bpLMhivSuEMA6+dJMHLKzG/8S3WGrk=;
        b=jPm+myx/ovuhGNdOwEJ/mzB2Qco+/P66G22nxjvr251o2CoiYvTXrU2d+zTJaNb4ms
         60tq4cMGcRkJAepagpmIO2yUelU8w3YmLK1sJR+6xERud5R9fqRiLroElVdfttwr3XRS
         m93YQw2P6TET9qlfWEJrWqt1w8EBx1VRzqL3TbF9GbggkZwjGI0Vj+sluGCVw9K64QiM
         NYDKmUa4aqxup+hzM7zH8ci60tCGN4k3rUw41zEMl+GiB/Ls+lClhQNCi46U9/tebimW
         oHnGWaEnBM3K0FGFIJNnGJJj8/dejTcJg/bYTED8PYwc4nkKFJPlIQfFNGR2H421P1R5
         lhPQ==
X-Gm-Message-State: AOAM5338jKEgnmxkaVXjGou7YybEZKQ/n7F4Sq/I4X3Ts96XDiinEbX3
        cV2J77H2MaTxgbkD3PFLehJoa9kXBJ4CJn6U47k=
X-Google-Smtp-Source: ABdhPJwoiZrUETM2yFPXjegPd7djCrTKyeTo6WbivlDrp6LYzG0wufjvHh04Km1QUNibBmSLKIy7aZ+maj5RPBkeb/I=
X-Received: by 2002:a9d:74c6:: with SMTP id a6mr5162050otl.132.1621538822372;
 Thu, 20 May 2021 12:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210520120248.3464013-1-lee.jones@linaro.org> <20210520120248.3464013-39-lee.jones@linaro.org>
In-Reply-To: <20210520120248.3464013-39-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 20 May 2021 15:26:51 -0400
Message-ID: <CADnq5_NLnfGYuoz8+1z=q1Y90Re_XCkDHREoMZW2so0gk-hwwA@mail.gmail.com>
Subject: Re: [PATCH 38/38] drm/amd/amdgpu/smuio_v13_0: Realign
 'smuio_v13_0_is_host_gpu_xgmi_supported()' header
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Thu, May 20, 2021 at 8:03 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c:99: warning: expecting prototyp=
e for smuio_v13_0_supports_host_gpu_xgmi(). Prototype was for smuio_v13_0_i=
s_host_gpu_xgmi_supported() instead
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c b/drivers/gpu/drm/a=
md/amdgpu/smuio_v13_0.c
> index 3c47c94846d6d..39b7c206770f6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c
> @@ -106,7 +106,7 @@ static u32 smuio_v13_0_get_socket_id(struct amdgpu_de=
vice *adev)
>  }
>
>  /**
> - * smuio_v13_0_supports_host_gpu_xgmi - detect xgmi interface between cp=
u and gpu/s.
> + * smuio_v13_0_is_host_gpu_xgmi_supported - detect xgmi interface betwee=
n cpu and gpu/s.
>   *
>   * @adev: amdgpu device pointer
>   *
> --
> 2.31.1
>
