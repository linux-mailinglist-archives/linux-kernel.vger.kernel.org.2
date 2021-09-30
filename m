Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B1A41DB8C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 15:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351523AbhI3Nz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 09:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351484AbhI3Nzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 09:55:55 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDEFC06176C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 06:54:12 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id b20so25895520lfv.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 06:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kempniu.pl; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=IdLMxkgri7V5entmZJQNJDz8zpFwVw1y07FV58dcbto=;
        b=ERulCy/fsaITHIG0mWFm3/2gwLLrJI6tKL0vkkC4oD7KAbYsmkiy0BKmIqn/+pfmEJ
         7t3Iah/ieg/J1wCyPzsfIRtmy+TRgB+Ae6DTdkeEIR2hbDFumh9ZZirPQ8GHVfnK3Jr0
         xVnTofriDTprFctoGaE46m/G4WLc1C6m4M0UA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IdLMxkgri7V5entmZJQNJDz8zpFwVw1y07FV58dcbto=;
        b=BhJy8EK+TPqqHyHogbzUFJXOCx4ShLd5oiy2KBC+OO/2Qa6mI6M5s+Gxmeg4qUT4BR
         IWynsqvTQ02/fK4oaNYNPpDglWHUMdL+BpsIoGFkSU74jn7L0s2VSXygTmqWATSVaULk
         NtJAC7E5+YAvPL951iF37x3DmGF9BCBXzHJG1oboNWYAGyAfmtQt0B+FhHrGE3CkY769
         2SECAP8nFUPMJE9PSbxy/pVLO4zbCCznTMg510OJELESKVL8qBb9uTQAqYKBrJSwkQxu
         udGR0mtKFGDJ6mgM30AZq8xb6bfDckc8hC2GXzeFvKh+oo6McxhVz3PRLykedXlGxzx6
         5BUw==
X-Gm-Message-State: AOAM532tw9Z3kk4ra9VSz+Wnijq4lh3sdyQxi7lh1dlqOeM9AYfE4SeS
        cccXZs1/Sg1dQljWr6MtosHMeQ==
X-Google-Smtp-Source: ABdhPJyjxExAlth6xAb+iGCfadGoFBjFej58ch5RdBRbApgFFu8ZjE/BJ/DbtYOQYm+YD0Ca+M+Kaw==
X-Received: by 2002:a19:f249:: with SMTP id d9mr6080077lfk.229.1633010050307;
        Thu, 30 Sep 2021 06:54:10 -0700 (PDT)
Received: from larwa.hq.kempniu.pl ([2001:470:64df:111::e02])
        by smtp.gmail.com with ESMTPSA id 10sm346077ljp.12.2021.09.30.06.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 06:54:09 -0700 (PDT)
Date:   Thu, 30 Sep 2021 15:54:07 +0200
From:   =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH] mtd: add MEMREAD ioctl
Message-ID: <YVXBf0v0AQ5+G9dt@larwa.hq.kempniu.pl>
References: <20210920070221.10173-1-kernel@kempniu.pl>
 <20210928155859.433844cb@xps13>
 <20210928162402.6bb64fcf@collabora.com>
 <20210928163519.08cd1138@xps13>
 <YVTBoAnQKYLNpOPc@larwa.hq.kempniu.pl>
 <20210930085133.13b5a228@collabora.com>
 <20210930104721.03dc45bb@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210930104721.03dc45bb@xps13>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > > I remember discussing search a new READ ioctl with Sascha Hauer a few
> > > > > years back, but I can't find the discussion...    
> > > 
> > > I think this is the thread in question:
> > > 
> > >     https://www.infradead.org/pipermail/linux-mtd/2016-April/thread.html#67085
> > > 
> > > In fact, it looks like Boris beat me to preparing a draft patch adding a
> > > MEMREAD ioctl by some five years:
> > > 
> > >     https://www.infradead.org/pipermail/linux-mtd/2016-April/067187.html  
> > 
> > Exactly the one I was referring to. Note that this patch still contains
> > the unbounded malloc which I think is worth fixing, but other than
> > that and the addition of ECC stats, it looks pretty similar to yours.

Right, thanks.

> > > I guess the big question from my perspective is: should I revive Boris'
> > > original effort on the MEMREAD ioctl (which returns more detailed
> > > bitflip stats in the structure passed by user space) or would that be a
> > > waste of time because the subsystem will be switched over wholesale to a
> > > new way of doing I/O (mtd_io_op) in the foreseeable future and therefore
> > > exposing yet another ioctl to user space today would be frowned upon?
> > >   
> > 
> > That's not my call to make, but I think those 2 things are orthogonal
> > and can be addressed separately.
> 
> Agreed.

Thank you both - it sounds like I should start working on a v2 that will
make the new MEMREAD ioctl return more detailed ECC statistics to user
space.

Boris, I think a Suggested-by tag crediting you is in order for both the
unbounded malloc issue and the MEMREAD ioctl, but submitting-patches.rst
says I should not add this tag without your permission.  So, are you
okay with me adding it?

Miquel, as for the unbounded malloc issue, should I address this in a
separate (preliminary) patch or rather submit a two-patch v2 series
(unbounded malloc fix + new MEMREAD ioctl)?

-- 
Best regards,
Michał Kępień
