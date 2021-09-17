Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0774E410013
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 21:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344700AbhIQTxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 15:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344518AbhIQTxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 15:53:39 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B979DC0617BC
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 12:51:14 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id m4so11468443ilj.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 12:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AO8stvH6wLQIPUW7jVtw5X0QFxjdUv6SibSuWzk36Rk=;
        b=VdePcfsHpNUgpbkw8TARXrR7jC9aG7x/7YmP5iPfWGD+cqXy5vsT4cDu7rBnNIcEY2
         yD1T4FDdiBbNu07dGt+Oo3Pl1m8rZFXCp+kenOQL8Rh0DIeOT2An+WrcS2OP1CWRny+j
         kNopwuwAZdjru1KuowyYEC1EjO5qwmF9ztCrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AO8stvH6wLQIPUW7jVtw5X0QFxjdUv6SibSuWzk36Rk=;
        b=KkZsQrb3p10krX0aEmqubcmeG0zgaZYQ6aj+mc06Yg/iwZn+pykOfr+Vbq03FQoUpW
         J1e7i2Wn8o/DqUYe8VjFAugXB+c+9oeaEvNU3sr0FtSZvTe0TScgDWjrxYzSJTFhBiRZ
         WZIxKmFW3y7Pe4XCTJZcIRMVXea1SwZ+0y8U6vpY69jbz4ALDA0A527jeS+FpTAwbgL/
         lKw7idZpZ6z1Gv2UR3k41qqJbgdH1zTiod806oBK3AUXI+98jTINHV79urHgSgkkt0Qs
         DXJj2DusrheyJFcYXvrpdvmxOKuZ3N2IQKYoF6T3zaHt0GA5UG74F+lwIZXBtEHqHMb+
         5w7w==
X-Gm-Message-State: AOAM533dGhDYzSXiTpVa2HScEo6lV+sNiuJ/Z1LtnV9mb5Hq+ie8AK+E
        VrxN+ke/Gw3GuV/VpcbjuesjvRi0t+K2Xw==
X-Google-Smtp-Source: ABdhPJw/G7DAKxwxIqt02WHYAIvl2jLVQjnYy1gaFyTjti4McdtwEcjXEpDoxmA4ELoWrCstkQl5hA==
X-Received: by 2002:a05:6e02:156c:: with SMTP id k12mr9326281ilu.61.1631908273766;
        Fri, 17 Sep 2021 12:51:13 -0700 (PDT)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com. [209.85.166.174])
        by smtp.gmail.com with ESMTPSA id s7sm3885153ioe.11.2021.09.17.12.51.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 12:51:13 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id i13so11469297ilm.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 12:51:12 -0700 (PDT)
X-Received: by 2002:a05:6e02:2141:: with SMTP id d1mr5491891ilv.242.1631908271903;
 Fri, 17 Sep 2021 12:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210917114930.47261-1-colin.king@canonical.com>
In-Reply-To: <20210917114930.47261-1-colin.king@canonical.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 17 Sep 2021 21:51:01 +0200
X-Gmail-Original-Message-ID: <CANiDSCv7okdqtfMpjPB9Gg+RvUSqsondN_-jo3xCNn7bRAaq0Q@mail.gmail.com>
Message-ID: <CANiDSCv7okdqtfMpjPB9Gg+RvUSqsondN_-jo3xCNn7bRAaq0Q@mail.gmail.com>
Subject: Re: [PATCH][next] media: uvcvideo: Fix memory leak of object map on
 error exit path
To:     Colin King <colin.king@canonical.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Collin

Thanks for catching it up.

On Fri, 17 Sept 2021 at 13:49, Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Currently when the allocation of map->name fails the error exit path
> does not kfree the previously allocated object map. Fix this by
> setting ret to -ENOMEM and taking the free_map exit error path to
> ensure map is kfree'd.
>
> Addresses-Coverity: ("Resource leak")
> Fixes: 07adedb5c606 ("media: uvcvideo: Use control names from framework")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>

> ---
>  drivers/media/usb/uvc/uvc_v4l2.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> index f4e4aff8ddf7..711556d13d03 100644
> --- a/drivers/media/usb/uvc/uvc_v4l2.c
> +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> @@ -44,8 +44,10 @@ static int uvc_ioctl_ctrl_map(struct uvc_video_chain *chain,
>         if (v4l2_ctrl_get_name(map->id) == NULL) {
>                 map->name = kmemdup(xmap->name, sizeof(xmap->name),
>                                     GFP_KERNEL);
> -               if (!map->name)
> -                       return -ENOMEM;
> +               if (!map->name) {
> +                       ret = -ENOMEM;
> +                       goto free_map;
> +               }
>         }
>         memcpy(map->entity, xmap->entity, sizeof(map->entity));
>         map->selector = xmap->selector;
> --
> 2.32.0
>


--
Ricardo Ribalda
