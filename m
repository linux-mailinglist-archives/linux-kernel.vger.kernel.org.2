Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFCD43E309A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 22:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237744AbhHFVAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 17:00:04 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:34777 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbhHFVAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 17:00:03 -0400
Received: by mail-io1-f51.google.com with SMTP id i7so7748344iow.1;
        Fri, 06 Aug 2021 13:59:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Abd72sZNRU0BLu7YkKaiYFwOHr3rHD24N77jTkRPs6M=;
        b=S6eLliLe7ltUIrJKB7yXXjmFUuic5LYPK2j3Z5h8BAZduQjSCD5648dRh536Nc6xEL
         5ZT+swkMy3lOskddtC0cBCFZoyMeMcUyiqQyEfxRe5BEKGlyFWeW19WJlYgQLjCARKOm
         9t5jnvsL1JfYrwvsP9a10BCBgLIm39xC9G7eE5vk2ynKYJUXa/NaJiaNgKl6TR9W9Ws2
         VLkfF+l769zxE3IdJQa/VH3mtpWrwb8qEaaEWRM5f+lOi4o9hxl8kZiCzDlRAbZttO65
         6gV/7EAbB8mPY04oKNnMU56CVxWaDC/zsKlzgppseBVh4+whb+3XeZM5Uugfj0bIZny9
         b9Tg==
X-Gm-Message-State: AOAM531yCyURlXUSZbFDVOj+MVbZu9sSeH+9AXed9rkhBWs2DqhDENj3
        JdIYa6WGzAz790X40OHghA==
X-Google-Smtp-Source: ABdhPJzyr3XOBq5uPxRDKXpTJOdZ6Sg4iLb6fl58mEob9P0bnfHDB8LAbg+1E/tRB8RW8/BxSSQcUg==
X-Received: by 2002:a05:6602:14f:: with SMTP id v15mr136277iot.206.1628283586727;
        Fri, 06 Aug 2021 13:59:46 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id b23sm4530328iof.8.2021.08.06.13.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 13:59:45 -0700 (PDT)
Received: (nullmailer pid 1787406 invoked by uid 1000);
        Fri, 06 Aug 2021 20:59:44 -0000
Date:   Fri, 6 Aug 2021 14:59:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bert Vermeulen <bert@biot.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, John Crispin <john@phrozen.org>,
        Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH 3/5] ARM: dts: Add basic support for EcoNet EN7523
Message-ID: <YQ2iwIcSuDwcw/s5@robh.at.kernel.org>
References: <20210730134552.853350-1-bert@biot.com>
 <20210730134552.853350-4-bert@biot.com>
 <20210730144627.GB19569@C02TD0UTHF1T.local>
 <d0ff051b-280c-4021-f4ee-7bfda5e356d3@biot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0ff051b-280c-4021-f4ee-7bfda5e356d3@biot.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2021 at 06:41:55PM +0200, Bert Vermeulen wrote:
> On 7/30/21 4:46 PM, Mark Rutland wrote:
> > On Fri, Jul 30, 2021 at 03:45:50PM +0200, Bert Vermeulen wrote:
> > > +	timer {
> > > +		compatible = "arm,armv8-timer";
> > 
> > This should be "arm,armv7-timer".
> > 
> > > +		interrupt-parent = <&gic>;
> > > +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> > > +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> > > +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> > > +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> > 
> > GICv3 doesn't have a cpumask in its PPI description, so the
> > GIC_CPU_MASK_SIMPLE() bits should be removed.
> 
> Ok, will fix.
> 
> > > +		clock-frequency = <25000000>;
> > 
> > Please have your FW configure CNTFRQ on each CPU; the clock-frequency
> > property in the DT is a workaround for broken FW, and it's *vastly*
> > preferable for FW to configure this correctly (e.g. as it means VMs
> > should "just work").
> 
> I've since got hold of the modified U-Boot that runs on my eval board, and
> indeed it doesn't set CNTFRQ. So the kernel does need this, for the moment.

Can't you write CNTFRQ in the u-boot shell/script?

> I may get a chance to upstream support for this SoC in U-Boot, but I can't
> control what people are going to ship with their board. Is it ok to leave
> this in?

If they want a working upstream Linux, then you can control it.

I seem to recall this being rejected in other cases. That may have been 
on v8 which has taken stricter stances (but arguably any new v7 stuff 
should too).

Rob
