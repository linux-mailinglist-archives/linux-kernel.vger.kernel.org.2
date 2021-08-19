Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB483F1AF1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 15:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240272AbhHSNxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 09:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240102AbhHSNxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 09:53:34 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E8EC061575;
        Thu, 19 Aug 2021 06:52:58 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id lo4so13079379ejb.7;
        Thu, 19 Aug 2021 06:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/HYaakT71hwEdcXvkxwyQsillUjSwTO59JhdjV9n6y4=;
        b=BVG+5HrApNRX9+03fK0jt38W6Ps+UyhCQADZcdZe1QVPyVsrWh+RlxWohzju5i7IfV
         IGO9cvRFPjCMp+i8l1kXqOyMt3QsOoyEyu6f7xLSY7Vs2LzpmsgFEuz3zLkK/6CTLrdj
         F7nnKRo3DDRugBTcoyY2Rss9o2yUYfy9fQZb1Ep0lkSXVE8XYZuQuYlYw0PKM9C5vj1A
         w2VGwE8UO4owDU0hs4h1DKqlg8np9j+vKv5jrARah7QGVhcuNxgx2j2bpqUMvH8vp+eV
         vRUi7Sq+lk179LXgirigXKAzF0UqCguYyHo0hgqud7AZMK6uB2DFeBV2HxFX1QzBgUO8
         +utQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/HYaakT71hwEdcXvkxwyQsillUjSwTO59JhdjV9n6y4=;
        b=LotufcwczG5DolTfY7J1TFerP/Db/QLWe+IGDLqcK5+k97Gb1ao1nl0E5pN0+TVX5E
         BWv+WWhF6xCkbh09Qpfuc8DOnx6NC65HbQ9EKHUtUvQIUgl4dK6fU4gL7GJ2K52LQmjk
         erYPqwsMh+rh7Huv4M7C0XVRYQoIi+yQHRbD/Mn7vDYnM3VaSTRG89v6savN9rKyhACq
         aoaBD8o6R9X3fp6ol2FzwI+x1Jftm3nnCoA50qt2qewWoMsdhzS5a28k7qKZbLBSbyhy
         f7YpSkLgCl5aHpAZX+Xn/CSM9a7vFy5aVQ2Jqa3njq5+ESam4XYXy8UDG1PhQr4VAooJ
         09hQ==
X-Gm-Message-State: AOAM530BWg66EweUgtRo5lUv58Cl0d5U6Opc5aPqvjEYjoqXSefmuHah
        k8uxyk19v0jjKsIAR39XBag=
X-Google-Smtp-Source: ABdhPJxf6vkzIJ5gvRxJJnkoE76NF/NsXfuA1qI+2XbKik7L6dd//lHk57lp40vP12GLenGbbQ1fCQ==
X-Received: by 2002:a17:906:1dd6:: with SMTP id v22mr9418467ejh.226.1629381176818;
        Thu, 19 Aug 2021 06:52:56 -0700 (PDT)
Received: from archbook.localnet (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id y23sm1294480ejp.115.2021.08.19.06.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 06:52:56 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: sound: add rockchip i2s-tdm binding
Date:   Thu, 19 Aug 2021 15:52:55 +0200
Message-ID: <2412250.zZEsDtmPgG@archbook>
In-Reply-To: <deb50900-fcfd-23d0-ab8a-0e64b2abb063@arm.com>
References: <20210817101119.423853-1-frattaroli.nicolas@gmail.com> <20210817101119.423853-3-frattaroli.nicolas@gmail.com> <deb50900-fcfd-23d0-ab8a-0e64b2abb063@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Donnerstag, 19. August 2021 14:08:36 CEST Robin Murphy wrote:
> On 2021-08-17 11:11, Nicolas Frattaroli wrote:
> > +  rockchip,trcm-sync:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      Which lrck/bclk clocks each direction will sync to. You should use
> > the +      constants in <dt-bindings/sound/rockchip,i2s-tdm.h>
> > +    oneOf:
> > +      - const: 0
> > +        description:
> > +          RK_TRCM_TXRX. Use both the TX and the RX clock for TX and RX.
> > +      - const: 1
> > +        description:
> > +          RK_TRCM_TX. Use only the TX clock for TX and RX.
> > +      - const: 2
> > +        description:
> > +          RK_TRCM_RX. Use only the RX clock for TX and RX.
> 
> I wonder if that might make sense to have boolean properties to describe
> the latter two cases (which would effectively be mutually-exclusive),
> rather than a magic number? Or possibly even just make the respective
> clocks optional, if this is something which would be done per-SoC rather
> than per-board?
> 

From what I know from downstream vendor device trees, these are per
board, not for the SoC as a whole. There are I2S/TDM controllers on the
SoC which I think are hardwired to certain other IP blocks, such as I2S0
being connected to HDMI, but I2S1 can be routed outside of the SoC where
these come into play I believe.

As for making them boolean properties, I'd rather not. If I were to make it
two mutually exclusive booleans, this would result in 4 possible states
rather than 3, and require complexity to check it both in the schema and
in the probe function. Like this, I can get away with a switch case that
has a fallthrough, and a list of consts in the schema.

> > +
> > +  "#sound-dai-cells":
> > +    const: 0
> > +
> > +  rockchip,no-dmaengine:
> > +    description:
> > +      If present, driver will not register a pcm dmaengine, only the dai.
> > +      If the dai is part of multi-dais, the property should be present.
> > +    type: boolean
> 
> That sounds a lot more like a policy decision specific to the Linux
> driver implementation, than something which really belongs in DT as a
> description of the platform.

I agree. Should I be refactoring this into a module parameter or
something along those lines? I'm unsure of where this goes.

> 
> > +
> > +  rockchip,playback-only:
> > +    description: Specify that the controller only has playback
> > capability.
> > +    type: boolean
> > +
> > +  rockchip,capture-only:
> > +    description: Specify that the controller only has capture capability.
> > +    type: boolean
> 
> Could those be inferred from the compatible string, or are there cases
> where you have multiple instances of the IP block in different
> configurations within the same SoC? (Or if it's merely reflecting
> whether the respective interface is actually wired up externally, could
> that be inferred from the attached codec?)
> 
> Robin.
> 

They can't be inferred from the SoC because there are indeed multiple
instances of this IP block in different configurations on the same SoC.
The RK3566 and RK3568 have four in total, of two different categories,
each being able to be configured for a different format (though the
number of channels and available formats vary for the two categories,
one group only supports I2S and PCM with two channels)

The particular configuration may even vary per-board; an I2S/TDM
controller may be connected to an external codec which does not
support capture, whereas on another board it may be connected to
one that does.

As an example, if I understand it correctly, I2S3 on the RK3566 and
RK3568 can do 2 channels RX and TX in I2S mode, but only 2 channels
either RX or TX in PCM mode, but I'm unsure of the language in the
(still not public) documentation I have.

Regards,
Nicolas Frattaroli


