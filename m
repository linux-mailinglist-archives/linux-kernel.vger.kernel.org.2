Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B3E316752
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 13:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhBJM71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 07:59:27 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:37691 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbhBJM4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 07:56:33 -0500
Received: by mail-wm1-f44.google.com with SMTP id m1so1766294wml.2;
        Wed, 10 Feb 2021 04:56:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=klyvuCb2s80xxmYVdUoIwTBI4ZLcJg7EZBGPH+l10fY=;
        b=auU+VBRerIgXeBh0ER8IiXAVrUy335iZjMe8VdtnYnlqVpSsaWw3aSDN8LiFULtZWz
         rDD5Pv1GIKgZFPtMp+uhw0OkbABy9kNoSKNcrHlwU/xM56W/56gLkA1bfMkh1icEd4jA
         cdhVezh+Y9VTku9oJhss61NtMXFJ6hhoMZ10ZQ08YKiNjxStqBE/ztEbk16SWGhNXR+Y
         kM/vTpKuivDQe7luv0DeOCesEewUpsK+u+HZAGETz1DMIPAfFvNZ7ggrVMj/y2E9Tjwq
         +GBc7PjKmaOaChUBHOHTBwvDl3YQlilFKVkl6xuZgUhQRXT/QHvSJGoLZrAmcryZXSGa
         sUvQ==
X-Gm-Message-State: AOAM531gsE55ReQgMWG/6RypfSdjjn4mi7w3w29N+wm3RptDFhHeDsSR
        eMCwt7HHeo27EGCDb08lZ0QNBVLbN2M=
X-Google-Smtp-Source: ABdhPJxEJMv2xTHkhA5hRM6aKJJZhYfdlEBUHOKcxJzOPO3sXDi3h9DHp9MZv//bMkX9mQOgPEc9bA==
X-Received: by 2002:a1c:3b8a:: with SMTP id i132mr2869183wma.26.1612961750425;
        Wed, 10 Feb 2021 04:55:50 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id 64sm3601054wrc.50.2021.02.10.04.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 04:55:49 -0800 (PST)
Date:   Wed, 10 Feb 2021 13:55:48 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Hector Martin <marcan@marcan.st>, Arnd Bergmann <arnd@kernel.org>,
        devicetree@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        linux-kernel@vger.kernel.org, soc@kernel.org, robh+dt@kernel.org,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 18/18] arm64: apple: Add initial Mac Mini 2020 (M1)
 devicetree
Message-ID: <20210210125548.sdeadc4ncoxu3ikj@kozik-lap>
References: <20210204203951.52105-1-marcan@marcan.st>
 <20210204203951.52105-19-marcan@marcan.st>
 <20210208110441.25qc6yken4effd6c@kozik-lap>
 <cd67b2ce-9676-31b4-85f7-de1ec9b2bf72@marcan.st>
 <YCOzLSqdsr83xf0b@atomide.com>
 <4481998a-27f6-951e-bb4f-a9d2b95f211f@marcan.st>
 <YCPE2lPpBlhCi7TH@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YCPE2lPpBlhCi7TH@atomide.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 01:34:50PM +0200, Tony Lindgren wrote:
> * Hector Martin <marcan@marcan.st> [210210 11:14]:
> > On 10/02/2021 19.19, Tony Lindgren wrote:
> > > * Hector Martin 'marcan' <marcan@marcan.st> [210208 12:05]:
> > > > On 08/02/2021 20.04, Krzysztof Kozlowski wrote:
> > > ...
> > > 
> > > > > > +	clk24: clk24 {
> > > > > 
> > > > > Just "clock". Node names should be generic.
> > > > 
> > > > Really? Almost every other device device tree uses unique clock node names.
> > > 
> > > Yeah please just use generic node name "clock". FYI, we're still hurting
> > > because of this for the TI clock node names years after because the drivers
> > > got a chance to rely on the clock node name..
> > > 
> > > Using "clock" means your clock driver code won't get a chance to wrongly
> > > use the node name and you avoid similar issues.
> > 
> > That means it'll end up like this (so that we can have more than one
> > fixed-clock):
> > 
> > clocks {
> >     #address-cells = <1>;
> >     #size-cells = <0>;
> > 
> >     clk123: clock@0 {
> >         ...
> >         reg = <0>
> >     }
> > 
> >     clk456: clock@1 {
> >         ...
> >         reg = <1>
> >     }
> > }
> > 
> > Correct?
> 
> Yeah, just don't use an imaginary dummy index for the reg. Use a real
> register offset from a clock controller instance base, and a register
> bit offset too if needed.

No, there is no need for fake "clocks" node with fake addresses. If you
have multiple clocks, the rules are the same as for other similar cases,
e.g. leds:

{
    clock-0 {
       ...
    };

    clock-1 {
        ..
    };

    soc@0 {
    };
}

This should not generate any dtc W=1 warnings and work with dtschema
(you need to check for both).

Best regards,
Krzysztof

