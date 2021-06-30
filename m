Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8853B8272
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 14:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbhF3MyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 08:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234774AbhF3MyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 08:54:07 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38648C061766
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 05:51:37 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id b15so2990177iow.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 05:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=23LSu5ps4pqluX6wQzacngV2TJfwUHGp50Q2mgVmohg=;
        b=cNJMxHTKQI33zo74/BJ4fJdjcdCWMjNoZAvCmSyzuk6mhdsZ68lQitD0q4CJii2xEk
         L8i+euAihrAWh/+L2I8cUWn5SRB102r527eXh5Lo8jSYn3zmv5iERzXflPFIcKyVgc6G
         wOnQk2EC3V2CGi+zHCwxELNQ/zpCl9yILXJ80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=23LSu5ps4pqluX6wQzacngV2TJfwUHGp50Q2mgVmohg=;
        b=dhf5rCVjcP1CMtw+eqah58dsI2Fjwn2bIMJ++zc4lwdd63iPWnZEVEDXlI00O1TdM5
         kiVaAqPjSZ9hzJF3577FBG9+xC+98Wf5G9Iapv+mnDlyBvayunVMxI8Z0yhNJuSU6/Gp
         BHKCv6gcev88UGIt2mOuWC7u6/iZ9PkKb8zfjkFFWvQQx8ansz4Dc/bfRatQP0WQY/l9
         Ef/dvTJUex2FZL75p/4A+/rhmqZ+AdXwNNQy5W0w7l/dIz9eAUTHT3+g6jprs0pbua83
         3df05cJxhLLZ7Qr/D4IShov/eLggqPYoccxxyVIvEAmZRkXQu1WM0/QfA6LnvJtZVBQa
         c49A==
X-Gm-Message-State: AOAM533KbCWLcIqWskfPsWyTsxMWaaaKGbB5hGVbl1/kX78U7vAGvLHl
        EAyanewez9YAku1xyq9n2E2RDlbyEo+51Q==
X-Google-Smtp-Source: ABdhPJyStYwUx6CcxPhW+9ju+qnKxF12XtLWp3KQqQ40MByfwBLuzmen+JGtxS7ehrJeBvBLBo8X6A==
X-Received: by 2002:a02:8521:: with SMTP id g30mr8742281jai.113.1625057495951;
        Wed, 30 Jun 2021 05:51:35 -0700 (PDT)
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com. [209.85.166.46])
        by smtp.gmail.com with ESMTPSA id a11sm12231368ioq.12.2021.06.30.05.51.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jun 2021 05:51:35 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id y76so2969935iof.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 05:51:35 -0700 (PDT)
X-Received: by 2002:a02:c851:: with SMTP id r17mr8596271jao.13.1625057494533;
 Wed, 30 Jun 2021 05:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210618122923.385938-1-ribalda@chromium.org> <20210618122923.385938-22-ribalda@chromium.org>
 <CANiDSCvNvJ_xyuqgvvFv6aZGSm=H-9=SeV6wp5C_0-acm+wC=A@mail.gmail.com>
 <820809c2-a564-8a79-c279-7570c3bcc801@xs4all.nl> <CANiDSCvwQvDYKNqxAZjtAKY6CGNrnn21LMoNnsg7FrrDiooi-A@mail.gmail.com>
 <d65ab386-370e-b2e9-dbac-a981993d9da7@xs4all.nl>
In-Reply-To: <d65ab386-370e-b2e9-dbac-a981993d9da7@xs4all.nl>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 30 Jun 2021 14:51:23 +0200
X-Gmail-Original-Message-ID: <CANiDSCv=FMy6g1aQhVRxH1tADSyLAOAY7csMwPFtXZVMU8N6VA@mail.gmail.com>
Message-ID: <CANiDSCv=FMy6g1aQhVRxH1tADSyLAOAY7csMwPFtXZVMU8N6VA@mail.gmail.com>
Subject: Re: [PATCH v10 21/21] media: uvcvideo: Return -EACCES to inactive controls
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, tfiga@chromium.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans


On Wed, 30 Jun 2021 at 11:03, Hans Verkuil <hverkuil-cisco@xs4all.nl> wrote:
>
> Hi Ricardo,
>
> On 25/06/2021 15:55, Ricardo Ribalda wrote:
> > Hi Hans
> >
> > On Fri, 25 Jun 2021 at 13:07, Hans Verkuil <hverkuil-cisco@xs4all.nl> wrote:
> >>
> >> On 25/06/2021 12:29, Ricardo Ribalda wrote:
> >>> Hi Hans
> >>>
> >>> Did you have some hardware that did not work fine without this patch?
> >>> Am I remembering correctly?
> >>
> >> Yes, that's correct. It's one of my webcams, but I can't remember which one
> >> it is. You probably want me to test this v10?
> >>
> >> Regards,
> >
> > That would be awesome. Thanks!
>
> You can add my:
>
> Tested-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Thanks a lot for testing it!

Sorry to bother you, but could I ask you to try again, but with this
patch reverted? This is v10 1-20, without 21/21


Thanks!
>
> to this series.
>
> I do get these warnings (depends on the webcam model, though, some do, some don't):
>
> Streaming ioctls:
>         test read/write: OK (Not Supported)
>         test blocking wait: OK
>                 warn: v4l2-test-buffers.cpp(438): got sequence number 1, expected 0
>         test MMAP (no poll): OK
>                 warn: v4l2-test-buffers.cpp(438): got sequence number 1, expected 0
>         test MMAP (select): OK
>                 warn: v4l2-test-buffers.cpp(438): got sequence number 1, expected 0
>         test MMAP (epoll): OK
>                 warn: v4l2-test-buffers.cpp(438): got sequence number 1, expected 0
>         test USERPTR (no poll): OK
>                 warn: v4l2-test-buffers.cpp(438): got sequence number 1, expected 0
>         test USERPTR (select): OK
>         test DMABUF: Cannot test, specify --expbuf-device
>
> It's something to do with the Field ID, but I'm not sure if this is really correctly
> reporting a dropped frame, or if it is a false report and the sequence counter was
> wrongly incremented.
>
> This is a separate issue, though, and doesn't block this series.
>
> Regards,
>
>         Hans
>
> >
> >>
> >>         Hans
> >>
> >>>
> >>> Thanks!
> >>>
> >>> On Fri, 18 Jun 2021 at 14:29, Ricardo Ribalda <ribalda@chromium.org> wrote:
> >>>>
> >>>> If a control is inactive return -EACCES to let the userspace know that
> >>>> the value will not be applied automatically when the control is active
> >>>> again.
> >>>>
> >>>> Also make sure that query_v4l2_ctrl doesn't return an error.
> >>>>
> >>>> Suggested-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> >>>> Reviewed-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> >>>> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> >>>> ---
> >>>>  drivers/media/usb/uvc/uvc_ctrl.c | 73 +++++++++++++++++++++-----------
> >>>>  1 file changed, 49 insertions(+), 24 deletions(-)
> >>>>
> >>>> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> >>>> index da44d5c0b9ad..4f80c06d3c43 100644
> >>>> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> >>>> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> >>>> @@ -1104,13 +1104,36 @@ static const char *uvc_map_get_name(const struct uvc_control_mapping *map)
> >>>>         return "Unknown Control";
> >>>>  }
> >>>>
> >>>> +static bool uvc_ctrl_is_inactive(struct uvc_video_chain *chain,
> >>>> +                                struct uvc_control *ctrl,
> >>>> +                                struct uvc_control_mapping *mapping)
> >>>> +{
> >>>> +       struct uvc_control_mapping *master_map = NULL;
> >>>> +       struct uvc_control *master_ctrl = NULL;
> >>>> +       s32 val;
> >>>> +       int ret;
> >>>> +
> >>>> +       if (!mapping->master_id)
> >>>> +               return false;
> >>>> +
> >>>> +       __uvc_find_control(ctrl->entity, mapping->master_id, &master_map,
> >>>> +                          &master_ctrl, 0);
> >>>> +
> >>>> +       if (!master_ctrl || !(master_ctrl->info.flags & UVC_CTRL_FLAG_GET_CUR))
> >>>> +               return false;
> >>>> +
> >>>> +       ret = __uvc_ctrl_get(chain, master_ctrl, master_map, &val);
> >>>> +       if (ret < 0 || val == mapping->master_manual)
> >>>> +               return false;
> >>>> +
> >>>> +       return true;
> >>>> +}
> >>>> +
> >>>>  static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
> >>>>         struct uvc_control *ctrl,
> >>>>         struct uvc_control_mapping *mapping,
> >>>>         struct v4l2_queryctrl *v4l2_ctrl)
> >>>>  {
> >>>> -       struct uvc_control_mapping *master_map = NULL;
> >>>> -       struct uvc_control *master_ctrl = NULL;
> >>>>         const struct uvc_menu_info *menu;
> >>>>         unsigned int i;
> >>>>
> >>>> @@ -1126,18 +1149,8 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
> >>>>         if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR))
> >>>>                 v4l2_ctrl->flags |= V4L2_CTRL_FLAG_READ_ONLY;
> >>>>
> >>>> -       if (mapping->master_id)
> >>>> -               __uvc_find_control(ctrl->entity, mapping->master_id,
> >>>> -                                  &master_map, &master_ctrl, 0);
> >>>> -       if (master_ctrl && (master_ctrl->info.flags & UVC_CTRL_FLAG_GET_CUR)) {
> >>>> -               s32 val;
> >>>> -               int ret = __uvc_ctrl_get(chain, master_ctrl, master_map, &val);
> >>>> -               if (ret < 0)
> >>>> -                       return ret;
> >>>> -
> >>>> -               if (val != mapping->master_manual)
> >>>> -                               v4l2_ctrl->flags |= V4L2_CTRL_FLAG_INACTIVE;
> >>>> -       }
> >>>> +       if (uvc_ctrl_is_inactive(chain, ctrl, mapping))
> >>>> +               v4l2_ctrl->flags |= V4L2_CTRL_FLAG_INACTIVE;
> >>>>
> >>>>         if (!ctrl->cached) {
> >>>>                 int ret = uvc_ctrl_populate_cache(chain, ctrl);
> >>>> @@ -1660,25 +1673,37 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
> >>>>         return 0;
> >>>>  }
> >>>>
> >>>> -static int uvc_ctrl_find_ctrl_idx(struct uvc_entity *entity,
> >>>> -                                 struct v4l2_ext_controls *ctrls,
> >>>> -                                 struct uvc_control *uvc_control)
> >>>> +static int uvc_ctrl_commit_error(struct uvc_video_chain *chain,
> >>>> +                                struct uvc_entity *entity,
> >>>> +                                struct v4l2_ext_controls *ctrls,
> >>>> +                                struct uvc_control *err_control,
> >>>> +                                int ret)
> >>>>  {
> >>>>         struct uvc_control_mapping *mapping;
> >>>>         struct uvc_control *ctrl_found;
> >>>>         unsigned int i;
> >>>>
> >>>> -       if (!entity)
> >>>> -               return ctrls->count;
> >>>> +       if (!entity) {
> >>>> +               ctrls->error_idx = ctrls->count;
> >>>> +               return ret;
> >>>> +       }
> >>>>
> >>>>         for (i = 0; i < ctrls->count; i++) {
> >>>>                 __uvc_find_control(entity, ctrls->controls[i].id, &mapping,
> >>>>                                    &ctrl_found, 0);
> >>>> -               if (uvc_control == ctrl_found)
> >>>> -                       return i;
> >>>> +               if (err_control == ctrl_found)
> >>>> +                       break;
> >>>>         }
> >>>> +       ctrls->error_idx = i;
> >>>> +
> >>>> +       /* We could not find the control that failed. */
> >>>> +       if (i == ctrls->count)
> >>>> +               return ret;
> >>>> +
> >>>> +       if (uvc_ctrl_is_inactive(chain, err_control, mapping))
> >>>> +               return -EACCES;
> >>>>
> >>>> -       return ctrls->count;
> >>>> +       return ret;
> >>>>  }
> >>>>
> >>>>  int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
> >>>> @@ -1701,8 +1726,8 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
> >>>>                 uvc_ctrl_send_events(handle, ctrls->controls, ctrls->count);
> >>>>  done:
> >>>>         if (ret < 0 && ctrls)
> >>>> -               ctrls->error_idx = uvc_ctrl_find_ctrl_idx(entity, ctrls,
> >>>> -                                                         err_ctrl);
> >>>> +               ret = uvc_ctrl_commit_error(chain, entity, ctrls, err_ctrl,
> >>>> +                                           ret);
> >>>>         mutex_unlock(&chain->ctrl_mutex);
> >>>>         return ret;
> >>>>  }
> >>>> --
> >>>> 2.32.0.288.g62a8d224e6-goog
> >>>>
> >>>
> >>>
> >>
> >
> >
>


-- 
Ricardo Ribalda
