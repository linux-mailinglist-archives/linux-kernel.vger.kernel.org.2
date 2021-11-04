Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8944455D1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 15:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbhKDPAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 11:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbhKDPAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 11:00:20 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CF1C06127A
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 07:57:41 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id f8so22559094edy.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 07:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Js+7/ZUk3/r5KTWs85NRZyo6sXhu0UrCLJkgLeGrU3E=;
        b=WxCVTUR+5MuH4Qn/EOCelYlsykqVipe4Czt+xp7BPgB0n+5+qzWsf4wifNlE17YWIf
         mFuqHXEKGywAentpewg7c6FeAG0omVvodGgE0qtSdXw+biMfFj/RT0u+Lnu6Qlfo7zn/
         yXphNDPC74+N9719S3wvflqA4izXA2zH5Yfhba4XLhAKOZ2U1eBoEU5fOFT84hQrn9a3
         vS5FH69WrOR0ISBBmi269Qo1VR2qoyZkCgG2VjVeVzGKmkcC8GXfFXBstVRACQkpjkmn
         5nAXerq2naBM1oiSB0c3XQD879AQd+64uotVdMiOq4JwYY+jB1wdIuhZFnvh1VulBtV9
         tguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Js+7/ZUk3/r5KTWs85NRZyo6sXhu0UrCLJkgLeGrU3E=;
        b=pj6/JAKYuxoSMgL8NuCahpppP4WnS8PyZ+JSmHfFDeqE/tC+Xzt0U2VdUQL1EabSJ1
         vERyxxazW+JNs3ExrnlNoNlGEoiVC9i9oVotNGBsveYKyCiUDcUb4we0YGZMox1EbF/Y
         Qge9w5EG69apo1xm+tN0GLgKO2kOyFO3DG9/M5PTmYoF4kgQss1PP7U34Jjjz5WvWyRa
         4IBAP5iTQN261Hb1nQDkLEAbnZS8xzg8x505NAgZ43SlGqFnMB5OIi/LmLtln0UtY+tI
         VrF84MFbkK70g/KAsWCzNVgwx6Gxnh3XVaQuXL36Tx0qtdfHv2X+iGeAzhuxr7lKdUe9
         Ka6g==
X-Gm-Message-State: AOAM5318HPCDZZmlqacdIMKttPEDIyRa6XEYTlh0bjxw0dtqcPhQL+GM
        xBbYLoUrIN/sUJKRy15cLK+837prGI0=
X-Google-Smtp-Source: ABdhPJyo/kokp4/M8E2jNqYDfEVY9FCPGNVvHJ9ac1J61eStHZ+aymU/7gHwxddg6vw4ZFdjubOalA==
X-Received: by 2002:a17:906:3784:: with SMTP id n4mr63427943ejc.129.1636037858825;
        Thu, 04 Nov 2021 07:57:38 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.gmail.com with ESMTPSA id eu9sm2569338ejc.14.2021.11.04.07.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 07:57:38 -0700 (PDT)
Date:   Thu, 4 Nov 2021 15:57:35 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regmap: allow to define reg_update_bits for no bus
 configuration
Message-ID: <YYP03zJO7VVqHxmc@Ansuel-xps.localdomain>
References: <20211102214138.28873-1-ansuelsmth@gmail.com>
 <YYLAXL4HjgBGuF91@sirena.org.uk>
 <YYLnlbTFRUdLrmpW@Ansuel-xps.localdomain>
 <YYL/JwHxKsTmGT84@sirena.org.uk>
 <YYMEzTQhb8s31rzu@Ansuel-xps.localdomain>
 <YYPzN98RdHGEkK+n@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYPzN98RdHGEkK+n@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 02:50:31PM +0000, Mark Brown wrote:
> On Wed, Nov 03, 2021 at 10:53:17PM +0100, Ansuel Smith wrote:
> > On Wed, Nov 03, 2021 at 09:29:11PM +0000, Mark Brown wrote:
> 
> > > > > I don't understand this change.  The point of the check for volatile
> > > > > there is that if the register isn't volatile then we need to ensure that
> > > > > the cache gets updated with any change that happens so we need to go
> > > > > through paths that include cache updates.  The presence or otherwise of
> > > > > a bus does not seem at all relevant here.
> 
> > I think I'm missing something. The user case is a driver that
> > have CACHE DISABLED. The !map->bus check is added just to limit this to
> > a no bus configuration not to permit this with CACHE enabled. The limit
> > I was referring was in the init function where the update_bits is
> > assigned to the map. I honestly didn't notice that anything with cache
> > disabled was flagged as volatile.
> 
> In what way would the presence or absence of a bus be relevant to a
> decision about being able to safely use an _update_bits() operation?
>

No reason. It was just to make changes only to a no bus configuration
and doesn't cause any problem/error to other regmap configuration.
(since currently we can declare a custom update_bits function only for
bus configuration)

> > So the rest of the changes permit to declare a update_bits function
> > for a no bus configuration is good?
> 
> Probably, I'd need to look again.

Let me send a v2 so you can check the final patch.

-- 
	Ansuel
