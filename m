Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7321943E9EF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 23:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbhJ1VCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 17:02:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32043 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230404AbhJ1VCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 17:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635454809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YyHcHMPFK6L4kSqZBARMjYQnoudOF5bHyFz0FdV/YWw=;
        b=Pq/5Ah4MLy8w++WZnE7quaKdeP75UH6CZtk2XBmdjgEgNDSYzezbeNC1G8z1z8TEhETSe9
        khm77zJLW3Bhik9ZLFeDj5WqUf0Bz0GkrC+C0I2wMmZJN683EM0R3ZnOSdFsuGA+sPILr3
        UTWH3Jy7zbe6NMqItCwkXF09+k2BXZQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-Z6_CJeuCNGqYxuE4aJzefg-1; Thu, 28 Oct 2021 17:00:06 -0400
X-MC-Unique: Z6_CJeuCNGqYxuE4aJzefg-1
Received: by mail-qv1-f72.google.com with SMTP id ed7-20020ad44ea7000000b003856143a678so5970125qvb.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 14:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=YyHcHMPFK6L4kSqZBARMjYQnoudOF5bHyFz0FdV/YWw=;
        b=cisnrFKNJiYF6mbsRfwyaCFgLDTmfwjbfkH9WiHrJIO0I6b2Lm0SQDXXZou4CWjmss
         fkFbcH+yBux4HK0FvDBTeugBncyJ9sX5lgWRdHjz84Y0xwg5H0ChrdpHbbxIpsyS/8F5
         TjdZ41ztri1/3JfA3SaLnGxEUepan5743SoyGxFinLpWdCBeEhp2t0JyQN5k+DYhJ4Vi
         zAiCDj7G3p6HrOozAlUEEvdPNHDod8yaurv8krrQDr9zdJE2TZAA90Rdh2h6nDEVWS0b
         G/ovaoAtttvHd87b1Zqm3GU+pp+1lJcSwZZnfI8NdKS+79PehDXnlFOm0YIZx7NZlqiQ
         jLQw==
X-Gm-Message-State: AOAM531EIqwn/A2FCmbk3/GppjPYcA922vadWF5Y5twM5zKChCUCrqDS
        uT+g5FCgVB7n2iUiCevqb/p9MB5Xd4wbFNek4/MAXlaVL/VZArmwPpKdtwU8+pFla4ZJA9aTjQ3
        tR6Dr3Q/a7PGcEWY68o1wkX+G
X-Received: by 2002:ac8:7193:: with SMTP id w19mr7354834qto.311.1635454806037;
        Thu, 28 Oct 2021 14:00:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDlnXAfxMInUNg2FDZR0gL41Mf7pQpcS0zWxi7UlLCw9YzoEg6Gp1ylQDXamI3Dcj5CHkREg==
X-Received: by 2002:ac8:7193:: with SMTP id w19mr7354806qto.311.1635454805809;
        Thu, 28 Oct 2021 14:00:05 -0700 (PDT)
Received: from [192.168.8.138] (pool-96-230-249-157.bstnma.fios.verizon.net. [96.230.249.157])
        by smtp.gmail.com with ESMTPSA id w185sm2692822qkd.30.2021.10.28.14.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 14:00:05 -0700 (PDT)
Message-ID: <2f2145ed5e0a73a59a6996f2f709a3270b8d1449.camel@redhat.com>
Subject: Re: [PATCH v4 3/5] drm/dp: Disable unsupported features in
 DP_EDP_BACKLIGHT_MODE_SET_REGISTER
From:   Lyude Paul <lyude@redhat.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Intel Graphics <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>,
        Satadru Pramanik <satadru@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Date:   Thu, 28 Oct 2021 17:00:03 -0400
In-Reply-To: <CAD=FV=VXJA0DoCBOG+fzqv-5rYP4mWQE-HPxH9DxCVWgnuS4Dw@mail.gmail.com>
References: <20211026220848.439530-1-lyude@redhat.com>
         <20211026220848.439530-4-lyude@redhat.com>
         <CAD=FV=VXJA0DoCBOG+fzqv-5rYP4mWQE-HPxH9DxCVWgnuS4Dw@mail.gmail.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-10-28 at 11:27 -0700, Doug Anderson wrote:
> Hi,
> 
> On Tue, Oct 26, 2021 at 3:09 PM Lyude Paul <lyude@redhat.com> wrote:
> > 
> > As it turns out, apparently some machines will actually leave additional
> > backlight functionality like dynamic backlight control on before the OS
> > loads. Currently we don't take care to disable unsupported features when
> > writing back the backlight mode, which can lead to some rather strange
> > looking behavior when adjusting the backlight.
> > 
> > So, let's fix this by ensuring we only keep supported features enabled for
> > panel backlights - which should fix some of the issues we were seeing from
> > this on fi-bdw-samus.
> > 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > Fixes: 867cf9cd73c3 ("drm/dp: Extract i915's eDP backlight code into DRM
> > helpers")
> > ---
> >  drivers/gpu/drm/drm_dp_helper.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_dp_helper.c
> > b/drivers/gpu/drm/drm_dp_helper.c
> > index ada0a1ff262d..8f2032a955cf 100644
> > --- a/drivers/gpu/drm/drm_dp_helper.c
> > +++ b/drivers/gpu/drm/drm_dp_helper.c
> > @@ -3372,7 +3372,9 @@ int drm_edp_backlight_enable(struct drm_dp_aux *aux,
> > const struct drm_edp_backli
> >                 return ret < 0 ? ret : -EIO;
> >         }
> > 
> > -       new_dpcd_buf = dpcd_buf;
> > +       /* Disable any backlight functionality we don't support that might
> > be on */
> > +       new_dpcd_buf = dpcd_buf & (DP_EDP_BACKLIGHT_CONTROL_MODE_MASK |
> > +                                  DP_EDP_BACKLIGHT_FREQ_AUX_SET_ENABLE);
> 
> My first thought when reading the above was: if we're masking so much
> stuff out, why do we bother reading the old value back out at all?
> 
> I guess the two places you use the old value for are:
> 
> 1. You avoid setting the "DP_EDP_PWMGEN_BIT_COUNT" if the backlight
> was already configured for DPCD mode.
> 
> 2. You avoid writing the register if you didn't change it.
> 
> I would actually argue that use #1 is probably a bug. If you're
> worried about the firmware leaving the backlight configured in a
> strange way, it could very well have left the backlight configured in
> DPCD mode but set a different "bit count" than you want, right? Maybe
> you should just always set the bit count?
> 
> Use #2 is fine, but does it buy you anything? Are writes to the DCPD
> bus somehow more expensive than reads? ...or maybe you're expecting
> that a display will glitch / act badly if you write the same value
> that's already there?
> 
> 
> So I guess my instinct here is that you should avoid reading all
> together and just program the value you want.

Good point, will respin this in a little bit

> 
> -Doug
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

