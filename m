Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1AB3B41B0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 12:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbhFYKcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 06:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbhFYKcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 06:32:18 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E75C061760
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 03:29:58 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id g3so381281ilj.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 03:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8l+zzvIF6XiRoW9cSAlQ5A0vVNKEKZTujABMITdBz4c=;
        b=fNyJoKzV7kOp3jDzZ+via62uRAgL1/8nX362jkWvMj4LrlrwHCRUog8+n0Ep8OTWDJ
         7tKKs+8RfjRgoCRor1pqIgf3SPrdIZadaWoeqS2jasd0OvZXVDeu5jDuY1eOx3KjiwnA
         eK/db2nOUBYf+XwrUBwtKsyWiN0JSbW703krw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8l+zzvIF6XiRoW9cSAlQ5A0vVNKEKZTujABMITdBz4c=;
        b=mFeMNLaI1GuYgGphltTijHxeUtGENzMFTZauqxui87kyZUdrv8/84JOv434Ke6o7SY
         s4cQtaPS0Su5ykx9W1Ly3l9UEU9ALtpt1jgDkqBflcYn+ZbHeGiLe/H6YTFE1+e6U8YF
         99R1utqmCtorxIbWqbiYeDifX+QMGxMDOGLHKxrt8K0SgpUkkP4U1OlYjVpsfZiS8AjT
         UDXzH9DXLp83BnWBJMpBmRBETvdi2GNt13aRfzjM0DM4VHJuIOutAat2VdQJfbTqMK1P
         ZR19/AseEKK5y/bPjNoMXbpzbVmdzmks9lzazSLMle3H9bmBTyMCKd6aWryYCmUXoF0O
         zmpw==
X-Gm-Message-State: AOAM531Xn4mJqm1EApJTMXaY+CMQlvOfDfxF8mTQEEv01QBQL00dbu6k
        TlJKpPBF4SPl+CESZtku0d1IyMz30jiIMQ==
X-Google-Smtp-Source: ABdhPJwb8Q4EYUiS/xsPQ1jhz/qSiECNI/wtk+Uj5sQoyfmnQyOSMlfyywS8ecbb5JKkKkFNzW3IoA==
X-Received: by 2002:a92:d8ce:: with SMTP id l14mr796152ilo.283.1624616997775;
        Fri, 25 Jun 2021 03:29:57 -0700 (PDT)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com. [209.85.166.174])
        by smtp.gmail.com with ESMTPSA id 67sm2687959iob.15.2021.06.25.03.29.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 03:29:57 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id k5so9251916ilv.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 03:29:56 -0700 (PDT)
X-Received: by 2002:a92:6d0b:: with SMTP id i11mr6974931ilc.160.1624616996319;
 Fri, 25 Jun 2021 03:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210618122923.385938-1-ribalda@chromium.org> <20210618122923.385938-22-ribalda@chromium.org>
In-Reply-To: <20210618122923.385938-22-ribalda@chromium.org>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 25 Jun 2021 12:29:44 +0200
X-Gmail-Original-Message-ID: <CANiDSCvNvJ_xyuqgvvFv6aZGSm=H-9=SeV6wp5C_0-acm+wC=A@mail.gmail.com>
Message-ID: <CANiDSCvNvJ_xyuqgvvFv6aZGSm=H-9=SeV6wp5C_0-acm+wC=A@mail.gmail.com>
Subject: Re: [PATCH v10 21/21] media: uvcvideo: Return -EACCES to inactive controls
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, tfiga@chromium.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans

Did you have some hardware that did not work fine without this patch?
Am I remembering correctly?

Thanks!

On Fri, 18 Jun 2021 at 14:29, Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> If a control is inactive return -EACCES to let the userspace know that
> the value will not be applied automatically when the control is active
> again.
>
> Also make sure that query_v4l2_ctrl doesn't return an error.
>
> Suggested-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> Reviewed-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 73 +++++++++++++++++++++-----------
>  1 file changed, 49 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index da44d5c0b9ad..4f80c06d3c43 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -1104,13 +1104,36 @@ static const char *uvc_map_get_name(const struct uvc_control_mapping *map)
>         return "Unknown Control";
>  }
>
> +static bool uvc_ctrl_is_inactive(struct uvc_video_chain *chain,
> +                                struct uvc_control *ctrl,
> +                                struct uvc_control_mapping *mapping)
> +{
> +       struct uvc_control_mapping *master_map = NULL;
> +       struct uvc_control *master_ctrl = NULL;
> +       s32 val;
> +       int ret;
> +
> +       if (!mapping->master_id)
> +               return false;
> +
> +       __uvc_find_control(ctrl->entity, mapping->master_id, &master_map,
> +                          &master_ctrl, 0);
> +
> +       if (!master_ctrl || !(master_ctrl->info.flags & UVC_CTRL_FLAG_GET_CUR))
> +               return false;
> +
> +       ret = __uvc_ctrl_get(chain, master_ctrl, master_map, &val);
> +       if (ret < 0 || val == mapping->master_manual)
> +               return false;
> +
> +       return true;
> +}
> +
>  static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
>         struct uvc_control *ctrl,
>         struct uvc_control_mapping *mapping,
>         struct v4l2_queryctrl *v4l2_ctrl)
>  {
> -       struct uvc_control_mapping *master_map = NULL;
> -       struct uvc_control *master_ctrl = NULL;
>         const struct uvc_menu_info *menu;
>         unsigned int i;
>
> @@ -1126,18 +1149,8 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
>         if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR))
>                 v4l2_ctrl->flags |= V4L2_CTRL_FLAG_READ_ONLY;
>
> -       if (mapping->master_id)
> -               __uvc_find_control(ctrl->entity, mapping->master_id,
> -                                  &master_map, &master_ctrl, 0);
> -       if (master_ctrl && (master_ctrl->info.flags & UVC_CTRL_FLAG_GET_CUR)) {
> -               s32 val;
> -               int ret = __uvc_ctrl_get(chain, master_ctrl, master_map, &val);
> -               if (ret < 0)
> -                       return ret;
> -
> -               if (val != mapping->master_manual)
> -                               v4l2_ctrl->flags |= V4L2_CTRL_FLAG_INACTIVE;
> -       }
> +       if (uvc_ctrl_is_inactive(chain, ctrl, mapping))
> +               v4l2_ctrl->flags |= V4L2_CTRL_FLAG_INACTIVE;
>
>         if (!ctrl->cached) {
>                 int ret = uvc_ctrl_populate_cache(chain, ctrl);
> @@ -1660,25 +1673,37 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
>         return 0;
>  }
>
> -static int uvc_ctrl_find_ctrl_idx(struct uvc_entity *entity,
> -                                 struct v4l2_ext_controls *ctrls,
> -                                 struct uvc_control *uvc_control)
> +static int uvc_ctrl_commit_error(struct uvc_video_chain *chain,
> +                                struct uvc_entity *entity,
> +                                struct v4l2_ext_controls *ctrls,
> +                                struct uvc_control *err_control,
> +                                int ret)
>  {
>         struct uvc_control_mapping *mapping;
>         struct uvc_control *ctrl_found;
>         unsigned int i;
>
> -       if (!entity)
> -               return ctrls->count;
> +       if (!entity) {
> +               ctrls->error_idx = ctrls->count;
> +               return ret;
> +       }
>
>         for (i = 0; i < ctrls->count; i++) {
>                 __uvc_find_control(entity, ctrls->controls[i].id, &mapping,
>                                    &ctrl_found, 0);
> -               if (uvc_control == ctrl_found)
> -                       return i;
> +               if (err_control == ctrl_found)
> +                       break;
>         }
> +       ctrls->error_idx = i;
> +
> +       /* We could not find the control that failed. */
> +       if (i == ctrls->count)
> +               return ret;
> +
> +       if (uvc_ctrl_is_inactive(chain, err_control, mapping))
> +               return -EACCES;
>
> -       return ctrls->count;
> +       return ret;
>  }
>
>  int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
> @@ -1701,8 +1726,8 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
>                 uvc_ctrl_send_events(handle, ctrls->controls, ctrls->count);
>  done:
>         if (ret < 0 && ctrls)
> -               ctrls->error_idx = uvc_ctrl_find_ctrl_idx(entity, ctrls,
> -                                                         err_ctrl);
> +               ret = uvc_ctrl_commit_error(chain, entity, ctrls, err_ctrl,
> +                                           ret);
>         mutex_unlock(&chain->ctrl_mutex);
>         return ret;
>  }
> --
> 2.32.0.288.g62a8d224e6-goog
>


-- 
Ricardo Ribalda
