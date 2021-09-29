Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A68FA41BD6B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 05:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244005AbhI2Daq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 23:30:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35196 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243975AbhI2Dan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 23:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632886142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ypu7lSHLqUrP/H0+g4r3QAtlIt7DSpEMHZQnw4kUfiM=;
        b=Q5US/XUjUjKuRyODjblovUWUaV/iWUM5R7CU1CK0HLrzRmDJzP7gKfLonifdPXdsI1RD7F
        qIJ4V35ikNaGMvesnHl6+Ae06wXsFGpSYPG/EIT9u0KHvTDYW9eO109m/g6bAdycpl8k9y
        Xg1mRFvKr/AVwc9W6YWPoxdHGh0gc3g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-fGvSZfvXND2YT9CdW0DR6w-1; Tue, 28 Sep 2021 23:28:59 -0400
X-MC-Unique: fGvSZfvXND2YT9CdW0DR6w-1
Received: by mail-wm1-f69.google.com with SMTP id p63-20020a1c2942000000b0030ccf0767baso2076538wmp.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 20:28:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ypu7lSHLqUrP/H0+g4r3QAtlIt7DSpEMHZQnw4kUfiM=;
        b=4m6m3uMmekkNRylFC7d+sIYEm7yEKEIe2GZfkQUFmQJ6987BkJmge/IyhDEQ4fOYfn
         ++pgQi1IY1ygTFm4kMaHkPXfTzht2jS1dMGsiTaYDtWGWZH8d5PQ85DNKTkxaHE+E71P
         fTfTNtAM/9vfDXKwCryF7tGHW1HxbRGBdBMOrAwjcQRte+HdtNVVyioltP+Y37srZIZR
         rtQo2VXdExhJkZmCER11NbA28epUSXcha1RVwQW9JrgTFHze18rcT1t1vVJ1yJGk8pw2
         GlCRB+3L7MCHQjZ6W1G8Hc6p4G1mEg/zJvjZPge3Tck3lUmeqxZ49EtYwnrRY5VgmkWs
         WWFw==
X-Gm-Message-State: AOAM5318lt66xFRpG9upOY/blCFU3amHRgvXzfNjvmG7U09pTF7JHOrb
        dvYMAK51NnVmpLiSpPMgDf5wkr4zXIzHbteZTpTn7i+texMkhSG60RzScGUy0AOEh+P3dNZF2Rr
        KG4Y/SW8rpNWdgvHPB2ooLYP9x3ZPbN7fTnrLJ1RP
X-Received: by 2002:a05:600c:4991:: with SMTP id h17mr8150571wmp.74.1632886138162;
        Tue, 28 Sep 2021 20:28:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6FKlEbCVhn+zhHA/mzkU4owvOyJWUbP+zvqJr/PTgo0iMkgM659VzGx/wX8Umvr4GJinRuUX0AjYIjW/UQVU=
X-Received: by 2002:a05:600c:4991:: with SMTP id h17mr8150552wmp.74.1632886137916;
 Tue, 28 Sep 2021 20:28:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210928222513.GA294575@embeddedor>
In-Reply-To: <20210928222513.GA294575@embeddedor>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Wed, 29 Sep 2021 05:28:47 +0200
Message-ID: <CACO55tsD98dNzw8fP=CiKLsdbnn2Vg78+wTRM90kutHtv1RZ5A@mail.gmail.com>
Subject: Re: [PATCH][next] nouveau/svm: Use kvcalloc() instead of kvzalloc()
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lack of documentation inside Linux here is a bit annoying, but do I
understand it correctly, that the main (and probably only) difference
is that kvcalloc checks whether the multiplication overflows and
returns NULL in this case?

On Wed, Sep 29, 2021 at 12:21 AM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> Use 2-factor argument form kvcalloc() instead of kvzalloc().
>
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/gpu/drm/nouveau/nouveau_svm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
> index b0c3422cb01f..1a896a24288a 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_svm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
> @@ -992,7 +992,7 @@ nouveau_svm_fault_buffer_ctor(struct nouveau_svm *svm, s32 oclass, int id)
>         if (ret)
>                 return ret;
>
> -       buffer->fault = kvzalloc(sizeof(*buffer->fault) * buffer->entries, GFP_KERNEL);
> +       buffer->fault = kvcalloc(sizeof(*buffer->fault), buffer->entries, GFP_KERNEL);
>         if (!buffer->fault)
>                 return -ENOMEM;
>
> --
> 2.27.0
>

