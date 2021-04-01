Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2A6352153
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 23:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234412AbhDAVKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 17:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbhDAVKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 17:10:44 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C3DC0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 14:10:44 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 68-20020a9d0f4a0000b02901b663e6258dso3275912ott.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 14:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dn6QNqzedYyCxFSxmCymnqkmYNnWvvinHAK+WCVgT1o=;
        b=eD3LuB/1TLZ6RQvi2aXVuaq7Mu/BK6RTGFlbZgj9QzZS0B9/VaYkn2iiKXGC/LxVMR
         7LBtF9L40qMkvafrx+OTjPicPY0KLHHJQ7kPaD1wYoS38jrWLlXvNRC9ZOpJ/MbzXh5l
         7tEyKyJ88E7M3OsTW7tyiybe16wMxuIYQ8Mk5AfOOIx2YFRYYvSs0ti0lh5YXyhagEya
         7HZHrzp/7rxyNRkCsJJC1FIKA5wb6AiSACbjkt8ykoA+Qr2nIw/0uM/IMOkdzEZhhOZD
         k4HA8lB+luvtGDoE0CYZdQjn1mEOCLUnXIUuWhjoSh02BymInuzaMVWzevml3jolBs/q
         P+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dn6QNqzedYyCxFSxmCymnqkmYNnWvvinHAK+WCVgT1o=;
        b=gEjA6lvF+6E8whxvIrucdQyPVMrxDtOjpl+Y6zxwY2pLNlnr7v6CxkmYtBsdYWDbI8
         M9RXz1AESNQYIE5vz7Cu9UxeTW1RFR2a0w6P2Rancl1povOWn3pLO2/NY+TXWxVLCKIF
         lCDcJu7TuQ+wwmdrcWHwFg8YPUkf138Bji+qYfd19HVO0Aexxwvg6HVeQd8K6C2FDICO
         2X17UrzJAwL0jFiEHFr47S36kn5sQG2+oH5XsNLMs2N4rSXxeYxtS9U7/4ORFfTAma+9
         b8Uf3ok67UFqWMlSK/PbIllo0NngfV0izg2YAI4iwQtZbPygG8IMHBqCFm2JD7efjp2I
         ALSA==
X-Gm-Message-State: AOAM531IsksMHWVVoYpF9VujSR9TjG5sUnQmcyNUpWWE4zjS9MiKwpuM
        6L0l+ULQ1w4+QhyWBofzZ75INXdXoy/uON1lXL0=
X-Google-Smtp-Source: ABdhPJwrD9U1EuoDIcewRKSx9Axm1yuo3/l3feLiLMVJfjlNhkKopbZgudfF0DMMZz8wuNUo7fNvoSvHi9mEKNnGQZM=
X-Received: by 2002:a9d:7288:: with SMTP id t8mr8955661otj.132.1617311443744;
 Thu, 01 Apr 2021 14:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210331131218.60768-1-bernard@vivo.com>
In-Reply-To: <20210331131218.60768-1-bernard@vivo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 1 Apr 2021 17:10:32 -0400
Message-ID: <CADnq5_MR1_LaTfhAym=dbORhaBLLZxxgO13CyB4j3QA1D1RC1Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: use kmalloc_array over kmalloc with multiply
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Wed, Mar 31, 2021 at 9:36 AM Bernard Zhao <bernard@vivo.com> wrote:
>
> Fix patch check warning:
> WARNING: Prefer kmalloc_array over kmalloc with multiply
> +       buf = kmalloc(MAX_KFIFO_SIZE * sizeof(*buf), GFP_KERNEL);
>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> index 17d1736367ea..246522423559 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -81,7 +81,7 @@ static ssize_t kfd_smi_ev_read(struct file *filep, char __user *user,
>         struct kfd_smi_client *client = filep->private_data;
>         unsigned char *buf;
>
> -       buf = kmalloc(MAX_KFIFO_SIZE * sizeof(*buf), GFP_KERNEL);
> +       buf = kmalloc_array(MAX_KFIFO_SIZE, sizeof(*buf), GFP_KERNEL);
>         if (!buf)
>                 return -ENOMEM;
>
> --
> 2.31.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
