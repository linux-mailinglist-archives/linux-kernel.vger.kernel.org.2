Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA893EAEFB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 05:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237853AbhHMDkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 23:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbhHMDku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 23:40:50 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C501C061756;
        Thu, 12 Aug 2021 20:40:24 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id s22-20020a17090a1c16b0290177caeba067so18803488pjs.0;
        Thu, 12 Aug 2021 20:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ORlrD9sl2aYo7jcRja/hxhONlCSeq5JNCCwjrBnwxHg=;
        b=ls+y9PABiM7r2XhDF6NpqmapOhuDd3WDTmTnpnP3+eOcE/KB0PBGnOMGCTwiWmCxZU
         zRtrd/D/KjHERYC7MTD8uRVfXzG2Z3HMizrjPVThbvc0Jn4mv8A/w1u2/0UmT+VeoOy4
         3QbaSEy+9SrswsB+SIEssE3V2Wai5hML/bWmUvsTYU/Exi+Oz3uilkjwqQ/pvR+VGy+L
         xEJTN4AxgeY/0UlnLApejq8ai34l4SANvij0fRnaR5wI4+AygGI1FTzF80JVv7ieaASI
         zWnHrO72pTJmD0O/WVdun7wGDUdBEF/Kctn2zoaQFwPrsJQ5o/mXLKr6pOmXC/e9NwQF
         kXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ORlrD9sl2aYo7jcRja/hxhONlCSeq5JNCCwjrBnwxHg=;
        b=EB1QxmuSUOsl/2NwbR3d1EiBfa0vfmQv71RMtDmEj3sGllfUCTFrofdfNUI+LW/ClT
         F7AtQO07xMdQoEYXSvECIzIBCEycG4T3MyY/GdV2zZ7QJjg9KEWirSvnSQ/nMqoDb1lp
         T5337G9buWOYXzO60p1nTqxfnTE9Uo1/ugvUppIc9Y+XxqYBLC1TXt+q0HEBP6Tq5Ica
         uc1h1iGWPdi8L+IJGkYzbeEU0jHb+AXodOyW9q2f3AWnH5XRB/JSk/O6xd5FktB3UHC6
         KEl1iG5wA+updXtwqRAvEfdNKnaiAlTbDHF7R0hvICu+QkeqDPVpaB9qwiNoqg7f4R/D
         6m2w==
X-Gm-Message-State: AOAM530bFwWFnXkMgu1vmnX+Eiu7tFnApjiN81iqiBjHyzpbp0GbjVAU
        w6V2yOty0K64jximd9cZ1/E=
X-Google-Smtp-Source: ABdhPJzhTgI45W86irveIUKBOUgK67+9nGpu3ltrKHOvKGT9EQFFV8uNZpi8CRMREa+QzJyTRGOSyg==
X-Received: by 2002:a17:902:8f90:b029:12d:1b48:efd8 with SMTP id z16-20020a1709028f90b029012d1b48efd8mr352319plo.23.1628826023485;
        Thu, 12 Aug 2021 20:40:23 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91 (c-73-92-48-112.hsd1.ca.comcast.net. [73.92.48.112])
        by smtp.gmail.com with ESMTPSA id z24sm236977pjq.43.2021.08.12.20.40.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Aug 2021 20:40:23 -0700 (PDT)
Date:   Thu, 12 Aug 2021 20:40:17 -0700
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Rob Herring <robh+dt@kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Tao Ren <taoren@fb.com>
Subject: Re: [PATCH v2 4/6] ARM: dts: aspeed: Add Facebook Cloudripper
 (AST2600) BMC
Message-ID: <20210813034016.GA21895@taoren-ubuntu-R90MNF91>
References: <20210805222818.8391-1-rentao.bupt@gmail.com>
 <20210805222818.8391-5-rentao.bupt@gmail.com>
 <CACPK8XcV5On2D4D+SXnfw1M0owwfCL4Su19jOEA7yWpq+T3jLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8XcV5On2D4D+SXnfw1M0owwfCL4Su19jOEA7yWpq+T3jLw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2021 at 01:29:17AM +0000, Joel Stanley wrote:
> On Thu, 5 Aug 2021 at 22:28, <rentao.bupt@gmail.com> wrote:
> > +&mdio1 {
> > +       status = "okay";
> 
> You're enabling this but it looks like it's unused?

Thanks Joel for the careful review. The MDIO controller is not paired
with BMC MAC; instead, it's connected to the MDC/MDIO interface of the
on-board switch (whose ports are connected to BMC, Host and front panel
management port).

In other word, the MDIO controller is used, but we do need some user
space scripts to control the controller. What's your suggestion? For
example, should I add some comments to explain the purpose?


Cheers,

Tao

> 
> > +};
> > +
> > +&mdio3 {
> > +       status = "okay";
> > +
> > +       ethphy1: ethernet-phy@13 {
> > +               compatible = "ethernet-phy-ieee802.3-c22";
> > +               reg = <0x0d>;
> > +       };
> > +};
> > +
> > +&mac3 {
> > +       status = "okay";
> > +       phy-mode = "rgmii";
> > +       phy-handle = <&ethphy1>;
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_rgmii4_default>;
> > +};
