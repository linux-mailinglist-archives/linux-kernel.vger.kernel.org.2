Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014BF3893BF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 18:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355332AbhESQ24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 12:28:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21052 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355274AbhESQ2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 12:28:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621441647;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nGnpvPgbrDN+JDIydAmxeVfjxeD6fg7sVHqQMUXSv7o=;
        b=LTPMPMcz/XBpp4Jdg0FmA4zVhoF53gPME9Wup2XeOuAMTGV+eIg684cu8R2YlJw4bMbWsl
        66hFdgluj+NoCj03CD7nq+2e4hI548hPp50mnB/IPD1M5EN+rXmVUMZUoHxdI90IAnIOAy
        gu3aLJJhfRFlc3haBEpAnFNKCO4GwAI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-DbDCeKtpMz29-UV44YfxuQ-1; Wed, 19 May 2021 12:27:04 -0400
X-MC-Unique: DbDCeKtpMz29-UV44YfxuQ-1
Received: by mail-qv1-f70.google.com with SMTP id l61-20020a0c84430000b02901a9a7e363edso10742850qva.16
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 09:27:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=nGnpvPgbrDN+JDIydAmxeVfjxeD6fg7sVHqQMUXSv7o=;
        b=Y17ZLzJY6gvdcsdeHG+u6D4a8A73XQ6eWvh4qII5trWxrpCtnIBvyEohM4i4Yj1jQv
         whktbL4weuhiXcjqExBKbOyFygKL1rC4hGKWMHvsy5Du1vR9B2onPU2V+iSn7lgQF37K
         Z1HslNQwWr2X+H0Vs+n+0UXwymHSt7n7w7R+h+ytBM5cErVfyeISwocUiTXbZuh8LstU
         owf3XZwEpcdRKq5hndkpuqx3mmqKai+D9nE+f480ZUJsfTVrCBlvDq2ZzphBFTtIux1d
         SCjppgY1wtiYZXwx2IjPD+HGWyAbQJYYf4DW12TcRtrxBvoolwZP10YwsANdusGUtl6x
         IWpA==
X-Gm-Message-State: AOAM531dDQb3ljz+5zYKXs3HxK14b8aPgVSArHmCUu6oDW9odZz2eEgY
        V+jmN092BGoIzOQLYVme4TaCEmAO3DHw517LdlSQmHDqdmgaMDCO/9o4InI9/t+KkAgk7BPY+QA
        jdUOWYE11//bR2njluMGw8hjP
X-Received: by 2002:ae9:ef14:: with SMTP id d20mr132273qkg.107.1621441624439;
        Wed, 19 May 2021 09:27:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxxhWDl0Wrh3EwbniSsRrVjhhrSiaiOxzCbltW98bS6gYPpFU5nR/3zpxDikzE/i/6y4FaOw==
X-Received: by 2002:ae9:ef14:: with SMTP id d20mr132265qkg.107.1621441624268;
        Wed, 19 May 2021 09:27:04 -0700 (PDT)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id z187sm97109qkb.129.2021.05.19.09.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 09:27:03 -0700 (PDT)
Message-ID: <57b373372cb64e8a48d12e033a23e7711332b0ec.camel@redhat.com>
Subject: Re: [PATCH] drm/i915: Force DPCD backlight mode for Samsung 16727
 panel
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Aaron Ma <aaron.ma@canonical.com>, jani.nikula@intel.com,
        airlied@linux.ie, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Wed, 19 May 2021 12:27:03 -0400
In-Reply-To: <20210519095305.47133-1-aaron.ma@canonical.com>
References: <20210519095305.47133-1-aaron.ma@canonical.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seems reasonable to me:

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Wed, 2021-05-19 at 17:53 +0800, Aaron Ma wrote:
> Another Samsung OLED panel needs DPCD to get control of backlight.
> Kernel 5.12+ support the backlight via:
> commit: <4a8d79901d5b> ("drm/i915/dp: Enable Intel's HDR backlight interface
> (only SDR for now)")
> Only make backlight work on lower versions of kernel.
> 
> Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/3474
> Cc: stable@vger.kernel.org # 5.11-
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
>  drivers/gpu/drm/drm_dp_helper.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
> index 5bd0934004e3..7b91d8a76cd6 100644
> --- a/drivers/gpu/drm/drm_dp_helper.c
> +++ b/drivers/gpu/drm/drm_dp_helper.c
> @@ -1960,6 +1960,7 @@ static const struct edid_quirk edid_quirk_list[] = {
>         { MFG(0x4d, 0x10), PROD_ID(0xe6, 0x14),
> BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
>         { MFG(0x4c, 0x83), PROD_ID(0x47, 0x41),
> BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
>         { MFG(0x09, 0xe5), PROD_ID(0xde, 0x08),
> BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
> +       { MFG(0x4c, 0x83), PROD_ID(0x57, 0x41),
> BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
>  };
>  
>  #undef MFG

-- 
Sincerely,
   Lyude Paul (she/her)
   Software Engineer at Red Hat
   
Note: I deal with a lot of emails and have a lot of bugs on my plate. If you've
asked me a question, are waiting for a review/merge on a patch, etc. and I
haven't responded in a while, please feel free to send me another email to check
on my status. I don't bite!

