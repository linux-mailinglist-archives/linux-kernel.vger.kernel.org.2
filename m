Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 925A8444A81
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 22:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhKCV4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 17:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbhKCVz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 17:55:59 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABD3C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 14:53:21 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id t30so5628983wra.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 14:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jyLAJwUm/AOuLnPRyRRsAl2gXmuTkEQg9TaAGOMRoqs=;
        b=SvBVNQDCTSvYEoGLP0vAjlKodw407ylFgmo39iYK0Ow0XxgvQTTo5s4eQg2XrypDQv
         rDBqdsE5L3AqbB0KLbDifuhLNg342lmHlriE2dBEMK9bT8IslDbQph380UZ9OvWqOp9s
         G/EQuctF6jTqRsfu4iV1fWpOUQQm6WGgiQSktwlMBInGQZFaFWcU4fYXWGZTxMI1mbAR
         Sr2SRBWkLsE4cNW/XmOrdQdGYaP5JKVIHkR8tq8ic6hDtL8C1USL1lmQBklHyV7dxlFf
         zx4ZNau/QKP+5GzwibzjmyutcA1tecgUvo0V3ASAJwa8gAgpU4LwV1MKIGh4OUBPA+o9
         HbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jyLAJwUm/AOuLnPRyRRsAl2gXmuTkEQg9TaAGOMRoqs=;
        b=uLQW8Cd67hrIx1ycwu3AJjeT3eDYptXj0iPIxTPmQU+lq/JApgEOfphIEvp06UQSZE
         N68MigDalD+PxCky63ls5qrcVzNeblrA//6UiAVEvZDMA0AsSya1/dye0BENaNTccNYm
         YrLV+s1br5JVTP+tfczuupO+HoVUItBG/CCggChUbkpUHR1+t/KpIUDkcMILDE9KvwB7
         ePFSfsywTYkX6sBjFozI6mDiQAZztZp9EQq0nHDELoHz+/u8+x158qcXaKS2LyLWmAc6
         zYwD67+cJEo2xWpuB/BNoi61ovYakOGUsIwCufAhRS+dK1iJtFAJVYZmGUdzpzqaRZ/r
         zCMw==
X-Gm-Message-State: AOAM5311hf+rETxjCbBSQauB6tqhfaizkijoB0GLgirxbOBSf71BwuZe
        mJkod/NhYBLsSHLgrK+O8pQ3zK2Hafs=
X-Google-Smtp-Source: ABdhPJwyhXQl/9nO95rjc0HZ58pZ/EF3df/hiLMfpbENl9znEYrNAlw5uZUKIs3utODFSebp1IJFBw==
X-Received: by 2002:adf:9bcd:: with SMTP id e13mr16611113wrc.165.1635976400236;
        Wed, 03 Nov 2021 14:53:20 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.gmail.com with ESMTPSA id e18sm3054762wrs.48.2021.11.03.14.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 14:53:19 -0700 (PDT)
Date:   Wed, 3 Nov 2021 22:53:17 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regmap: allow to define reg_update_bits for no bus
 configuration
Message-ID: <YYMEzTQhb8s31rzu@Ansuel-xps.localdomain>
References: <20211102214138.28873-1-ansuelsmth@gmail.com>
 <YYLAXL4HjgBGuF91@sirena.org.uk>
 <YYLnlbTFRUdLrmpW@Ansuel-xps.localdomain>
 <YYL/JwHxKsTmGT84@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYL/JwHxKsTmGT84@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2021 at 09:29:11PM +0000, Mark Brown wrote:
> On Wed, Nov 03, 2021 at 08:48:37PM +0100, Ansuel Smith wrote:
> > On Wed, Nov 03, 2021 at 05:01:16PM +0000, Mark Brown wrote:
> > > On Tue, Nov 02, 2021 at 10:41:38PM +0100, Ansuel Smith wrote:
> 
> > > > -	if (regmap_volatile(map, reg) && map->reg_update_bits) {
> > > > +	if ((regmap_volatile(map, reg) || !map->bus) && map->reg_update_bits) {
> > > >  		ret = map->reg_update_bits(map->bus_context, reg, mask, val);
> > > >  		if (ret == 0 && change)
> > > >  			*change = true;
> 
> > > I don't understand this change.  The point of the check for volatile
> > > there is that if the register isn't volatile then we need to ensure that
> > > the cache gets updated with any change that happens so we need to go
> > > through paths that include cache updates.  The presence or otherwise of
> > > a bus does not seem at all relevant here.
> 
> > I put the check there to not duplicate the code. The idea here is:
> > if we are doing a regmap_update_bits operation on a no bus configuration
> > and the function have a dedicated reg_update_bits function, use that
> > instead of the normal _reg_read, check and _reg_write.
> 
> Yes, I can see that this is what the change does - the problem is that
> it's buggy.
> 
> > To workaround the CACHE problem, I can add a check and detect if cache is
> > disabled and only with that option permit to add a reg_update_bits
> > function to the map (for no bus configuration).
> 
> That's what the volatile check that is already there does - if there is
> no cache or that particular register is uncached then the register is
> volatile and we don't need to worry about updating the cache.  There is
> not and should not be any connection to how the device is physically
> accessed, any connection there is clearly an abstraction problem.
> 
> > Again the problem here is in situation where lock is handled outside of
> > the read/write and the read/modify/write operation has to be done in one
> > go so splitting this operation in 2 step (like it's done for
> > regmap_update_bits) would be problematic.
> 
> Unconditionally introducing a data corruption or power management bug
> for any device that provides an update bits operation regardless of
> their requirements to use that operation for a specific register is not
> a good idea.  If an individual device can't cope with some or all
> registers being cached then the driver for that device should configure
> it's regmap appropriately to ensure that the registers in question won't
> be cached.
> 
> > Another solution would be to expose a way to change the cache externally
> > to the regmap operation so that if someone require cache operation and
> > require also a dedicated reg_update_bits, he can do that by implementing
> > that in his own function.
> 
> I'm struggling to see a case where this would be useful without the
> register also being volatile in which case it's totally redundant.  If
> the register can change underneath us then it is by definition volatile,
> if the register can't be changed underneath us then with a cache there's
> unlikely to be any meaningful upside to using a specific read/modify/write
> operation in the first place.  You might have some case for wider
> registers where you can do a smaller transfer but that's got to be rare
> and I'd expect we'd have to be doing a lot of register I/O to care about
> the performance diffrence.
> 
> > A third solution would be check if it's possible to cache the value
> > externally to function... Something that calls the reg_update_bits
> > dedicated function and then update the cache if needed.
> 
> That's exactly what the existing volatility check does, 
> 
> > But do we really need to add all this complexity when we can just deny
> > an option with cache enabled and force to use the normal way (else part
> > in this function)
> 
> > Hope I was able to explain better why we need this change.
> 
> We do not need this change.  The change that is being proposed will
> cause bugs, my best guess is that it's trying to work around a bug in
> the driver you're developing where it's enabling caching but not marking
> all the volatile registers properly.  If there is any change needed in
> the _update_bits() implementation then where we get a device specific
> _update_bits() operation from should have no influence on our decision
> to use it, doing that is a clear sign that there's an abstraction
> problem.

I think I'm missing something. The user case is a driver that
have CACHE DISABLED. The !map->bus check is added just to limit this to
a no bus configuration not to permit this with CACHE enabled. The limit
I was referring was in the init function where the update_bits is
assigned to the map. I honestly didn't notice that anything with cache
disabled was flagged as volatile.

So the rest of the changes permit to declare a update_bits function
for a no bus configuration is good?

Again that was the main reason of this patch. Obviously I didn't want to
introduce bugs or an hack to bypass the cache thing. Just I notice this
was permitted with a bus configuration but the no bus configuration
lacks any way to configure a update_bits function.

-- 
	Ansuel
