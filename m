Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 610B435FAAE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351351AbhDNSSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:18:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36996 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232990AbhDNSSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618424281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PqMQq5ZjcTbXc6ahUAb6RtVIAIQY30tln4IDoLvU+WA=;
        b=D0FS6MN7uUD3y/GnhIc14w0bP4GIFSVUAoSQRN0/i5TgMplZ9hbKiG9hCBHehDk8mYwzOg
        AIPak4q9NQucVrGicPcIc9XT+uPOayDWvgsojmM5kP4L4+c4FNutmzVJbZp0FwGYoB24iZ
        YlKuLnS3Qa4Vv9DxHWvs+0xG8TlvKBM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-mOnUgD2JNpuHpQ04Page5g-1; Wed, 14 Apr 2021 14:17:47 -0400
X-MC-Unique: mOnUgD2JNpuHpQ04Page5g-1
Received: by mail-qv1-f71.google.com with SMTP id i2-20020ad44cc20000b029019a3866abf5so157917qvz.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:17:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=PqMQq5ZjcTbXc6ahUAb6RtVIAIQY30tln4IDoLvU+WA=;
        b=qpn+Sio2TxND0HIluzQ9+lJW77zS5K7L0lNIG20hNFPNfTz+mBY+WroPtpMLu2T+X9
         +xPdtepN0mp9fHV5r7CgVHeez9hyMz4GETTxTIIE+FFckxQ8pIqaBDmwQSu0Y2RRr2zL
         jnbfXBvdoAcDsEj+wXjIbd5JVBC1Rdvsxvs1ZP1SYJyfrcY8soPIiGw3uzrcGCj0AYvJ
         qIIHmIHsDLsj8erYlcQwZO6MRUEDcd8T/bSLKnEiM6qnTInCiS10dbyWg/JZ7dQe3ed2
         fp4JafnbwXiSb/EZxDvsKmUBssGdSPEzl0/qxQiIjMmwSsEOxdmIdrbimXUqgfHZEJAx
         DPSg==
X-Gm-Message-State: AOAM5305BMSFOB8nO1gQShZCOBI5HMcH1O9uQ1MRIyi1KAXoXa5vLYHW
        6uyB8JdMkm+OufmTmoSr3BdK/fdrag25OeW0wI1KUXydPFXZe56JntEDNaHTUk8MKdfmxkELn2Y
        XHnHAb74BuFeRfwiFRmSz5I+h
X-Received: by 2002:ae9:ed16:: with SMTP id c22mr21123683qkg.292.1618424267440;
        Wed, 14 Apr 2021 11:17:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhCLrjqwhBZruoTsJbpDIweXUGa1EcovOGAxb7r+GzlNzNtaJxFvwGSpsXlU7qgvJApBoMyg==
X-Received: by 2002:ae9:ed16:: with SMTP id c22mr21123654qkg.292.1618424267200;
        Wed, 14 Apr 2021 11:17:47 -0700 (PDT)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id e7sm113738qth.27.2021.04.14.11.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:17:46 -0700 (PDT)
Message-ID: <0a64b70c89699b4e6c7aaa3ba8e75531031faa3c.camel@redhat.com>
Subject: Re: [PATCH 03/30] drm/tegra: Don't register DP AUX channels before
 connectors
From:   Lyude Paul <lyude@redhat.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "open list:DRM DRIVERS FOR NVIDIA TEGRA" 
        <linux-tegra@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Wed, 14 Apr 2021 14:17:45 -0400
In-Reply-To: <YHcdCAQ7Dlb2vSzn@orome.fritz.box>
References: <20210219215326.2227596-1-lyude@redhat.com>
         <20210219215326.2227596-4-lyude@redhat.com>
         <YHcdCAQ7Dlb2vSzn@orome.fritz.box>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-04-14 at 18:49 +0200, Thierry Reding wrote:
> On Fri, Feb 19, 2021 at 04:52:59PM -0500, Lyude Paul wrote:
> > As pointed out by the documentation for drm_dp_aux_register(),
> > drm_dp_aux_init() should be used in situations where the AUX channel for a
> > display driver can potentially be registered before it's respective DRM
> > driver. This is the case with Tegra, since the DP aux channel exists as a
> > platform device instead of being a grandchild of the DRM device.
> > 
> > Since we're about to add a backpointer to a DP AUX channel's respective
> > DRM
> > device, let's fix this so that we don't potentially allow userspace to use
> > the AUX channel before we've associated it with it's DRM connector.
> > 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > ---
> >  drivers/gpu/drm/tegra/dpaux.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/tegra/dpaux.c b/drivers/gpu/drm/tegra/dpaux.c
> > index 105fb9cdbb3b..ea56c6ec25e4 100644
> > --- a/drivers/gpu/drm/tegra/dpaux.c
> > +++ b/drivers/gpu/drm/tegra/dpaux.c
> > @@ -534,9 +534,7 @@ static int tegra_dpaux_probe(struct platform_device
> > *pdev)
> >         dpaux->aux.transfer = tegra_dpaux_transfer;
> >         dpaux->aux.dev = &pdev->dev;
> >  
> > -       err = drm_dp_aux_register(&dpaux->aux);
> > -       if (err < 0)
> > -               return err;
> > +       drm_dp_aux_init(&dpaux->aux);
> 
> I just noticed that this change causes an error on some setups that I
> haven't seen before. The problem is that the SOR driver tries to grab a
> reference to the I2C device to make sure it doesn't go away while it has
> a pointer to it.
> 
> However, since now the I2C adapter hasn't been registered yet, I get
> this:
> 
>         [   15.013969] kobject: '(null)' (000000005c903e43): is not
> initialized, yet kobject_get() is being called.
> 
> I recall that you wanted to make this change so that a backpointer to
> the DRM device could be added (I think that's patch 15 of the series),
> but I didn't see that patch get merged, so it's a bit difficult to try
> and fix this up.

I'm pretty sure I already merged the tegra change in drm-misc-next, so if it's
causing issues you probably should send out a revert for now and I can r-b it
so we can figure out a better solution for this in the mean time

> Has the situation changed? Do we no longer need the backpointer? If we
> still want it, what's the plan for merging the change? Should I work
> under the assumption that patch will make it in sometime and try to fix
> this on top of that?

yes we do still need the backpointer - I'm just still working on getting
reviews for some of the other parts of this series, and have been on PTO/busy
with a couple of other things.

> 
> I'm thinking that perhaps we can move the I2C adapter registration into
> drm_dp_aux_init() since that's independent of the DRM device.

Yeah this makes sense for me - I can try to make this change on the next
respin of this series. What kind of setup were you able to reproduce issues on
this with btw?

>  It would
> also make a bit more sense from the Tegra driver's point of view where
> all devices would be created during the ->probe() path, and only during
> the ->init() path would the connection between DRM device and DRM DP AUX
> device be established.
> 
> Thierry

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

