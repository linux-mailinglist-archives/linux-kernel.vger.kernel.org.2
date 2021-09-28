Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB48841ADE6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 13:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240368AbhI1Lga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 07:36:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39736 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240302AbhI1Lg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 07:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632828889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M/E3G8A3gYE+U2dreASmQnyRqiphlZRJm1ekOxiW/BA=;
        b=Db/jIBEtXpIF0syeXJbAx/fFMLc5JI7+RsqWEmh46it7oWi0AOI1QcAus/tgJiScHEGby/
        OILD7U7ibUKB5okAl/haMvaLNPh2eF+lVSeTAEDOQIv/3mTCkTJTDfzRzPROCY0xMVnrni
        9tjdiooy0kbzEExK2lNIQetfO+zoD5Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-_Q9W-OGGM7aCznE82X-BhA-1; Tue, 28 Sep 2021 07:34:48 -0400
X-MC-Unique: _Q9W-OGGM7aCznE82X-BhA-1
Received: by mail-wm1-f71.google.com with SMTP id k5-20020a7bc3050000b02901e081f69d80so1872238wmj.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 04:34:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M/E3G8A3gYE+U2dreASmQnyRqiphlZRJm1ekOxiW/BA=;
        b=SP+Ws415pq9qWQM7YNRIjTv1b8mvXG5USPtsRrFxdzPOJe20fr7dPvgmxE5O/siBn1
         jsLu8L8kgkS/8tF+0dE404Fx4yCHUDd0BOcJ8VOj4Kvg3hY7rXQ5uvEnf5Tq4kN6pJ4v
         PCiYGHG+BUiChiReQH6jRB/GPZyhUXC9qkZJ4JQS12qDMp6gJBltil29To+kdTCXVV46
         iCdP5RkWVOR4sBTxw1QAhflqoslfJMlUeQW0XUn9FvVsiXFs/osEr0IAJfmgqXcs70fP
         qAizfvBL2VTVghZYBAwrvYsp9pKGcEV0uk4PULSJQV2S2lJv1OllVvVWaWm5trGR15kI
         NkRQ==
X-Gm-Message-State: AOAM531FG1wDvWy7oFV0R14zZ0mxm5FJPVRay11PXoNSLyO49Rj8Xu5U
        zLLHvXsJl3XCe++n+okFMgwQzNlX3VXPy/024Mo8JcSZNo8A3nYFhvlAROX+K9bmLoO4YrIxohD
        zIP1ueKkiHaOljrZ6xCZ5K/5Sp3Btw0RPbd91SGFJ
X-Received: by 2002:adf:e684:: with SMTP id r4mr5880465wrm.229.1632828887297;
        Tue, 28 Sep 2021 04:34:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJys6dX122BOsP5c995TAAKHZg1HhiNlNbb3SH87eApAz3oYL6keGkax7mwj4JY6pjNM9VZ/avus/dM3dwa+cIU=
X-Received: by 2002:adf:e684:: with SMTP id r4mr5880447wrm.229.1632828887161;
 Tue, 28 Sep 2021 04:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210911075023.3969054-1-yangyingliang@huawei.com> <20210911075023.3969054-2-yangyingliang@huawei.com>
In-Reply-To: <20210911075023.3969054-2-yangyingliang@huawei.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Tue, 28 Sep 2021 13:34:36 +0200
Message-ID: <CACO55tsKcZjB_9E-QfbDY99LT+w_fgssONjEd-qymoSCe0Z7qw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/nouveau/debugfs: fix file release memory leak
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Karol Herbst <kherbst@redhat.com>

On Sat, Sep 11, 2021 at 9:45 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> When using single_open() for opening, single_release() should be
> called, otherwise the 'op' allocated in single_open() will be leaked.
>
> Fixes: 6e9fc177399f ("drm/nouveau/debugfs: add copy of sysfs pstate interface ported to debugfs")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_debugfs.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.c b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> index c2bc05eb2e54..1cbe01048b93 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> @@ -207,6 +207,7 @@ static const struct file_operations nouveau_pstate_fops = {
>         .open = nouveau_debugfs_pstate_open,
>         .read = seq_read,
>         .write = nouveau_debugfs_pstate_set,
> +       .release = single_release,
>  };
>
>  static struct drm_info_list nouveau_debugfs_list[] = {
> --
> 2.25.1
>

