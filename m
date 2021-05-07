Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44041376BBC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 23:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbhEGV3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 17:29:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44078 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229470AbhEGV3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 17:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620422890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pVNjq4cwxRpZVEM9G+ZCz6caWZiQ6FKaXq/9liRlvVI=;
        b=hXBuxzLQgTQbJFjx4bBmYLDzBZEb1mzg7YWNVI4nMDHEcoa3cQ0tqImCAcXxoZAtqEGNtp
        uWYDY2s20iOX/Zop418X0pdr/iHYw2Rii0SiOYRmoEdgK02h2TFhOzJ9YIVoQOiszdLz6t
        lGANg3i3uOGBictOQeRoyh/WG8GbCyU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-SZHAzaX6MNKcxCosRygqOQ-1; Fri, 07 May 2021 17:28:06 -0400
X-MC-Unique: SZHAzaX6MNKcxCosRygqOQ-1
Received: by mail-qv1-f71.google.com with SMTP id l5-20020a0ce0850000b02901c37c281207so7575935qvk.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 14:28:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=pVNjq4cwxRpZVEM9G+ZCz6caWZiQ6FKaXq/9liRlvVI=;
        b=D5/u9p4X3lKO190VpqsG8I1WrKJ5dLKJITys9P+JPursSug8F/v0/SvKPP75hjL1Z+
         5J9dVAWPyC7/OU0tbHiMVo5iweBSlmijkYQvCEaV62HUziqPh0rVXBez5t4hpqSObHh+
         N+Q/PHW2rXza7Zn4Gxvi0FS5lgyWsM4PTMMeENeVT+LCsVViMghTIc4EQhZTIe4TZfBJ
         LHmN0MNDrIaJ1bZa2t9qcZnkj2vDJ9+2jw08bXWsWE+EtiH9gnnXaQ9Hisnx5SC3agF+
         Kcdm8yTkTkU4vFZ/h1jbaV3AQCDZ21VZ8fhyPhetuAC/q3zYLyEOoG1wdApeIB+UCJ5Y
         sqLw==
X-Gm-Message-State: AOAM5314Y53o03qMwt+X6WDWG7acxiv8GA5rVt0LIBdo/kzZwiVxbPNI
        MGInCt+2aZuB6OS3ivgJl4KwEOs4RGDVEJLVFLh4pwEYbbbhajHvFfeU2/giR/iQ/jme87/RGk0
        1WT2PetqzVz8b6PvuNTAKWRcO
X-Received: by 2002:ac8:109a:: with SMTP id a26mr11012770qtj.156.1620422885845;
        Fri, 07 May 2021 14:28:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx4umG7ULJ2428gNNMYBy++wm63s5NWc12Pht4FLFgn8RWxeg/DGz3zuQqldKEj2lf9x+1nFA==
X-Received: by 2002:ac8:109a:: with SMTP id a26mr11012759qtj.156.1620422885691;
        Fri, 07 May 2021 14:28:05 -0700 (PDT)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id v18sm1635624qkv.34.2021.05.07.14.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 14:28:05 -0700 (PDT)
Message-ID: <cbbd22463a3af9efa7f12dc90b74231dc0ae5771.camel@redhat.com>
Subject: Re: [Intel-gfx] [PATCH 2/2] drm/dp: Drop open-coded
 drm_dp_is_branch() in drm_dp_read_downstream_info()
From:   Lyude Paul <lyude@redhat.com>
To:     Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>
Date:   Fri, 07 May 2021 17:28:03 -0400
In-Reply-To: <YI9otSh/ftvLqMxb@intel.com>
References: <20210430223428.10514-1-lyude@redhat.com>
         <20210430223428.10514-2-lyude@redhat.com> <YI9otSh/ftvLqMxb@intel.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-05-03 at 06:06 +0300, Ville Syrjälä wrote:
> On Fri, Apr 30, 2021 at 06:34:28PM -0400, Lyude Paul wrote:
> > Noticed this while fixing another issue in drm_dp_read_downstream_info(),
> > the open coded DP_DOWNSTREAMPORT_PRESENT check here just duplicates what
> > we
> > already do in drm_dp_is_branch(), so just get rid of it.
> > 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > ---
> >  drivers/gpu/drm/drm_dp_helper.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_dp_helper.c
> > b/drivers/gpu/drm/drm_dp_helper.c
> > index 27c8c5bdf7d9..0f84df8798ab 100644
> > --- a/drivers/gpu/drm/drm_dp_helper.c
> > +++ b/drivers/gpu/drm/drm_dp_helper.c
> > @@ -677,9 +677,7 @@ int drm_dp_read_downstream_info(struct drm_dp_aux
> > *aux,
> >         memset(downstream_ports, 0, DP_MAX_DOWNSTREAM_PORTS);
> >  
> >         /* No downstream info to read */
> > -       if (!drm_dp_is_branch(dpcd) ||
> > -           dpcd[DP_DPCD_REV] < DP_DPCD_REV_10 ||
> > -           !(dpcd[DP_DOWNSTREAMPORT_PRESENT] & DP_DWN_STRM_PORT_PRESENT))
> > +       if (!drm_dp_is_branch(dpcd) || dpcd[DP_DPCD_REV] < DP_DPCD_REV_10)
> 
> BTW that DPCD_REV check looks rather wrong.
> 
> Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

I'll send out a separate fix for this in just a moment, thanks for pointing it
out!

> 
> >                 return 0;
> >  
> >         /* Some branches advertise having 0 downstream ports, despite also
> > advertising they have a
> > -- 
> > 2.30.2
> > 
> > _______________________________________________
> > Intel-gfx mailing list
> > Intel-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/intel-gfx
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

