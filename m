Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B0D3925C1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 06:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhE0ECd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 00:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhE0EC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 00:02:28 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6C1C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 21:00:55 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so3167630oth.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 21:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=APGqEQQKklVqx+e+nEY1OGGyF9cgDa3PPLqNkgcDFtE=;
        b=rod1T2rjLNLXdShw7Ee3xcuNeytqVwUBmsE+CS7Kpu0+oDCJrwSs75MoHtIRYv05Sh
         pLWZkEub70QUK/vtkQxFm25AjMRuHXziuIRJrgCTvDpx/QRFyO0VQLZQWx05GGPfpWny
         4XZ8RXpl0u2bXwf0RvlQVMHqsW/wpturxvUmoTD5Gf+kn+flUEMZn9Znp+iQzp2b4JM7
         4FbI0xd+hdRcnSGd5vNhApbwkScVen7K501N6iF4TfjMizkJVMuyPCdCxCSXIXX95bHk
         LUnot92cAmKveqIAuOiaxPwSGnGMHBf77l2ZN32aaw1lgaT7jTU5jQQtwgvU30QhoH3P
         zhAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=APGqEQQKklVqx+e+nEY1OGGyF9cgDa3PPLqNkgcDFtE=;
        b=SpmwwSJzcYVp/v3YGntCJYg163gULjt8D4KUunqz0b9JLYxMaGn37RUEQIfuvf4CNo
         BgCOqABPobFfOqZu9oTay9g4xqNwlSoBYQv0eM5H9hvujF1NsGBx2+xIK0T8U6BgDoH7
         KxFsC8V0UuK3QUWFoiSe7MjJ9EEXHcJq9jw9tXQpD5/S9d3xxt/05PE3Yd2f1EADrJF/
         QDe6sKvul34Xy+sPsnUADnju+cjPNs3t/7C6rU/HTbHzLbITWTil/MOxJ2AhRZrfURg4
         0vWm6cfV1Kd2UvvsjcO3+2zJd6r0mfw/qZSeddKT3alJjBepCx24cKXYGB4muYqaa2nf
         OGNg==
X-Gm-Message-State: AOAM533NJ1occx1zWxCRA9vNVaPwz1cj4dilHONbVCqr5rKUn7drTqon
        GDoJ0dskDsfdEuyhc/39myX0Ti/2o9TWxAfHp/o=
X-Google-Smtp-Source: ABdhPJwTFbg86d5m1kGBug4qpsnNlPlGtJmoEoSn/XOtNyLD3d3qLRkNElC/2g/pS6OEa4WVo7cLLlRk7eabZvjp5FE=
X-Received: by 2002:a9d:6548:: with SMTP id q8mr1218750otl.311.1622088055142;
 Wed, 26 May 2021 21:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210526084726.552052-1-lee.jones@linaro.org> <20210526084726.552052-14-lee.jones@linaro.org>
In-Reply-To: <20210526084726.552052-14-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 27 May 2021 00:00:44 -0400
Message-ID: <CADnq5_PLcwcmY88uecMh7FPYungfskpBgWmiy9qTJrE_k06MAQ@mail.gmail.com>
Subject: Re: [PATCH 13/34] drm/amd/display/dc/dce/dmub_outbox: Convert over to kernel-doc
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Jun Lei <Jun.Lei@amd.com>,
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
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_outbox.c:30: warning: =
Cannot understand  ********************************************************=
*********************
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
> Cc: Jun Lei <Jun.Lei@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  .../gpu/drm/amd/display/dc/dce/dmub_outbox.c    | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_outbox.c b/drivers/g=
pu/drm/amd/display/dc/dce/dmub_outbox.c
> index 295596d1f47f2..faad8555ddbb6 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dmub_outbox.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_outbox.c
> @@ -27,19 +27,10 @@
>  #include "dmub/inc/dmub_cmd.h"
>
>  /**
> - ***********************************************************************=
******
> - *  Function: dmub_enable_outbox_notification
> - *
> - *  @brief
> - *             Sends inbox cmd to dmub to enable outbox1 messages with i=
nterrupt.
> - *             Dmub sends outbox1 message and triggers outbox1 interrupt=
.
> - *
> - *  @param
> - *             [in] dc: dc structure
> - *
> - *  @return
> - *     None
> - ***********************************************************************=
******
> + *  dmub_enable_outbox_notification - Sends inbox cmd to dmub to enable =
outbox1
> + *                                    messages with interrupt. Dmub send=
s outbox1
> + *                                    message and triggers outbox1 inter=
rupt.
> + * @dc: dc structure
>   */
>  void dmub_enable_outbox_notification(struct dc *dc)
>  {
> --
> 2.31.1
>
