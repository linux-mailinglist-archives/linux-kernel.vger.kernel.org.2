Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3927C392DF6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 14:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbhE0MbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 08:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbhE0Ma6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 08:30:58 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A40C061761
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 05:29:22 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id p39so450787pfw.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 05:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lzggwkwLPsGkqROCQrFoMo/EvgYIJci/zbm9PeGjIk0=;
        b=EYmigkpQTz9NSx6So1qYsm7RWFpAJD9ork/TZ4owbGAgWg/9D7pft/OiwioWRV1UY/
         4Pg1cmCoaaqMEPnMB5xnJxM+VImS9+YJqEXgohfTEPseh5vy11mnubEVGyYo5kieIuYF
         JHMW+qzqun0WFNX0q15+sphLQq/NCObdjEM5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lzggwkwLPsGkqROCQrFoMo/EvgYIJci/zbm9PeGjIk0=;
        b=kS1nbs7xA9iCziXZ/68MKygTWmUYEc3r9TnPLBf42YhmewhQUW5wuaoTyw2r+28kpE
         55G+Uh3F+IOKhBOurbNgldbFJMg7uk6/cV6wn4RVbjGli7SFGIu453atLQRquwHoGUqV
         9h34Ls7gWItwJ0xYUXsqpAmqfYf6cHpBhzZmCVzk4FT7nggvAHci32OOEl4Tgzr0IZbC
         IYp806kaPCFzfGCU3Jy/XtmqY3rhHCVen3wwHOU57SbulBwvk14/DGQSGdBf9wEwRTFI
         yA2Nf4SUoT07DXjjIG1H9BoWcZEjtjaoRBt3KvA/LRO2NO7v+Ssz/oBCWwkZ8mD630A/
         8Kvg==
X-Gm-Message-State: AOAM532R0JBp3K2wOA15FqZc6kZ44P/yUzGBonvseM8IxEqKF7dozC4S
        tFj/Tekf4mSUUOgJLVvhvvC8Xg==
X-Google-Smtp-Source: ABdhPJxHlrGNoVThzD9jXDunpAOOoUVlqmsHj782bf3WpYVZpsXhZsPr8L6VnGUc3ZUFw5LcKkXdEw==
X-Received: by 2002:a05:6a00:1a0f:b029:2dd:823b:3dce with SMTP id g15-20020a056a001a0fb02902dd823b3dcemr3487042pfv.35.1622118562288;
        Thu, 27 May 2021 05:29:22 -0700 (PDT)
Received: from 7698f5da3a10 ([124.170.34.40])
        by smtp.gmail.com with ESMTPSA id h26sm1946892pfk.19.2021.05.27.05.29.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 May 2021 05:29:21 -0700 (PDT)
Date:   Thu, 27 May 2021 12:29:15 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>, chenjh@rock-chips.com
Subject: Re: [PATCH] regulator: fan53555: add back tcs4526
Message-ID: <20210527122911.GA1640@7698f5da3a10>
References: <20210526162342.GA20@8bbba9ba63a4>
 <CAMdYzYpZoKs3P62j02RW-+5BEpqC9JL3apjucTWLWmvNFrOrCg@mail.gmail.com>
 <20210527105943.GA441@7698f5da3a10>
 <462b8d80447efb6c00e93704914169bceb5adc4d.camel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <462b8d80447efb6c00e93704914169bceb5adc4d.camel@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ezequiel and Peter,

Thanks for the feedback.

On Thu, May 27, 2021 at 08:51:27AM -0300, Ezequiel Garcia wrote:
> Hi Rudi,
> 
> Thanks for the patch.
> 
> On Thu, 2021-05-27 at 10:59 +0000, Rudi Heitbaum wrote:
> > On Wed, May 26, 2021 at 02:41:00PM -0400, Peter Geis wrote:
> > > On Wed, May 26, 2021 at 12:23 PM Rudi Heitbaum <rudi@heitbaum.com> wrote:

...

> > I chose to follow the example of silergy,syr827 and silergy,syr828 for
> > tcs4526 (given I made the mistake in assuming that support for tcs4525
> > meant support for tcs4525.) This would maintain consistency of naming
> > of
> > tcs4526 throughout the source. Is that ok?
> 
> It's fine to have both compatibles (and avoids confusion in
> device-trees), just remember to update the dt-bindings as well.
> It's funny to see drivers with both schemes, so we really have to
> decide which path we want to go down.
> Considering the syr827/syr828 as convention, we should probably just
> go down that route for consistency within the driver.

Thanks Peter - I will resubmit the tcs4526 patch along these lines.

> > Removal of the operating points kind of makes the gpu regulator
> > moot, don't you think?

> As Peter rightly said, this will prevent gpu devfreq from working.

This is the draft that I have been working on within LibreELEC10, still
a ways to go I'm afraid. Having decided to getting the SBC to run
mainline kernel and u-boot. The regulator and subsequent regulator fix
will hopefully address https://bugzilla.kernel.org/show_bug.cgi?id=212917 
too. As you have identified - it is not ready for upstreaming :-)

Thank you both for the direction and pointers on the dts. I will get the
v2 patch going first.

> Out of curiosity, why disabling the little VOP?

Only disabled within my WIP dts so as to focus my attention on successful 
running of LE10 on the rk3399pro, before I move to attempting to enable 
the NPU and the other nodes.

> I can be wrong, but I think regulator-compatible is deprecated.

I will look it to this. 

Now with the addition of the regulator and Peter's fix I will start
qualifing each of the dts nodes and the correct options against the
schematic.

> > +??????????????????????????????vsel-gpios = <&gpio1 RK_PC1 GPIO_ACTIVE_HIGH>;
> 
> Is vsel-gpios ever used in the mainline driver?
>
> > +??????????????????????????????regulator-compatible = "fan53555-reg";
> 
> Ditto.
>
> > +??????????????????????????????vsel-gpios = <&gpio1 RK_PB6 GPIO_ACTIVE_HIGH>;
> 
> Ditto.
>
> > +??????????????????????????????regulator-boot-on;
> 
> Just out of curiosity, is regulator-boot-on really needed for the GPU?

Will check.
