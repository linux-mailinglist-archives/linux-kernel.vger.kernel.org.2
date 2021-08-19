Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35BD03F1E91
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 19:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhHSRCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 13:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhHSRCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 13:02:06 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4F5C061575;
        Thu, 19 Aug 2021 10:01:29 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id gr13so14291957ejb.6;
        Thu, 19 Aug 2021 10:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HOnBGLFQ/RPkWyVebKZOihfXyP1VfPHshsIs+J3gUi4=;
        b=gtjctdvwMmR+KSoAu9WPHrM3VQ1bojXNADyhNT5C/CWdI8eqrxzXML8ywRkuk+hlfz
         PprjBPzk510Gbr3qulBKAN51iG1gZxzii91z5gVuaUKxQqWsuboVjsJOupWDhCebGfxo
         wlPv3URrKTYZyCy0MMU9x7fOoPcxQWawlhwrh7LtfJhK4mHo3tlmpGyFr0kyxb0g6VHX
         OVoFeCsjuRwezH3VmWztgW2hSuMj/1Fjw8N0DLu3HAa2he1INBu9ybJw1o/Spe6kHhGS
         3O4RBHvAT7BTA/GkzpOi20MjfjCQf9YjRh0ehoCd1Q2TGuwUJla1eCGY7Ldp1eb8vhhK
         AQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HOnBGLFQ/RPkWyVebKZOihfXyP1VfPHshsIs+J3gUi4=;
        b=VA1XXlqSxxxfkQqSjDyI7+OdGeQ0TMALhAca3ZzoaeC0uZayegokmwUIUJRmNI43HF
         s426ZYbX/MRfCjO+1s+FYsYn9DciTGtnUlPZ6RxuG6qdOhTNvp3ntba8WsgAukPJJuUW
         IwTmLZRpaZVdeueJL0UNJ71NOtyfZ2QaVFWeQgre/DO82lgR+wG06A3panJwxZ21uHoU
         fUtPIQv64sayy8aJZ4V86D7tp9QgH98Z4jaAJQrqn13vKT+I7pixds+RESM+kFmr9tu2
         ++xGC28TOvVl+bSIhfDneZyIEfl9DJjv9AnPWN/Rj8DV9UNIE5f4tXKWTZYv7EuMpFo2
         5+rA==
X-Gm-Message-State: AOAM532zZif3VeF58lnnhcQasWdCN7RRinpSfYZGXxg1Xv03/DvewkFi
        HyhgK5Y3212AWN1pA3fQB3/gytcQONcekg==
X-Google-Smtp-Source: ABdhPJyWDs5yB6T1OuTS+UOyjwaJiM6R+2uqmgtC45avvP1J/qktmzyKNhL1VibEzRQtpC1IDes4vg==
X-Received: by 2002:a17:906:b787:: with SMTP id dt7mr17258690ejb.111.1629392488064;
        Thu, 19 Aug 2021 10:01:28 -0700 (PDT)
Received: from archbook.localnet (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id n23sm2090257eds.41.2021.08.19.10.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 10:01:27 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Robin Murphy <robin.murphy@arm.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: sound: add rockchip i2s-tdm binding
Date:   Thu, 19 Aug 2021 19:01:25 +0200
Message-ID: <1870492.5CqhBlFY90@archbook>
In-Reply-To: <20210819141617.GM4177@sirena.org.uk>
References: <20210817101119.423853-1-frattaroli.nicolas@gmail.com> <2412250.zZEsDtmPgG@archbook> <20210819141617.GM4177@sirena.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Donnerstag, 19. August 2021 16:16:17 CEST Mark Brown wrote:
> On Thu, Aug 19, 2021 at 03:52:55PM +0200, Nicolas Frattaroli wrote:
> > On Donnerstag, 19. August 2021 14:08:36 CEST Robin Murphy wrote:
> > > > +  rockchip,no-dmaengine:
> > > > +    description:
> > > > +      If present, driver will not register a pcm dmaengine, only the
> > > > dai.
> > > > +      If the dai is part of multi-dais, the property should be
> > > > present.
> > > > +    type: boolean
> > > 
> > > That sounds a lot more like a policy decision specific to the Linux
> > > driver implementation, than something which really belongs in DT as a
> > > description of the platform.
> > 
> > I agree. Should I be refactoring this into a module parameter or
> > something along those lines? I'm unsure of where this goes.
> 
> Why is this even required?  What is "multi-dais" and why would
> registering the DMA stuff cause a problem?

After some research, it appears that multi-dais is a special driver that
downstream uses to allow multiple sub-DAIs to be combined into one DAI
that has all the channels of the sub-DAIs. This does not seem like
something that should be done at that level to me, because it seems
like it's pushing a sound driver configuration into the realm of
hardware description.

In retrospect, I should have stripped this out before submitting it,
because I should not be submitting things I don't understand completely.
I apologise.

> > The particular configuration may even vary per-board; an I2S/TDM
> > controller may be connected to an external codec which does not
> > support capture, whereas on another board it may be connected to
> > one that does.
> 
> If the external device doesn't support both directions then why does the
> driver for the I2S controller in the CPU care?  The constraint handling
> code in the core will ensure that nothing tries to start something that
> isn't supported

I went over the downstream text binding description again and from that
it appears that the playback/capture-only capability is something
specific to the controller, not to any device connected to it.

The downstream device tree for the rk3568 specifies playback-only for
I2S0, a.k.a. the one connected to the HDMI that I can't test because
we currently don't have a video clock. Another downstream device tree,
specific to what appears to be a robot demo for the px30 SoC, uses this
property on i2s1, which tells me that this is not an actual description
of the controller hardware but just a description of the application.

While not relevant to the device tree schema, the driver reacts to these
properties by setting the opposite directions _minimum_ channel number
to 0 (from the default of 2.)

My conclusion from this is that this reeks of nonsense and I will look
into what happens when I simply remove these properties and lower the
channels_min to 0 in the driver. If it turns out that on some SoC for
some I2S/TDM controller instance there is a limitation where specifying
that the controller only handles either capture or playback does make
sense, we can always add it later.

Thank you for your comments,
Nicolas Frattaroli


