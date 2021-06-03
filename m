Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D19B39A1E8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 15:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhFCNN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 09:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbhFCNN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 09:13:26 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F2DC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 06:11:28 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id i68so2236611qke.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 06:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HJZ7A14zlAZU2aqQm9r0tLKTQX8EXuekENg8fiKt0KY=;
        b=gkyyJp2kGe5pONFFg8zTpcd7F4+7Ud35yEbAd1dSKdb+78U4uPOpU4OXzj4etj3x3Z
         pQfSvZZnPgNZgYgT3xX49Wp3QwRQiJU4puIJvuhOsD16vS5CnDON5SbVE8LOnl2uszj2
         44Qpqz3EnmKoqRc5tBOC3iu0D8B6vOC3DL09CD848X9DibFkYLeTrQqqJTqPs6+80HF0
         VJ/EzrNmF/vmzjXJRGODpI4bfpfbu3C1/xwwjGUpAu/5P3tf06GW1Qoc/zjMbzTLCKxs
         X2FklaxDu2jvoX7/H/4O5BcoJ24/ky9j2cQIFZ1wXxcCJ/Gcv+bNvj8SGFHLGFk3yknv
         E44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=HJZ7A14zlAZU2aqQm9r0tLKTQX8EXuekENg8fiKt0KY=;
        b=kyh4P2IcsCx4cOgW/zi03ZhW4w289kNdYM1iwMospcqoFnSYy5Mc7M+rBxWAYvXUze
         9r6g9YLwmWib01uLhx2tItGORBnimU+t74kwHlpBjeTMKgFiK98Xe00845hmUhZEr2Ai
         Q84eBBpMYitV4YiFNmdtiDgaf+4j05kVgf5UqZJdxWoJn5J/NCjdTHExIwHgZJsRFJvH
         e6KfYYKDGVG/SaOQIGYqexZ71qTv6QTEcgO9+r+4+s4yVYmG6eg5uzVSQcPhpbHlCw8D
         qRU23XCeFmv07R0P6FpIET/YH0nHkkKZvdw2D3vPX6RdRFxgustanMhmyomDf8IuIx17
         oBHQ==
X-Gm-Message-State: AOAM5323NIdYcNjgRBnCtnBf5ZZTlPrjz9mU6jo2B3c/7cKl+/XkfKFZ
        ej6ovD3yhFCPzLJVzhyiGI0=
X-Google-Smtp-Source: ABdhPJyyGsIdSqIWzy2TXX98F3bbhKVz9tTsZ9ycIIa+Ga9wud2CFKb+1ikA7/CAj1NZwPZcwExZXQ==
X-Received: by 2002:a37:6581:: with SMTP id z123mr32033772qkb.47.1622725887355;
        Thu, 03 Jun 2021 06:11:27 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h4sm1713093qti.0.2021.06.03.06.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 06:11:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 3 Jun 2021 06:11:24 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Russell King <linux@armlinux.org.uk>, arm@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Stefan Agner <stefan@agner.ch>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] ARM: xen: Register with kernel restart handler
Message-ID: <20210603131124.GA1040254@roeck-us.net>
References: <20191015145147.1106247-1-thierry.reding@gmail.com>
 <20191015145147.1106247-3-thierry.reding@gmail.com>
 <CAF2Aj3hbW7+pNp+_jnMVL8zeSxAvSbV1ZFZ_4PAUj6J0TxMk7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF2Aj3hbW7+pNp+_jnMVL8zeSxAvSbV1ZFZ_4PAUj6J0TxMk7g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 01:43:36PM +0100, Lee Jones wrote:
> On Tue, 15 Oct 2019 at 15:52, Thierry Reding <thierry.reding@gmail.com>
> wrote:
> 
> > From: Guenter Roeck <linux@roeck-us.net>
> >
> > Register with kernel restart handler instead of setting arm_pm_restart
> > directly.
> >
> > Select a high priority of 192 to ensure that default restart handlers
> > are replaced if Xen is running.
> >
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  arch/arm/xen/enlighten.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> 
> This patch does appear to be useful.
> 
> Is this just being solved in downstream trees at the moment?
> 
> It would be nice if we could relinquish people of this burden and get it
> into Mainline finally.
> 

There must have been half a dozen attempts to send this patch series
upstream. I have tried, and others have tried. Each attempt failed with
someone else objecting for non-technical reasons (such as "we need more
reviews") or no reaction at all, and maintainers just don't pick it up.

So, yes, this patch series can only be found in downstream trees,
and it seems pointless to submit it yet again.

Guenter
