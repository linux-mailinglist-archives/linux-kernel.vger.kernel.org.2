Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F0236CEBC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 00:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237136AbhD0Wpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 18:45:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30812 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235395AbhD0Wpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 18:45:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619563497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EgiXRmMXa3NJldt/X/DsEnucIqp2KsWziXQ4O//7F28=;
        b=OnbQToJ2D1OqGzX9zBaJ5KS++0p5Gyo4OTHEwTtgUOWto+NSYtRR6b9aULVJlmb750abX6
        I9fPxxEOFw1FO3kU2KisbtY6UnfpiDzhJy3qaW7Sc6VNnIu1n8hrKNhmbEHtZVp+fPyo7m
        oNKGLr6/uRsFBJpPlxkvN//JkkpCZJo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-Sp0RTJWDNFuxCC8Aso_RuQ-1; Tue, 27 Apr 2021 18:44:54 -0400
X-MC-Unique: Sp0RTJWDNFuxCC8Aso_RuQ-1
Received: by mail-qk1-f199.google.com with SMTP id r123-20020a378f810000b029028244d5f023so23995828qkd.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 15:44:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=EgiXRmMXa3NJldt/X/DsEnucIqp2KsWziXQ4O//7F28=;
        b=qaYY2jRGJ0zoJRvGRaZiIhap0H+QdWFblYHTAHaS9LVj7PxsojOLHV/ofnPjFo7nZ/
         3I0MfYXGIPhPOMljh73tLXy0DPEk8pgfCa4W/1QkQKZ8KPXupjARS+hZ3dQ03rbpNHl7
         /B2hp5p5Ml52KNRSYcTl2z8I+uV+3j1/79IeHICajNXnbyTfsEdBy8g9lNVF8hd02APH
         Dj8glldkLcpo6VSDJtNd2tP2aoPzT4wzeNrpTSjtBPKB5nmRUXxC3lZGM2EovddFywii
         VcozbAvO+jgqw6KLWrzR5L4uebjaKMydkX3h5VEWX6nLk+arUR08n1yWxfu3Tv9B7vCw
         0P0A==
X-Gm-Message-State: AOAM533dcOpGYZL6zc9uD+0coQpi26JbAYwBYVt21ROc0ODsM2wxC8BZ
        YncSD6SyJGEOfXvvhgNagx9suQpMe2YaL2fAeo2wlo8PQ64ITbV/UOr1WMo4c4Qb/f+0PO6Uf+H
        fYuLHQxEhvArYcfgBSL3ovTAm
X-Received: by 2002:ac8:7761:: with SMTP id h1mr4639163qtu.226.1619563494316;
        Tue, 27 Apr 2021 15:44:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyW8E9WJQ40Y3UXOfq1mqkdZDksWBoxiI9VSIOGaYGWFbfX2Oo6ApE9CxLBPAUrNQWKTWwdjA==
X-Received: by 2002:ac8:7761:: with SMTP id h1mr4639146qtu.226.1619563494109;
        Tue, 27 Apr 2021 15:44:54 -0700 (PDT)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id n15sm917482qti.51.2021.04.27.15.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 15:44:53 -0700 (PDT)
Message-ID: <43482b904ef0150b6577044668dd651684590ab0.camel@redhat.com>
Subject: Re: [PATCH 1/2] drm/tegra: Get ref for DP AUX channel, not its ddc
 adapter
From:   Lyude Paul <lyude@redhat.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thierry Reding <treding@nvidia.com>,
        Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Date:   Tue, 27 Apr 2021 18:44:52 -0400
In-Reply-To: <YIZu4PD6BmlGYXuc@orome.fritz.box>
References: <20210423182146.185633-1-lyude@redhat.com>
         <20210423182146.185633-2-lyude@redhat.com>
         <YIZu4PD6BmlGYXuc@orome.fritz.box>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-04-26 at 09:42 +0200, Thierry Reding wrote:
> On Fri, Apr 23, 2021 at 02:21:45PM -0400, Lyude Paul wrote:
> > While we're taking a reference of the DDC adapter for a DP AUX channel in
> > tegra_sor_probe() because we're going to be using that adapter with the
> > SOR, now that we've moved where AUX registration happens the actual device
> > structure for the DDC adapter isn't initialized yet. Which means that we
> > can't really take a reference from it to try to keep it around anymore.
> > 
> > This should be fine though, because we can just take a reference of its
> > parent instead.
> > 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > Fixes: 39c17ae60ea9 ("drm/tegra: Don't register DP AUX channels before
> > connectors")
> > Cc: Lyude Paul <lyude@redhat.com>
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Cc: Jonathan Hunter <jonathanh@nvidia.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-tegra@vger.kernel.org
> > ---
> >  drivers/gpu/drm/tegra/sor.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/tegra/sor.c b/drivers/gpu/drm/tegra/sor.c
> > index 7b88261f57bb..4e0e3a63e586 100644
> > --- a/drivers/gpu/drm/tegra/sor.c
> > +++ b/drivers/gpu/drm/tegra/sor.c
> > @@ -3739,11 +3739,11 @@ static int tegra_sor_probe(struct platform_device
> > *pdev)
> >                 if (!sor->aux)
> >                         return -EPROBE_DEFER;
> >  
> > -               if (get_device(&sor->aux->ddc.dev)) {
> > -                       if (try_module_get(sor->aux->ddc.owner))
> > +               if (get_device(sor->aux->dev)) {
> > +                       if (try_module_get(sor->aux->dev->driver->owner))
> >                                 sor->output.ddc = &sor->aux->ddc;
> >                         else
> > -                               put_device(&sor->aux->ddc.dev);
> > +                               put_device(sor->aux->dev);
> >                 }
> >         }
> 
> Unfortunately, I think it's a bit more subtle than that. The reason for
> this get_device()/try_module_get() dance was to mirror the behaviour of
> of_get_i2c_adapter_by_node() so that when we call i2c_put_adapter() in
> tegra_output_remove() we correctly decrease the reference count.
> 
> The above will increase the reference on the I2C adapter's parent while
> i2c_put_adapter() will then only decrease the reference on the I2C
> adapter, so I think effectively we'd be leaking a reference to the I2C
> adapter's parent.
> 
> Also, since we didn't take a reference on the I2C adapter explicitly,
> releasing that reference in tegra_output_remove() might free the I2C
> adapter too early.
> 
> I wonder if perhaps it'd be easier to get rid of the struct tegra_output
> abstraction altogether and push this down into the individual drivers,
> even if that means a bit more code duplication. That's not the kind of
> quick fix to resolve this current situation, so perhaps as a stop-gap we
> just need to sprinkle a few more conditionals throughout tegra_output
> code. We could, for example, avoid calling i2c_put_adapter() in
> tegra_output_remove() for the DisplayPort cases and instead manually
> release the reference to the I2C adapter's parent in tegra_sor_remove().
> On top of your patch above that /should/ fix things properly for now.

Alright - I will try to get to this tomorrow

> 
> Thierry

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

