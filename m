Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D827142A350
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 13:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236265AbhJLLbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 07:31:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39870 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236266AbhJLLbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 07:31:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634038177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+956HXQTjGs6a34u/u+/FjVYaM1e8zxxcd9Fx/dYps8=;
        b=S/dabcEG9ULECkofY7tOHVwcSkVlkRqm2uhSktU4itFX976xigSUvXK9QU0L4CGtdXbg1D
        AoOId0KxJrorPxCEEWmmCuS/sSrLQrPJ13QHRpA/wADi5KRqN67XcBlRoNzikQQoDVoaXz
        1QLOB8NYWrzS98aScxPO1pxf1bE5oH4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-kQ71V3HUMj6hMZXVR2JuTw-1; Tue, 12 Oct 2021 07:29:36 -0400
X-MC-Unique: kQ71V3HUMj6hMZXVR2JuTw-1
Received: by mail-wr1-f72.google.com with SMTP id h11-20020adfa4cb000000b00160c791a550so15308229wrb.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 04:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+956HXQTjGs6a34u/u+/FjVYaM1e8zxxcd9Fx/dYps8=;
        b=FJc+dgIXNd4TYcEGUGaMf/oBQ1H0TcvVpXkdFmPG+y8WPJwJl3h7ZQZ8NvMVGst/Yf
         gZIT0NixAhizBtbkwo+ZYN9ttJsAm7GrAJwQfSzXR4ez66YdpWxZ28PAbqtAke/1U3Np
         l3eOkNWP21iyNA2NFTJ7SH/T7xNKe1nGd7llobMWfQve9Trx/IRdGthmynU0ma49SpmA
         wpglkxeQX+/g+vxlgQSo/72p4fUJTohEEplI/OPkN+Qg95oqEe9plYjY4ZHZqpFV9uJU
         qYcdTDn6/tajLMqPuX+v1EON3g5a78dUzzyYcWyx8qA64eKCTDd+H5eH3INrZFJ42mUh
         /3ZQ==
X-Gm-Message-State: AOAM530MXObR4+gQxqNQWv8oaL3YMu3NerFFBfapZaZ3/RgK7rcfvTWS
        l+1xrd2cnF1FWIU9Vx6rzvdhzm94F1nihGdkt4Lg4M/tjmnJhL07MmhhbryGR3qf2T0ruEAVtZY
        CJR+nOPQBULxhsgwm+vb8ZaTLxSO8vGeMPys4NzQi
X-Received: by 2002:a05:600c:284b:: with SMTP id r11mr4940980wmb.179.1634038174952;
        Tue, 12 Oct 2021 04:29:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzSIW87MAnP/YGW/e3O+0hW0JLMaF3rLvNqNrNOXN3NYEhTe6teWlliWCUN6zZ66tm7KP2tKzRbb4aLIwOsxAQ=
X-Received: by 2002:a05:600c:284b:: with SMTP id r11mr4940959wmb.179.1634038174772;
 Tue, 12 Oct 2021 04:29:34 -0700 (PDT)
MIME-Version: 1.0
References: <20211012131836.4e17a031@canb.auug.org.au>
In-Reply-To: <20211012131836.4e17a031@canb.auug.org.au>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Tue, 12 Oct 2021 13:29:24 +0200
Message-ID: <CACO55ttUA1nwFf0UP_+8q8f_baYey0+WwcwJvLMixFDv=RsncQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the drm-misc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Luo penghao <luo.penghao@zte.com.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

uhh, that's on me. I will send out a patch today. I just noticed that
the config file I used for testing had WERROR disabled.

On Tue, Oct 12, 2021 at 4:18 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the drm-misc tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c: In function 'gp100_vmm_fault_cancel':
> drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c:491:6: error: unused variable 'inst' [-Werror=unused-variable]
>   491 |  u32 inst, aper;
>       |      ^~~~
> cc1: all warnings being treated as errors
>
> Caused by commit
>
>   404046cf4805 ("drm/nouveau/mmu/gp100-: drop unneeded assignment in the if condition.")
>
> I have used the drm-misc tree from next-20211011 for today.
>
> --
> Cheers,
> Stephen Rothwell

