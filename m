Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E46844D2F8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 09:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbhKKIPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 03:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbhKKIPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 03:15:31 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97F9C0613F5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 00:12:42 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id 7so97668oip.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 00:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KQq/BQSI+/+gb2fPGmG7DEX6ES551D0y01me3Mg5Cvk=;
        b=grffX+6iRJp/AuG8bzCb596zILz1Ddz2xAkvUAEL4mdY08rdPabLMt4cHLeaNW39g3
         RWdKkKMWez+bBKfMZkTBhxNHbTDQWO/yy5isw8RVc4MmEGIT7Pp3lW9QhhKrnMRFsh23
         AnwHXTaQdTA8wAsGQHr8tjfYEyrDxB6XJfu4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KQq/BQSI+/+gb2fPGmG7DEX6ES551D0y01me3Mg5Cvk=;
        b=ynuDLXt9vzEeu5B4sThkP91Z2ril/j0aGsjTpP11kDVWWiKCiNzsuYeQchs40KkVCH
         u4YhaHGVCJx1rHxCLhAnM7n1hrcKIPQaTbDdpoxeIo/RzHBoDOlfz50QYoU7g0tRt5iY
         6/gN3/cQs7Qo+JDJg921Q3TZOhv9ac78e+taFfwT/djLUcISNHu8/t/UZ54jgcPQW0Pn
         iyXZz9NPpTenQg9iHsfZywouqyDSFOyewMMUjwoJEtt8ry7MHdRlr7rh5H3uVMvFXLUE
         ZIcZ9J7V20oteypyz08pFPEWFxok5irN0HWAj4uoaJ172ug9f4AQXEciy82IsmtJNowj
         Nmmw==
X-Gm-Message-State: AOAM532SDjNgP7V754goXTO7njIfBw66UzrgcC04vk/yaP0P3weZhGJK
        ijngfv14dnIhdUFc0GdorOYAnJAvLKtfQA==
X-Google-Smtp-Source: ABdhPJx5WnnL1uR+IdhxT6qctPtr+fk3WiKPpbT4B/ADGD/wawCiHTsf+q9nex+12x289hqKqdtyUg==
X-Received: by 2002:a05:6808:140f:: with SMTP id w15mr4817514oiv.16.1636618362163;
        Thu, 11 Nov 2021 00:12:42 -0800 (PST)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com. [209.85.210.42])
        by smtp.gmail.com with ESMTPSA id 64sm514961otm.37.2021.11.11.00.12.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 00:12:41 -0800 (PST)
Received: by mail-ot1-f42.google.com with SMTP id x19-20020a9d7053000000b0055c8b39420bso7845025otj.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 00:12:41 -0800 (PST)
X-Received: by 2002:a9d:5541:: with SMTP id h1mr4442058oti.229.1636618360946;
 Thu, 11 Nov 2021 00:12:40 -0800 (PST)
MIME-Version: 1.0
References: <95f3fd02313ff41d6808b8e1f20e0c582f46edc8.1636617903.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <95f3fd02313ff41d6808b8e1f20e0c582f46edc8.1636617903.git.christophe.jaillet@wanadoo.fr>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 11 Nov 2021 09:12:29 +0100
X-Gmail-Original-Message-ID: <CANiDSCsWE+cr70hdNkqXKxj8EXdJ-bRtXqLDgiGhYVdHYTFHBQ@mail.gmail.com>
Message-ID: <CANiDSCsWE+cr70hdNkqXKxj8EXdJ-bRtXqLDgiGhYVdHYTFHBQ@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Fix a memory leak in an error handling
 path of 'uvc_ioctl_ctrl_map()'
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     laurent.pinchart@ideasonboard.com, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe

I believe this is a dup of:
https://lore.kernel.org/lkml/20210917114930.47261-1-colin.king@canonical.com/

Thanks

On Thu, 11 Nov 2021 at 09:06, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> If 'map->name' can't be allocated, 'map' must be released before returning.
>
> Fixes: 70fa906d6fce ("media: uvcvideo: Use control names from framework")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/media/usb/uvc/uvc_v4l2.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> index f4e4aff8ddf7..5aa76a9a6080 100644
> --- a/drivers/media/usb/uvc/uvc_v4l2.c
> +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> @@ -44,8 +44,10 @@ static int uvc_ioctl_ctrl_map(struct uvc_video_chain *chain,
>         if (v4l2_ctrl_get_name(map->id) == NULL) {
>                 map->name = kmemdup(xmap->name, sizeof(xmap->name),
>                                     GFP_KERNEL);
> -               if (!map->name)
> +               if (!map->name) {
> +                       kfree(map);
>                         return -ENOMEM;
> +               }
>         }
>         memcpy(map->entity, xmap->entity, sizeof(map->entity));
>         map->selector = xmap->selector;
> --
> 2.30.2
>


-- 
Ricardo Ribalda
