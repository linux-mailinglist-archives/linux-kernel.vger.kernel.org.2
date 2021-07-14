Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A60C3C8B44
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 20:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240098AbhGNSv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 14:51:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35158 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238941AbhGNSv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 14:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626288516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IAAG1k0NOT+ym7PfZu/f9WCZIsLgpHJ+m+NpG0hxB7k=;
        b=bmKq37HmdYD/xxnD0FX1Unkgw7IMHFYckIlSm7jjUIGwOBY1OXuogG2azPqu39c1yAc+9E
        4ECcMGY+O+T3F9Sp1axvDG60VaRAoBjd2pJg9inrH/gtDGzDhnvJpeN0VmyCX+CrBhIj2z
        KGXkuQtcPaMyf8RcsPjTGF4f24XnF0Q=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-545-nfJ9ySduNpqH1LDyf3g20g-1; Wed, 14 Jul 2021 14:48:35 -0400
X-MC-Unique: nfJ9ySduNpqH1LDyf3g20g-1
Received: by mail-qt1-f197.google.com with SMTP id j16-20020ac855100000b029025bf786be09so2470235qtq.20
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 11:48:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=IAAG1k0NOT+ym7PfZu/f9WCZIsLgpHJ+m+NpG0hxB7k=;
        b=Gv5Rk0ENJ9lIEYaCfQewWb9oEOaj5Yo/nwa8LoHaOZL3Y8GkRo5dab9GM0zU/XmeXs
         aK7psMM0FWLzc53fzHVwq/8OW6oo6llUw6TTpoF8swOo478QB3sz+mxSOiuHtC2HeZZE
         gTGA2PviVr5ZJNbGg9BSanw0a3E6Ge0lIL+yAuU4boIsSffeI2Qy8Mdhph9c15cKCXtL
         aMXM2GeLM+HKEnM8HiH8c5bUWGrqt6Au2ij532/d8ZwSaAzIW/bEGq9aRdY6n/iyMTDY
         Kw5vwrOKccm60JNgo2iQArtzUnykjnrGAIHHk/njd7SAYQXeEjU2GTvPoBblfyPOrlsg
         fOUA==
X-Gm-Message-State: AOAM532Wb1CSsTv9Rm+rmSi7oxxJVqDGflAVIRv6dGfgXOlTh9CdCgyF
        b/zecdGa/ddUEhubtfkNGu4ssGQKhdSKNBN/qpRop6f85NHZ6v7h2acBS5YqU8nVVaTn3X9bqgd
        OBsKvSomwiYgSSM610vlGZB9g
X-Received: by 2002:a05:620a:2486:: with SMTP id i6mr11706225qkn.142.1626288514788;
        Wed, 14 Jul 2021 11:48:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTzkuZkVkZeDwSGZU5OrDpRxFfb/p+SDHUynGKRITTybPtm0GFBfFCAzQogD2Ky5fRu2d1fg==
X-Received: by 2002:a05:620a:2486:: with SMTP id i6mr11706211qkn.142.1626288514646;
        Wed, 14 Jul 2021 11:48:34 -0700 (PDT)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id c16sm1355706qka.122.2021.07.14.11.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 11:48:34 -0700 (PDT)
Message-ID: <a1ece28471de34abbc8238836622f662dc2f27af.camel@redhat.com>
Subject: Re: [PATCH] drm/panel-simple: Power the panel when probing DP AUX
 backlight
From:   Lyude Paul <lyude@redhat.com>
To:     Douglas Anderson <dianders@chromium.org>,
        Rajeev Nandan <rajeevny@codeaurora.org>,
        Robert Foss <robert.foss@linaro.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Wed, 14 Jul 2021 14:48:33 -0400
In-Reply-To: <20210714093334.1.Idb41f87e5abae4aee0705db7458b0097fc50e7ab@changeid>
References: <20210714093334.1.Idb41f87e5abae4aee0705db7458b0097fc50e7ab@changeid>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Wed, 2021-07-14 at 09:33 -0700, Douglas Anderson wrote:
> When I tried booting up a device that needed the DP AUX backlight, I
> found an error in the logs:
>   panel-simple-dp-aux: probe of aux-ti_sn65dsi86.aux.0 failed with error -
> 110
> 
> The aux transfers were failing because the panel wasn't powered. Just
> like when reading the EDID we need to power the panel when trying to
> talk to it. Add the needed pm_runtime calls.
> 
> After I do this I can successfully probe the panel and adjust the
> backlight on my board.
> 
> Fixes: bfd451403d70 ("drm/panel-simple: Support DP AUX backlight")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  drivers/gpu/drm/panel/panel-simple.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c
> b/drivers/gpu/drm/panel/panel-simple.c
> index e0a05f366ce6..9b286bd4444f 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -827,7 +827,10 @@ static int panel_simple_probe(struct device *dev, const
> struct panel_desc *desc,
>                 goto disable_pm_runtime;
>  
>         if (!panel->base.backlight && panel->aux) {
> +               pm_runtime_get_sync(dev);
>                 err = drm_panel_dp_aux_backlight(&panel->base, panel->aux);
> +               pm_runtime_mark_last_busy(dev);
> +               pm_runtime_put_autosuspend(dev);
>                 if (err)
>                         goto disable_pm_runtime;
>         }

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

