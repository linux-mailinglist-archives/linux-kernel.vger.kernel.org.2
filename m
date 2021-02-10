Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C003167F9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 14:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbhBJN0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 08:26:19 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:36145 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhBJN0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 08:26:04 -0500
Received: by mail-wr1-f47.google.com with SMTP id u14so2558110wri.3;
        Wed, 10 Feb 2021 05:25:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qbkae6XY7nF+JRYKySs6fWFYR01dWCp9hvuftwHNY5Q=;
        b=cvDmmuPRiqVga9SU5Iyh0Bt76l43MvISi/t42nUzlUfnW3T87Bouq/LmEv7YsZMncx
         seWDlifTkLOPxcQJYQ0ldWORPHVeh8/eiWZpdVeH9w2j3yZDpb13bnp90alCyLTd0H/x
         oIQ8ERHkvwEfO7UF1wuMrV9/Mdqz10+TqehHNDcG9rapEXgg0X321cERMZdC9k5DQ0t3
         CuLgGFtcKkqppHNFCTOnmzhwnWBqGAvAonIyVd8UnVftCbhACtMrFEuqcsCWE6OTlpNj
         G1g9c1z76J8vKc5i8p+1oOd8QNUM/7Ay0Wt7Vv3VHklej214XRjWO0aE+oednxCvAvea
         2/lA==
X-Gm-Message-State: AOAM532MWgVDfuNo0vWGmfsBW7oAmeDPzba/4589+EisHUuZm4A9p6pE
        sQKgSolsCJXul1yxuFkc3LE=
X-Google-Smtp-Source: ABdhPJw2XE1pIwLVQEAfJrFRyhQJBLSdyhHkZA/kqetUF5a5F5YWWHUVOfaPXlPHyoH3cIrs6pZRVA==
X-Received: by 2002:adf:80c8:: with SMTP id 66mr3729053wrl.344.1612963521202;
        Wed, 10 Feb 2021 05:25:21 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id f14sm2363823wmj.30.2021.02.10.05.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 05:25:19 -0800 (PST)
Date:   Wed, 10 Feb 2021 14:25:18 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Hector Martin <marcan@marcan.st>, Arnd Bergmann <arnd@kernel.org>,
        devicetree@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        linux-kernel@vger.kernel.org, soc@kernel.org, robh+dt@kernel.org,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 18/18] arm64: apple: Add initial Mac Mini 2020 (M1)
 devicetree
Message-ID: <20210210132518.de7eyzrb5p5xycox@kozik-lap>
References: <20210204203951.52105-1-marcan@marcan.st>
 <20210204203951.52105-19-marcan@marcan.st>
 <20210208110441.25qc6yken4effd6c@kozik-lap>
 <cd67b2ce-9676-31b4-85f7-de1ec9b2bf72@marcan.st>
 <YCOzLSqdsr83xf0b@atomide.com>
 <4481998a-27f6-951e-bb4f-a9d2b95f211f@marcan.st>
 <YCPE2lPpBlhCi7TH@atomide.com>
 <20210210125548.sdeadc4ncoxu3ikj@kozik-lap>
 <YCPdclQykSPx96hk@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YCPdclQykSPx96hk@atomide.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 03:19:46PM +0200, Tony Lindgren wrote:
> * Krzysztof Kozlowski <krzk@kernel.org> [210210 12:56]:
> > On Wed, Feb 10, 2021 at 01:34:50PM +0200, Tony Lindgren wrote:
> > > * Hector Martin <marcan@marcan.st> [210210 11:14]:
> > > > On 10/02/2021 19.19, Tony Lindgren wrote:
> > > > > * Hector Martin 'marcan' <marcan@marcan.st> [210208 12:05]:
> > > > > > On 08/02/2021 20.04, Krzysztof Kozlowski wrote:
> > > > > ...
> > > > > 
> > > > > > > > +	clk24: clk24 {
> > > > > > > 
> > > > > > > Just "clock". Node names should be generic.
> > > > > > 
> > > > > > Really? Almost every other device device tree uses unique clock node names.
> > > > > 
> > > > > Yeah please just use generic node name "clock". FYI, we're still hurting
> > > > > because of this for the TI clock node names years after because the drivers
> > > > > got a chance to rely on the clock node name..
> > > > > 
> > > > > Using "clock" means your clock driver code won't get a chance to wrongly
> > > > > use the node name and you avoid similar issues.
> > > > 
> > > > That means it'll end up like this (so that we can have more than one
> > > > fixed-clock):
> > > > 
> > > > clocks {
> > > >     #address-cells = <1>;
> > > >     #size-cells = <0>;
> > > > 
> > > >     clk123: clock@0 {
> > > >         ...
> > > >         reg = <0>
> > > >     }
> > > > 
> > > >     clk456: clock@1 {
> > > >         ...
> > > >         reg = <1>
> > > >     }
> > > > }
> > > > 
> > > > Correct?
> > > 
> > > Yeah, just don't use an imaginary dummy index for the reg. Use a real
> > > register offset from a clock controller instance base, and a register
> > > bit offset too if needed.
> > 
> > No, there is no need for fake "clocks" node with fake addresses. If you
> > have multiple clocks, the rules are the same as for other similar cases,
> > e.g. leds:
> > 
> > {
> >     clock-0 {
> >        ...
> >     };
> > 
> >     clock-1 {
> >         ..
> >     };
> > 
> >     soc@0 {
> >     };
> > }
> > 
> > This should not generate any dtc W=1 warnings and work with dtschema
> > (you need to check for both).
> 
> OK yeah so no need for the node name there after the "clock-" :)
> Sounds good to me.

You also could add a suffix or prefix ("fixed-clock-0", "clock-ext").
There is no strict requirement and Rob admitted that as-is was good
enough.

From my point of view, the dt spec mentions "clock" as one of preferred
names, so I would stick to it.

Anyway, it's not that important. :)

Best regards,
Krzysztof

