Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9F9396EBE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 10:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbhFAIV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 04:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233431AbhFAIVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 04:21:19 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA2FC061756
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 01:19:37 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id q5so13283797wrs.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 01:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=KukDru8x9QpmY3cmltufnJ8Ttohzvm/qv7QdMVbte6Q=;
        b=vWeB5vM7l9vQeqWDCKYiIIf6rdKeCS6rOqxAXs5SkMsl0zAQz2MreKsTuutru/3KHS
         N1rcbpd/MbStA2AoeesYEmPdzGkiTCGDYi/nDwtr20SLW6k/u+oA3n1nHf01dCkhj7PZ
         m4DafUjHVAs8x9mThNr6lYhqzZOb/vbRG1C5dS+aheSb2hxaEfZPI1Dnre5AvV+o7kai
         S9AjWb34gmTK7ksUnM540qp51IG0ALLZVF8WglKka5lDjz1nibnhwC6nWsU6k8f6nHkf
         dfgq2w8i4Vadgo8Q0i8N+ORUGoYsfD+53/LD2JKkQ+q+WBN0vkAqEByoqGwJRoma/S2R
         gA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KukDru8x9QpmY3cmltufnJ8Ttohzvm/qv7QdMVbte6Q=;
        b=OsH7HXoAEorp3Beh240Hzxl6icuJmYIXEsAk8tT4/+ucwGw7s4DVGOuhw87BklZo2t
         s9ei8NRrMpcpvFuM7sUTKQklvRf8ieDVJ6Cep03zCsI9UmhH4jFBD/7BM0fxzRHX4Fnm
         SNNzH/HCz54iz6DXG5ySI/OeCAGmjR5Ge0DcByvw+7voNbI/VmBgVTA2s3EfDEN+ZYRX
         Ei424t1rFDKQTAmMajzNX+Hl6PyebWKU2riUPmGYfDLNT858JYLI+PXWqb038CGvlFRZ
         WQb0Hg6Cy7/Hdzc4gkrhy6X9dJZf5hOf6ZTvaby7V0rOTlbmHBpD9dsjcd/ThiTax+zf
         qbbA==
X-Gm-Message-State: AOAM531cFVaAN4wN3lMpNJyEanJCmoKhrpuoMCD10vPJSRidSv+XZzcf
        0r5UQ8womov8SjLNfygPsFqDCw==
X-Google-Smtp-Source: ABdhPJzIworTj34S1WsMzhTicK84t6ne3uMrwkffGkcGsO94WMOa27KFQn7os5+/Ub6oYkfJI2b+AQ==
X-Received: by 2002:adf:f14d:: with SMTP id y13mr26368165wro.261.1622535575803;
        Tue, 01 Jun 2021 01:19:35 -0700 (PDT)
Received: from dell ([91.110.221.249])
        by smtp.gmail.com with ESMTPSA id t4sm612108wru.53.2021.06.01.01.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 01:19:35 -0700 (PDT)
Date:   Tue, 1 Jun 2021 09:19:33 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        bgolaszewski@baylibre.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luka Perkov <luka.perkov@sartura.hr>, jmp@epiphyte.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Donald Buczek <buczek@molgen.mpg.de>
Subject: Re: [PATCH v2 3/4] dt-bindings: mfd: Add Delta TN48M CPLD drivers
 bindings
Message-ID: <20210601081933.GU543307@dell>
References: <20210524120539.3267145-1-robert.marko@sartura.hr>
 <20210524120539.3267145-3-robert.marko@sartura.hr>
 <20210524230940.GA1350504@robh.at.kernel.org>
 <20210525074649.GC4005783@dell>
 <CA+HBbNFxCKbitVctbUisuZXJWxaZp0cswNNNTgD0UxQZ1smJbg@mail.gmail.com>
 <20210526075255.GG4005783@dell>
 <CA+HBbNGSH9AvRo0Hwa5pWea94u0LwJt=Kj7gWjSAV9fS5VFr0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+HBbNGSH9AvRo0Hwa5pWea94u0LwJt=Kj7gWjSAV9fS5VFr0A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 May 2021, Robert Marko wrote:

> On Wed, May 26, 2021 at 9:52 AM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Tue, 25 May 2021, Robert Marko wrote:
> >
> > > On Tue, May 25, 2021 at 9:46 AM Lee Jones <lee.jones@linaro.org> wrote:
> > > >
> > > > On Mon, 24 May 2021, Rob Herring wrote:
> > > >
> > > > > On Mon, May 24, 2021 at 02:05:38PM +0200, Robert Marko wrote:
> > > > > > Add binding documents for the Delta TN48M CPLD drivers.
> > > > > >
> > > > > > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > > > > > ---
> > > > > > Changes in v2:
> > > > > > * Implement MFD as a simple I2C MFD
> > > > > > * Add GPIO bindings as separate
> > > > >
> > > > > I don't understand why this changed. This doesn't look like an MFD to
> > > > > me. Make your binding complete if there are missing functions.
> > > > > Otherwise, stick with what I already ok'ed.
> > > >
> > > > Right.  What else, besides GPIO, does this do?
> > >
> > > It currently does not do anything else as hwmon driver was essentially
> > > NACK-ed for not exposing standard attributes.
> >
> > Once this provides more than GPIO capabilities i.e. becomes a proper
> > Multi-Function Device, then it can use the MFD framework.  Until then,
> > it's a GPIO device I'm afraid.
> >
> > Are you going to re-author the HWMON driver to conform?
> hwmon cannot be reathored as it has no standard hwmon attributes.
> 
> >
> > > The CPLD itself has PSU status-related information, bootstrap related
> > > information,
> > > various resets for the CPU-s, OOB ethernet PHY, information on the exact board
> > > model it's running etc.
> > >
> > > PSU and model-related info stuff is gonna be exposed via a misc driver
> > > in debugfs as
> > > we have user-space SW depending on that.
> > > I thought we agreed on that as v1 MFD driver was exposing those directly and
> > > not doing anything else.
> >
> > Yes, we agreed that creating an MFD driver just to expose chip
> > attributes was not an acceptable solution.
> >
> > > So I moved to use the simple I2C MFD driver, this is all modeled on the sl28cpld
> > > which currently uses the same driver and then GPIO regmap as I do.
> > >
> > > Other stuff like the resets is probably gonna get exposed later when
> > > it's required
> > > to control it directly.
> >
> > In order for this driver to tick the MFD box, it's going to need more
> > than one function.
> 
> Understood, would a debug driver count or I can expose the resets via
> a reset driver
> as we have a future use for them?

CPLDs and FPGAs are funny ones and are often difficult to support in
Linux.  Especially if they can change their behaviour.

It's hard to make a solid suggestion as to how your device is handled
without knowing the intricacies of the device.

Why do you require one single Regmap anyway?  Are they register banks
not neatly separated on a per-function basis?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
