Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63467410CB9
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 19:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhISRkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 13:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhISRkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 13:40:25 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D331C061574;
        Sun, 19 Sep 2021 10:38:50 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id t6so51432856edi.9;
        Sun, 19 Sep 2021 10:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5M7w7zPy21obTvYguz5Oq3eJq+JEdmpFilnfj/UaVzQ=;
        b=LhN5noFjo+451RFhaPdyEiaEskENVgpQpw/AKZYzB8yPg8w21uDQt3oeX0bOsbP3Gr
         CGbr7gmvPPmOjUdEtYO1vPUHutZjRsb2Qz9ekOMJ9IuCgg1/ArcVxFt7UeAyH1dESchQ
         TifLDaNGbXnep5im/SQaOK2V8JBxUNsIiwi720vH6zqPKVpELwe09vto+ju7FUNMMn1N
         gU4slJRLmX75YPFoPC/T02fI96cx4hv6v05GkCo7tUDhkmnQftykur0LfeKdjI1NZIvs
         Y5++L/weCha9F5RhlJCbiweOVNPBFO5bD4F3ywAQIwH54pEdF7MqpE//ZPSgmjSdnZfZ
         nUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5M7w7zPy21obTvYguz5Oq3eJq+JEdmpFilnfj/UaVzQ=;
        b=svHDiyI+2S58ekWXxPolli2uu6cYk8ZQlJFhYyTqloQtG6P2of8E8ZHVM+T3AVzO30
         7TaDSUX4nuMpjsxxUM9WCpET55SjTcKYGRH9tZesa6IHtEbj1rCsAVlKmhMqh1ADV+ip
         oTCZrg2WCBRZojuKaSncTDlH0LFNJpj/UFOOrrDglQzkAedSPOBEUN4rcO0KN2U4+ptB
         v3iISRdqZCzc1WWinNr97AFkYS8UJNZVrbLT1osRivKURWDBurufAJT49WF2Iin+UfyE
         i6ZnK38FjBQqfsOTtF8wHVIieCvkW+GSTTCSWM/44DDynI8jsLlqlhP529nX4mChIxr9
         c0Pw==
X-Gm-Message-State: AOAM533pSIi8PQqwS54mcdo3W3RrL/pg5e96YTr6JzdGNkv5nJlSYh+P
        huo/iJVtb75IBBp9Qka53V4=
X-Google-Smtp-Source: ABdhPJzIc1p2YHYXKQUZaJF5CsnCuPC6aHASPs/54dQ8LsS6ySMakHNHKw85yPRAQNwt3LxaJWqlFw==
X-Received: by 2002:a05:6402:88e:: with SMTP id e14mr25583141edy.342.1632073128991;
        Sun, 19 Sep 2021 10:38:48 -0700 (PDT)
Received: from archbook.localnet (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id c28sm5214401ejc.102.2021.09.19.10.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 10:38:48 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] dt-bindings: sound: add rockchip i2s-tdm binding
Date:   Sun, 19 Sep 2021 19:38:47 +0200
Message-ID: <2435067.tOv7cHfTnj@archbook>
In-Reply-To: <20210916122549.GF5048@sirena.org.uk>
References: <20210903231536.225540-1-frattaroli.nicolas@gmail.com> <42974939.Tn3hggVSkZ@archbook> <20210916122549.GF5048@sirena.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Donnerstag, 16. September 2021 14:25:49 CEST Mark Brown wrote:
> On Wed, Sep 15, 2021 at 07:06:14PM +0200, Nicolas Frattaroli wrote:
> > On Mittwoch, 15. September 2021 16:10:12 CEST Mark Brown wrote:
> > > Why is this not part of the normal bus format configuration?  I don't
> > > know what this is but it sounds a lot like I2S mode...
> > 
> > This affects all TDM I2S modes, i.e. TDM Normal, TDM Left Justified and
> > TDM
> > Right Justified.
> > 
> > Without tdm-fsync-half-frame, we purportedly get the following output in
> > TDM Normal Mode (I2S Format):
> > (ch0l = channel 0 left, ch0r = channel 0 right)
> > 
> > fsync: 	_____________________________
> > 
> >                      	            \____________________________
> > 
> > sdi/sdo: ch0l, ch0r, ..., ch3l, ch3r,  ch0l, ch0r, ...
> > 
> > With tdm-fsync-half-frame, we purportedly get the following:
> > 
> > fsync: 	_____________________________
> > 
> >                      	            \____________________________
> > 
> > sdi/sdo: ch0l,  ch1l,  ch2l,  ch3l,   ch0r,  ch1r,  ch2r,  ch3r
> > 
> > At least, according to the TRM. I do not have an oscilloscope to verify
> > this myself, and in the following paragraphs, I will elaborate why this
> > seems confusing to me.
> 
> fsync-half-frame is just normal TDM for I2S, the default mode is how DSP
> mode normally operates.  I don't know that there's any pressing need to
> support mix'n'match here, you could but it should be through the TDM
> configuration API.
> 
> > So to answer the question, it's not part of the bus format because it
> > applies to three bus formats, and I'm completely out of my depth here and
> > wouldn't define three separate bus formats based on my own speculation of
> > how this works.
> 
> It is part of the bus format really.  I suspect the hardware is the kind
> that only really implements DSP mode and can just fake up a LRCLK for
> I2S in order to interoperate.

Thank you for your explanation!

Going forward, what would be a solution that is acceptable for upstream? As 
far as I understand, the obvious route here is to drop the rockchip,fsync-
half-frame property and just always set this mode when we're using a TDM bus 
format. Is this correct?

According to the TRM, the register bit this sets only affects TDM modes. 
Though since TDM is not standardised in any way from what I've read online, it 
is possible that there is hardware out there which expects the non-fsync-half-
frame mode, but I am completely fine with only thinking about this hardware 
when it actually surfaces.

Regards,
Nicolas Frattaroli


