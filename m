Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240073462FC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 16:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbhCWPeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 11:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbhCWPd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 11:33:58 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4909C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 08:33:58 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id h6-20020a0568300346b02901b71a850ab4so19841974ote.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 08:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BU22F3GylJCKeCQWy9MpZdNcfqLAl6Ije4lLEtEa8GY=;
        b=FBzNhcrN7thCIaDBITnPorfkjdlRIsHFHiUvYcccyToaj4vMKgH80eNBrdw/Gnw3tB
         uErAaGg4NWxUEbPUWotD7t8VcUg2Zf71LavYayx6de7yRsxby7ufzIauY1L4URerzG/W
         VDEJX0K/fIyHR9ieW8q9zQZ5q/rJgB+i3tHbwHNAyJFrWV5I1XM8hngCNi5ltGeUu8nQ
         VHsKIBJQor4+2XLwUCrJjKejy78IuAt9lL0pP/P4NBQq/2/hsmo48+sDFlRFWywlHZuk
         reuzf40q/emMKXjMjpt1RpDlBl7CngRU+UDa0YZc1Mh2uERPFssPgsvKilX+DcAb9hwP
         tRPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BU22F3GylJCKeCQWy9MpZdNcfqLAl6Ije4lLEtEa8GY=;
        b=f2q7nQCrw0rnUOLw7ZfwMooQ2lS+5MtHk8Julw4kfOgRxO0iKWfD8UaCkXHN6NrObj
         k0agTLY8P97qjMcdkUMHUjZYDCQkKD6JEXIhJDN9O6dkDNpdn7jhw5//AZF7RS6J9sxb
         +j6R4uclWxEjcL7RssiYM3JDoFkVLbiPSRzoDiY9+UhbUhyQvJg8oFT4SIuht1y3/gcp
         2NKrVMuQ9TfHcsPwaxLMgqVXBXf5SqHANMOghLIaXrF3DDk4jBstK7e7OWSV9T+b3YAY
         iydfitQUbEI/eI8vj3xAZlkUdYt8HpAROEAUNaevOgYq6/0b0Bpo0lLGG2Pi6TFGv6AH
         zPyQ==
X-Gm-Message-State: AOAM530kt22YLF4fkgOHN7C3nEj/y852V3OoTnOkdt9WXgLDXttrcKml
        /jDGm9B3tsjZRW/VS3WZQ7PdKjI4luO+e+Fz2tO7qWP3
X-Google-Smtp-Source: ABdhPJxFXYs/7acwhn00qep8mlUpC9T+CKHJrdfAbBpBhuQNReaMkZBPCVNWLBPFYIy648/pkeGe+lCHThIvm+KGocQ=
X-Received: by 2002:a05:6830:408f:: with SMTP id x15mr5048220ott.132.1616513638090;
 Tue, 23 Mar 2021 08:33:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210323130430.2250052-1-arnd@kernel.org>
In-Reply-To: <20210323130430.2250052-1-arnd@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 23 Mar 2021 11:33:47 -0400
Message-ID: <CADnq5_MYZF2VWe=fYOqj-M5QA2myYTy-Lwu6uchuXZEz+oZbQw@mail.gmail.com>
Subject: Re: [PATCH] amdgpu: fix gcc -Wrestrict warning
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jinzhou Su <Jinzhou.Su@amd.com>, Arnd Bergmann <arnd@arndb.de>,
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

On Tue, Mar 23, 2021 at 9:04 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> gcc warns about an sprintf() that uses the same buffer as source
> and destination, which is undefined behavior in C99:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c: In function 'amdgpu_securedisplay_debugfs_write':
> drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c:141:6: error: 'sprintf' argument 3 overlaps destination object 'i2c_output' [-Werror=restrict]
>   141 |      sprintf(i2c_output, "%s 0x%X", i2c_output,
>       |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   142 |       securedisplay_cmd->securedisplay_out_message.send_roi_crc.i2c_buf[i]);
>       |       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c:97:7: note: destination object referenced by 'restrict'-qualified argument 1 was declared here
>    97 |  char i2c_output[256];
>       |       ^~~~~~~~~~
>
> Rewrite it to remember the current offset into the buffer instead.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> index 834440ab9ff7..69d7f6bff5d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> @@ -136,9 +136,10 @@ static ssize_t amdgpu_securedisplay_debugfs_write(struct file *f, const char __u
>                 ret = psp_securedisplay_invoke(psp, TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC);
>                 if (!ret) {
>                         if (securedisplay_cmd->status == TA_SECUREDISPLAY_STATUS__SUCCESS) {
> +                               int pos = 0;
>                                 memset(i2c_output,  0, sizeof(i2c_output));
>                                 for (i = 0; i < TA_SECUREDISPLAY_I2C_BUFFER_SIZE; i++)
> -                                       sprintf(i2c_output, "%s 0x%X", i2c_output,
> +                                       pos += sprintf(i2c_output + pos, " 0x%X",
>                                                 securedisplay_cmd->securedisplay_out_message.send_roi_crc.i2c_buf[i]);
>                                 dev_info(adev->dev, "SECUREDISPLAY: I2C buffer out put is :%s\n", i2c_output);
>                         } else {
> --
> 2.29.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
