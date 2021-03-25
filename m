Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E83F349784
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 18:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhCYRBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 13:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbhCYRBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 13:01:40 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DE7C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 10:01:40 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id w31-20020a9d36220000b02901f2cbfc9743so2596290otb.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 10:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wJ8zHlM8qfvcT77mCcQxpLWUbrfiiGwRTV3uVZ1+Q5c=;
        b=Z7ULpDZtsbxI2ysuOWL2BF/qgIuGGJ+WWpS77Yfmszj+y7UWsA5mzt6wkwVjuRyiwx
         lPNGLipNXE1/IdWMLjPAZ22YRwdK2vI6qIS8gkg7O1WP+JOTAtAjv0qhHIaCRuXVndnq
         a9mTfNi9zCMTDD19JiFhe98YcHPqN/DdaVI/ViUr5dbtar8mI4ZCkxMiTMIPTY38lcDV
         9evC0uMLO8R4K1Yil7GtxCtS1gP5+rnSd1Diwl6ouDgIaESOCN6Z08Py3z4sDIpEJNaH
         WaSHIzn8Upm5EhBBO8HLTQl4necgCbD/oHbrkXivtUWzQsMEdWM1BcgT3sAl1RlvtZHc
         H4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wJ8zHlM8qfvcT77mCcQxpLWUbrfiiGwRTV3uVZ1+Q5c=;
        b=uGe/zEpKfaRfCtl4qF0qbstZsApaDnTOcAEfgIPQDocCoOFmi/2G2XU4eZ7pYMKvnp
         6x0kiguSMBAdvyQYRsr+heh1KBpIwNiZVFFyi8xiGemdDQBRMrWILcand2xrZx6/dQH0
         Wea/ldqRZw5IE3qXjxI5QP9LQzmhzBsiokC4rJmZIa2cCgWpJcGGL4hDca+4lXDA7ESa
         tjLzU8IdXG4nYBVPR0aD7hsL/T7b89JylMqEPI5cYSR+ceSqiVRCwTyIhDx6gOTWHlOU
         sZynxK0Qs3Fct5MOjC59I6qq9RCOotgMqnbHdkQJD+a3j2+NbFruvRhWwtTDtfRocxPW
         cKuw==
X-Gm-Message-State: AOAM532OX9y7bI6JtoibDsCqUzLFm61mUKDS47UywOlNGVIY3vFhxcmN
        jVayxRu1aw2zuuraeYwGTG/Wu7F3ZdtLsV/KCO8=
X-Google-Smtp-Source: ABdhPJzaNvM9VQW41z7AkU7Mo0seISiGbYGwZorNkvm1iNHJHID2QGt+wE7Y+5+rr4rmF7L6MmZS8L8aWH9xC8klIEU=
X-Received: by 2002:a05:6830:408f:: with SMTP id x15mr8697018ott.132.1616691699957;
 Thu, 25 Mar 2021 10:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210324133705.2664873-1-arnd@kernel.org>
In-Reply-To: <20210324133705.2664873-1-arnd@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 25 Mar 2021 13:01:29 -0400
Message-ID: <CADnq5_Mtr4EaR_pXETdWiwNtutXweDMeB_2V=2mgqimt=OJt+w@mail.gmail.com>
Subject: Re: [PATCH] amdgpu: securedisplay: simplify i2c hexdump output
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jinzhou Su <Jinzhou.Su@amd.com>, Arnd Bergmann <arnd@arndb.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Huang Rui <ray.huang@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Wed, Mar 24, 2021 at 9:37 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> A previous fix I did left a rather complicated loop in
> amdgpu_securedisplay_debugfs_write() for what could be expressed in a
> simple sprintf, as Rasmus pointed out.
>
> This drops the leading 0x for each byte, but is otherwise
> much nicer.
>
> Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> index 69d7f6bff5d4..fc3ddd7aa6f0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> @@ -92,9 +92,7 @@ static ssize_t amdgpu_securedisplay_debugfs_write(struct file *f, const char __u
>         struct drm_device *dev = adev_to_drm(adev);
>         uint32_t phy_id;
>         uint32_t op;
> -       int i;
>         char str[64];
> -       char i2c_output[256];
>         int ret;
>
>         if (*pos || size > sizeof(str) - 1)
> @@ -136,12 +134,9 @@ static ssize_t amdgpu_securedisplay_debugfs_write(struct file *f, const char __u
>                 ret = psp_securedisplay_invoke(psp, TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC);
>                 if (!ret) {
>                         if (securedisplay_cmd->status == TA_SECUREDISPLAY_STATUS__SUCCESS) {
> -                               int pos = 0;
> -                               memset(i2c_output,  0, sizeof(i2c_output));
> -                               for (i = 0; i < TA_SECUREDISPLAY_I2C_BUFFER_SIZE; i++)
> -                                       pos += sprintf(i2c_output + pos, " 0x%X",
> -                                               securedisplay_cmd->securedisplay_out_message.send_roi_crc.i2c_buf[i]);
> -                               dev_info(adev->dev, "SECUREDISPLAY: I2C buffer out put is :%s\n", i2c_output);
> +                               dev_info(adev->dev, "SECUREDISPLAY: I2C buffer out put is: %*ph\n",
> +                                        TA_SECUREDISPLAY_I2C_BUFFER_SIZE,
> +                                        securedisplay_cmd->securedisplay_out_message.send_roi_crc.i2c_buf);
>                         } else {
>                                 psp_securedisplay_parse_resp_status(psp, securedisplay_cmd->status);
>                         }
> --
> 2.29.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
