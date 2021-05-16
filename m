Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40874382018
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 18:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhEPQ7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 12:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhEPQ7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 12:59:19 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FCAC061573;
        Sun, 16 May 2021 09:58:03 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id r11so4100519edt.13;
        Sun, 16 May 2021 09:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=THGNQdN+G1zV46mDYPmEAZYdYXCX5MmcuOTwcSwtuvo=;
        b=vAwr7XqIbClut1z4sdTFuPnfDRT1ReLHcBMUUYKcxipLRLfV/kXk3zPTCVrzm+fdyg
         GfOTvKxO/JsS73b3r+5civRLoH6xcwav0JK7i76bRxbzMNt2ejSSZLjyoM88eW2v8RKF
         yhrGqWpt7E9XKqed3CTJQqdwVjgWnp0hq2Vn+2p3uGEtIB27UTpX8Zj8fTEECzHkLztC
         HFSvs76VCxvdJeD/Drx4dAp19lieKG65qSWKvz74tOuKBFPCDS0ZdQxEZPQpVCQtiIIq
         oFHVlNlXKk/W9dAbPBo0p119Z0MPSQn/hhbSlu1L7n68Wp+VE4jL6NhFewnV47SNgEKE
         TPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=THGNQdN+G1zV46mDYPmEAZYdYXCX5MmcuOTwcSwtuvo=;
        b=mZWdNW0Pp6gBX+/aJ77Wd3I+Cm+U2BgHvQdjgPZFQnUrdetriP/wAzSxttpBWNUERe
         A9nytcrZLUiKHQrhUjENyacKCdifchq7gttlUFlTCMsorUB2jeoG05D6gGF86Hh8yqCq
         QSpW69/g4f4+gxcJP8Yl9/XwX4Q69rdka7xcpbWlspM5rCdKM2Mo7NDUIS1xbLkyyJ4w
         Y2dmLCAbReGzjmd5MHAC5XZBBy1tYIx4y5P7CfTK5W1+EiKUsa1ozwx6lXrlFzqEC5oC
         fRZa4S1TUuqCeb1FCQyfUnDbWprfB2jAe2E8BP4r921khXBkFyTi0WFQcqQpOtgHMg76
         FIuA==
X-Gm-Message-State: AOAM5323hcSbwhLL2KsxaXKVbW9MRgZ+thd9YfnoThIl2xYbdMqI8sSM
        SGW27S+whdnHriZIFcjehao=
X-Google-Smtp-Source: ABdhPJwaShKoLi6L7M46jeK47mTX8GC6V1iNP2M+rmarPzrHU77J5vNHFEl+wU8YJI3T79mFG1OrGQ==
X-Received: by 2002:aa7:c548:: with SMTP id s8mr5163282edr.114.1621184281922;
        Sun, 16 May 2021 09:58:01 -0700 (PDT)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
        by smtp.gmail.com with ESMTPSA id l11sm9027237edw.42.2021.05.16.09.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 09:58:01 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date:   Sun, 16 May 2021 18:58:00 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        "B.R. Oake" <broake@mailfence.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Vagrant Cascadian <vagrant@reproducible-builds.org>
Subject: Re: [PATCH] ARM: dts: sun8i: h3: orangepi-plus: Fix Ethernet PHY mode
Message-ID: <YKFPGC2qBMipQPbd@eldamar.lan>
References: <1243888060.510560.1612783497400@ichabod.co-bxl>
 <20210210150118.ly252i37eykayrcb@gilmour>
 <1719200956.433094.1613199092092@ichabod.co-bxl>
 <6612268.HtAl026vyE@jernej-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6612268.HtAl026vyE@jernej-laptop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Feb 13, 2021 at 09:51:17AM +0100, Jernej Škrabec wrote:
> Hi!
> 
> Let me first explain that it was oversight on my side not noticing initials in 
> your SoB tag. But since the issue was raised by Maxime, I didn't follow up.
> 
> Dne sobota, 13. februar 2021 ob 07:51:32 CET je B.R. Oake napisal(a):
> > On Wed Feb 10 at 16:01:18 CET 2021, Maxime Ripard wrote:
> > > Unfortunately we can't take this patch as is, this needs to be your real
> > > name, see:
> > > https://www.kernel.org/doc/html/latest/process/submitting-patches.html#de
> > > veloper-s-certificate-of-origin-1-1
> > Dear Maxime,
> > 
> > Thank you very much for considering my contribution and for all your
> > work on supporting sunxi-based hardware; I appreciate it.
> > 
> > Thank you for referring me to the Developer's Certificate of Origin, but
> > I had already read it before submitting (I had to do so in order to know
> > what I was saying by "Signed-off-by:") and I do certify what it says.
> > 
> > Looking through recent entries in the commit log of the mainline kernel,
> > I see several patches from authors such as:
> > 
> >   H.J. Lu <hjl.tools@gmail.com>
> >   B K Karthik <karthik.bk2000@live.com>
> >   JC Kuo <jckuo@nvidia.com>
> >   EJ Hsu <ejh@nvidia.com>
> >   LH Lin <lh.lin@mediatek.com>
> >   KP Singh <kpsingh@kernel.org>
> >   Karthik B S <karthik.b.s@intel.com>
> >   Shreyas NC <shreyas.nc@intel.com>
> >   Vandana BN <bnvandana@gmail.com>
> > 
> > so I believe names of this form are in fact acceptable, even if the
> > style might seem a little old-fashioned to some.
> 
> Speaking generally, not only for this case, prior art arguments rarely hold, 
> because:
> - it might be oversight,
> - it might be a bad practice, which should not be followed in new 
> contributions,
> - different maintainers have different point of view on same thing,
> - maintainer wants to adapt new practice or steer subsystem in new direction
> 
> > 
> > I would like to add that I have met many people with names such as C.J.,
> > A A, TC, MG, etc. That is what everybody calls them and it would be
> > natural for them to sign themselves that way. Some of them might want to
> > contribute to Linux some day, and I think it would be a great shame and
> > a loss to all of us if they were discouraged from doing so by reading
> > our conversation in the archives and concluding that any contribution
> > from them, however small, would be summarily refused simply because of
> > their name. Please could you ensure that does not happen?
> 
> The link you posted says following:
> "using your real name (sorry, no pseudonyms or anonymous contributions.)"
> 
> I believe that real name means no initials, no matter what people are 
> accustomed to. From my point of view, CJ is pseudonym derived from real name.
> 
> This is not the first time that fix of SoB tag was requested, you can find such 
> requests in ML archives.

Any chance this could be resolved? In downstream (here Debian) we
would be interested to have the patch applied due to
https://bugs.debian.org/988574 reported by Vagrant Cascadian.

Regards,
Salvatore
