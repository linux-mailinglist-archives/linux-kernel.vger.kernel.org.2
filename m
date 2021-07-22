Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F054B3D2B80
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 19:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhGVRNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 13:13:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40487 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229914AbhGVRND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 13:13:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626976418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y2GEg8okcVMAYnKdKmQC+g9S6ixUz1NHqQ1kjsCY4C0=;
        b=fJft5StI+AV3ERKShins3h17g5azGVRiT2IznUIBe8yvs0qrlABcud/8rAm/WYgtsizKPB
        yBzk9Pn+ffr3waxSC3i5fOFnE5PYiYCYYIQ84zK2Mv6Du1WgMOxXtzRTcbIdb2QTGdeAYc
        lJhl3qaoAa7IWDVI8I4JsKaIee6HDpg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-gDM4yzhWNqq9MKaZtQwjHw-1; Thu, 22 Jul 2021 13:53:37 -0400
X-MC-Unique: gDM4yzhWNqq9MKaZtQwjHw-1
Received: by mail-qv1-f72.google.com with SMTP id gm10-20020a056214268ab02902eaed054a57so64604qvb.15
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 10:53:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=Y2GEg8okcVMAYnKdKmQC+g9S6ixUz1NHqQ1kjsCY4C0=;
        b=sniURM+68FEOpVvGjVcsr8yimTvH9jYoTEu4uVv4pF7Oi6ReljHZJxm3uIhhBoZ0/R
         gFAL6ztHrfaHPfkt637O84lPWK2DAFBIO9FneLmtQ+tnhAk30nGbmwjtavRr5Gfg94PI
         Xnsj7UP/sMTByqdJb+TIBzZWIIA/h7hLwYBabi93UEGNjg3Sv4kn6Fdvf4hJnMklyNmk
         MSnmhLUSCCETas+JuTCPaPgJiB6aqyqqgfRJRR6cUAE5um328xGVR8/1GvrTxlJw0cv9
         vlku8M56bn8JTVsSx4180lcFKmhn8ADZCZXXBuPdeSA/ctxur6iITsZKiMw3RIq72vxB
         /koQ==
X-Gm-Message-State: AOAM531jYogQBN0j0tZNBq3QoSxgAjVpI2CKcFERVs7+RtAZrEaYpFUf
        aHiOuPu1CRLxAf4O7Hn3D005fbnCmzMR+78AaAg3Xo8lDzeETvKHhdL08smRqFHERP5Dh0hTsHl
        UBfMBmVB1Ufku64rdZqCfD9LC
X-Received: by 2002:a05:6214:129:: with SMTP id w9mr824695qvs.13.1626976416769;
        Thu, 22 Jul 2021 10:53:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIX3vEtdM0CCkt3/yc6zqizr4OQmJT/HqF+o8uo7lMAGVHdyTFMumcqgcTkFv0yWCssyBNqw==
X-Received: by 2002:a05:6214:129:: with SMTP id w9mr824673qvs.13.1626976416543;
        Thu, 22 Jul 2021 10:53:36 -0700 (PDT)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id s19sm7294756qtx.5.2021.07.22.10.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 10:53:36 -0700 (PDT)
Message-ID: <2da3949fa3504592da42c9d01dc060691c6a8b8b.camel@redhat.com>
Subject: Re: [PATCH v3] drm/dp_mst: Fix return code on sideband message
 failure
From:   Lyude Paul <lyude@redhat.com>
To:     khsieh@codeaurora.org, Jani Nikula <jani.nikula@linux.intel.com>
Cc:     robdclark@gmail.com, sean@poorly.run, swboyd@chromium.org,
        abhinavk@codeaurora.org, aravindh@codeaurora.org,
        rsubbia@codeaurora.org, rnayak@codeaurora.org,
        freedreno@lists.freedesktop.org, airlied@linux.ie, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 22 Jul 2021 13:53:34 -0400
In-Reply-To: <a514c19f712a6feeddf854dc17cb8eb5@codeaurora.org>
References: <1625585434-9562-1-git-send-email-khsieh@codeaurora.org>
         <87zguy7c5a.fsf@intel.com>
         <a514c19f712a6feeddf854dc17cb8eb5@codeaurora.org>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-07-13 at 15:24 -0700, khsieh@codeaurora.org wrote:
> On 2021-07-07 01:37, Jani Nikula wrote:
> > On Tue, 06 Jul 2021, Kuogee Hsieh <khsieh@codeaurora.org> wrote:
> > > From: Rajkumar Subbiah <rsubbia@codeaurora.org>
> > > 
> > > Commit 2f015ec6eab6 ("drm/dp_mst: Add sideband down request tracing +
> > > selftests") added some debug code for sideband message tracing. But
> > > it seems to have unintentionally changed the behavior on sideband 
> > > message
> > > failure. It catches and returns failure only if DRM_UT_DP is enabled.
> > > Otherwise it ignores the error code and returns success. So on an MST
> > > unplug, the caller is unaware that the clear payload message failed 
> > > and
> > > ends up waiting for 4 seconds for the response. Fixes the issue by
> > > returning the proper error code.
> > > 
> > > Changes in V2:
> > > -- Revise commit text as review comment
> > > -- add Fixes text
> > > 
> > > Changes in V3:
> > > -- remove "unlikely" optimization
> > > 
> > > Fixes: 2f015ec6eab6 ("drm/dp_mst: Add sideband down request tracing + 
> > > selftests")
> > > 
> > > Signed-off-by: Rajkumar Subbiah <rsubbia@codeaurora.org>
> > > Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
> > > 
> > > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> > 
> > Reviewed-by: Jani Nikula <jani.nikula@intel.com>
> > 
> > 
> > > ---
> Lyude,
> Any comments from you?
> Thanks,

Hey! Sorry did I forget to respond to this?

Reviewed-by: Lyude Paul <lyude@redhat.com>

> 
> > >  drivers/gpu/drm/drm_dp_mst_topology.c | 10 ++++++----
> > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c 
> > > b/drivers/gpu/drm/drm_dp_mst_topology.c
> > > index 1590144..df91110 100644
> > > --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> > > +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> > > @@ -2887,11 +2887,13 @@ static int process_single_tx_qlock(struct 
> > > drm_dp_mst_topology_mgr *mgr,
> > >         idx += tosend + 1;
> > > 
> > >         ret = drm_dp_send_sideband_msg(mgr, up, chunk, idx);
> > > -       if (unlikely(ret) && drm_debug_enabled(DRM_UT_DP)) {
> > > -               struct drm_printer p = drm_debug_printer(DBG_PREFIX);
> > > +       if (ret) {
> > > +               if (drm_debug_enabled(DRM_UT_DP)) {
> > > +                       struct drm_printer p =
> > > drm_debug_printer(DBG_PREFIX);
> > > 
> > > -               drm_printf(&p, "sideband msg failed to send\n");
> > > -               drm_dp_mst_dump_sideband_msg_tx(&p, txmsg);
> > > +                       drm_printf(&p, "sideband msg failed to send\n");
> > > +                       drm_dp_mst_dump_sideband_msg_tx(&p, txmsg);
> > > +               }
> > >                 return ret;
> > >         }
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

