Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5202D454F7F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 22:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbhKQVnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 16:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbhKQVnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 16:43:41 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2777C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 13:40:42 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id u74so9365174oie.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 13:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=80qrjaKuckfIxKf3DLVTv6a7iYoyD9Sd1U/A6GrtV40=;
        b=AjM9ULmodQVC58Cu0Dno9jz4ysnFH2WEnIivupLTuRkk7hn0LPaYS477qAkjYt4T76
         4L9um1lijnyvYCMUp3vkHhHEDwwL/1CjaDGhIxJcnnL+2upS7hXM90dXhFInZVc4fUTG
         ZOwqBRuF+Js5dkKZXWrqx2eXCoY7ZJNxokKNSmIKfQKUma6a8m2ue84OLVluZsP0qKlQ
         vIYnpkWXh70s1glTHAWmfwHfJwIUmkDDjM2dKUKeRnIEbSnMTK0WtHlJV0cuB4KAtI5t
         qsIwC5bSbizogJ/rE5xWK/vJwUecbWTGUe64Q0bawFbMB1+1hZ5mf3M0zO8tDfQIhLtu
         bQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=80qrjaKuckfIxKf3DLVTv6a7iYoyD9Sd1U/A6GrtV40=;
        b=5AMU0gxU0hH+0js9hHC2d1oT6zSnziMYB6g+ALoCPqCU36dOYg+XydfkObqn8crcku
         oEs4G0tTIbK6OvlcH9LCIpaOM98o7KW3HkTVtkul7LlGpfvXfveCyehyxaJcyGZn5XJR
         XFleK40rd4L4ZBy7HsuKVxzLV9P9E3YEtCPDFhyWknT6pO5FB0NsN2tlVFRED1bYoPZO
         zgPkqGus8Y3lAOBdzSAfvVN2Plzg4QqHSGMEDgd3YtlZ8QT+EF/LxEgWWGSnCYc7ECrq
         EJux5vYm52Uji1SDwXUMi19T4cxtjXh2Qavdq1O2g3Q2P9/ZmMc9dJ8tn0p+f1F/jET+
         MURg==
X-Gm-Message-State: AOAM533heyzZW9vkucGRg1vIy/1nuEWt3PQyOCurMqvzl08pA5j37Jz9
        2BKHAULhrWxeNiU3j37WiQNF8j7009hyY9eV3k0=
X-Google-Smtp-Source: ABdhPJxrs7xTtPn1zFRtZ5i3FY/8UZ/DJotfsZ7+hYwxZMxL6ar5KwSQnPGsPX0qTiwORjQm6ItE+gRSOvERV7I704w=
X-Received: by 2002:aca:3f87:: with SMTP id m129mr2809816oia.5.1637185242017;
 Wed, 17 Nov 2021 13:40:42 -0800 (PST)
MIME-Version: 1.0
References: <1636963819-19726-1-git-send-email-yang.lee@linux.alibaba.com>
In-Reply-To: <1636963819-19726-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 17 Nov 2021 16:40:31 -0500
Message-ID: <CADnq5_O+h4J5hYrnODix4_bdMgyZMt-wcUsSWr6DGrWwUkJFog@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: check top_pipe_to_program pointer
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@linux.ie>,
        llvm@lists.linux.dev,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Mon, Nov 15, 2021 at 3:10 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Clang static analysis reports this error
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:2870:7: warning:
> Dereference of null pointer [clang-analyzer-core.NullDereference]
>                 if
> (top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable) {
>                     ^
>
> top_pipe_to_program being NULL is caught as an error
> But then it is used to report the error.
>
> So add a check before using it.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 39ad385..34382d0 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -2867,7 +2867,8 @@ static void commit_planes_for_stream(struct dc *dc,
>  #endif
>
>         if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed)
> -               if (top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable) {
> +               if (top_pipe_to_program &&
> +                       top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable) {
>                         if (should_use_dmub_lock(stream->link)) {
>                                 union dmub_hw_lock_flags hw_locks = { 0 };
>                                 struct dmub_hw_lock_inst_flags inst_flags = { 0 };
> --
> 1.8.3.1
>
