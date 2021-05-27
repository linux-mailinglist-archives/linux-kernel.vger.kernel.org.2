Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27DA0392659
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 06:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhE0E2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 00:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhE0E2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 00:28:18 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F400C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 21:26:45 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id x15so3853370oic.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 21:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MAqtfQh3kqLNCeKLPTeKdUEM29PsijCc//DfraUHLwQ=;
        b=eqBhr8eAXHo+lVRn+9mISIFH3Gy2q+Zk8dohqjdKoojg0OgqzwQqg/0IEaIiA0jsVW
         6GaZ41eYjO/4AmuMb5xxcLJhsiXwAjOM8Qr6mDvVlQQzm1AAd5V/63pX8Sm0Pzi0NcJm
         gAh4bKbpmXUdqNzhxHUeks+X2gJEy5A0+DKQ6KsygLSrh2ui01rFbvoCLBDgXCFk3uyw
         QvUeEWGHZ0CvivmK8gqV+qPaIBcRvB0qZiCAeifLCaR3PyBEOdTi7y4uVyAZZA6SMPIY
         IBrx46ptfW+pDG3f1o/m9elVSGqs0PNpHr8abQWVO9k5py7B8jilH9Kv+4XTHyGLdK8O
         WEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MAqtfQh3kqLNCeKLPTeKdUEM29PsijCc//DfraUHLwQ=;
        b=A+86SRLwAlF1FAACl6qTxQxwJi5pVqMWtvMeS/ju+KLhA8AX8z2hghGSaegrli+jXA
         7lDu2bjp5aKy1S4Ojm340FwqTg2cmBnmEnSdakaDUzPzk4eOlPyIwZnQZCOJ69IeOsHj
         XxYnao5PxW29W9paDRIeKYJjPlIP7PlHLLfwJoLJIrkx9zaX217N2FzVAAHNyejTRfSH
         p0JtdKgaSDgMpgZPk5KRdiX560YhpjQz9ZTORNecjsgfIUNsOSM2peYoy1m4j9Leqi6a
         KDPV4SAMKxUDx/r02/zxciBCACu3ZD+wcl4DlOaUt+gMtjPXTmIvvLf/iS2gOz51N/A0
         LgNA==
X-Gm-Message-State: AOAM530Pzaw4jq3yvoffhTJCreYCvWLgIL8u/hwDcerogAI7ZKbSMwJN
        5sYfO6iKTSxJ7YO4OgaRV0sjmPTK1JeL8nILCP/vXG4i
X-Google-Smtp-Source: ABdhPJzSqLPyykDzrtM8uq9qKFXoEWkTve47q5DnAyeOgEMSN6yyg5sq5O2i3SRoUEnG6rHpKT45/NvEAbzcnTful+Q=
X-Received: by 2002:a05:6808:1592:: with SMTP id t18mr1079682oiw.123.1622089604710;
 Wed, 26 May 2021 21:26:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210526084726.552052-1-lee.jones@linaro.org> <20210526084726.552052-23-lee.jones@linaro.org>
In-Reply-To: <20210526084726.552052-23-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 27 May 2021 00:26:33 -0400
Message-ID: <CADnq5_PsDZPaJxmxYJBv3sY17Wu=9W4Eqgtb2EDo6PgxdzgwWQ@mail.gmail.com>
Subject: Re: [PATCH 22/34] drm/amd/display/dc/core/dc: Convert function
 headers to kernel-doc
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
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:3324: warning: Cannot=
 understand  **************************************************************=
***************
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:3344: warning: Cannot=
 understand  **************************************************************=
***************
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:3417: warning: Cannot=
 understand  **************************************************************=
***************
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
>  drivers/gpu/drm/amd/display/dc/core/dc.c | 46 ++++++------------------
>  1 file changed, 11 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/a=
md/display/dc/core/dc.c
> index ef157b83bacd2..34c207f92df98 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -3335,18 +3335,10 @@ void dc_hardware_release(struct dc *dc)
>  #endif
>
>  /**
> - ***********************************************************************=
******
> - *  Function: dc_enable_dmub_notifications
> + * dc_enable_dmub_notifications - Returns whether dmub notification can =
be enabled
> + * @dc: dc structure
>   *
> - *  @brief
> - *             Returns whether dmub notification can be enabled
> - *
> - *  @param
> - *             [in] dc: dc structure
> - *
> - *     @return
> - *             True to enable dmub notifications, False otherwise
> - ***********************************************************************=
******
> + * Returns: True to enable dmub notifications, False otherwise
>   */
>  bool dc_enable_dmub_notifications(struct dc *dc)
>  {
> @@ -3355,21 +3347,13 @@ bool dc_enable_dmub_notifications(struct dc *dc)
>  }
>
>  /**
> - ***********************************************************************=
******
> - *  Function: dc_process_dmub_aux_transfer_async
> - *
> - *  @brief
> - *             Submits aux command to dmub via inbox message
> - *             Sets port index appropriately for legacy DDC
> - *
> - *  @param
> - *             [in] dc: dc structure
> - *             [in] link_index: link index
> - *             [in] payload: aux payload
> + * dc_process_dmub_aux_transfer_async - Submits aux command to dmub via =
inbox message
> + *                                      Sets port index appropriately fo=
r legacy DDC
> + * @dc: dc structure
> + * @link_index: link index
> + * @payload: aux payload
>   *
> - *     @return
> - *             True if successful, False if failure
> - ***********************************************************************=
******
> + * Returns: True if successful, False if failure
>   */
>  bool dc_process_dmub_aux_transfer_async(struct dc *dc,
>                                 uint32_t link_index,
> @@ -3428,16 +3412,8 @@ bool dc_process_dmub_aux_transfer_async(struct dc =
*dc,
>  }
>
>  /**
> - ***********************************************************************=
******
> - *  Function: dc_disable_accelerated_mode
> - *
> - *  @brief
> - *             disable accelerated mode
> - *
> - *  @param
> - *             [in] dc: dc structure
> - *
> - ***********************************************************************=
******
> + * dc_disable_accelerated_mode - disable accelerated mode
> + * @dc: dc structure
>   */
>  void dc_disable_accelerated_mode(struct dc *dc)
>  {
> --
> 2.31.1
>
