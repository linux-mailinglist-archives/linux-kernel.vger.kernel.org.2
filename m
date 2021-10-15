Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0A342FD7D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 23:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243136AbhJOVfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 17:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243079AbhJOVfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 17:35:44 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8047C061570;
        Fri, 15 Oct 2021 14:33:37 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id x192so12039906lff.12;
        Fri, 15 Oct 2021 14:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gix2t0OaFc3liLwqh7FD+UgpYjMWRC2yF5wlNLCRBI8=;
        b=qis8HY5aJowC4EqJFx3MOPhEGhcXjXhZTpVf0O0ZaJ8dAFgGw91o/hVODkU7FRxcw6
         AZU8vc1BfB4zTjM1P62wns5tOI3qN2C+s4pQ1Wsy7bv7gKL7jKc2hWKLs86XVr4W4TUT
         h5GijvI+PE96P1JI/y2GSZq49aFy6a6+/4SPzO/ECa11w6Y/Kv6VmU9qceSy5gDjzk8o
         pnepTbIkXzhYSl8fZ83W2Z3QQXtAUBpmlgoDMhpCXuKK0p9NHv69rY9hNa2BbT6Eg8it
         MsEqAMGICMa6VJqyKAXdLuPQ4xTTE1dI1LqDGKMGRp/pg/8J7tVBDb3taihP7FUws+6E
         ilHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gix2t0OaFc3liLwqh7FD+UgpYjMWRC2yF5wlNLCRBI8=;
        b=3bO+DnadSFUCh8FtN9H91OaFfk+VMU3Ap1To/C3KizwrW+nGuQ9wklarWQvNyC077W
         4mDYGhrdgiTEe28Z/yTTIWqoChDEcThErh074cf2XeLF4eZxVekX9uwfec+m1EjdKzTS
         ROZ6Ybz8M/vxiN5IEVaLhS8oBRS4Qzgkr25O1puhZk4JWh+y/IXHobotHwsnLvlvvrZZ
         ORwpcZvVjF1Fv5GAxCRt8SgrKEbC3hwCEI8YNm3Bd5kbqyNLQ1XimEeiqpFzmbQYkjaq
         Xj04wxshPm0Sb5AP1/HJD9FEJvqUqWrVHUuFbFeeoVABJziyJ1ZxtVeXf5xBrTqaD0lR
         Dr1Q==
X-Gm-Message-State: AOAM530TUhXLK1jrZONlk/PYy0jAs4z4rBN8LpZB5XfDvqFDBSWtv41r
        um/co+J+UOzcv6jK6ZuI33Q=
X-Google-Smtp-Source: ABdhPJyGE7Et43k/hdPxjdpBoYE8kfL5iTjenGOdjS4PvWxGzZHpGXrxlrYYk3a+u1/JkqbbVxvBCQ==
X-Received: by 2002:a05:6512:3b94:: with SMTP id g20mr13375031lfv.77.1634333616241;
        Fri, 15 Oct 2021 14:33:36 -0700 (PDT)
Received: from archbook.localnet (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id f23sm689425ljn.110.2021.10.15.14.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 14:33:35 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Rob Herring <robh@kernel.org>, linux-rockchip@lists.infradead.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: rockchip: i2s-tdm: fix rockchip, cru requirement
Date:   Fri, 15 Oct 2021 23:33:34 +0200
Message-ID: <2236749.301RoY5kYM@archbook>
In-Reply-To: <8553b0cd-95e4-c3db-c75a-d3b28e99f131@arm.com>
References: <20211015143115.1445707-1-frattaroli.nicolas@gmail.com> <8553b0cd-95e4-c3db-c75a-d3b28e99f131@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Freitag, 15. Oktober 2021 19:44:56 CEST Robin Murphy wrote:
> On 2021-10-15 15:31, Nicolas Frattaroli wrote:
> > The behaviour described in the bindings is exactly the opposite
> > of what it should be, so this patch fixes the description and
> > adjusts the if conditions for adding rockchip,cru to required.
> > 
> > Fixes: 510f1c133aed ("ASoC: dt-bindings: rockchip: add i2s-tdm bindings")
> > Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> > ---
> > 
> >   .../devicetree/bindings/sound/rockchip,i2s-tdm.yaml   | 11 ++++++++---
> >   1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
> > b/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml index
> > ce3e18b50230..93f5221e9381 100644
> > --- a/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
> > +++ b/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
> > 
> > @@ -86,7 +86,7 @@ properties:
> >       $ref: /schemas/types.yaml#/definitions/phandle
> >       
> >       description:
> >         The phandle of the cru.
> > 
> > -      Required if neither trcm-sync-tx-only nor trcm-sync-rx-only are
> > specified. +      Required if either trcm-sync-tx-only or
> > trcm-sync-rx-only are specified.> 
> >     rockchip,grf:
> >       $ref: /schemas/types.yaml#/definitions/phandle
> > 
> > @@ -147,8 +147,13 @@ required:
> >   allOf:
> >     - if:
> >         properties:
> > -        rockchip,trcm-sync-tx-only: false
> > -        rockchip,trcm-sync-rx-only: false
> > +        rockchip,trcm-sync-tx-only: true
> > +    then:
> > +      required:
> > +        - rockchip,cru
> > +  - if:
> > +      properties:
> > +        rockchip,trcm-sync-rx-only: true
> 
> FWIW, isn't this just a long-winded way to say
> 
>    if:
>      anyOf:
>        - properties:
>            rockchip,trcm-sync-tx-only: true
>        - properties:
>            rockchip,trcm-sync-rx-only: true
> 
> which itself could still be more concisely
> 
>    if:
>      not:
>        properties:
>          rockchip,trcm-sync-tx-only: false
>          rockchip,trcm-sync-rx-only: false
> 
> ?

Hi Robin,

you are absolutely correct. I'm not very familiar with dtschema yet,
so I mostly just did what I know would work, as I didn't know about
"not" or "anyOf" in this context.

However I don't think this patch is going to get a V2 because I may
have found a way to easily get rid of the CRU property altogether,
making this patch sort of obsolete in the very near future.

Thank you for your review nonetheless, I learned some more dtschema
today thanks to it. :)

> 
> Robin.
> 
> >       then:
> >         required:
> >           - rockchip,cru

Regards,
Nicolas Frattaroli



