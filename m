Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA3442CCF6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 23:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhJMVnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 17:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJMVnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 17:43:11 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C58C061749
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 14:41:07 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id lk8-20020a17090b33c800b001a0a284fcc2so5443672pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 14:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WLc6IrRUzN1NvABbj03b/K9mQI1mZYYIfJGl67UGN1E=;
        b=jDN/84phO6U6OaSVcThD15QLRd2ZqbAZo/8MbgCsAWe0rbQalRTW6L7kXvj6dKFnDc
         Y8Z5L1EwDO/zlr8NNf6AXf/6y27lmdnHqn83Kg9p9yWsNj9NmvEFGJpiAZhd60h7stRo
         G0dcmsDAPKzxg9a4reONasgPPFLjKSOdjl9tmetSamocgxCfsRzWe+vrv4nZlNd5GQmc
         Um+3J/v85kAxFLVoQOuRDv8vnaxFgPGbhlbSXwg4Jj9Ltdcr0LVqNlNSkhfcvyoY1btE
         IcnH0RBxKrQn37/gJEwgQbgXtt3BIJvri4wcPXfPvT2ZcyO/HSAgYZMrOSm6lNoONadY
         dX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WLc6IrRUzN1NvABbj03b/K9mQI1mZYYIfJGl67UGN1E=;
        b=EmYsmggMd1mBaCph+skEOyGEVIAj4kHOd/9xiBthXahywoP0SjnXnGQbvoljgkGyJa
         2O5OlESNnNGomvWRGRwTDjqZeVpYJB4fFY4hqOQ0TnWFtrnV0pki/jLsqBKwt8HKk+1/
         Nn5WIPb5lSPbOT3/ktaOLRyoNs9L3TGyS92RIYUHEuhWpeC/zOzcLMcqUUAf33lw3U9g
         jjWfEe+nnm9a/jeDpxk/Z99svHBh45V7b8llc1mrwttZt7VJ/nyJgPaQMlTIAmB4/E7n
         ncg69T5EvYJOogXdb4P7I+84P3B/fmIrwQ2FWlygs39yinY85+6GGeEzCs7reMHSxJf5
         b+eA==
X-Gm-Message-State: AOAM530eSYpRb1poARMH5f8C/p1JX2q9wa33VX8IHELl1SIpuBU6or9c
        dMA3WsPQX94JUS6P29cLmPH5fg==
X-Google-Smtp-Source: ABdhPJy9LDPdllIYUeK920uW66OjzrCDW6L9SnC73V58zpH3rwB2+vHPLI64AB5nRJs+sl8PMx6vTg==
X-Received: by 2002:a17:903:11c9:b0:13b:9a01:aa27 with SMTP id q9-20020a17090311c900b0013b9a01aa27mr1466854plh.46.1634161267013;
        Wed, 13 Oct 2021 14:41:07 -0700 (PDT)
Received: from x1 ([2601:1c2:1080:1950:bd36:67b6:1d6:68ff])
        by smtp.gmail.com with ESMTPSA id n21sm398999pfv.115.2021.10.13.14.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 14:41:06 -0700 (PDT)
Date:   Wed, 13 Oct 2021 14:41:03 -0700
From:   Drew Fustini <dfustini@baylibre.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Benoit Cousson <bcousson@baylibre.com>,
        Dave Gerlach <d-gerlach@ti.com>, Keerthy <j-keerthy@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: am335x: Add rtc node as system-power-controller
Message-ID: <20211013214103.GA10628@x1>
References: <20211012191311.879838-1-dfustini@baylibre.com>
 <YWaJfofs8QAtBnVu@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWaJfofs8QAtBnVu@hovoldconsulting.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 09:23:42AM +0200, Johan Hovold wrote:
> On Tue, Oct 12, 2021 at 12:13:12PM -0700, Drew Fustini wrote:
> > From: Keerthy <j-keerthy@ti.com>
> > 
> > PMIC_PWR_EN pin of RTC on am335x-evm, bone, and boneblack is connected to
> > PMIC on board, so flag rtc node as system-power-controller to allow
> > software to poweroff boards.
> 
> The "system-power-controller" property is already set in
> bone-common.dtsi since
> 
> 	2876cc4a773c ("ARM: dts: Move most of am335x-boneblack.dts to am335x-boneblack-common.dtsi")
> 
> so this probably only affects am335x-evm and that should be reflected in
> the commit message.
> 
> Also, should you now remove the property from boneblack-common? Or just
> add it to am335x-evm instead?

Thank you for reviewing. Yes, I should improve the commit message as the
BeagleBone Black is already covered for the rtc system-power-controller
in am335x-boneblack-common.dtsi.  

I believe it would be ok to remove system-power-controller from 
am335x-boneblack-common.dtsi and have it in am335x-bone-common.dtsi.

These are the files that include am335x-boneblack-common.dtsi:
arch/arm/boot/dts/am335x-boneblack-wireless.dts
arch/arm/boot/dts/am335x-boneblack.dts
arch/arm/boot/dts/am335x-sancloud-bbe-lite.dts
arch/arm/boot/dts/am335x-sancloud-bbe.dts

But they all also include am335x-bone-common.dtsi.

However, I just noticed that am335x-evm.dts does not include either
am335x-boneblack-common.dtsi or am335x-boneblack-common.dtsi. Thus
rtc system-power-controller should be directly inserted into
am335x-evm.dts.

I considered just moving system-power-controller to the rtc node in
am33xx-l4.dtsi but I don't think that would be correct as this would not
be valid for all am33xx devices.

Does that seem correct to you?

Thank you,
Drew
