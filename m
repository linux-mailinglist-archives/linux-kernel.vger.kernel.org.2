Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F42A40CB64
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 19:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbhIORHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 13:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhIORHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 13:07:36 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E282C061574;
        Wed, 15 Sep 2021 10:06:17 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id b6so4955877wrh.10;
        Wed, 15 Sep 2021 10:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GTVsTGVHzHHxdcEJg4/8YrzvHZvRek9+ki75XlfwV6w=;
        b=U3vEqEgCOGl+c9PEE+3pQVWcmVpFPwH4Vk1y0emiMUsRJL7SIuEuiz2GuNdcFHZe6C
         DWyPP5WtNcPjHwquO2rXLaXgsGo3XAGuWZ/2vdt6PjOkXhVU0Zv8NWVXNHUIPRtpE+z/
         FXyehLwcE/nMqnUUb3yzosCLAtt/aIngZPEhgJTitK23lRkJgXzZGXOPtFiTkZvbDOPt
         0II9VJR54WTHU5mo/35kAwtjkE7+Wys5Cvyfl0u2ADdMIumGYIZm1cYtFNAB8Ri712Ly
         wWD3sbj3tK0mwP2PVHMe5hVmFLItWdqcuXTdD+RmRJVK0qlVKQjv95qT1DwMA96qtRiU
         RdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GTVsTGVHzHHxdcEJg4/8YrzvHZvRek9+ki75XlfwV6w=;
        b=nraAsBMFULmrqv7A9Se73NLwd91KlbRGcz69U57eougsPYQ0jFwRXP623zIiuGDrz9
         C7JbmMUxYBUHtKZseJh+a2iDv2GdowwveO4Q7l7RuVPynbtetDyyImTepifDLbPj3Hdd
         rtCw3WUWVFyRHcalzAHcJ8kLN3pW2ssEegtG1cvvocK41oBVUxXU5k+YmcyAlmezXsyK
         m8hohy7F5AJ+yDuIcj90WJdKuIo7vrmaDzF/3pPNXUAI11XRAoizKePLwY2NxypkHAJG
         A4vqDPq7KVHYj5b2I9+CSv8s5FPuPR0oUikZd2nR1QLdwCW/Ch9ufBvM92jpAHsEyJUK
         dbUw==
X-Gm-Message-State: AOAM530QxQlH1tTpHBBihwU71oTD1f85qkBorC0moV2eQhb3rfDXwXMd
        kNrGU2B6WIAbt0y0+h3a+FA=
X-Google-Smtp-Source: ABdhPJwJpOmUK49E3LeTsgzkI8+y91tIlB46nQfOTD778QVq5gZRib5LmUCXTPjYG103hZ2OLszbrQ==
X-Received: by 2002:adf:ce0c:: with SMTP id p12mr1204705wrn.194.1631725576068;
        Wed, 15 Sep 2021 10:06:16 -0700 (PDT)
Received: from archbook.localnet ([185.213.155.232])
        by smtp.gmail.com with ESMTPSA id f1sm509887wri.43.2021.09.15.10.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 10:06:15 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] dt-bindings: sound: add rockchip i2s-tdm binding
Date:   Wed, 15 Sep 2021 19:06:14 +0200
Message-ID: <42974939.Tn3hggVSkZ@archbook>
In-Reply-To: <20210915141012.GC12513@sirena.org.uk>
References: <20210903231536.225540-1-frattaroli.nicolas@gmail.com> <20210903231536.225540-3-frattaroli.nicolas@gmail.com> <20210915141012.GC12513@sirena.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mittwoch, 15. September 2021 16:10:12 CEST Mark Brown wrote:
> On Sat, Sep 04, 2021 at 01:15:34AM +0200, Nicolas Frattaroli wrote:
> > +  rockchip,tdm-fsync-half-frame:
> > +    description: Whether to use half frame fsync.
> > +    type: boolean
> > +
> 
> Why is this not part of the normal bus format configuration?  I don't
> know what this is but it sounds a lot like I2S mode...

This affects all TDM I2S modes, i.e. TDM Normal, TDM Left Justified and TDM 
Right Justified.

Without tdm-fsync-half-frame, we purportedly get the following output in TDM 
Normal Mode (I2S Format):
(ch0l = channel 0 left, ch0r = channel 0 right)

fsync: 	_____________________________
                     	            \____________________________
sdi/sdo: ch0l, ch0r, ..., ch3l, ch3r,  ch0l, ch0r, ...

With tdm-fsync-half-frame, we purportedly get the following:

fsync: 	_____________________________
                     	            \____________________________
sdi/sdo: ch0l,  ch1l,  ch2l,  ch3l,   ch0r,  ch1r,  ch2r,  ch3r

At least, according to the TRM. I do not have an oscilloscope to verify this 
myself, and in the following paragraphs, I will elaborate why this seems 
confusing to me.

The comment block "DAI hardware signal polarity" in soc-dai.h seems to imply 
that what the TRM says the tdm-fsync-half-frame mode is (if one inverts fsync 
polarity of those waveforms), is what is expected:

> * FSYNC "normal" polarity depends on the frame format:
> * - I2S: frame consists of left then right channel data. Left channel starts
> *      with falling FSYNC edge, right channel starts with rising FSYNC edge.
> * - Left/Right Justified: frame consists of left then right channel data.
> *      Left channel starts with rising FSYNC edge, right channel starts with
> *      falling FSYNC edge.

I don't know if this is only applicable to non-TDM I2S, and whether it's 
normal to have the channels interleaved like that in TDM.

I don't see any DAIFMT that does what this does in any case.

So to answer the question, it's not part of the bus format because it applies 
to three bus formats, and I'm completely out of my depth here and wouldn't 
define three separate bus formats based on my own speculation of how this 
works.


