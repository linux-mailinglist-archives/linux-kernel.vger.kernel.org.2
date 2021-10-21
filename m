Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB13435B1C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 08:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbhJUGvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 02:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhJUGvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 02:51:09 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F134BC06161C;
        Wed, 20 Oct 2021 23:48:52 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id z24so5252011qtv.9;
        Wed, 20 Oct 2021 23:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mNvxWtckYIaJV931ioym14Q5jqNR1mKAgWlKsIbIzrY=;
        b=NkQbrePiO+dBHQ9EvaNmEDupYsux/mvqQMa1GaCYmiycTjQJXAT1gAMc7VxaUVMeIl
         xFKQN3r3sN/FQycbzp2XPHz1vjhUy5BBfP1pZvOrpvgMRtVPz8RTH9cFoG+CHJVB5RyG
         XhxYmTcdIG7/Rt8AEgJrTlJTpgBAfwaL4kFII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mNvxWtckYIaJV931ioym14Q5jqNR1mKAgWlKsIbIzrY=;
        b=kwUULa7Fmal9WbgT8DDFTLbPuduh+5Q4y1mX6PEbfmnlHAFxtdEVnd+tPrPqx3uD42
         18kR3vSS3UFRpnHw6jxNPGm16s69ArYSNR6T1Ll1omXef792tHhVwdp7qncdwg/Qvanq
         K+z9NFckYp/Ns9EDr71P13SqPjJE4kkfLZ5t6ChwG9VUdfd3AY2PgsH9rVR97URgGrnN
         MinaO24xTsVSlriqSKrrg0OThl29HUuFSGCpfq/hkOwC9+XDG/h0M3DFjUjoBtMG+LRX
         o8TRfpb4A2FjZgOjvFYpckKv/Dvf8ESlV6viHjtxPcqpZEU1KVrPhvX54F10h2lMwq6G
         zHjQ==
X-Gm-Message-State: AOAM532/5Rbxtll97kGb1cofMBZIqToIpjyoSO8LpXmu6SBbrxDyeyAS
        kUHG8oeQ+FCWfFgS99dCwYZuimjxyC0XF9lSLec=
X-Google-Smtp-Source: ABdhPJzBXdMJj7nI0BKVHrtJsFRFYsv4NGS3cg0KW3U1+iTkclWXcGjaJNsdvv35wBUBca9PfSTZTpnV25AliumF8xI=
X-Received: by 2002:a05:622a:1006:: with SMTP id d6mr3975310qte.259.1634798932006;
 Wed, 20 Oct 2021 23:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210927023053.6728-1-chiawei_wang@aspeedtech.com>
 <20210927023053.6728-2-chiawei_wang@aspeedtech.com> <CACPK8Xc+9yFJn_pO1sAVQJu_FWkA1U9XnbB+TLYgfdbHi1TyaQ@mail.gmail.com>
 <CACPK8Xfj=wJBCX5ogyf02pLJsLrooVWBJ92GJ1E+jxQW5wiFEw@mail.gmail.com> <HK0PR06MB3779F430883E60E7E47849BE91BF9@HK0PR06MB3779.apcprd06.prod.outlook.com>
In-Reply-To: <HK0PR06MB3779F430883E60E7E47849BE91BF9@HK0PR06MB3779.apcprd06.prod.outlook.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 21 Oct 2021 06:48:40 +0000
Message-ID: <CACPK8Xc2wzx1dthFYC_0vm4mj9e1BbL+Kwkqc_PvPFj4sqjOJg@mail.gmail.com>
Subject: Re: [PATCH v7 1/5] ARM: dts: aspeed: Drop reg-io-width from LPC nodes
To:     ChiaWei Wang <chiawei_wang@aspeedtech.com>
Cc:     Andrew Jeffery <andrew@aj.id.au>, Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Oskar Senft <osk@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2021 at 06:37, ChiaWei Wang <chiawei_wang@aspeedtech.com> wrote:
>
> > From: Joel Stanley <joel@jms.id.au>
> > Sent: Thursday, October 21, 2021 2:29 PM
> >
> > On Fri, 8 Oct 2021 at 04:35, Joel Stanley <joel@jms.id.au> wrote:
> > >
> > > On Mon, 27 Sept 2021 at 02:31, Chia-Wei Wang
> > > <chiawei_wang@aspeedtech.com> wrote:
> > > >
> > > > The 'reg-io-width' properties are not used by LPC drivers nor
> > > > documented as part of bindings. Therefore drop them.
> > >
> > > I assume they are there due to the lpc having a 'syscon' compatible.
> > > THey are documented in the syscon bindings:
> > >
> > > Documentation/devicetree/bindings/mfd/syscon.yaml
> > >
> > > Andrew, do you have any comments?
> >
> > Andrew indicated to me that he agreed with my observation: the properties
> > should be present as they are used by the regmap/syscon.
>
> Thanks. Shall we just drop this one and move on with the rest patches?
> However, like Rob mentioned, when doing 'make dtbs_check', there is a warning:
>
> /builds/robherring/linux-dt-review/arch/arm/boot/dts/aspeed-ast2500-evb.dt.yaml:
> lpc@1e789000: 'ibt@140', 'kcs@114', 'kcs@24', 'kcs@28', 'kcs@2c', 'lhc@a0', 'reg-io-width' do not match any of the regexes:
> '^lpc-ctrl@[0-9a-f]+$', '^lpc-snoop@[0-9a-f]+$', '^reset-controller@[0-9a-f]+$', 'pinctrl-[0-9]+'
> From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
>
> As part of this series has been applied, maybe we can fix this later?

Yes, that's a good idea.

I will send a pull request with your driver to the soc maintainers.

Cheers,

Joel

>
> Regards,
> Chiawei
>
> >
> > >
> > > >
> > > > This is in preparation to move aspeed-lpc.txt to YAML schema.
> > > >
> > > > Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> > > > ---
> > > >  arch/arm/boot/dts/aspeed-g4.dtsi | 1 -
> > > > arch/arm/boot/dts/aspeed-g5.dtsi | 1 -
> > > > arch/arm/boot/dts/aspeed-g6.dtsi | 1 -
> > > >  3 files changed, 3 deletions(-)
> > > >
> > > > diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi
> > > > b/arch/arm/boot/dts/aspeed-g4.dtsi
> > > > index c5aeb3cf3a09..45a25eb4baa4 100644
> > > > --- a/arch/arm/boot/dts/aspeed-g4.dtsi
> > > > +++ b/arch/arm/boot/dts/aspeed-g4.dtsi
> > > > @@ -345,7 +345,6 @@
> > > >                         lpc: lpc@1e789000 {
> > > >                                 compatible =
> > "aspeed,ast2400-lpc-v2", "simple-mfd", "syscon";
> > > >                                 reg = <0x1e789000 0x1000>;
> > > > -                               reg-io-width = <4>;
> > > >
> > > >                                 #address-cells = <1>;
> > > >                                 #size-cells = <1>; diff --git
> > > > a/arch/arm/boot/dts/aspeed-g5.dtsi
> > > > b/arch/arm/boot/dts/aspeed-g5.dtsi
> > > > index 73ca1ec6fc24..8e1d00d8445e 100644
> > > > --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> > > > +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> > > > @@ -436,7 +436,6 @@
> > > >                         lpc: lpc@1e789000 {
> > > >                                 compatible =
> > "aspeed,ast2500-lpc-v2", "simple-mfd", "syscon";
> > > >                                 reg = <0x1e789000 0x1000>;
> > > > -                               reg-io-width = <4>;
> > > >
> > > >                                 #address-cells = <1>;
> > > >                                 #size-cells = <1>; diff --git
> > > > a/arch/arm/boot/dts/aspeed-g6.dtsi
> > > > b/arch/arm/boot/dts/aspeed-g6.dtsi
> > > > index 1b47be1704f8..0d1aae6887cd 100644
> > > > --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> > > > +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> > > > @@ -490,7 +490,6 @@
> > > >                         lpc: lpc@1e789000 {
> > > >                                 compatible =
> > "aspeed,ast2600-lpc-v2", "simple-mfd", "syscon";
> > > >                                 reg = <0x1e789000 0x1000>;
> > > > -                               reg-io-width = <4>;
> > > >
> > > >                                 #address-cells = <1>;
> > > >                                 #size-cells = <1>;
> > > > --
> > > > 2.17.1
> > > >
