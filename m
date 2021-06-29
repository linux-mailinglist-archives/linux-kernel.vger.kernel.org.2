Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9733B79FB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 23:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbhF2Vkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 17:40:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34844 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233744AbhF2Vku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 17:40:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625002702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=556hAVcxkakk3x66+sCCRkRCbnFq/lA0vFoRpZZIZRk=;
        b=SsgWnfQHhcXy/KQ5eO+rmJ8/bd87KkxMDqAYVAy/0tYeS9VLyulKgducSAaJvweY3i4iSA
        FRWv7IdcpuWtC9uz1SfST3/pBvl3A5RrH1DVGX8CKrct4r4mIq1GtbXJqhAgEniF7TzINY
        fkgzSlwSrX6p50xwE6JFAhENVEWaCs8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-cpHNRVvlPWq2vtL0eJjugg-1; Tue, 29 Jun 2021 17:38:20 -0400
X-MC-Unique: cpHNRVvlPWq2vtL0eJjugg-1
Received: by mail-qv1-f72.google.com with SMTP id dj4-20020a0562140904b029028f9edbbb48so4501609qvb.23
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 14:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=556hAVcxkakk3x66+sCCRkRCbnFq/lA0vFoRpZZIZRk=;
        b=C83kQgnUWyKAZIn293AdyFOqyD11lQWueQvbOZCn/a9vL0KZsjLCqVrOSn+aOX5UT5
         QlwutktdOJR0jAvz/VPw83kZqGVwkemoaaTpvTBxTlYpkQStfR2ecuRMwS4PbLJROEZI
         wqueJzxke1gmeRebQajah8F2wcRFMVzadOCy544QYcMO0pxLAt/NTLofWFXwryDQdw6C
         bD9Ww/dCfqKo0tujzVPWezLUlNlKRaYzI5hqMlaKG+7MuPLeO/L5yYPoef7LMWfP8ZpS
         rhBQzX7TQglQl2FKu0fi6TdmgBI5dyVeRQmPYE4AR28+ZIz9CeeL1H7P5NUqnDoNLv/3
         h50g==
X-Gm-Message-State: AOAM530Fw2QuLcrz19vmEjFgUhsI4ZsqFZxbv9sRF0SBbdMkoqWkgLPo
        Jm90O2ApfZEk7J5ITSll6Ge09Y6j82WbFo5ndrJFLaEdA/L8ildNf2ZKYwuMTUNSSKxSUIUCded
        13Y7GobOLNiggesPwtPbg/Xze
X-Received: by 2002:a05:620a:62e:: with SMTP id 14mr23446267qkv.180.1625002700441;
        Tue, 29 Jun 2021 14:38:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwh0LaLNSmT7YCUeuFj0ztZxSOcVXe4qks8kATy5bQNb++niof019SEITuHPzGZcc57m7Tavg==
X-Received: by 2002:a05:620a:62e:: with SMTP id 14mr23446240qkv.180.1625002700239;
        Tue, 29 Jun 2021 14:38:20 -0700 (PDT)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id b188sm12497748qkf.133.2021.06.29.14.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 14:38:19 -0700 (PDT)
Message-ID: <d8e09114428307a029f31dc1a7da77e21f9b2b34.camel@redhat.com>
Subject: Re: [PATCH] drm/dp_mst: Fix return code on sideband message failure
From:   Lyude Paul <lyude@redhat.com>
To:     Stephen Boyd <swboyd@chromium.org>,
        Kuogee Hsieh <khsieh@codeaurora.org>, robdclark@gmail.com,
        sean@poorly.run
Cc:     abhinavk@codeaurora.org, aravindh@codeaurora.org,
        rsubbia@codeaurora.org, rnayak@codeaurora.org,
        freedreno@lists.freedesktop.org, airlied@linux.ie, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 29 Jun 2021 17:38:17 -0400
In-Reply-To: <CAE-0n50onDrop=67VvMWL2sbSJedxhKEX13PsiZNaokucSgLew@mail.gmail.com>
References: <1624997336-2245-1-git-send-email-khsieh@codeaurora.org>
         <CAE-0n50onDrop=67VvMWL2sbSJedxhKEX13PsiZNaokucSgLew@mail.gmail.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

JFYI this is on my radar and I'll take a look asap

On Tue, 2021-06-29 at 13:41 -0700, Stephen Boyd wrote:
> +Lyude, author of fixed commit. Please add relevant folks in the future.
> 
> Quoting Kuogee Hsieh (2021-06-29 13:08:56)
> > From: Rajkumar Subbiah <rsubbia@codeaurora.org>
> > 
> > The commit 2f015ec6eab69301fdcf54d397810d72362d7223 added some debug
> 
> Please write
> 
> Commit 2f015ec6eab6 ("drm/dp_mst: Add sideband down request tracing +
> selftests") added some debug
> 
> > code for sideband message tracing. But it seems to have unintentionally
> > changed the behavior on sideband message failure. It catches and returns
> > failure only if DRM_UT_DP is enabled. Otherwise it ignores the error code
> > and returns success. So on an MST unplug, the caller is unaware that the
> > clear payload message failed and ends up waiting for 4 seconds for the
> > response.
> > 
> > This change fixes the issue by returning the proper error code.
> 
> $ git grep "This patch" -- Documentation/process
> 
> > 
> > Change-Id: I2887b7ca21355fe84a7968f7619d5e8199cbb0c6
> 
> Please replace with
> 
> Fixes: 2f015ec6eab6 ("drm/dp_mst: Add sideband down request tracing +
> selftests")
> 
> > Signed-off-by: Rajkumar Subbiah <rsubbia@codeaurora.org>
> 
> Should be a Signed-off-by from Kuogee Hsieh here.
> 
> > ---
> >  drivers/gpu/drm/drm_dp_mst_topology.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> > b/drivers/gpu/drm/drm_dp_mst_topology.c
> > index 1590144..8d97430 100644
> > --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> > +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> > @@ -2887,11 +2887,13 @@ static int process_single_tx_qlock(struct
> > drm_dp_mst_topology_mgr *mgr,
> >         idx += tosend + 1;
> > 
> >         ret = drm_dp_send_sideband_msg(mgr, up, chunk, idx);
> > -       if (unlikely(ret) && drm_debug_enabled(DRM_UT_DP)) {
> > -               struct drm_printer p = drm_debug_printer(DBG_PREFIX);
> > +       if (unlikely(ret)) {
> > +               if (drm_debug_enabled(DRM_UT_DP)) {
> > +                       struct drm_printer p =
> > drm_debug_printer(DBG_PREFIX);
> > 
> > -               drm_printf(&p, "sideband msg failed to send\n");
> > -               drm_dp_mst_dump_sideband_msg_tx(&p, txmsg);
> > +                       drm_printf(&p, "sideband msg failed to send\n");
> > +                       drm_dp_mst_dump_sideband_msg_tx(&p, txmsg);
> > +               }
> >                 return ret;
> >         }
> > 
> 
> With the above fixed up
> 
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

