Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A09743E15D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 14:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhJ1M5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 08:57:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230216AbhJ1M5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 08:57:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 890FB610FF;
        Thu, 28 Oct 2021 12:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635425686;
        bh=GtJLRYLuGrV2uT1n3W9oht5XbcRdmvlz4JXikPuQm3U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZkwW6fisThr70yVcy4EVb8dtVXdvQ7ak4hBI9xd8EvkezuFjO8Hu4L2NNjxP5RDmb
         UFyLtlQoqhpWJJqJTIuU3NTmsyGEz21nBSr/dxa4c1B7j7AJ1DV0oSkkcpHLvMFuvg
         ytsOQof0S6MT6KfwsjvTrIiAwQMuv2tb8o2RxrC7OQxwx6uG+Rl8fyLPQpx70JwVmC
         KiBvkleXN8U5aDwFigkIxc24z3S3aFgx247NZ/FdmOmS3/ikp36EFp97G2lcNS1rJs
         ZcQYRposXXrskpNBBjXq0gthvNnaY4PGEfsVZWhERJpLxUm9PvajhoUxTEbWYFzYB7
         KW1L2xole/lHg==
Received: by mail-ed1-f44.google.com with SMTP id g8so24776381edb.2;
        Thu, 28 Oct 2021 05:54:46 -0700 (PDT)
X-Gm-Message-State: AOAM533Q1X3ULQTTWWgZKK+KB00MT0SUfTAJyk7utsdG6uxfR9QCjSvY
        iZMiA8NhE9WfpRHqggl3BQ6f8JvK+x5jsdxQIg==
X-Google-Smtp-Source: ABdhPJxr+SMstzl9DSZeVu23uMNa2HGUTxREj661Hr+EOzZnaBn0IhQOOcbIi2gAIChLEz6GVvyRhiT7BJWdIWw7Yzs=
X-Received: by 2002:a17:907:869e:: with SMTP id qa30mr5140865ejc.320.1635425685001;
 Thu, 28 Oct 2021 05:54:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211026225527.3460520-1-robh@kernel.org> <361311a6-5818-6fc8-56d9-1a0ab8eaa74b@gmail.com>
In-Reply-To: <361311a6-5818-6fc8-56d9-1a0ab8eaa74b@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 28 Oct 2021 07:54:33 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK2MDBoLqREsV9MBxvEs4Pxtg87r4LgCMHoUrgu_1yLLw@mail.gmail.com>
Message-ID: <CAL_JsqK2MDBoLqREsV9MBxvEs4Pxtg87r4LgCMHoUrgu_1yLLw@mail.gmail.com>
Subject: Re: [PATCH] of/unittest: Disable new dtc node_name_vs_property_name
 and interrupt_map warnings
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 7:05 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 10/26/21 5:55 PM, Rob Herring wrote:
> > The unittest dtbs have various intentional errors which cause warnings.
> > With the latest dtc sync to v1.6.1-19-g0a3a9d3449c8, we need to disable
> > some new checks: node_name_vs_property_name and interrupt_map warnings.
> >
> > These warnings are also generated for static_base_1.dtb, so let's just
> > disable the problematic warnings for all unittest dtbs instead of just
> > testcases.dtb.
> >
> > Fixes: e76187b9792e ("scripts/dtc: Update to upstream version v1.6.1-19-g0a3a9d3449c8")
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Cc: Frank Rowand <frowand.list@gmail.com>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/of/unittest-data/Makefile | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/of/unittest-data/Makefile b/drivers/of/unittest-data/Makefile
> > index a5d2d9254b2c..7e1a25ad4e5c 100644
> > --- a/drivers/of/unittest-data/Makefile
> > +++ b/drivers/of/unittest-data/Makefile
> > @@ -37,7 +37,9 @@ DTC_FLAGS_overlay_base += -@
> >  DTC_FLAGS_testcases += -@
> >
> >  # suppress warnings about intentional errors
> > -DTC_FLAGS_testcases += -Wno-interrupts_property
> > +DTC_FLAGS += -Wno-interrupts_property \
> > +     -Wno-node_name_vs_property_name \
> > +     -Wno-interrupt_map
> >
> >  # Apply overlays statically with fdtoverlay.  This is a build time test that
> >  # the overlays can be applied successfully by fdtoverlay.  This does not
> >
>
> Before applying this commit, I am not seeing the warning that -Wno-interrupt_map
> suppresses.  I've tried with (1) CONFIG_OF_DYNAMIC and (2) with both
> CONFIG_OF_DYNAMIC and CONFIG_OF_OVERLAY, and I don't see the warning.
>
> Where are you seeing the interrupt_map warning?

I should have noted that that is dependent on re-enabling the
interrupt_provider warning which was dependent on the dtc changes.
I've already submitted dts fixes for that and plan to enable soon:

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 56d50eb0cd80..d435db2222ab 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -305,7 +305,6 @@ quiet_cmd_gzip = GZIP    $@
 # DTC
 # ---------------------------------------------------------------------------
 DTC ?= $(objtree)/scripts/dtc/dtc
-DTC_FLAGS += -Wno-interrupt_provider

 # Disable noisy checks by default
 ifeq ($(findstring 1,$(KBUILD_EXTRA_WARN)),)
@@ -319,8 +318,7 @@ endif

 ifneq ($(findstring 2,$(KBUILD_EXTRA_WARN)),)
 DTC_FLAGS += -Wnode_name_chars_strict \
-       -Wproperty_name_chars_strict \
-       -Winterrupt_provider
+       -Wproperty_name_chars_strict
 endif

 DTC_FLAGS += $(DTC_FLAGS_$(basetarget))

(I just noticed that dtc doesn't seem to handle overriding options
such as: '-Wno-interrupt_provider -Winterrupt_provider')

> I would prefer not changing from DTC_FLAGS_testcases to DTC_FLAGS because
> the suppresses the warning for all unittest .dts files, not just the two
> that lead to the node_name_vs_property_name warning. These two cases can
> be covered with DTC_FLAGS_testcases and DTC_FLAGS_static_test_1.

Okay.

Rob
