Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D162453B8B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 22:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhKPVU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 16:20:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:51239 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229642AbhKPVU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 16:20:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637097480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z4ttEiULMGdMkhTFpGiltGiBnhVT9018p53mbEP4OWA=;
        b=J81VOHKyenB+e/rWLuv+VBa+6X6OxB9SZg1cno/QHPSIUcfr8uUz45UpKB2OnMwYXWB9sW
        gsfDZyWH8yMznxFOjRrx+gxN/o+ABsmLPYx4jjHitFeCrHUaRc8/kA6+AzJ5cVoyrYjl46
        5MrR46M40xE6r5k9PtHEvRWxJjXjPpk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-129-Lf6mCZF2NG2lmsqxHJnohA-1; Tue, 16 Nov 2021 16:17:59 -0500
X-MC-Unique: Lf6mCZF2NG2lmsqxHJnohA-1
Received: by mail-qv1-f72.google.com with SMTP id kj12-20020a056214528c00b003bde2e1df71so570623qvb.18
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 13:17:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=z4ttEiULMGdMkhTFpGiltGiBnhVT9018p53mbEP4OWA=;
        b=qrQotjd3XPc69Ys24o6QwBlguol1CiVLgg7j21TjwrkxYapNq4zk4H3j9hT8rf6GQl
         rLdsJRdJlbQP411NknfLAqeMNwEJq0qTUwn+MD6XxEjRypkNyJ80wgvQ2Stb+3mr9PIy
         mxaDYhFKl61r8Uzi8vsP0vrFemuSwCWZDdmlA9kWa3d8qSbTyzph711ZHUupaUXQ/S+w
         9/KvLxnvwXo4VJQVthG/Kp7oS4GNQ9yuCcTfgBEVX+1oqBxpTxu2RI1mFCqC2mEMlAWm
         QoBG4rugkZzSOCRvJI7aZyYahlL6mZlDPnq5Kr0COcyYpQPgNL7UOE8Ak/0y+dlaPQEI
         AVlg==
X-Gm-Message-State: AOAM531NTNMKa6D8zvdlBxbBGlGMRPd9OmZwZDN8gQBmCjnKll6N/s37
        TO5I2/rd4gK7gGxfFZfyfA6djhBMsjiMFHeq3Hj7Cg7BQY3wwn+zO0q2aBXWip7dM6l55j90T5c
        KT+NOYwXZfNa/BdeSj1n3skk0
X-Received: by 2002:a37:9d8b:: with SMTP id g133mr8461206qke.180.1637097478675;
        Tue, 16 Nov 2021 13:17:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz62Hg/kjKrougWFbpHWD2ssL0dJuk/qAO5ctquOWFbZqBzjVoR9pGuski9Qq326P5ilEvfEA==
X-Received: by 2002:a37:9d8b:: with SMTP id g133mr8461185qke.180.1637097478494;
        Tue, 16 Nov 2021 13:17:58 -0800 (PST)
Received: from [192.168.8.138] (pool-96-230-249-157.bstnma.fios.verizon.net. [96.230.249.157])
        by smtp.gmail.com with ESMTPSA id y16sm9564415qtm.12.2021.11.16.13.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 13:17:58 -0800 (PST)
Message-ID: <6a79eef26121afa9190de5a021f4edef53fc9651.camel@redhat.com>
Subject: Re: [PATCH] In function nvkm_ioctl_map(), the variable "type" could
 be uninitialized if "nvkm_object_map()" returns error code, however, it
 does not check the return value and directly use the "type" in the if
 statement, which is potentially unsafe.
From:   Lyude Paul <lyude@redhat.com>
To:     Yizhuo Zhai <yzhai003@ucr.edu>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 16 Nov 2021 16:17:56 -0500
In-Reply-To: <20211116070708.429432-1-yzhai003@ucr.edu>
References: <20211116070708.429432-1-yzhai003@ucr.edu>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a very long patch name, it should probably be shorter and the
details in the patch title moved into the actual commit description
instead. Also a couple of things aren't formatted correctly:

* Cc tag for stable is missing, see
  https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
* Fixes tag isn't formatted properly

I generally recommend using `dim fixes` from
https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
in order to get the correct stable kernel CC tag and Fixes: tag (you can
drop any of the Ccs it gives you beyond the one to stable at vger dot
kernel dot org.

Also, if you could try to Cc: me on the next version - will help me
respond faster :).

On Mon, 2021-11-15 at 23:07 -0800, Yizhuo Zhai wrote:
> Fixes:01326050391ce("drm/nouveau/core/object: allow arguments to
> be passed to map function")
> Signed-off-by: Yizhuo Zhai <yzhai003@ucr.edu>
> ---
>  drivers/gpu/drm/nouveau/nvkm/core/ioctl.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/core/ioctl.c
> b/drivers/gpu/drm/nouveau/nvkm/core/ioctl.c
> index 735cb6816f10..4264d9d79783 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/core/ioctl.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/core/ioctl.c
> @@ -266,6 +266,8 @@ nvkm_ioctl_map(struct nvkm_client *client,
>                 ret = nvkm_object_map(object, data, size, &type,
>                                       &args->v0.handle,
>                                       &args->v0.length);
> +               if (ret)
> +                       return ret;
>                 if (type == NVKM_OBJECT_MAP_IO)
>                         args->v0.type = NVIF_IOCTL_MAP_V0_IO;
>                 else

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

