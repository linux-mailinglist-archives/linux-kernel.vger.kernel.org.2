Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8ADD43560E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 00:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbhJTWrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 18:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhJTWrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 18:47:08 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8630C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 15:44:53 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id o42so12838373vkf.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 15:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3n5KN7CgyVUxl41i9GwqHeUxPHOQhKY+yRME9tGutzM=;
        b=lkfzF5a6fPegqGNyMP1wQKvcQ401LABTRcmen2TkQPuO/ngYwnKJwBCXhis3WqPTDM
         /2tNDLU4mzSPVinR+iAX5ZKu2qBVolAmfApgxSdcm2IFF9CXUlgcRPQch1cJxvd00nXs
         kxc3xLtuFwz0rhRmj6Gr4pCcgXfL0wdhxKWKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3n5KN7CgyVUxl41i9GwqHeUxPHOQhKY+yRME9tGutzM=;
        b=sK+yyFntTahFpcvB1SNITfWdT30cJDfSdEvpcjGi7eMqLZE+Vggq/uKOr1saAw/FZy
         9Nh+JzvyiIy0lvvfxuGn9FdEC2IccK9mIzGjYYf8jXE61amWXmK5FL5G5RIzSJCRziHC
         Wd+QfAIkX9HooMmMHmZVfZ+qH6H9PTHJ3rOSOFB2vUoNsEMIuMHu+Bhwd+KP5hiBmher
         6o8GE0koIwwjWOlufRrVsMABOSC8cj4W0S5sLw3RNktk+oy0PFgqMFIR5zSsiN4AsSJB
         pPNwF3uxX02bXAUKtqjk7/O9bz/lsEeyCdKTEdT0CdPqVQsHs+BJCTd2helTJjVQKJWY
         pctA==
X-Gm-Message-State: AOAM532SfLwkKsQCBAoQ/gW6PPsx/s8R7AZH14hVjCKpwKqZ9WoU5H6k
        DzuFauvdJzUeqgx2cqaWpt/Bd9h3grDCO2vGGq1ZPA==
X-Google-Smtp-Source: ABdhPJwTBA1dHLoiaEx5Gl46AJ0ybgiAu3wLJWDZZn9dae/whPJNISodXSKsk3p0Dnv5iiLlCvjWoBvLkZWEmt8aqbA=
X-Received: by 2002:a05:6122:1309:: with SMTP id e9mr2254892vkp.11.1634769892433;
 Wed, 20 Oct 2021 15:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <20211003125134.2.I7733f5a849476e908cc51f0c71b8a594337fbbdf@changeid>
 <YVtWVZDzhwMPnKj0@robh.at.kernel.org> <CAPnjgZ3hUu6AUiMtC8tSQPeeG1aH1bQMcE8SQ_T8Nd-FjY_fGQ@mail.gmail.com>
 <CAL_JsqLT28Lp6pVYLxheZ=iK9QDOzXcezihR+sru4qLQLoUeWw@mail.gmail.com>
 <CAPnjgZ1accZg-G00xX7HPE8KAoh9NPAkfrb9BFrj3W5Bo_0pKg@mail.gmail.com> <CAL_JsqL5MP1efM_d5EF3x4M_qf3gee8Sc8TQFgxoVsdCWTY9uw@mail.gmail.com>
In-Reply-To: <CAL_JsqL5MP1efM_d5EF3x4M_qf3gee8Sc8TQFgxoVsdCWTY9uw@mail.gmail.com>
From:   Simon Glass <sjg@chromium.org>
Date:   Wed, 20 Oct 2021 16:44:41 -0600
Message-ID: <CAPnjgZ2r1qSDkJS_Z2v25=EsZj_9pt=qSTre3yTjqUnQrV7+ww@mail.gmail.com>
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

Hi Rob,

On Mon, 18 Oct 2021 at 16:26, Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Oct 13, 2021 at 11:33 AM Simon Glass <sjg@chromium.org> wrote:
> >
> > "
> > Hi Rob,
> >
> > On Tue, 12 Oct 2021 at 09:05, Rob Herring <robh@kernel.org> wrote:
> > >
> > >  On Tue, Oct 12, 2021 at 8:41 AM Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Rob,
> > > >
> > > > On Mon, 4 Oct 2021 at 13:30, Rob Herring <robh@kernel.org> wrote:
> > > > >
> > > > > On Sun, Oct 03, 2021 at 12:51:53PM -0600, Simon Glass wrote:
> > > > > > U-Boot makes use of the devicetree for its driver model. Devices are bound
> > > > > > based on the hardware description in the devicetree.
> > > > > >
> > > > > > Since U-Boot is not an operating system, it has no command line or user
> > > > > > space to provide configuration and policy information. This must be made
> > > > > > available in some other way.
> > > > > >
> > > > > > Therefore U-Boot uses devicetree for configuration and run-time control
> > > > > > and has done for approximately 9 years. This works extremely well in the
> > > > > > project and is very flexible. However the bindings have never been
> > > > > > incorporated in the devicetree bindings in the Linux tree. This could be
> > > > > > a good time to start this work as we try to create standard bindings for
> > > > > > communicating between firmware components.
> > > > > >
> > > > > > Add an initial binding for this node, covering just the config node, which
> > > > > > is the main requirement. It is similar in concept to the chosen node, but
> > > > > > used for passing information between firmware components, instead of from
> > > > > > firmware to operating system.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > ---
> > > > > > Please be kind in your review. Some words about why this is needed are
> > > > > > included in the description in config.yaml file.
> > > > > >
> > > > > > The last attempt to add just one property needed by U-Boot went into the
> > > > > > weeds 6 years ago, with what I see as confusion about the role of the
> > > > > > chosen node in devicetree[1].
> > > > > >
> > > > > > I am trying again in the hope of reaching resolution rather than just
> > > > > > going around in circles with the 'devicetree is a hardware description'
> > > > > > argument :-)
> > > > > >
> > > > > > Quoting from the introduction to latest devicetree spec[2]:
> > > > > >
> > > > > > >>>
> > > > > > To initialize and boot a computer system, various software components
> > > > > > interact. Firmware might perform low-level initialization of the system
> > > > > > hardware before passing control to software such as an operating system,
> > > > > > bootloader, or  hypervisor. Bootloaders and hypervisors can, in turn,
> > > > > > load and transfer control to operating systems. Standard, consistent
> > > > > > interfaces and conventions facilitate the interactions between these
> > > > > > software components. In this document the term boot program is used to
> > > > > > generically refer to a software component that initializes the system
> > > > > > state and executes another software component referred to as a client
> > > > > > program.
> > > > > > <<<
> > > > > >
> > > > > > This clearly envisages multiple software components in the firmware
> > > > > > domain and in fact that is the case today. They need some way to
> > > > > > communicate configuration data such as memory setup, runtime-feature
> > > > > > selection and developer conveniences. Devicetree seems ideal, at least for
> > > > > > components where the performance / memory requirements of devicetree are
> > > > > > affordable.
> > > > > >
> > > > > > I hope that the Linux community (which owns the devicetree bindings) finds
> > > > > > this initiative valuable and acceptable.
> > > > >
> > > > > Owns? I'm having a sale and can make you a good offer. Buy 1 binding,
> > > > > get 2000 free. :)
> > > >
> > > > Yes, it's the price of that first binding that surely puts everyone off.
> > > >
> > > > (sorry for sitting on this for a week, my spam filter doesn't like
> > > > some mailing lists and I'm working on it)
> > > >
> > > > >
> > > > > >
> > > > > > [1] https://lists.denx.de/pipermail/u-boot/2015-July/218585.html
> > > > > > [2] https://github.com/devicetree-org/devicetree-specification/releases/tag/v0.3
> > > > > >
> > > > > >  .../devicetree/bindings/u-boot/config.yaml    | 137 ++++++++++++++++++
> > > > > >  1 file changed, 137 insertions(+)
> > > > > >  create mode 100644 Documentation/devicetree/bindings/u-boot/config.yaml
> > > > >
> > > > > Might as well put this into dt-schema rather than the kernel. But might
> > > > > get more review here first.
> > > >
> > > > OK, so does that mean a PR to https://github.com/robherring/dt-schema
> > >
> > > Wrong one: https://github.com/devicetree-org/dt-schema
> > >
> > > I need to update the readme there for the old one.
> >
> > OK thanks.
> >
> > >
> > > > or is there a mailing list for it? I think I am missing some
> > > > understanding here.
> > >
> > > You can send a PR or to a DT mailing list, but the mail list will get
> > > more reviews (hopefully). devicetree-spec is better than devicetree as
> > > it is not a firehose.
> >
> > OK.
> >
> > >
> > > > >
> > > > > > diff --git a/Documentation/devicetree/bindings/u-boot/config.yaml b/Documentation/devicetree/bindings/u-boot/config.yaml
> > > > > > new file mode 100644
> > > > > > index 00000000000000..336577a17fdf5a
> > > > > > --- /dev/null
> > > > > > +++ b/Documentation/devicetree/bindings/u-boot/config.yaml
> > > > > > @@ -0,0 +1,137 @@
> > > > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > > > +%YAML 1.2
> > > > > > +---
> > > > > > +$id: http://devicetree.org/schemas/u-boot/config.yaml#
> > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > +
> > > > > > +title: U-Boot configuration node
> > > > > > +
> > > > > > +maintainers:
> > > > > > +  - Simon Glass <sjg@chromium.org>
> > > > > > +
> > > > > > +description: |
> > > > > > +  The config node does not represent a real device, but serves as a place
> > > > > > +  for passing data between firmware elements, like memory maps. Data in the
> > > > > > +  config node does not represent the hardware. It is ignored by operating
> > > > > > +  systems.
> > > > > > +
> > > > > > +  Purpose of config node
> > > > > > +  ----------------------
> > > > > > +
> > > > > > +  A common problem with firmware is that many builds are needed to deal with the
> > > > > > +  slight variations between different, related models. For example, one model
> > > > > > +  may have a TPM and another may not. Devicetree provides an excellent solution
> > > > > > +  to this problem, in that the devicetree to actually use on a platform can be
> > > > > > +  injected in the factory based on which model is being manufactured at the time.
> > > > > > +
> > > > > > +  A related problem causing build proliferation is dealing with the differences
> > > > > > +  between development firmware, developer-friendly firmware (e.g. with all
> > > > > > +  security features present but with the ability to access the command line),
> > > > > > +  test firmware (which runs tests used in the factory), final production
> > > > > > +  firmware (before signing), signed firmware (where the signatures have been
> > > > > > +  inserted) and the like. Ideally all or most of these should use the same
> > > > > > +  U-Boot build, with just some options to determine the features available. For
> > > > > > +  example, being able to control whether the UART console or JTAG are available,
> > > > > > +  on any image, is a great debugging aid.
> > > > > > +
> > > > > > +  When the firmware consists of multiple parts (various U-Boot phases, TF-A,
> > > > > > +  OP-TEE), it is helpful that all operate the same way at runtime, regardless of
> > > > > > +  how they were built. This can be achieved by passing the runtime configuration
> > > > > > +  (e.g. 'enable UART console', 'here are your public keys') along the chain
> > > > > > +  through each firmware stage. It is frustrating to have to replicate a bug on
> > > > > > +  production firmware which does happen on developer firmware, because they are
> > > > > > +  completely different builds.
> > > > > > +
> > > > > > +  The config node provides useful functionality for this. It allows the different
> > > > > > +  controls to be 'factored out' of the U-Boot binary, so they can be controlled
> > > > > > +  separately from the initial source-code build. The node can be easily updated
> > > > > > +  by a build or factory tool and can control various features in U-Boot. It is
> > > > > > +  similar in concept to a Kconfig option, except that it can be changed after
> > > > > > +  U-Boot is built.
> > > > > > +
> > > > > > +  The config node is similar in concept to /chosen (see chosen.txt) except that
> > > > >
> > > > > chosen.yaml now (in dt-schema).
> > > >
> > > > OK
> > > >
> > > > >
> > > > > > +  it is for passing information *into* and *between) firmware components,
> > > > > > +  instead of from firmware to the Operating System. Also, while operating
> > > > > > +  systems typically have a (sometimes extremely long) command line, U-Boot does
> > > > > > +  not support this, except with sandbox. The devicetree provides a more
> > > > > > +  structured approach in any case.
> > > > >
> > > > > What about having a /chosen/u-boot/ node instead?
> > > >
> > > > What is your rationale for doing that?
> > >
> > > Simply that /chosen is where the s/w configuration for the next stage
> > > consuming the DT goes. Also, we already have bootcmd defined in chosen
> > > and don't need it in a whole other place.
> >
> > OK I see.
> >
> > The spec says "The /chosen node does not represent a real device in
> > the system but describes parameters chosen or specified by the system
> > firmware at run time. It shall be a child of the root node."
> >
> > To my reading, this is not the same thing. I would prefer something like:
> >
> > "The /xxx node does not represent a real device in the system but
> > describes parameters used by the system firmware at run time. It shall
> > be a child of the root node."
>
> The wording is from simpler times... We can reword it however we need.

Yes, as is the /chosen node, I think. So perhaps we should be able to
expand to other nodes as needed!

>
> > Anyway, we could use /chosen, and I can see it will make a lot of
> > people happy. But I don't think it is a great plan. Here are my
> > thoughts:
> >
> > 1. This node is built, packaged and set up by and used by U-Boot
> > itself, at least in most cases, so U-Boot is not the next stage, but
> > the current stage. Conceptually, using /chosen is confusing for U-Boot
> > itself.
> >
> > 2.. bootcmd is the Operating System command line, whereas the one here
> > is for U-Boot, specifically
> >
> > 3. U-Boot does not and should not change this node, but it does change /chosen.
> >
> > 4. If we move to livetree for writing in U-Boot, we'll want to flatten
> > the tree (containing /chosen) before calling Linux. Having the config
> > under the /chosen node is an added complication there.
>
> How is deleting a node under /chosen harder than a node off of the root node?

I was not expecting we would delete it, but the fact that you say that
does seem to suggest it doesn't belong there.

Ideally I'd like the bindings to work so we can pass things all the
way through without trouble.

>
> > 5.  It is slightly more efficient for U-Boot to put this at the top
> > level - this matters in SPL. But I don't think this is huge concern.
> >
> > 6.. I very much think of /chosen as an operating system thing. Would
> > this be the first use by firmware?
> >
> > 7. If we want to sign the U-Boot config then it is easier if it is in
> > a separate node from /chosen, which is, after all, updated by U-Boot.
>
> Isn't it just as easy to sign /chosen/u-boot if we are signing on a
> per node basis?
>
> Or does it matter since u-boot is re-signing /chosen anyways. Do we
> need to maintain the old signature?

Yes we can sign a node without signing its subnode, but it's a bit confusing.

I'm actually not sure U-Boot will sign /chosen, though. At present it
has no signing infrastructure.

>
> > I'd really like to discuss whether we can break out of the /chosen
> > node straightjacket. Perhaps instead we should have something like
> > /firmware or /chosen-fw with the U-Boot node under that? I can
> > definitely see the concern about having lots of vendor-specific nodes
> > at the top level for every component, though.
>
> Well, /firmware has generally meant h/w devices implemented with
> firmware interfaces. For example, a system controller implementing
> clock provider over a mailbox interface. That said, I'd be okay with
> this under /firmware.

OK.

>
> >
> > Do you have any other ideas?
> >
> > >
> > > Arguably, we don't even need another sub-node here. We could just say
> > > a given component is responsible for consuming /chosen and then
> > > updating it for the next component. The problem with that is if you
> > > want all the configuration to coexist at the start. Overlapping
> > > properties is also a problem. The only overlap in this case is
> > > bootcmd, but you could handle that with a 'u-boot,bootcmd'. Not saying
> > > we should do that though given we need to extend things beyond 2
> > > components.
> >
> > Are we trying to conserve nodes? They are not that expensive. I like
> > the idea of separating our concerns between firmware and OS, or this
> > is going to get mighty confusing. As you say it makes it hard to use a
> > mostly static DT.
>
> As I said, not suggesting we should do that, only that it *could*
> work. And yes, it does get confusing.

OK

>
> >
> > >
> > > > Should we perhaps have a vendor/ directory for vendor-specific tags?
> > >
> > > In the kernel tree, we already have bindings/soc/<vendor> and vendors
> > > like to just dump all their stuff there when it belongs in a directory
> > > for the function.
> >
> > OK so perhaps we should leave this file where it is.
> >
> > >
> > > > Also, thinking ahead, I am interested in how we can add bindings for
> > > > firmware-to-firmware communications. There are some settings that
> > > > could be defined across projects (such as memory layout, security
> > > > level/settings) and these should ideally be harmless to pass to the
> > > > kernel (i.e. ignored by the kernel). It is possible that some of these
> > > > could be used by the kernel but then we can always recreate them using
> > > > kernel bindings as needed (and cross that bridge when we come to it).
> > > > So this would be a set of bindings used by firmware components in
> > > > general. We would not want to use "u-boot,xxx" in that case.
> > >
> > > Yes, that is also why I'm thinking about how do we extend /chosen.
> > > More generally, it's just one stage to the next. firmware-to-firmware
> > > is not really any different than bootloader to OS. /chosen serves that
> > > purpose already, so the question is how to make chosen support
> > > multiple components.
> >
> > The problem, as I see it, is that we don't have
> > /chosen/operating-system, we just have /chosen
>
> Right, redesigning from scratch would be easier. My thinking was the
> immediate properties in /chosen are owned by the OS and child nodes
> are their own namespace. That works in terms of separate namespaces as
> long as we don't need a global one which the OS can override. The one
> exception where this breaks down is simple framebuffer has already
> added a child node, but that overlap doesn't seem too problematic to
> me.

Well, if we have to, but I'd rather it were separate.

>
> >
> > So that namespace is already claimed for the OS. A clean break seems
> > better to me.
> >
> > Just a thought...if we have /chosen-fw we could have subnodes for each
> > firmware component, with the 'standard' bindings at the top level?
>
> You mean like this?:
>
> /chosen
>  + OS props
>
> /chosen-fw
>  +/u-boot
>    + u-boot props
>  +/other-fw

Yes, with the addition of 'common' properties/nodes. For example:

/chosen-fw {
   enable-jtag;   // common firmware property

   console-record {   // common firmware property
      reg = <0x12340000 0x8000>;
   };

   security {
      protect-text;
   }

   u-boot {
   };

   atf {
   };
   optee {
   };
}

Regards,
Simon
