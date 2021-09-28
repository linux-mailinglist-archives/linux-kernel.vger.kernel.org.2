Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF1741ADB2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 13:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240302AbhI1LTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 07:19:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35650 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240170AbhI1LTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 07:19:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632827884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LTH1Bqp5aQrMW9U7Wyi09yKeBdxoa/KnxdAvfiFTjy0=;
        b=ApNirNrITskNaJtHM6jYrLzYPKxFSdOOrJPtB2HOzyAvjWjVJDK+PNKCpDCBVS8GkFGDsa
        XUCZil1RECx0Z0q1GecG5xQmd+Ky10tmHHMvkQpAXFQFngJDA0YeTVMIgkRwUR5L/SUv0O
        BeaUzmvSikGnx3no1MGv4/ASXm3LbLs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-VHxARXXkOO-AM4STDZDCJw-1; Tue, 28 Sep 2021 07:18:02 -0400
X-MC-Unique: VHxARXXkOO-AM4STDZDCJw-1
Received: by mail-wm1-f71.google.com with SMTP id p63-20020a1c2942000000b0030ccf0767baso966677wmp.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 04:18:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LTH1Bqp5aQrMW9U7Wyi09yKeBdxoa/KnxdAvfiFTjy0=;
        b=YWeeUJS9+a1wmVGWXjPDO4hz2VphFWj6gDyM7zj1hKXF1yJWfyD3Yf9jnUHMFH5MUS
         vbGqoKAITnM1fE7imnjXba+LDqHr8jaEA6bR0goL+CxPfYEM7fxolBGHT4s+dCxzk2/w
         eMIv7RsJ/nfBqmQbSHJU4HyRPRyX7k/PNqRzmsd3lcNFLqGQMI7F/DpcWTcF9j+QiTjL
         KtDc6meu0cP6mqBDOyPPwutYPtKkdf0QXIzdkLajKGx+IBC8xgOo8XEo9wPoSnSz+tC6
         4EBV/RBg4Rp8Vu2bL7/B+R/jXaNsjnkX4nJaUVoWhJNJ9Y6W4UeBL36N+u/uWBV4rhLw
         DQJg==
X-Gm-Message-State: AOAM533FjfD40XpjfO/WxC/6saEjeGcMM+zqTtqpQy5gSjEcEgx2qj39
        NIbHAxp+JsAnH/cu4OGPm3wV8UcwYMSJpaX8Uu3RRajyPtGZB17H49Bh3QzChggiosRLw2YnoPE
        YOq7N6s7YRFp7Rs/fG3pgkKS2DcbI/6dJGVxF8ruE
X-Received: by 2002:a5d:59a6:: with SMTP id p6mr5703235wrr.142.1632827881283;
        Tue, 28 Sep 2021 04:18:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXey4AvCzQ1OIitejIrHYkhslIGKRMhKkajU7oL55IV3B2Y8nmEuFYibwyOSrec5I/msAUej7ScCzCJYa6KtI=
X-Received: by 2002:a5d:59a6:: with SMTP id p6mr5703226wrr.142.1632827881160;
 Tue, 28 Sep 2021 04:18:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210821021447.27097-1-luo.penghao@zte.com.cn>
In-Reply-To: <20210821021447.27097-1-luo.penghao@zte.com.cn>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Tue, 28 Sep 2021 13:17:50 +0200
Message-ID: <CACO55tt3FF1gEffPjQTS+m3oW1yWG_xUQL_kP=kezyesj_oYkg@mail.gmail.com>
Subject: Re: [PATCH linux-next] drm/nouveau/mmu/gp100-: drop unneeded
 assignment in the if condition.
To:     CGEL <cgel.zte@gmail.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alistair Popple <apopple@nvidia.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Karol Herbst <kherbst@redhat.com>

but I will remove the unnecessary brackets as well

On Sat, Aug 21, 2021 at 10:46 AM CGEL <cgel.zte@gmail.com> wrote:
>
> From: Luo penghao <luo.penghao@zte.com.cn>
>
> In order to keep the code style consistency of the whole file,
> the 'inst' assignments should be deleted.
>
> The clang_analyzer complains as follows:
>
> drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c:499:8: warning:
> Although the value storedto 'inst' is used in the enclosing expression,
> the value is never actually read from 'inst'.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Luo penghao <luo.penghao@zte.com.cn>
> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c
> index f02abd9..5d7766a 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c
> @@ -502,7 +502,7 @@ gp100_vmm_fault_cancel(struct nvkm_vmm *vmm, void *argv, u32 argc)
>         args->v0.inst |= 0x80000000;
>
>         if (!WARN_ON(nvkm_gr_ctxsw_pause(device))) {
> -               if ((inst = nvkm_gr_ctxsw_inst(device)) == args->v0.inst) {
> +               if ((nvkm_gr_ctxsw_inst(device)) == args->v0.inst) {
>                         gf100_vmm_invalidate(vmm, 0x0000001b
>                                              /* CANCEL_TARGETED. */ |
>                                              (args->v0.hub    << 20) |
> --
> 2.15.2
>
>

