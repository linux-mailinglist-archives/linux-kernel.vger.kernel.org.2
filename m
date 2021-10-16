Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56EDC4304E0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 22:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244552AbhJPUOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 16:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbhJPUOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 16:14:00 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22936C061765;
        Sat, 16 Oct 2021 13:11:52 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id y12so54330621eda.4;
        Sat, 16 Oct 2021 13:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=diHmcCG07tOewGHnFIu68qwDszuCtQ+0f3a8ZrskUEw=;
        b=f8xzPb0d4Mk+ufC5y9Rb4MdKPL6q3lWciHPVky/sx2SeaaS3hnYtOL3EIcWP5IcmaJ
         6ynl6Dfiz6rpWAoPurBtZoIPsGfAzmsHxlvcgai95kAfnOFmCcr5M6XBc+/PWa9KhT/j
         WIyVq1e50MAB6ROSWNAiRWsliF++35uDDpeA4VaZXWCECyWYwvGCkZgV/fNW+2Vj9nuG
         sPXKpCC+2bK9XhkzVQg5H4fUkFRHvEP9RmeZiNcy51SikDKuiDkS8ttK3hqpg01YH2Ox
         sW2HYfPFVcXDHaaymlzC6qNxxVaTOvv1dddJi6X08OGV0dmWympgCqpkAYdL17mhwMdb
         eJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=diHmcCG07tOewGHnFIu68qwDszuCtQ+0f3a8ZrskUEw=;
        b=yNKB3CaS4kHhYNHeibfjHNHCuvIVJT39HTFC6Bn5htJPqvVhiAMnjV8fYex2EPmetv
         4vltKr9zP2ycWVOZpfj8nK84v+T03FHntecbJHDnG54LG0ogwh4cGtiLX0rM2Igi4Xpt
         i0uYDPNds6gHj8RRs7quaq7HTWRyKZFQcpuraK9aFJznNJeV8At4jKtbriBdNYly+oQ5
         4rK5gX8GtPvCDvYPEFIy4TkkxqzrHvNe2p9WDoz8v8hLkWox4zu2VJiWg3RSH0m19u4F
         s3g74RDio8Zopdf/kChAsCRUNSuZIWMa+SeCqHa9FmsZ+4HzBzgetofCAAh9YkkCgXwc
         pyfQ==
X-Gm-Message-State: AOAM5329HCzp3Zh35gooUIY9mg1rgybTfzRX70FObwizuV5H6W9SE3CM
        rft7nyW6AG9J0Z8qvOl08HGFaTRRXOqbzhljvpo=
X-Google-Smtp-Source: ABdhPJxNHuxrzCAC70slKiY+5vu297Kl9jKDVafpvtqgGN9gqrRhXXNcv1npylYpd0oQIc8YgUQcBfv7QcaMXsLxBs8=
X-Received: by 2002:a05:6402:cb2:: with SMTP id cn18mr26752546edb.249.1634415110466;
 Sat, 16 Oct 2021 13:11:50 -0700 (PDT)
MIME-Version: 1.0
References: <20201118230414.121316-1-aford173@gmail.com> <20201130220249.GA3109751@robh.at.kernel.org>
 <CAHCN7x+om4W5jqnuAW4-nMkZLc5nrYu7NUsbM36r0wyFSYa4-g@mail.gmail.com>
In-Reply-To: <CAHCN7x+om4W5jqnuAW4-nMkZLc5nrYu7NUsbM36r0wyFSYa4-g@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Sat, 16 Oct 2021 15:11:39 -0500
Message-ID: <CAHCN7xKEkpq07AfMbpPfEcz0x=XvVjST==8gYRyrbW+Cjs3ONg@mail.gmail.com>
Subject: Re: [PATCH V5] dt-bindings: soc: imx: Add binding doc for spba bus
To:     Rob Herring <robh@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Adam Ford-BE <aford@beaconembedded.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 1, 2021 at 4:19 PM Adam Ford <aford173@gmail.com> wrote:
>
> On Mon, Nov 30, 2020 at 4:02 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Wed, 18 Nov 2020 17:04:14 -0600, Adam Ford wrote:
> > > Add binding doc for fsl,spba-bus.
> > >
> > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > > ---
> > > make dt_binding_check -j8 |grep spba
> > >   DTEX    Documentation/devicetree/bindings/bus/fsl,spba-bus.example.dts
> > >   DTC     Documentation/devicetree/bindings/bus/fsl,spba-bus.example.dt.yaml
> > >   CHECK   Documentation/devicetree/bindings/bus/fsl,spba-bus.example.dt.yaml
> > >
> > > V5:  Rebase on 5.10-rc2 to be able to check yaml
> > >      Add Reg entry
> > >
> > > V4:  Remove an accidental makefile change
> > >      Move type:object under additional properties
> > >
> > > V3:  Rebase sample from aips-bus example
> > >      Split off from series adding i.MX8M Nano functions to reduce noise
> > >
> > > V2:  Attempted to update yaml from feedback
> > >
> >
> > Applied, thanks!
>
> Rob,
>
> I am not seeing this anywhere.  Can you tell me where this was
> applied?  It's not appearing in Linux-next

Rob,

Patchwork shows this has been accepted [1], however I don't see that
it's still applied.


[1] https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20201118230414.121316-1-aford173@gmail.com/

Can you apply it?  It looks like building the device tree is throwing
messages because this is missing.

adam
>
> adam
