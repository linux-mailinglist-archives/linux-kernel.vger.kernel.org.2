Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A44639A2B7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 16:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbhFCOFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 10:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbhFCOFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 10:05:02 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01016C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 07:03:06 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id p13-20020a05600c358db029019f44afc845so3770044wmq.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 07:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HnXSvMcSi8D0z3yqSZsCKXksxVPvBQl+1ZcuaItTvjE=;
        b=MOvuI+hJvcZtHqunxi+C5MnW/X1VmWZ8HPDMQH4TM0VPcj1vgGQXvlLUEWWa6oIktC
         yMTZHswVUyfXRBPKJ1rDafjVCIRAyz2pE6ZmJu/YImJH5ZuxaY1aXOeIIFjcJAdR5Wit
         C3eaqLXolFSs+YB7fAQbucpjOctNqNnEXHE7A1UxrBGFSSf8Hx3/+Qb2RGdqHyZf2OP6
         mYJRICQqk54H6UucjFpnZzuSGDrZV/E7k9jiLnxo7qjtOftyFJ8NFH7GqiUQZOEcW5S6
         YDZlcgQ3F5MMAR2V1boKkr+08uafG5iLV7AnjicU05uOIAnqqzJi1Y8XlxcdKu96NkfP
         iUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HnXSvMcSi8D0z3yqSZsCKXksxVPvBQl+1ZcuaItTvjE=;
        b=ednuLRqWQkgbpyau7RQp8naTDpIIF6js8xsTC3/Q+iYr9sm1P/HyXkzFTxLNeA0ud8
         ett4hyySZP89eUdtLk1R5V3dcMnTQnZBhy0D43wg8hb5h/UPD0J0J6pIfthSn7og7K33
         vsXKh8SgHJFiVA/5juYezlhZFJ5TCAdvtv03ir4pLO0FFINeBku3LZkbFSkQLZQopVj4
         tlkGBsoUJAG+g0I7pUrvR17hUqtJ7YayQcGqWNS54D5OymZVFCZqFuKKO/XFiDR8Wv/m
         psSvrmA5wb/ejhbmQkBTeNeMtSf1i4Vp/i5w+cALEQAQSlgrJwdt9yuY2uxBhBFjj7le
         /AJQ==
X-Gm-Message-State: AOAM530nbAPyMl3aza0nMpbweNHVcLsOduu6Jsza2UACalTvdYK89YFJ
        YGnwfSnN73FKx9h8eFlD0p19xA==
X-Google-Smtp-Source: ABdhPJyxNgzbzfike0kJ2xLVP51DteK7WEqaxZwTZ6902ifvDnLGcnJ6fK2+MnHmjaUJqhs8SC9/MA==
X-Received: by 2002:a05:600c:4f4d:: with SMTP id m13mr13649706wmq.189.1622728984402;
        Thu, 03 Jun 2021 07:03:04 -0700 (PDT)
Received: from dell ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id 30sm3799856wrl.37.2021.06.03.07.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 07:03:03 -0700 (PDT)
Date:   Thu, 3 Jun 2021 15:03:01 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <thierry.reding@gmail.com>, arm@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Stefan Agner <stefan@agner.ch>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH 2/6] ARM: xen: Register with kernel restart handler
Message-ID: <20210603140301.GC2435141@dell>
References: <20191015145147.1106247-1-thierry.reding@gmail.com>
 <20191015145147.1106247-3-thierry.reding@gmail.com>
 <CAF2Aj3hbW7+pNp+_jnMVL8zeSxAvSbV1ZFZ_4PAUj6J0TxMk7g@mail.gmail.com>
 <20210603131124.GA1040254@roeck-us.net>
 <20210603133840.GB2435141@dell>
 <7a1cf301-ba99-1e01-c43e-53b53f4d3e04@oracle.com>
 <20210603135608.GU30436@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210603135608.GU30436@shell.armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Jun 2021, Russell King (Oracle) wrote:

> On Thu, Jun 03, 2021 at 09:48:59AM -0400, Boris Ostrovsky wrote:
> > On 6/3/21 9:38 AM, Lee Jones wrote:
> > > On Thu, 03 Jun 2021, Guenter Roeck wrote:
> > >
> > >> On Thu, Jun 03, 2021 at 01:43:36PM +0100, Lee Jones wrote:
> > >>> On Tue, 15 Oct 2019 at 15:52, Thierry Reding <thierry.reding@gmail.com>
> > >>> wrote:
> > >>>
> > >>>> From: Guenter Roeck <linux@roeck-us.net>
> > >>>>
> > >>>> Register with kernel restart handler instead of setting arm_pm_restart
> > >>>> directly.
> > >>>>
> > >>>> Select a high priority of 192 to ensure that default restart handlers
> > >>>> are replaced if Xen is running.
> > >>>>
> > >>>> Acked-by: Arnd Bergmann <arnd@arndb.de>
> > >>>> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > >>>> Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > >>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > >>>> Signed-off-by: Thierry Reding <treding@nvidia.com>
> > >>>> ---
> > >>>>  arch/arm/xen/enlighten.c | 12 ++++++++++--
> > >>>>  1 file changed, 10 insertions(+), 2 deletions(-)
> > >>>>
> > >>> This patch does appear to be useful.
> > >>>
> > >>> Is this just being solved in downstream trees at the moment?
> > >>>
> > >>> It would be nice if we could relinquish people of this burden and get it
> > >>> into Mainline finally.
> > >>>
> > >> There must have been half a dozen attempts to send this patch series
> > >> upstream. I have tried, and others have tried. Each attempt failed with
> > >> someone else objecting for non-technical reasons (such as "we need more
> > >> reviews") or no reaction at all, and maintainers just don't pick it up.
> > > Looking at the *-by tag list above, I think we have enough quality
> > > reviews to take this forward.
> > >
> > >> So, yes, this patch series can only be found in downstream trees,
> > >> and it seems pointless to submit it yet again.
> > > IMHO, it's unfair to burden multiple downstream trees with this purely
> > > due to poor or nervy maintainership.  Functionality as broadly useful
> > > as this should be merged and maintained in Mainline.
> > >
> > > OOI, who is blocking?  As I see it, we have 2 of the key maintainers
> > > in the *-by list.  With those on-board, it's difficult to envisage
> > > what the problem is.
> > 
> > 
> > Stefano (who is ARM Xen maintainer) left Citrix a while ago. He is at sstabellini@kernel.org (which I added to the CC line).
> 
> Stefano already reviewed this patch, which is part of a larger series
> that primarily touches 32-bit ARM code, but also touches 64-bit ARM
> code as well.
> 
> As I said in my previous reply, I don't see that there's any problem
> with getting these patches merged had the usual processes been
> followed - either ending up in the patch system, or the pull request
> being sent to me directly.
> 
> Sadly, the pull request was sent to the arm-soc people excluding me,
> I happened to notice it and requested to see the patches that were
> being asked to be pulled (since I probably couldn't find them)...
> and it then took two further weeks before the patches were posted,
> which I then missed amongst all the other email.
> 
> It's a process failure and unfortunate timing rather than anything
> malicious.

Understood.

Is there anything I can do to help this forward?

I can either collect and re-submit the patches to the MLs if that
makes people's lives any easier.  Or if one of the original submitters
wish to retain responsibility, I have no qualms with that either.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
