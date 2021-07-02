Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A313BA471
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 21:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhGBTxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 15:53:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35572 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229676AbhGBTxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 15:53:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625255445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=29SPvxPVQ0+aj9h4WhYrD9uwRhZ/3csk1qtrjUjwTJI=;
        b=PgTqf4GXXmHiyu/i1wnn10Jiuc9fpwH1IxRJXQVTGt5u8fhJw67wql1bQfjYiC+yivB3Mq
        7xhTrIOo3hHVJwTCKnGWBZAYh72HTGiLHaJV7MizD089hdqSOBnnFzwHRfpTx1C/nc2Mzm
        NJoo164n8T46P0xG6VP5jXMQL+hYa4I=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-Vkgqq8KuM6aoKI-Z4wIlbA-1; Fri, 02 Jul 2021 15:50:44 -0400
X-MC-Unique: Vkgqq8KuM6aoKI-Z4wIlbA-1
Received: by mail-qt1-f200.google.com with SMTP id x3-20020ac853830000b029025167dca6e0so6343549qtp.22
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 12:50:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=29SPvxPVQ0+aj9h4WhYrD9uwRhZ/3csk1qtrjUjwTJI=;
        b=bOL2ncaQY7HrBFWCOu2GDqHixrVBBuOGpYhdVrDS+fwBYuKwMb7BMCiHf7KN9hwXsz
         Ce7D9V+bmYM4kPMsK2GirMcN7AvPE3HjBfjeuACF+9h8v0PW23FGHE4ZWjxaRmUDWjAn
         SNl79OlP9/y/rfeJ2s/1ROmwHFWz3TsFZH6kmTFfDQBL0mmYIzkeTyo62K/pVmOAVxcK
         zo2POpUnSfk9K9a7oJ47o7lRzAKCMQHLS33N1aXr3oF3gJxa2KpPq5DTdTlz0cUOo2Xn
         pQTlKYTdOWpDORxDlWbr6qs3W2Tyoszj8p8DpD5QU6OdAZUEa/LjSdGht3ZJUBcegkZw
         oYWw==
X-Gm-Message-State: AOAM531RE66jtXhvOZ0vhokDzmBIC7Aq7hsmu3cgdXfuwLI5yrPe0X2s
        lYhzYY6TMaIm2zfvYKNoE2I5upHWI3yLCE6Cbwm8DpPNzf3hjciT0ySNSvkJDkO3CrvYlObmMi8
        NEKwi3cWXULF/MPNPzp8Oh6Qe
X-Received: by 2002:ad4:5f8c:: with SMTP id jp12mr1086876qvb.37.1625255443863;
        Fri, 02 Jul 2021 12:50:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxW/pFCKi5bwD15NnkBDOU0SdiHCeccT+EjQeuAb2xh34kiNOtKwHCq9x9h32qHxSz6gWx7IA==
X-Received: by 2002:ad4:5f8c:: with SMTP id jp12mr1086857qvb.37.1625255443708;
        Fri, 02 Jul 2021 12:50:43 -0700 (PDT)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id k8sm1853417qkj.46.2021.07.02.12.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 12:50:43 -0700 (PDT)
Message-ID: <ecd705dad88c4ea1331edc269f136aca4a5e63d5.camel@redhat.com>
Subject: Re: [PATCH v2] drm/dp_mst: Fix return code on sideband message
 failure
From:   Lyude Paul <lyude@redhat.com>
To:     Kuogee Hsieh <khsieh@codeaurora.org>, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org
Cc:     abhinavk@codeaurora.org, aravindh@codeaurora.org,
        rsubbia@codeaurora.org, rnayak@codeaurora.org,
        freedreno@lists.freedesktop.org, airlied@linux.ie, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 02 Jul 2021 15:50:42 -0400
In-Reply-To: <1625008068-16458-1-git-send-email-khsieh@codeaurora.org>
References: <1625008068-16458-1-git-send-email-khsieh@codeaurora.org>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

JFYI: will try to take a look at this at the start of next week

On Tue, 2021-06-29 at 16:07 -0700, Kuogee Hsieh wrote:
> From: Rajkumar Subbiah <rsubbia@codeaurora.org>
> 
> Commit 2f015ec6eab6 ("drm/dp_mst: Add sideband down request tracing +
> selftests") added some debug code for sideband message tracing. But
> it seems to have unintentionally changed the behavior on sideband message
> failure. It catches and returns failure only if DRM_UT_DP is enabled.
> Otherwise it ignores the error code and returns success. So on an MST
> unplug, the caller is unaware that the clear payload message failed and
> ends up waiting for 4 seconds for the response. Fixes the issue by
> returning the proper error code.
> 
> Changes in V2:
> -- Revise commit text as review comment
> -- add Fixes text
> 
> Fixes: 2f015ec6eab6 ("drm/dp_mst: Add sideband down request tracing +
> selftests")
> 
> Signed-off-by: Rajkumar Subbiah <rsubbia@codeaurora.org>
> Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
> 
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 1590144..8d97430 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -2887,11 +2887,13 @@ static int process_single_tx_qlock(struct
> drm_dp_mst_topology_mgr *mgr,
>         idx += tosend + 1;
>  
>         ret = drm_dp_send_sideband_msg(mgr, up, chunk, idx);
> -       if (unlikely(ret) && drm_debug_enabled(DRM_UT_DP)) {
> -               struct drm_printer p = drm_debug_printer(DBG_PREFIX);
> +       if (unlikely(ret)) {
> +               if (drm_debug_enabled(DRM_UT_DP)) {
> +                       struct drm_printer p =
> drm_debug_printer(DBG_PREFIX);
>  
> -               drm_printf(&p, "sideband msg failed to send\n");
> -               drm_dp_mst_dump_sideband_msg_tx(&p, txmsg);
> +                       drm_printf(&p, "sideband msg failed to send\n");
> +                       drm_dp_mst_dump_sideband_msg_tx(&p, txmsg);
> +               }
>                 return ret;
>         }
>  

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

