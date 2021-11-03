Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBD24443B6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 15:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbhKCOjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 10:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbhKCOjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 10:39:49 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A99EC061714;
        Wed,  3 Nov 2021 07:37:13 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id j21so9956323edt.11;
        Wed, 03 Nov 2021 07:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4l9+CNH1zvFA6GeAoxIinWOckYEE5i0Zd3a0AVw5MI8=;
        b=ZCKWEyY2KrwG6BEz8j5F8WnqD/9xzHqezwSEXXf68Cfx9nCBfuLa+KvR4gDbN60sVb
         WIHqxhEEgXCoSq6YvKVbjGZ+1OX9migWdTIpyMhh3a6qtX5qpS5qkDg64ntgvSmUnWmq
         oSKfG/XgsqJKBeXJFEJVAVml7yCVlgV1//+pGWLHAHVs2ndd18YgEyk2osMbVe+4rRiD
         nB+3efcMixAJ4jGkpQl8e1f37hr33XbzUUqwxl0yawNj7/SZHYrM6dIwtRVQwp3n6Iw+
         2m+zeH2WkWudaASE7jcSPmjLYfOy0/AuEpGcqz1tWRtxVh8594nxf5u+ojHwCYc38azO
         yqig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4l9+CNH1zvFA6GeAoxIinWOckYEE5i0Zd3a0AVw5MI8=;
        b=K7CLcgNhNyTgHOGIlCKGMvkIkC9qURKXxrJYXc4KjfgH7EKG4en4cX+0H5hRcefRy4
         0jjQ27Ozo8g6sNTJGBCshPAQzSS5HkdfTCw5ygJaTIVYB7AdGuPFmNP9pLA/z0nJFTE6
         Nw0v1souzIVzQChFwzA5lPTj1VgNT7tS4W1ztFLlmDGzLKLrX6wEfyLdsgkDbV1dS34B
         9WUlLq5u6XaooQA40C7LCbJJYFvWpzq82FNFkcW7I0Kx0/jjgaMdXE3FOO+W9X3uUhv0
         h5z+5Ub4RlXRwzSkbBumduiUzmBHVSZSzJ3YUnpyC7iDJSXi2Fp2lczA3Ge35a5g3l9T
         evyg==
X-Gm-Message-State: AOAM533xaHBdiHBpm/JzowjAHwqbdF5Pagcokg5mk8qsnngbh8ai5uW5
        PKJVGvGzazGZ5nhMCnkr45RJBsit6MV/ABbK0AmphJt5
X-Google-Smtp-Source: ABdhPJwt/pkDKB7laGuvay0LLu9639+72PKeT/pp6WyFWVUzg0/zcLKKhfoWry3aEhXHil2I96wgir8JneDfQhUc+Gg=
X-Received: by 2002:a50:be81:: with SMTP id b1mr61526669edk.59.1635950230835;
 Wed, 03 Nov 2021 07:37:10 -0700 (PDT)
MIME-Version: 1.0
References: <20201118230414.121316-1-aford173@gmail.com> <20201130220249.GA3109751@robh.at.kernel.org>
 <CAHCN7x+om4W5jqnuAW4-nMkZLc5nrYu7NUsbM36r0wyFSYa4-g@mail.gmail.com> <CAHCN7xKEkpq07AfMbpPfEcz0x=XvVjST==8gYRyrbW+Cjs3ONg@mail.gmail.com>
In-Reply-To: <CAHCN7xKEkpq07AfMbpPfEcz0x=XvVjST==8gYRyrbW+Cjs3ONg@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 3 Nov 2021 09:36:59 -0500
Message-ID: <CAHCN7xJK-iMMNMOtJCn9a2T2Jox=3LK3ANPGgZAC645wJw=3JQ@mail.gmail.com>
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

On Sat, Oct 16, 2021 at 3:11 PM Adam Ford <aford173@gmail.com> wrote:
>
> On Thu, Apr 1, 2021 at 4:19 PM Adam Ford <aford173@gmail.com> wrote:
> >
> > On Mon, Nov 30, 2020 at 4:02 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Wed, 18 Nov 2020 17:04:14 -0600, Adam Ford wrote:
> > > > Add binding doc for fsl,spba-bus.
> > > >
> > > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > > > ---
> > > > make dt_binding_check -j8 |grep spba
> > > >   DTEX    Documentation/devicetree/bindings/bus/fsl,spba-bus.example.dts
> > > >   DTC     Documentation/devicetree/bindings/bus/fsl,spba-bus.example.dt.yaml
> > > >   CHECK   Documentation/devicetree/bindings/bus/fsl,spba-bus.example.dt.yaml
> > > >
> > > > V5:  Rebase on 5.10-rc2 to be able to check yaml
> > > >      Add Reg entry
> > > >
> > > > V4:  Remove an accidental makefile change
> > > >      Move type:object under additional properties
> > > >
> > > > V3:  Rebase sample from aips-bus example
> > > >      Split off from series adding i.MX8M Nano functions to reduce noise
> > > >
> > > > V2:  Attempted to update yaml from feedback
> > > >
> > >
> > > Applied, thanks!
> >
> > Rob,
> >
> > I am not seeing this anywhere.  Can you tell me where this was
> > applied?  It's not appearing in Linux-next
>
> Rob,
>
> Patchwork shows this has been accepted [1], however I don't see that
> it's still applied.
>
>
> [1] https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20201118230414.121316-1-aford173@gmail.com/
>
> Can you apply it?  It looks like building the device tree is throwing
> messages because this is missing.
>

Shawn,

Since you're the maintainer for the IMX stuff, can I update the
MAINTAINERS file to add this yaml file under the IMX section?  When
building device trees, it throws a bunch of splat because this patch
was never applied, and checkpatch is showing it wants a maintainer.

> adam
> >
> > adam
