Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49ECB4247C9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 22:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239406AbhJFUQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 16:16:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58914 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232147AbhJFUQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 16:16:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633551274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cagY2D5F5NT1bAs4th+N+T0RHoiMV1A9dmi9z8s6Y24=;
        b=Bu57G9g2BoDNCTguojI0BqG5BF0JykGZ7oM7c4anKJ4vt/2XanGU4ZfcqZWC1Y1K5Igeel
        ItvlRZoa60+PMiOzE5Yz6sx3DCFTC0++wd6i2b29qay01GtCuna1TlnTy6y626DyvzbmUr
        MUodZhwXTyD/XbG7hQYVqGo55x+cHcM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-cS_sHWARNyCVPj1emB06tw-1; Wed, 06 Oct 2021 16:14:33 -0400
X-MC-Unique: cS_sHWARNyCVPj1emB06tw-1
Received: by mail-qt1-f199.google.com with SMTP id x6-20020ac81206000000b002a6e46bbd0eso3139213qti.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 13:14:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=cagY2D5F5NT1bAs4th+N+T0RHoiMV1A9dmi9z8s6Y24=;
        b=sDGhjJW5YJhGSjrOaJohjf13hAcKvhLfwWFsXnA3oR3PgjR44UmpDtSjBKusefenoI
         ndRG8GQ/idBitc/iuewxvyVk8NU6qPoUmrnORy23MrEMyH63NmittE4phvienepOpgfZ
         J+tejK2PLsb5j5ytqoeKO2QqDBd6AjLfPQAcTGfb/h+2RiS2mM1TSEVvjIInIl8Da0kP
         5aQKtcAQ30CfhWm/8FgN5Mz5qPrfoOvsrbKNvfZPxHjWmmRfbtBktdlEpARMhsLJoQIT
         ocbGyaRUMCmmFKKyO7vTdxWudZ8RVkG4jJUhHj4QcmxJVMnxRzQYs/d6DNy4zcZgE7uM
         kZ7A==
X-Gm-Message-State: AOAM5329symS2cG6GUHaOQTG+CGAt37qSOdhYEJnp/QSkrvsm8dYIEL+
        yrWSUq//F5bY3aPzrD5XY+QZh4ZhZ7aB2le9O5Ropn9Gvb3C4u2yr7juDK0xRbc5+5cUigZsCeR
        UzDJuAokXw2hoTm5zt2ATomJD
X-Received: by 2002:a37:2e03:: with SMTP id u3mr104144qkh.313.1633551273155;
        Wed, 06 Oct 2021 13:14:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy67uYZrgGccEL/pHmqUgpGEvM4fHcBT6qlvJsJt9Y4Bhg/bkAcrUOLDF6lDPANJdbr6kVesg==
X-Received: by 2002:a37:2e03:: with SMTP id u3mr104131qkh.313.1633551272978;
        Wed, 06 Oct 2021 13:14:32 -0700 (PDT)
Received: from [192.168.8.206] (pool-96-230-249-157.bstnma.fios.verizon.net. [96.230.249.157])
        by smtp.gmail.com with ESMTPSA id h17sm13302582qtp.13.2021.10.06.13.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 13:14:32 -0700 (PDT)
Message-ID: <f9c4bd7a1ac1a43a4cd2cde8e6d23a60a245b7e7.camel@redhat.com>
Subject: Re: [Nouveau] [PATCH v3 2/5] drm/nouveau/kms/nv50-: Explicitly
 check DPCD backlights for aux enable/brightness
From:   Lyude Paul <lyude@redhat.com>
To:     Karol Herbst <kherbst@redhat.com>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Date:   Wed, 06 Oct 2021 16:14:31 -0400
In-Reply-To: <CACO55tuMWVgsd44s1sAvgrKDHFZT2Z3F+CSqAh34_XaekYWuHA@mail.gmail.com>
References: <20211006024018.320394-1-lyude@redhat.com>
         <20211006024018.320394-3-lyude@redhat.com>
         <CACO55tuMWVgsd44s1sAvgrKDHFZT2Z3F+CSqAh34_XaekYWuHA@mail.gmail.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-10-06 at 18:30 +0200, Karol Herbst wrote:
> On Wed, Oct 6, 2021 at 4:41 AM Lyude Paul <lyude@redhat.com> wrote:
> > 
> > Since we don't support hybrid AUX/PWM backlights in nouveau right now,
> > let's add some explicit checks so that we don't break nouveau once we
> > enable support for these backlights in other drivers.
> > 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > ---
> >  drivers/gpu/drm/nouveau/nouveau_backlight.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_backlight.c
> > b/drivers/gpu/drm/nouveau/nouveau_backlight.c
> > index 1cbd71abc80a..ae2f2abc8f5a 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_backlight.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_backlight.c
> > @@ -308,7 +308,10 @@ nv50_backlight_init(struct nouveau_backlight *bl,
> >                 if (ret < 0)
> >                         return ret;
> > 
> > -               if (drm_edp_backlight_supported(edp_dpcd)) {
> > +               /* TODO: Add support for hybrid PWM/DPCD panels */
> > +               if (drm_edp_backlight_supported(edp_dpcd) &&
> > +                   (edp_dpcd[1] & DP_EDP_BACKLIGHT_AUX_ENABLE_CAP) &&
> 
> where does the DP_EDP_BACKLIGHT_AUX_ENABLE_CAP come from? afaik
> drm_edp_backlight_supported checks for
> DP_EDP_BACKLIGHT_BRIGHTNESS_AUX_SET_CAP and
> DP_EDP_TCON_BACKLIGHT_ADJUSTMENT_CAP so wondering if this was
> intentional or a typo

This is intentional - drm_edp_backlight_supported() does check for these, but
in the patch after this we remove the BRIGHTNESS_AUX_SET_CAP from
drm_edp_backlight_supported() in order to implement support for panels lacking
BRIGHTNESS_AUX_SET_CAP in i915. Since we don't have support for this in
nouveau yet but such backlights are likely to mostly work without the use of
DPCD if we avoid trying to set it up, this patch is just here to make sure
that the changes to drm_edp_backlight_supported() don't result in nouveau
suddenly trying (and failing) to enable DPCD backlight controls on those
backlights.

> 
> > +                   (edp_dpcd[2] &
> > DP_EDP_BACKLIGHT_BRIGHTNESS_AUX_SET_CAP)) {
> >                         NV_DEBUG(drm, "DPCD backlight controls supported
> > on %s\n",
> >                                  nv_conn->base.name);
> > 
> > --
> > 2.31.1
> > 
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

