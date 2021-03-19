Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E90E3418C1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 10:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhCSJtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 05:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhCSJtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 05:49:32 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33794C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 02:49:32 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id v3so5386866ioq.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 02:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KfhXVhfU9ZLYi13qFTwIMXTkfNiSwn935VN8lgtl8nc=;
        b=PJx0g8aO1MQa1qMbQdMr5L3cF1++Yli2awZxZxK4UkSsk3pwQYp2OYkL2h8UuSoo0w
         ZdIvy74r5FWvw+CZPOAy8dQN2XQ2LQ2sSFIIjBTeOp2BxvzqP8ujT/UaFSbhw4+O9LBH
         38xuphTAktzVuGOIaB/TCLXpNHkMMHoAB/lQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KfhXVhfU9ZLYi13qFTwIMXTkfNiSwn935VN8lgtl8nc=;
        b=Uqx4xYUEIZDs5nRtW+Z0Z9qWNXmJCX+vrryqoamnoTrp4ORp43w8k1K1EA/ozMdx0v
         ujPV9CN+FdpJ3cwhcMq8rhkXAdLVkHeur2PXjDq5SUvSFtlPAn3KGO0UfjwHy6ztFL7x
         rk3EpuYuKppvPwz9zs2Ilu7J0WpGbvF4ngQOW8IeDykNHiz2wDUpQRfazmVY/K8kWkLI
         1dmk/rMSaHRvDrEJc41dzB40sOQ524p18OV3k+0Hbdkl7F+VtNxPNYTf9mcnUuvl9E19
         Ha0c7GWoIOXUsdXW31E/PSIbjoidV7TRFYeO95lKYD9Oj7i6nkp7v2rxKtRqB2qND3wA
         wgvQ==
X-Gm-Message-State: AOAM530v0PdBg94arMTxMZUfO2o3qXTrHirj6SuwrJMuTVEY4ftzwZhb
        PNL9vJfEhqw+IN86kidIf2hXb+EZzgqSR6d/
X-Google-Smtp-Source: ABdhPJxVDXOHOvm4AxlPTB7Hc3l1f/2+YZknAlgjTAXmL+ahLl2utuTcybpZxhDWJ0hIp/evJ65fWA==
X-Received: by 2002:a02:ccb2:: with SMTP id t18mr481264jap.123.1616147371404;
        Fri, 19 Mar 2021 02:49:31 -0700 (PDT)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com. [209.85.166.49])
        by smtp.gmail.com with ESMTPSA id u15sm2362143iln.84.2021.03.19.02.49.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 02:49:30 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id r193so5396946ior.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 02:49:30 -0700 (PDT)
X-Received: by 2002:a05:6638:2711:: with SMTP id m17mr477603jav.115.1616147369923;
 Fri, 19 Mar 2021 02:49:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210318202928.166955-1-ribalda@chromium.org> <20210318202928.166955-14-ribalda@chromium.org>
 <21b313b4-dbdf-c1bd-450d-723c601cb61a@xs4all.nl>
In-Reply-To: <21b313b4-dbdf-c1bd-450d-723c601cb61a@xs4all.nl>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 19 Mar 2021 10:49:19 +0100
X-Gmail-Original-Message-ID: <CANiDSCu2__2Ta6BcF24DC=+Cir1aO=QF5xsVK4-vkephbAXiSg@mail.gmail.com>
Message-ID: <CANiDSCu2__2Ta6BcF24DC=+Cir1aO=QF5xsVK4-vkephbAXiSg@mail.gmail.com>
Subject: Re: [PATCH v7 13/17] media: uvcvideo: Return -EACCES to inactive controls
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans

Thanks for testing this.




On Fri, Mar 19, 2021 at 10:10 AM Hans Verkuil <hverkuil-cisco@xs4all.nl> wrote:
>
> On 18/03/2021 21:29, Ricardo Ribalda wrote:
> > If a control is inactive return -EACCES to let the userspace know that
> > the value will not be applied automatically when the control is active
> > again.
> >
> > Reviewed-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> > Suggested-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_ctrl.c | 68 ++++++++++++++++++++++----------
> >  drivers/media/usb/uvc/uvc_v4l2.c | 11 +++++-
> >  drivers/media/usb/uvc/uvcvideo.h |  2 +-
> >  3 files changed, 58 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > index 24fd5afc4e4f..1ec8333811bc 100644
> > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > @@ -1046,8 +1046,33 @@ static int uvc_query_v4l2_class(struct uvc_video_chain *chain, u32 req_id,
> >       return 0;
> >  }
> >
> > +static bool uvc_ctrl_is_inactive(struct uvc_video_chain *chain,
> > +                              struct uvc_control *ctrl,
> > +                              struct uvc_control_mapping *mapping)
> > +{
> > +     struct uvc_control_mapping *master_map = NULL;
> > +     struct uvc_control *master_ctrl = NULL;
> > +     s32 val;
> > +     int ret;
> > +
> > +     if (!mapping->master_id)
> > +             return false;
> > +
> > +     __uvc_find_control(ctrl->entity, mapping->master_id, &master_map,
> > +                        &master_ctrl, 0);
> > +
> > +     if (!master_ctrl || !(master_ctrl->info.flags & UVC_CTRL_FLAG_GET_CUR))
> > +             return false;
> > +
> > +     ret = __uvc_ctrl_get(chain, master_ctrl, master_map, &val);
> > +     if (ret < 0 || val == mapping->master_manual)
> > +             return false;
> > +
> > +     return true;
> > +}
>
> This doesn't work. The problem is that you need to test the new value for the
> master control against master_manual, and you are testing against the old value.
>
> So for my uvc camera I have this situation after boot:
>
>                   auto_exposure 0x009a0901 (menu)   : min=0 max=3 default=3 value=3 (Aperture Priority Mode)
>                                 1: Manual Mode
>                                 3: Aperture Priority Mode
>          exposure_time_absolute 0x009a0902 (int)    : min=3 max=2047 step=1 default=250 value=250 flags=inactive
>
> But trying to change both auto_exposure to manual AND set the new exposure_time_absolute
> will fail:
>
> $ v4l2-ctl -c auto_exposure=1,exposure_time_absolute=251
> VIDIOC_S_EXT_CTRLS: failed: Permission denied
> Error setting controls: Permission denied
>
> This works though with the uvc driver as is currently in the kernel.
>
> Unfortunately, this is not something that is explicitly tested in v4l2-compliance.
>

Can you try dropping this patch and relaying on  media: uvcvideo: Set
error_idx during ctrl_commit errors ?

thanks!

> Regards,
>
>         Hans
>
> > +
> >  int uvc_ctrl_is_accessible(struct uvc_video_chain *chain, u32 v4l2_id,
> > -                        bool read)
> > +                        unsigned long ioctl)
> >  {
> >       struct uvc_control_mapping *mapping;
> >       struct uvc_control *ctrl;
> > @@ -1059,11 +1084,26 @@ int uvc_ctrl_is_accessible(struct uvc_video_chain *chain, u32 v4l2_id,
> >       if (!ctrl)
> >               return -EINVAL;
> >
> > -     if (!(ctrl->info.flags & UVC_CTRL_FLAG_GET_CUR) && read)
> > -             return -EACCES;
> > -
> > -     if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR) && !read)
> > -             return -EACCES;
> > +     switch (ioctl) {
> > +     case VIDIOC_G_CTRL:
> > +     case VIDIOC_G_EXT_CTRLS:
> > +             if (!(ctrl->info.flags & UVC_CTRL_FLAG_GET_CUR))
> > +                     return -EACCES;
> > +             break;
> > +     case VIDIOC_S_EXT_CTRLS:
> > +     case VIDIOC_S_CTRL:
> > +             if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR))
> > +                     return -EACCES;
> > +             if (uvc_ctrl_is_inactive(chain, ctrl, mapping))
> > +                     return -EACCES;
> > +             break;
> > +     case VIDIOC_TRY_EXT_CTRLS:
> > +             if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR))
> > +                     return -EACCES;
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> >
> >       return 0;
> >  }
> > @@ -1087,8 +1127,6 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
> >       struct uvc_control_mapping *mapping,
> >       struct v4l2_queryctrl *v4l2_ctrl)
> >  {
> > -     struct uvc_control_mapping *master_map = NULL;
> > -     struct uvc_control *master_ctrl = NULL;
> >       const struct uvc_menu_info *menu;
> >       unsigned int i;
> >
> > @@ -1104,18 +1142,8 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
> >       if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR))
> >               v4l2_ctrl->flags |= V4L2_CTRL_FLAG_READ_ONLY;
> >
> > -     if (mapping->master_id)
> > -             __uvc_find_control(ctrl->entity, mapping->master_id,
> > -                                &master_map, &master_ctrl, 0);
> > -     if (master_ctrl && (master_ctrl->info.flags & UVC_CTRL_FLAG_GET_CUR)) {
> > -             s32 val;
> > -             int ret = __uvc_ctrl_get(chain, master_ctrl, master_map, &val);
> > -             if (ret < 0)
> > -                     return ret;
> > -
> > -             if (val != mapping->master_manual)
> > -                             v4l2_ctrl->flags |= V4L2_CTRL_FLAG_INACTIVE;
> > -     }
> > +     if (uvc_ctrl_is_inactive(chain, ctrl, mapping))
> > +             v4l2_ctrl->flags |= V4L2_CTRL_FLAG_INACTIVE;
> >
> >       if (!ctrl->cached) {
> >               int ret = uvc_ctrl_populate_cache(chain, ctrl);
> > diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> > index fbb99f3c2fb4..ddebdeb5a81b 100644
> > --- a/drivers/media/usb/uvc/uvc_v4l2.c
> > +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> > @@ -999,6 +999,10 @@ static int uvc_ioctl_g_ctrl(struct file *file, void *fh,
> >       struct v4l2_ext_control xctrl;
> >       int ret;
> >
> > +     ret = uvc_ctrl_is_accessible(chain, ctrl->id, VIDIOC_G_CTRL);
> > +     if (ret)
> > +             return ret;
> > +
> >       memset(&xctrl, 0, sizeof(xctrl));
> >       xctrl.id = ctrl->id;
> >
> > @@ -1023,6 +1027,10 @@ static int uvc_ioctl_s_ctrl(struct file *file, void *fh,
> >       struct v4l2_ext_control xctrl;
> >       int ret;
> >
> > +     ret = uvc_ctrl_is_accessible(chain, ctrl->id, VIDIOC_S_CTRL);
> > +     if (ret)
> > +             return ret;
> > +
> >       memset(&xctrl, 0, sizeof(xctrl));
> >       xctrl.id = ctrl->id;
> >       xctrl.value = ctrl->value;
> > @@ -1054,8 +1062,7 @@ static int uvc_ctrl_check_access(struct uvc_video_chain *chain,
> >       int ret = 0;
> >
> >       for (i = 0; i < ctrls->count; ++ctrl, ++i) {
> > -             ret = uvc_ctrl_is_accessible(chain, ctrl->id,
> > -                                         ioctl == VIDIOC_G_EXT_CTRLS);
> > +             ret = uvc_ctrl_is_accessible(chain, ctrl->id, ioctl);
> >               if (ret)
> >                       break;
> >       }
> > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > index 9471c342a310..a93aeedb5499 100644
> > --- a/drivers/media/usb/uvc/uvcvideo.h
> > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > @@ -903,7 +903,7 @@ static inline int uvc_ctrl_rollback(struct uvc_fh *handle)
> >  int uvc_ctrl_get(struct uvc_video_chain *chain, struct v4l2_ext_control *xctrl);
> >  int uvc_ctrl_set(struct uvc_fh *handle, struct v4l2_ext_control *xctrl);
> >  int uvc_ctrl_is_accessible(struct uvc_video_chain *chain, u32 v4l2_id,
> > -                        bool read);
> > +                        unsigned long ioctl);
> >
> >  int uvc_xu_ctrl_query(struct uvc_video_chain *chain,
> >                     struct uvc_xu_control_query *xqry);
> >
>


-- 
Ricardo Ribalda
