Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B105642C672
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 18:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237246AbhJMQfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 12:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237018AbhJMQfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 12:35:08 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14ACC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 09:33:04 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id j8so5659139uak.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 09:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rya4ql+J0pojULrtoj3YzEjPpJS8UxUANMAyi1vST04=;
        b=Jh5K0PsZ2LwyDqb9kV5ZGOG/Q5D6wNOU0HH/013jDrHVeA01RwJLvC5DbyObGiF15M
         RCRsVy5KvFKofxp/JQSTbWKqv1/MAt/QIEERdvjgkzvf9TjKTOlpM6HxAGBmhToAK9TI
         96q1T/JordgUVbYoTNK70Pt5QUlkycLASiHiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rya4ql+J0pojULrtoj3YzEjPpJS8UxUANMAyi1vST04=;
        b=eqT2DZPUDpvSmPQQ+ahdlmHGNZ45qemxYeycmiHW6yK8g+VYST9I18WeWDabeuGOoO
         buu8otiE7oA34rl7nVlE2kvqf7K5bf7CRnXknXroIZak8ZIPR1d/tu0Y8Zln4GUwgDOD
         TK4qVJXxgxUG/1Yl2zuUsVQPs7NbHBHpP8X/2ugja/kXhKhhR7006WKFs6Y/KCE3l2Gc
         H5vbOn3OKqZlLMyPXUCO++61YYvCers8ZmjRiYgm5xed8m32sqC7aWsYQZY+EAn/IWM5
         A2ziXGcnCP0R+yzocNo2tCOXZT6Eb/0RIkYuEbpH4zqn4g+kbDZlm4LQ9chHr6gD42K1
         GMzw==
X-Gm-Message-State: AOAM5320z3KQvlbZ+K3KpclYyoqAyLJ+YyO63x4ZOy7WWt6D1XsyhH6t
        UsQMN4lbNsZYw6Q6fbf5GdPkEE93ys0oBE6cKPg5lw==
X-Google-Smtp-Source: ABdhPJyL3+/4aN52X8gHGa+10XBOwIppW1O+lz1l1TRL006MiSuFnrPPhfmoFnW3ldqhq0URp7uYj/NE52TaV/QDEng=
X-Received: by 2002:a05:6102:3577:: with SMTP id bh23mr113737vsb.8.1634142783521;
 Wed, 13 Oct 2021 09:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <20211003125134.2.I7733f5a849476e908cc51f0c71b8a594337fbbdf@changeid>
 <YVtWVZDzhwMPnKj0@robh.at.kernel.org> <CAPnjgZ3hUu6AUiMtC8tSQPeeG1aH1bQMcE8SQ_T8Nd-FjY_fGQ@mail.gmail.com>
 <CAL_JsqLT28Lp6pVYLxheZ=iK9QDOzXcezihR+sru4qLQLoUeWw@mail.gmail.com>
In-Reply-To: <CAL_JsqLT28Lp6pVYLxheZ=iK9QDOzXcezihR+sru4qLQLoUeWw@mail.gmail.com>
From:   Simon Glass <sjg@chromium.org>
Date:   Wed, 13 Oct 2021 10:32:51 -0600
Message-ID: <CAPnjgZ1accZg-G00xX7HPE8KAoh9NPAkfrb9BFrj3W5Bo_0pKg@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: u-boot: Add an initial binding for config
To:     Rob Herring <robh@kernel.org>
Cc:     Devicetree Discuss <devicetree@vger.kernel.org>,
        Tom Rini <trini@konsulko.com>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        lk <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"
Hi Rob,

On Tue, 12 Oct 2021 at 09:05, Rob Herring <robh@kernel.org> wrote:
>
>  On Tue, Oct 12, 2021 at 8:41 AM Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Rob,
> >
> > On Mon, 4 Oct 2021 at 13:30, Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Sun, Oct 03, 2021 at 12:51:53PM -0600, Simon Glass wrote:
> > > > U-Boot makes use of the devicetree for its driver model. Devices are bound
> > > > based on the hardware description in the devicetree.
> > > >
> > > > Since U-Boot is not an operating system, it has no command line or user
> > > > space to provide configuration and policy information. This must be made
> > > > available in some other way.
> > > >
> > > > Therefore U-Boot uses devicetree for configuration and run-time control
> > > > and has done for approximately 9 years. This works extremely well in the
> > > > project and is very flexible. However the bindings have never been
> > > > incorporated in the devicetree bindings in the Linux tree. This could be
> > > > a good time to start this work as we try to create standard bindings for
> > > > communicating between firmware components.
> > > >
> > > > Add an initial binding for this node, covering just the config node, which
> > > > is the main requirement. It is similar in concept to the chosen node, but
> > > > used for passing information between firmware components, instead of from
> > > > firmware to operating system.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > > Please be kind in your review. Some words about why this is needed are
> > > > included in the description in config.yaml file.
> > > >
> > > > The last attempt to add just one property needed by U-Boot went into the
> > > > weeds 6 years ago, with what I see as confusion about the role of the
> > > > chosen node in devicetree[1].
> > > >
> > > > I am trying again in the hope of reaching resolution rather than just
> > > > going around in circles with the 'devicetree is a hardware description'
> > > > argument :-)
> > > >
> > > > Quoting from the introduction to latest devicetree spec[2]:
> > > >
> > > > >>>
> > > > To initialize and boot a computer system, various software components
> > > > interact. Firmware might perform low-level initialization of the system
> > > > hardware before passing control to software such as an operating system,
> > > > bootloader, or  hypervisor. Bootloaders and hypervisors can, in turn,
> > > > load and transfer control to operating systems. Standard, consistent
> > > > interfaces and conventions facilitate the interactions between these
> > > > software components. In this document the term boot program is used to
> > > > generically refer to a software component that initializes the system
> > > > state and executes another software component referred to as a client
> > > > program.
> > > > <<<
> > > >
> > > > This clearly envisages multiple software components in the firmware
> > > > domain and in fact that is the case today. They need some way to
> > > > communicate configuration data such as memory setup, runtime-feature
> > > > selection and developer conveniences. Devicetree seems ideal, at least for
> > > > components where the performance / memory requirements of devicetree are
> > > > affordable.
> > > >
> > > > I hope that the Linux community (which owns the devicetree bindings) finds
> > > > this initiative valuable and acceptable.
> > >
> > > Owns? I'm having a sale and can make you a good offer. Buy 1 binding,
> > > get 2000 free. :)
> >
> > Yes, it's the price of that first binding that surely puts everyone off.
> >
> > (sorry for sitting on this for a week, my spam filter doesn't like
> > some mailing lists and I'm working on it)
> >
> > >
> > > >
> > > > [1] https://lists.denx.de/pipermail/u-boot/2015-July/218585.html
> > > > [2] https://github.com/devicetree-org/devicetree-specification/releases/tag/v0.3
> > > >
> > > >  .../devicetree/bindings/u-boot/config.yaml    | 137 ++++++++++++++++++
> > > >  1 file changed, 137 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/u-boot/config.yaml
> > >
> > > Might as well put this into dt-schema rather than the kernel. But might
> > > get more review here first.
> >
> > OK, so does that mean a PR to https://github.com/robherring/dt-schema
>
> Wrong one: https://github.com/devicetree-org/dt-schema
>
> I need to update the readme there for the old one.

OK thanks.

>
> > or is there a mailing list for it? I think I am missing some
> > understanding here.
>
> You can send a PR or to a DT mailing list, but the mail list will get
> more reviews (hopefully). devicetree-spec is better than devicetree as
> it is not a firehose.

OK.

>
> > >
> > > > diff --git a/Documentation/devicetree/bindings/u-boot/config.yaml b/Documentation/devicetree/bindings/u-boot/config.yaml
> > > > new file mode 100644
> > > > index 00000000000000..336577a17fdf5a
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/u-boot/config.yaml
> > > > @@ -0,0 +1,137 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/u-boot/config.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: U-Boot configuration node
> > > > +
> > > > +maintainers:
> > > > +  - Simon Glass <sjg@chromium.org>
> > > > +
> > > > +description: |
> > > > +  The config node does not represent a real device, but serves as a place
> > > > +  for passing data between firmware elements, like memory maps. Data in the
> > > > +  config node does not represent the hardware. It is ignored by operating
> > > > +  systems.
> > > > +
> > > > +  Purpose of config node
> > > > +  ----------------------
> > > > +
> > > > +  A common problem with firmware is that many builds are needed to deal with the
> > > > +  slight variations between different, related models. For example, one model
> > > > +  may have a TPM and another may not. Devicetree provides an excellent solution
> > > > +  to this problem, in that the devicetree to actually use on a platform can be
> > > > +  injected in the factory based on which model is being manufactured at the time.
> > > > +
> > > > +  A related problem causing build proliferation is dealing with the differences
> > > > +  between development firmware, developer-friendly firmware (e.g. with all
> > > > +  security features present but with the ability to access the command line),
> > > > +  test firmware (which runs tests used in the factory), final production
> > > > +  firmware (before signing), signed firmware (where the signatures have been
> > > > +  inserted) and the like. Ideally all or most of these should use the same
> > > > +  U-Boot build, with just some options to determine the features available. For
> > > > +  example, being able to control whether the UART console or JTAG are available,
> > > > +  on any image, is a great debugging aid.
> > > > +
> > > > +  When the firmware consists of multiple parts (various U-Boot phases, TF-A,
> > > > +  OP-TEE), it is helpful that all operate the same way at runtime, regardless of
> > > > +  how they were built. This can be achieved by passing the runtime configuration
> > > > +  (e.g. 'enable UART console', 'here are your public keys') along the chain
> > > > +  through each firmware stage. It is frustrating to have to replicate a bug on
> > > > +  production firmware which does happen on developer firmware, because they are
> > > > +  completely different builds.
> > > > +
> > > > +  The config node provides useful functionality for this. It allows the different
> > > > +  controls to be 'factored out' of the U-Boot binary, so they can be controlled
> > > > +  separately from the initial source-code build. The node can be easily updated
> > > > +  by a build or factory tool and can control various features in U-Boot. It is
> > > > +  similar in concept to a Kconfig option, except that it can be changed after
> > > > +  U-Boot is built.
> > > > +
> > > > +  The config node is similar in concept to /chosen (see chosen.txt) except that
> > >
> > > chosen.yaml now (in dt-schema).
> >
> > OK
> >
> > >
> > > > +  it is for passing information *into* and *between) firmware components,
> > > > +  instead of from firmware to the Operating System. Also, while operating
> > > > +  systems typically have a (sometimes extremely long) command line, U-Boot does
> > > > +  not support this, except with sandbox. The devicetree provides a more
> > > > +  structured approach in any case.
> > >
> > > What about having a /chosen/u-boot/ node instead?
> >
> > What is your rationale for doing that?
>
> Simply that /chosen is where the s/w configuration for the next stage
> consuming the DT goes. Also, we already have bootcmd defined in chosen
> and don't need it in a whole other place.

OK I see.

The spec says "The /chosen node does not represent a real device in
the system but describes parameters chosen or specified by the system
firmware at run time. It shall be a child of the root node."

To my reading, this is not the same thing. I would prefer something like:

"The /xxx node does not represent a real device in the system but
describes parameters used by the system firmware at run time. It shall
be a child of the root node."

Anyway, we could use /chosen, and I can see it will make a lot of
people happy. But I don't think it is a great plan. Here are my
thoughts:

1. This node is built, packaged and set up by and used by U-Boot
itself, at least in most cases, so U-Boot is not the next stage, but
the current stage. Conceptually, using /chosen is confusing for U-Boot
itself.

2.. bootcmd is the Operating System command line, whereas the one here
is for U-Boot, specifically

3. U-Boot does not and should not change this node, but it does change /chosen.

4. If we move to livetree for writing in U-Boot, we'll want to flatten
the tree (containing /chosen) before calling Linux. Having the config
under the /chosen node is an added complication there.

5.  It is slightly more efficient for U-Boot to put this at the top
level - this matters in SPL. But I don't think this is huge concern.

6.. I very much think of /chosen as an operating system thing. Would
this be the first use by firmware?

7. If we want to sign the U-Boot config then it is easier if it is in
a separate node from /chosen, which is, after all, updated by U-Boot.

I'd really like to discuss whether we can break out of the /chosen
node straightjacket. Perhaps instead we should have something like
/firmware or /chosen-fw with the U-Boot node under that? I can
definitely see the concern about having lots of vendor-specific nodes
at the top level for every component, though.

Do you have any other ideas?

>
> Arguably, we don't even need another sub-node here. We could just say
> a given component is responsible for consuming /chosen and then
> updating it for the next component. The problem with that is if you
> want all the configuration to coexist at the start. Overlapping
> properties is also a problem. The only overlap in this case is
> bootcmd, but you could handle that with a 'u-boot,bootcmd'. Not saying
> we should do that though given we need to extend things beyond 2
> components.

Are we trying to conserve nodes? They are not that expensive. I like
the idea of separating our concerns between firmware and OS, or this
is going to get mighty confusing. As you say it makes it hard to use a
mostly static DT.

>
> > Should we perhaps have a vendor/ directory for vendor-specific tags?
>
> In the kernel tree, we already have bindings/soc/<vendor> and vendors
> like to just dump all their stuff there when it belongs in a directory
> for the function.

OK so perhaps we should leave this file where it is.

>
> > Also, thinking ahead, I am interested in how we can add bindings for
> > firmware-to-firmware communications. There are some settings that
> > could be defined across projects (such as memory layout, security
> > level/settings) and these should ideally be harmless to pass to the
> > kernel (i.e. ignored by the kernel). It is possible that some of these
> > could be used by the kernel but then we can always recreate them using
> > kernel bindings as needed (and cross that bridge when we come to it).
> > So this would be a set of bindings used by firmware components in
> > general. We would not want to use "u-boot,xxx" in that case.
>
> Yes, that is also why I'm thinking about how do we extend /chosen.
> More generally, it's just one stage to the next. firmware-to-firmware
> is not really any different than bootloader to OS. /chosen serves that
> purpose already, so the question is how to make chosen support
> multiple components.

The problem, as I see it, is that we don't have
/chosen/operating-system, we just have /chosen

So that namespace is already claimed for the OS. A clean break seems
better to me.

Just a thought...if we have /chosen-fw we could have subnodes for each
firmware component, with the 'standard' bindings at the top level?

Regards,
Simon
