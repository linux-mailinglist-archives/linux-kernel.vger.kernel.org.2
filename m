Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5598743898D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 16:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhJXOle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 10:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhJXOld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 10:41:33 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD428C061745
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 07:39:12 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id f126so3917323vke.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 07:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3D8GDSKP4b4iak3caMjKDgewc0dkNqxERr8vtXIFb5E=;
        b=Kq0V9JG8QxSsVF+syuSF2F9f2Qf33pqeKWkgYSxUWKQviYfRhBzPln/oaYZdlFFztB
         eduq3daSepKPQo5uzYJ9vdmRmOtQVNdNlpGLargu7MIro4Lr7U56Qz8fPYODJFYf/ulc
         7P1OJLv9BbsY+mbmudvjJ56WpTmHj24uHNfiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3D8GDSKP4b4iak3caMjKDgewc0dkNqxERr8vtXIFb5E=;
        b=OImPDxKoNvjlz/c9orZ7zSl/KuV4hI1NZGQQUK68pJCicN/9BIEQuHEAUZ1PxrkjG0
         9+nzHRwTdV6q+zocp17lpr/s6CXK1cRBBeQKAtsKE8uXvX25ramAeku/zm+bK5k4MEXV
         gZntZ9VlxNOUjplLHlBQvoSjNFaKTlJCof8/lmWN8RJK/5d/zep15ouoD9q5QMbYXmCX
         NQfsBknBUUzQnzGHr1JjDqAji+sI/TKiL/PN4Lw+68yVL4tgLp7r/0KbH8xOVPh2x6+H
         xnU0SsAy8J0qZCraxPqYgL8xMKuxn2bbGO2hgys44xSQUaUKv98WGXKvx0b3reFPAwhh
         2Yog==
X-Gm-Message-State: AOAM53339fJa0Pg6eeUdXVVEC2TcNzS1HEWSu9R94ZKem0F2vDFaApDx
        Cx8G3Jf+Ji2A9M1PdPYg5PvI3ftxiXyMsgYZtjqieg==
X-Google-Smtp-Source: ABdhPJyeWW2Kk8pchSdyqCB9Ehqc04eyaae6+Gf2j/tPot3AlwQhcRLSGp1JXizGMc+Ol7OvdnrHPNXwoVBWZGu78Sw=
X-Received: by 2002:a1f:5c46:: with SMTP id q67mr11033605vkb.24.1635086351424;
 Sun, 24 Oct 2021 07:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <20211003125134.2.I7733f5a849476e908cc51f0c71b8a594337fbbdf@changeid>
 <YVtWVZDzhwMPnKj0@robh.at.kernel.org> <CAPnjgZ3hUu6AUiMtC8tSQPeeG1aH1bQMcE8SQ_T8Nd-FjY_fGQ@mail.gmail.com>
 <CAL_JsqLT28Lp6pVYLxheZ=iK9QDOzXcezihR+sru4qLQLoUeWw@mail.gmail.com>
 <CAPnjgZ1accZg-G00xX7HPE8KAoh9NPAkfrb9BFrj3W5Bo_0pKg@mail.gmail.com>
 <CAL_JsqL5MP1efM_d5EF3x4M_qf3gee8Sc8TQFgxoVsdCWTY9uw@mail.gmail.com>
 <CAPnjgZ2r1qSDkJS_Z2v25=EsZj_9pt=qSTre3yTjqUnQrV7+ww@mail.gmail.com> <d3ca77bc4dfc5b70@bloch.sibelius.xs4all.nl>
In-Reply-To: <d3ca77bc4dfc5b70@bloch.sibelius.xs4all.nl>
From:   Simon Glass <sjg@chromium.org>
Date:   Sun, 24 Oct 2021 08:38:59 -0600
Message-ID: <CAPnjgZ28KsGUPLtuKEYGijP9=moHCcJ4O7yC2x9PAt9ak5fK-Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: u-boot: Add an initial binding for config
To:     Mark Kettenis <mark.kettenis@xs4all.nl>
Cc:     Rob Herring <robh@kernel.org>,
        Devicetree Discuss <devicetree@vger.kernel.org>,
        Tom Rini <trini@konsulko.com>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        lk <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Thu, 21 Oct 2021 at 02:51, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>
> > From: Simon Glass <sjg@chromium.org>
> > Date: Wed, 20 Oct 2021 16:44:41 -0600
> >
> > Hi Rob,
> >
> > On Mon, 18 Oct 2021 at 16:26, Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Wed, Oct 13, 2021 at 11:33 AM Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > "
> > > > Hi Rob,
> > > >
> > > > On Tue, 12 Oct 2021 at 09:05, Rob Herring <robh@kernel.org> wrote:
> > > > >
> > > > >  On Tue, Oct 12, 2021 at 8:41 AM Simon Glass <sjg@chromium.org> wrote:
> > > > > >
> > > > > > Hi Rob,
> > > > > >
> > > > > > On Mon, 4 Oct 2021 at 13:30, Rob Herring <robh@kernel.org> wrote:
> > > > > > >
> > > > > > > On Sun, Oct 03, 2021 at 12:51:53PM -0600, Simon Glass wrote:
> > > > > > > > U-Boot makes use of the devicetree for its driver model. Devices are bound
> > > > > > > > based on the hardware description in the devicetree.
> > > > > > > >
> > > > > > > > Since U-Boot is not an operating system, it has no command line or user
> > > > > > > > space to provide configuration and policy information. This must be made
> > > > > > > > available in some other way.
> > > > > > > >
> > > > > > > > Therefore U-Boot uses devicetree for configuration and run-time control
> > > > > > > > and has done for approximately 9 years. This works extremely well in the
> > > > > > > > project and is very flexible. However the bindings have never been
> > > > > > > > incorporated in the devicetree bindings in the Linux tree. This could be
> > > > > > > > a good time to start this work as we try to create standard bindings for
> > > > > > > > communicating between firmware components.
> > > > > > > >
> > > > > > > > Add an initial binding for this node, covering just the config node, which
> > > > > > > > is the main requirement. It is similar in concept to the chosen node, but
> > > > > > > > used for passing information between firmware components, instead of from
> > > > > > > > firmware to operating system.
> > > > > > > >
> > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > ---
> > > > > > > > Please be kind in your review. Some words about why this is needed are
> > > > > > > > included in the description in config.yaml file.
> > > > > > > >
> > > > > > > > The last attempt to add just one property needed by U-Boot went into the
> > > > > > > > weeds 6 years ago, with what I see as confusion about the role of the
> > > > > > > > chosen node in devicetree[1].
> > > > > > > >
> > > > > > > > I am trying again in the hope of reaching resolution rather than just
> > > > > > > > going around in circles with the 'devicetree is a hardware description'
> > > > > > > > argument :-)
> > > > > > > >
> > > > > > > > Quoting from the introduction to latest devicetree spec[2]:
> > > > > > > >
> > > > > > > > >>>
> > > > > > > > To initialize and boot a computer system, various software components
> > > > > > > > interact. Firmware might perform low-level initialization of the system
> > > > > > > > hardware before passing control to software such as an operating system,
> > > > > > > > bootloader, or  hypervisor. Bootloaders and hypervisors can, in turn,
> > > > > > > > load and transfer control to operating systems. Standard, consistent
> > > > > > > > interfaces and conventions facilitate the interactions between these
> > > > > > > > software components. In this document the term boot program is used to
> > > > > > > > generically refer to a software component that initializes the system
> > > > > > > > state and executes another software component referred to as a client
> > > > > > > > program.
> > > > > > > > <<<
> > > > > > > >
> > > > > > > > This clearly envisages multiple software components in the firmware
> > > > > > > > domain and in fact that is the case today. They need some way to
> > > > > > > > communicate configuration data such as memory setup, runtime-feature
> > > > > > > > selection and developer conveniences. Devicetree seems ideal, at least for
> > > > > > > > components where the performance / memory requirements of devicetree are
> > > > > > > > affordable.
> > > > > > > >
> > > > > > > > I hope that the Linux community (which owns the devicetree bindings) finds
> > > > > > > > this initiative valuable and acceptable.
> > > > > > >
> > > > > > > Owns? I'm having a sale and can make you a good offer. Buy 1 binding,
> > > > > > > get 2000 free. :)
> > > > > >
> > > > > > Yes, it's the price of that first binding that surely puts everyone off.
> > > > > >
> > > > > > (sorry for sitting on this for a week, my spam filter doesn't like
> > > > > > some mailing lists and I'm working on it)
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > [1] https://lists.denx.de/pipermail/u-boot/2015-July/218585.html
> > > > > > > > [2] https://github.com/devicetree-org/devicetree-specification/releases/tag/v0.3
> > > > > > > >
> > > > > > > >  .../devicetree/bindings/u-boot/config.yaml    | 137 ++++++++++++++++++
> > > > > > > >  1 file changed, 137 insertions(+)
> > > > > > > >  create mode 100644 Documentation/devicetree/bindings/u-boot/config.yaml
> > > > > > >
> > > > > > > Might as well put this into dt-schema rather than the kernel. But might
> > > > > > > get more review here first.
> > > > > >
> > > > > > OK, so does that mean a PR to https://github.com/robherring/dt-schema
> > > > >
> > > > > Wrong one: https://github.com/devicetree-org/dt-schema
> > > > >
> > > > > I need to update the readme there for the old one.
> > > >
> > > > OK thanks.
> > > >
> > > > >
> > > > > > or is there a mailing list for it? I think I am missing some
> > > > > > understanding here.
> > > > >
> > > > > You can send a PR or to a DT mailing list, but the mail list will get
> > > > > more reviews (hopefully). devicetree-spec is better than devicetree as
> > > > > it is not a firehose.
> > > >
> > > > OK.
> > > >
> > > > >
> > > > > > >
> > > > > > > > diff --git a/Documentation/devicetree/bindings/u-boot/config.yaml b/Documentation/devicetree/bindings/u-boot/config.yaml
> > > > > > > > new file mode 100644
> > > > > > > > index 00000000000000..336577a17fdf5a
> > > > > > > > --- /dev/null
> > > > > > > > +++ b/Documentation/devicetree/bindings/u-boot/config.yaml
> > > > > > > > @@ -0,0 +1,137 @@
> > > > > > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > > > > > +%YAML 1.2
> > > > > > > > +---
> > > > > > > > +$id: http://devicetree.org/schemas/u-boot/config.yaml#
> > > > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > > > +
> > > > > > > > +title: U-Boot configuration node
> > > > > > > > +
> > > > > > > > +maintainers:
> > > > > > > > +  - Simon Glass <sjg@chromium.org>
> > > > > > > > +
> > > > > > > > +description: |
> > > > > > > > +  The config node does not represent a real device, but serves as a place
> > > > > > > > +  for passing data between firmware elements, like memory maps. Data in the
> > > > > > > > +  config node does not represent the hardware. It is ignored by operating
> > > > > > > > +  systems.
> > > > > > > > +
> > > > > > > > +  Purpose of config node
> > > > > > > > +  ----------------------
> > > > > > > > +
> > > > > > > > +  A common problem with firmware is that many builds are needed to deal with the
> > > > > > > > +  slight variations between different, related models. For example, one model
> > > > > > > > +  may have a TPM and another may not. Devicetree provides an excellent solution
> > > > > > > > +  to this problem, in that the devicetree to actually use on a platform can be
> > > > > > > > +  injected in the factory based on which model is being manufactured at the time.
> > > > > > > > +
> > > > > > > > +  A related problem causing build proliferation is dealing with the differences
> > > > > > > > +  between development firmware, developer-friendly firmware (e.g. with all
> > > > > > > > +  security features present but with the ability to access the command line),
> > > > > > > > +  test firmware (which runs tests used in the factory), final production
> > > > > > > > +  firmware (before signing), signed firmware (where the signatures have been
> > > > > > > > +  inserted) and the like. Ideally all or most of these should use the same
> > > > > > > > +  U-Boot build, with just some options to determine the features available. For
> > > > > > > > +  example, being able to control whether the UART console or JTAG are available,
> > > > > > > > +  on any image, is a great debugging aid.
> > > > > > > > +
> > > > > > > > +  When the firmware consists of multiple parts (various U-Boot phases, TF-A,
> > > > > > > > +  OP-TEE), it is helpful that all operate the same way at runtime, regardless of
> > > > > > > > +  how they were built. This can be achieved by passing the runtime configuration
> > > > > > > > +  (e.g. 'enable UART console', 'here are your public keys') along the chain
> > > > > > > > +  through each firmware stage. It is frustrating to have to replicate a bug on
> > > > > > > > +  production firmware which does happen on developer firmware, because they are
> > > > > > > > +  completely different builds.
> > > > > > > > +
> > > > > > > > +  The config node provides useful functionality for this. It allows the different
> > > > > > > > +  controls to be 'factored out' of the U-Boot binary, so they can be controlled
> > > > > > > > +  separately from the initial source-code build. The node can be easily updated
> > > > > > > > +  by a build or factory tool and can control various features in U-Boot. It is
> > > > > > > > +  similar in concept to a Kconfig option, except that it can be changed after
> > > > > > > > +  U-Boot is built.
> > > > > > > > +
> > > > > > > > +  The config node is similar in concept to /chosen (see chosen.txt) except that
> > > > > > >
> > > > > > > chosen.yaml now (in dt-schema).
> > > > > >
> > > > > > OK
> > > > > >
> > > > > > >
> > > > > > > > +  it is for passing information *into* and *between) firmware components,
> > > > > > > > +  instead of from firmware to the Operating System. Also, while operating
> > > > > > > > +  systems typically have a (sometimes extremely long) command line, U-Boot does
> > > > > > > > +  not support this, except with sandbox. The devicetree provides a more
> > > > > > > > +  structured approach in any case.
> > > > > > >
> > > > > > > What about having a /chosen/u-boot/ node instead?
> > > > > >
> > > > > > What is your rationale for doing that?
> > > > >
> > > > > Simply that /chosen is where the s/w configuration for the next stage
> > > > > consuming the DT goes. Also, we already have bootcmd defined in chosen
> > > > > and don't need it in a whole other place.
> > > >
> > > > OK I see.
> > > >
> > > > The spec says "The /chosen node does not represent a real device in
> > > > the system but describes parameters chosen or specified by the system
> > > > firmware at run time. It shall be a child of the root node."
> > > >
> > > > To my reading, this is not the same thing. I would prefer something like:
> > > >
> > > > "The /xxx node does not represent a real device in the system but
> > > > describes parameters used by the system firmware at run time. It shall
> > > > be a child of the root node."
> > >
> > > The wording is from simpler times... We can reword it however we need.
> >
> > Yes, as is the /chosen node, I think. So perhaps we should be able to
> > expand to other nodes as needed!
>
> Maybe, but it we probably should follow existing practice.
>
> The whole DT thing came out of OpenFirmware.  The OpenFirmware
> standard defines a /options node with various options that control how
> the firmware behaves.  It is defined in the IEEE 1275 standard:
>
>   https://www.openfirmware.info/data/docs/of1275.pdf
>
> The way this behaves on Sun and (PowerPC) machines is quite similar
> how environment variables work in U-Boot.

I don't see much semantic difference between choices and options, but
I would be quite happy to use 'options' for firmware. In fact it seems
that 'options' serves the same purpose as the 'config' node I had in
mind. We still need to have subnodes for project-specific things
though.

BTW it is interesting reading that old doc again. I wonder who it was
who decided to allow x86 code in the boot ROMs?

Regards,
Simon
