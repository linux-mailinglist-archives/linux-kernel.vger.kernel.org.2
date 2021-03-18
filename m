Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C57340C24
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 18:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbhCRRu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 13:50:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33172 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229964AbhCRRtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 13:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616089792;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X1aq07hUECvkiCM1AMjlNy/+yooAsZ6Cw/htSTkJaNo=;
        b=hrJ65Fpx+C5RxT4OA4ide1FK4gQ5xRsu5oyAFHBAictpw0Joz+QVWFyDhSf03dOO0FFeJW
        4EgcU0Q4TXlJOh2RK1vFqJwhyBWbidRGqmZfda0aasx4mb3YqTIoaupzqvgt+3FBBS0Zzn
        ZWGrpSyB+OYbvE9012fOPYBh3e0op0E=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-PrHa31E1M2OubflGsJVevA-1; Thu, 18 Mar 2021 13:49:49 -0400
X-MC-Unique: PrHa31E1M2OubflGsJVevA-1
Received: by mail-qk1-f198.google.com with SMTP id b78so32124304qkg.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 10:49:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=X1aq07hUECvkiCM1AMjlNy/+yooAsZ6Cw/htSTkJaNo=;
        b=OpvBpQm5+R9WH2Usf29NAJbvebCes5PDPKRehhqrwLXX+1E+RYhCfTPOs+WiYWJC3h
         hURFs75O1vCyitdZlTTEzffe29Jojgl0EHqrBXGmZl0557fDsUC/A0FSyBOIxZ7ow5Sk
         tdTVF7Bo1g+Gu0PPyZUt9SjjaiYpr49LObgpRKIDNxF41wyCp/x5DdPDPJ33eZRjQDtT
         G016UtchaGAyaWssQdxUmZRGr86V8DF9nUtDlp7Qk2vyGD4cAYEQHeClaz08QC1Ops6p
         wTErw0GpCLLVQ5FOCsvLsAAFBUMI4bkJaKuU7obeHUBq1ouWyvBhNp907UCsopSEks6A
         B5FA==
X-Gm-Message-State: AOAM533SapI8a3zZ+7LkELlWe+TAxhfBKxrABnI3iWCd0R1EaPqIDdLv
        dYBZsUmH4virIgNLT1TgNq06qDa0XWNHHQqn5j4hyUutTfxXEcFJ/RarybS5X3PEfx0MaBuSqhB
        yQjeEF7fj8XwQn/xJhOIQTl78
X-Received: by 2002:a05:620a:15eb:: with SMTP id p11mr5374087qkm.454.1616089789402;
        Thu, 18 Mar 2021 10:49:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6RlaOk96Syg3NZIwU9HFylmyO+xGqvapwSiL2VZgzQaQreQr9yUIj7wRqiSeRuR3vLr6E0Q==
X-Received: by 2002:a05:620a:15eb:: with SMTP id p11mr5374074qkm.454.1616089789174;
        Thu, 18 Mar 2021 10:49:49 -0700 (PDT)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id m90sm1923315qte.44.2021.03.18.10.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 10:49:48 -0700 (PDT)
Message-ID: <dfec442a4888c8387a6002b0424415ee5d8be343.camel@redhat.com>
Subject: Re: [PATCH] drm/i915/dpcd_bl: Don't try vesa interface unless
 specified by VBT
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     intel-gfx@lists.freedesktop.org
Cc:     Jani Nikula <jani.nikula@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sean Paul <seanpaul@chromium.org>,
        Aaron Ma <aaron.ma@canonical.com>,
        Dave Airlie <airlied@redhat.com>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Thu, 18 Mar 2021 13:49:47 -0400
In-Reply-To: <20210318170204.513000-1-lyude@redhat.com>
References: <20210318170204.513000-1-lyude@redhat.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Actually-NAK this. I just realized I've been misreading the bug and that this
doesn't actually seem to be fixed. Will resend once I figure out what's going on

On Thu, 2021-03-18 at 13:02 -0400, Lyude Paul wrote:
> Looks like that there actually are another subset of laptops on the market
> that don't support the Intel HDR backlight interface, but do advertise
> support for the VESA DPCD backlight interface despite the fact it doesn't
> seem to work.
> 
> Note though I'm not entirely clear on this - on one of the machines where
> this issue was observed, I also noticed that we appeared to be rejecting
> the VBT defined backlight frequency in
> intel_dp_aux_vesa_calc_max_backlight(). It's noted in this function that:
> 
> /* Use highest possible value of Pn for more granularity of brightness
>  * adjustment while satifying the conditions below.
>  * ...
>  * - FxP is within 25% of desired value.
>  *   Note: 25% is arbitrary value and may need some tweak.
>  */
> 
> So it's possible that this value might just need to be tweaked, but for now
> let's just disable the VESA backlight interface unless it's specified in
> the VBT just to be safe. We might be able to try enabling this again by
> default in the future.
> 
> Fixes: 2227816e647a ("drm/i915/dp: Allow forcing specific interfaces through
> enable_dpcd_backlight")
> Cc: Jani Nikula <jani.nikula@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Bugzilla: https://gitlab.freedesktop.org/drm/intel/-/issues/3169
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> index 651884390137..4f8337c7fd2e 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> @@ -646,7 +646,6 @@ int intel_dp_aux_init_backlight_funcs(struct
> intel_connector *connector)
>                         break;
>                 case INTEL_BACKLIGHT_DISPLAY_DDI:
>                         try_intel_interface = true;
> -                       try_vesa_interface = true;
>                         break;
>                 default:
>                         return -ENODEV;

-- 
Sincerely,
   Lyude Paul (she/her)
   Software Engineer at Red Hat
   
Note: I deal with a lot of emails and have a lot of bugs on my plate. If you've
asked me a question, are waiting for a review/merge on a patch, etc. and I
haven't responded in a while, please feel free to send me another email to check
on my status. I don't bite!

