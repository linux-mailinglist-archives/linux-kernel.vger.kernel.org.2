Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3469B30959D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 14:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhA3Nyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 08:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbhA3Nv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 08:51:59 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183FDC061573
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 05:51:18 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id e15so9337569wme.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 05:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W3VBKfc+4tq/fmG30+/aKc2uMtbIAE8KQdiDwyUozgQ=;
        b=jaua0C33wX1KaPCmnOIdxz2s02T1wrTdS9POD92JnAdYIEBDQjNDOlkq9vu86BFLnr
         J+msOOLD/cC9D/76marTC4/e3flYSWPsM9IYTsH6zwJH2cjQIV4aiz/1fC1/esOJijSn
         T5q8m9EC5m9bRKPRcYgiZXVbHyXDlR28G152b5mMbktGoJFX71knwznIO0fEStgsZiYs
         aUU/VLdWvHwft/6r3hTpsgnwLX97ZA4m9LnJOnOSUaq5Y9j5UIkY0OjOwUyAdJ0SwxS6
         0ChA4i6icWbj3dua9hwjo/Yi6LAuR3bQAHtzsxMkznZqmREtLcN9ZjLwXq/OAFjE00Qz
         L0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W3VBKfc+4tq/fmG30+/aKc2uMtbIAE8KQdiDwyUozgQ=;
        b=D4rvEv4PNV6BpVId0dsXMj2x0o5/pqXwTwg6iszeMl2OtNX6ka6YH+so05WElkhU2A
         CP3QFu5KFv4Dbv0s8i0Iu4ZCYdTgG243RvHTk/277tBojEoxWyN9P4gZDRM+7MTxV/HR
         jMym3V6hM/VxqyoDL3Se2pf25B0wO35n0o0o8giFpaV//glUHtoAsRliUf/bplK7J50n
         gCUNHqJdFM9LrS2fH1V7McItN6rVBFgW1h06RiH+WcRETWq984zsIC/NIjiuXlcIlHkm
         qToIbA6gKuAb8skC7rcMQXlhphHCP31IF1o3va/yZ6R0OK0GL8kWYWTpYHWhCFHNLOLT
         e0PA==
X-Gm-Message-State: AOAM53065fEgJRvVkB9OzTSh+zyeQw6QJ3yXFjCNM5S0YQCxPVHE9OjN
        /++3/KDssYk3VBUpseiAp3xwXfsNveUxuhGNaQbgrrrhLzM=
X-Google-Smtp-Source: ABdhPJw7KtSJHup2r501KK4A1HOJY2DW3Cm6gdA+sYBex8S9Q2eqKOnegZBQSUG96/RUfvzVr2o2CDrLhUqS7tx8cqo=
X-Received: by 2002:a1c:688b:: with SMTP id d133mr7905587wmc.41.1612014676695;
 Sat, 30 Jan 2021 05:51:16 -0800 (PST)
MIME-Version: 1.0
References: <20210127105121.20345-1-lukasz.luba@arm.com>
In-Reply-To: <20210127105121.20345-1-lukasz.luba@arm.com>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Sat, 30 Jan 2021 21:51:05 +0800
Message-ID: <CAKGbVbsn=xVEa0=c3rywRShVZD18LkmLZ1qDUuDsrT5KnTjr6g@mail.gmail.com>
Subject: Re: [PATCH] drm/lima: Use delayed timer as default in devfreq profile
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, lima@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        christianshewitt@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the patch. But I can't observe any difference on glmark2
with or without this patch.
Maybe you can provide other test which can benefit from it.

Considering it will wake up CPU more frequently, and user may choose
to change this by sysfs,
I'd like to not apply it.

Regards,
Qiang

On Wed, Jan 27, 2021 at 6:51 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Devfreq framework supports 2 modes for monitoring devices.
> Use delayed timer as default instead of deferrable timer
> in order to monitor the GPU status regardless of CPU idle.
>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
> Hi all,
>
> I've missed the Lima driver while working on Panfrost patch for fixing
> the issue with default devfreq framework polling mode. More about this
> and the patch, can be found here [1].
>
> Regards,
> Lukasz Luba
>
> [1] https://lore.kernel.org/lkml/20210105164111.30122-1-lukasz.luba@arm.com/
>
>  drivers/gpu/drm/lima/lima_devfreq.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/lima/lima_devfreq.c b/drivers/gpu/drm/lima/lima_devfreq.c
> index 5686ad4aaf7c..f1c9eb3e71bd 100644
> --- a/drivers/gpu/drm/lima/lima_devfreq.c
> +++ b/drivers/gpu/drm/lima/lima_devfreq.c
> @@ -81,6 +81,7 @@ static int lima_devfreq_get_dev_status(struct device *dev,
>  }
>
>  static struct devfreq_dev_profile lima_devfreq_profile = {
> +       .timer = DEVFREQ_TIMER_DELAYED,
>         .polling_ms = 50, /* ~3 frames */
>         .target = lima_devfreq_target,
>         .get_dev_status = lima_devfreq_get_dev_status,
> --
> 2.17.1
>
