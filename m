Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229BE3925B1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 05:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbhE0D6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 23:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbhE0D6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 23:58:01 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3164AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 20:56:29 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id y76so3815236oia.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 20:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m0jJCLmOTTk7R3I0dOOysXS/9UkIHt3JyqhG11vxOu8=;
        b=bhVAq5i/UwQ3hdFM6/4lFFKrEsLKys4PeBECdlxkFDsGZSH9uR5zIou5Hn48fGzrIE
         cdZRNIdiIJC79QcCtMHLoRsPfKzl3BGxraNIpTDD0JDqiUifLKCkrFoouE+Mqoa0RqKd
         TXxZigAH0zfBwsHG72QOJQzWqM04RIEWixdApmY87iWanX837uR96/2chzsRLRa4mEKq
         FjsetMfTlcqHk30WCuWfqvM2W07ZeDWBw6apDAUlz3M33WfCS8s57PJVtnWQiCagAJ0v
         8DdJOxFaNVdDuwoI72sffvFNR6dv7xECjeBuqyq7+C2HvS+KQ8UNStrnkVean1pJPCL0
         kW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m0jJCLmOTTk7R3I0dOOysXS/9UkIHt3JyqhG11vxOu8=;
        b=PFCHMRiWlRCpu2LlwS35WDlz09+XzNwG7Hslat1o1O6iIiDIZQdMrKha43c1KQ5ZcP
         zk0XrsYeyZsBQbDKvZrEf/vKmRKaOStrnZwc67sfSA12VKmtrZU0mdxJWHWqXK1WdUx/
         QURbOc6dRie1s52wRL6G+orPcyI6ncm8SArKLogkxolKCiQHk9xJ4NCVlaGZ787bekJ1
         YxaLLxPCQb3CGRuLupaxOAP6J/T/DvuIEzESRNkrol+e+RyXViYk+7VUQj1b15V6qx93
         RVhWpYYfSKulmYTUUHk0PuA8X3pMaVu6Gblz2BrFZ2mSvjQz/nxHhiPo4/tTm1RH6WK4
         +K7g==
X-Gm-Message-State: AOAM533+DkJmMqtgymQUiWw9FfmYgIds7fPvm0rZHLejVZICqAYpeGZz
        5NN1MAZhMSMXqG6bU6B1zyNRvd+sEPF3Sp2vLtU=
X-Google-Smtp-Source: ABdhPJxdi3Mn6amONheYLR4VwqBYJHZISa2gtEudSqMqeC7zJHQsy0+SZo4vA8m8fcUpIEww3nOPrh/0Ukq0UoxZKYM=
X-Received: by 2002:a05:6808:206:: with SMTP id l6mr3994650oie.5.1622087788663;
 Wed, 26 May 2021 20:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210526084726.552052-1-lee.jones@linaro.org> <20210526084726.552052-10-lee.jones@linaro.org>
In-Reply-To: <20210526084726.552052-10-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 26 May 2021 23:56:17 -0400
Message-ID: <CADnq5_Oq0f+0e31pBBqej0Cvi2c_w2RFxbaChz+O2r4ezXkSAg@mail.gmail.com>
Subject: Re: [PATCH 09/34] drm/amd/display/dc/bios/command_table_helper2: Fix
 function name 'dal_cmd_table_helper_transmitter_bp_to_atom2()'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Leo Li <sunpeng.li@amd.com>, LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Wed, May 26, 2021 at 4:48 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table_helper2.c:14=
1: warning: expecting prototype for translate_transmitter_bp_to_atom2(). Pr=
ototype was for dal_cmd_table_helper_transmitter_bp_to_atom2() instead
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c =
b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
> index 00706b072b5f8..6d2fb112ad9f9 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
> @@ -129,7 +129,7 @@ bool dal_cmd_table_helper_controller_id_to_atom2(
>  }
>
>  /**
> - * translate_transmitter_bp_to_atom2 - Translate the Transmitter to the
> + * dal_cmd_table_helper_transmitter_bp_to_atom2 - Translate the Transmit=
ter to the
>   *                                     corresponding ATOM BIOS value
>   *  @t: transmitter
>   *  returns: digitalTransmitter
> --
> 2.31.1
>
