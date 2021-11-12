Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2C144EDE4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 21:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235552AbhKLU3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 15:29:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34394 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230235AbhKLU3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 15:29:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636748816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2hKzFqAYpjnD27jwSRYJVURcWAC9c1KmAhVPUzr+uD0=;
        b=TQFnARVW/vONEB0ssKQOEvcuJafPtZXrTc7osA7J2CU6RIBXJUZ7Dp8buKnDXhk0QOvKuW
        04Y1MA79j02bd8Ru5wq/k5DcblaYblANm6SF6NCJ/njjF5oxxeZEk4S0wsWQZV5UteZRcj
        +IF9Nf3BFApao/SpKZtoL9pqbanfCQU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-iYJ41YZsPfeDI4BJf_nd4A-1; Fri, 12 Nov 2021 15:26:55 -0500
X-MC-Unique: iYJ41YZsPfeDI4BJf_nd4A-1
Received: by mail-qk1-f199.google.com with SMTP id m19-20020a05620a221300b00467cb90a8e2so7237975qkh.18
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 12:26:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=2hKzFqAYpjnD27jwSRYJVURcWAC9c1KmAhVPUzr+uD0=;
        b=snHOvjte/2h7tpqOqi6lVFzlCWC06pWHj0PkgAIsNaNf74UOoJgs6SZ6LgKWzmAO09
         Ihj/CwqpdPQu6ye1W8/f9o3ywJdepQfc7T/e2hXOzFRT/WAeVH9lKqXnQa/BWzEzHHlb
         vyTavoQ0lRkFO9BTHBtxbfRnDI5tzHrtxJXs2rgJPpJDpHERnOxo0Dql1xDFT2dyRzaC
         sEMRsbQbZeCB/4AOrZaZi17DmMNHoesSMWzU33RaqMRYBCjgEqOS4mfYV73Y+fjcaOft
         E7Wo7VUWewhfUCX/dHMQMfMhmR3HljSbJ9nh3rigvT/F0jq3QKezygw8tTGmReVz6IfL
         E0Qg==
X-Gm-Message-State: AOAM530c656j4E4+XYnRe0WSsUx3TwcoyxDq5iKFjGNxce1/rJ1cGk7S
        Ed3/VRZYwNRJJdUEEjWUYe5R/dJtWFB+mK8buvzpY4WMjrwo/9L6ExQHBzZJOC2Ll/rNesGRJX8
        XeGKkEx2q4XBJuskGEbNviVSt
X-Received: by 2002:ad4:4452:: with SMTP id l18mr17371091qvt.8.1636748815184;
        Fri, 12 Nov 2021 12:26:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwCPD/xZBoIMM5Ht3JzQLe4OXeLMU7YK9BDgdA3kBtg895uCJ29aXlgQmKeeSXxnoIE8A5fMA==
X-Received: by 2002:ad4:4452:: with SMTP id l18mr17371052qvt.8.1636748814948;
        Fri, 12 Nov 2021 12:26:54 -0800 (PST)
Received: from [192.168.8.138] (pool-96-230-249-157.bstnma.fios.verizon.net. [96.230.249.157])
        by smtp.gmail.com with ESMTPSA id t11sm3167889qkm.96.2021.11.12.12.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 12:26:54 -0800 (PST)
Message-ID: <be1833c5d27e666b760c729fc112d1bbd7b7a269.camel@redhat.com>
Subject: Re: [PATCH v1 2/2] drm/tegra: Use drm_dp_aux_register_ddc/chardev()
 helpers
From:   Lyude Paul <lyude@redhat.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Thomas Graichen <thomas.graichen@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 12 Nov 2021 15:26:53 -0500
In-Reply-To: <5ee3f964-39ec-f6e2-5a01-230532a8b17e@gmail.com>
References: <20211107230821.13511-1-digetx@gmail.com>
         <20211107230821.13511-2-digetx@gmail.com>
         <YYk/jfcceun/Qleq@phenom.ffwll.local>
         <0a2c02ae-3fe1-e384-28d3-13e13801d675@gmail.com>
         <YYo9IXjevmstSREu@phenom.ffwll.local>
         <857a48ae-9ff4-89fe-11ce-5f1573763941@gmail.com>
         <efdc184a-5aa3-1141-7d74-23d29da41f2d@gmail.com>
         <71fcbc09-5b60-ee76-49b2-94adc965eda5@gmail.com>
         <49ffd29b-eb64-e0ca-410c-44074673d740@gmail.com>
         <YY5HfUUSmnr6qQSU@orome.fritz.box>
         <5ee3f964-39ec-f6e2-5a01-230532a8b17e@gmail.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-11-12 at 17:32 +0300, Dmitry Osipenko wrote:
> 12.11.2021 13:52, Thierry Reding пишет:
> > On Tue, Nov 09, 2021 at 05:39:02PM +0300, Dmitry Osipenko wrote:
> > > 09.11.2021 17:17, Dmitry Osipenko пишет:
> > > > 09.11.2021 17:08, Dmitry Osipenko пишет:
> > > > > > +static void host1x_drm_dev_deinit(struct host1x_device *dev)
> > > > > > +{
> > > > > > +       struct drm_device *drm = dev_get_drvdata(&dev->dev);
> > > > > And platform_unregister_drivers() should be moved here.
> > > > > 
> > > > 
> > > > Nah, that should cause deadlock. This ad-hoc is too lame.
> > > 
> > > Actually, there is no problem here as I see now. The host1x driver
> > > populates DT nodes after host1x_register() [1], meaning that Host1x DRM
> > > will be always inited first.
> > > 
> > > [1]
> > > https://elixir.bootlin.com/linux/v5.15/source/drivers/gpu/host1x/dev.c#L475
> > > 
> > > Still I'm not a fan of the ad-hoc solution.
> > 
> > Could we not fix this by making the panel "hot-pluggable"? I don't think
> > there's anything inherent to the driver that would prevent doing so. The
> > original reason for why things are as intertwined as they are now is
> > because back at the time deferred framebuffer creation didn't exist. In
> > fact I added deferred framebuffer support with Daniel's help precisely
> > to fix a similar issue for things like HDMI and DP.
> 
> I don't understand what do you mean by "hot-pluggable", panel is static.
> Please either clarify more or type the patch.
> 
> Keep in mind that fix should be simple and portable because stable
> kernels are wrecked.
> 
> > With HDMI and DP it's slightly less critical, because a lack of mode
> > support would've created a 1024x768 framebuffer, which most HDMI/DP
> > monitors support. However, with panels we need to ensure that the exact
> > mode from the panel is used to create the framebuffer, so it can only be
> > created when the panel is available.
> > 
> > But, given that deferred framebuffer creation works now (which allows
> > the framebuffer console to show up at the preferred resolution for HDMI
> > and DP), even if a monitor is attached only after the driver has probed
> > already, we should be able to make something like that work with panels
> > as well.
> 
> BTW, I see now that DPAUX I2C transfer helper may access
> aux->drm_device. Hence v1 patch isn't correct anyways.

JFYI - unless I'm misunderstanding you, the aux->drm_dev accesses in the DPAUX
i2c transfer functions are just from the various drm_{dbg,err,etc.} calls,
which means that they all should be able to handle aux->drm_dev being NULL. If
you can set aux->drm_dev before i2c transfers start that's more ideal, since
otherwise you'll see the AUX device name as "(null)" in the kernel log, but
any point before device registration should work.

> 
> For now I'll try to test more the ad-hoc variant with Thomas and send it
> as v2 if we won't have a better solution.
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

