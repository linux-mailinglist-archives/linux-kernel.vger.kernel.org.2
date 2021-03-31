Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD3534FB0F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 10:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbhCaIDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 04:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234062AbhCaID3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 04:03:29 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FBEC061574;
        Wed, 31 Mar 2021 01:03:28 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id g15so18521460qkl.4;
        Wed, 31 Mar 2021 01:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NJcIw73a//r28j1htif+6qunnsNeiLwQMekHuL3zxuc=;
        b=T/BjsSR2f4zCsI32B9vc+Fo0VhdeQ7uAqocnuUdCTzTRS2b8aqOi+l+XP+YZBKs8XO
         C22J8Ac2zQiQguWOjOdGqHaXIhAF781x/YZ6AGJWgYrMpkkVVcMhOe+3cIDAUHkwgTgL
         Q1Ay8yxsXn+jFIiLHipqKSgf835p4/9MfLpZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NJcIw73a//r28j1htif+6qunnsNeiLwQMekHuL3zxuc=;
        b=oG9igCNNh1+JQGX3JBeCKL5+G323VSEy+0nrWSVDL7UgY+GEBdueXx2Y83dgkKU+z6
         XztfnUIWPbXjxIONoouKouqzHgIrlgbVlmhks5MGIJ99y+slS1DzBM7DuMXWUC+y6uIc
         7A3gFcHQJTC7USjNCcT1+pcON6hHbm3EWhzY6OiITXZvQePAeUCVsIRlN287Ez668UdZ
         u9NzZL8m4ZHp2nKsQ6qGf31Cw+WsTqsM0GMnzP1ySNZCYpd5LeweqyPLJT+a4x0HUEkS
         93Hq83lMAQaPEDqunaiXG+Stthp9g+T4Dt3+LoXdiJ1iOHWXWsS4xs3Kl4n63F7HuJt7
         YjqQ==
X-Gm-Message-State: AOAM531WNa35X0E6617qUvvwaEICHal6AiOerhnLVsrlwfpAOH5oG+3C
        WTUvYJWO4Lt9d6wHkYBfNu9K9FF0HjtXrl4wVKg=
X-Google-Smtp-Source: ABdhPJwC6hlddgOP7Z7aBjcCddCYiFSG8M/SJxjKms1t4Jq6myn+rgd/kJbDtXxbvYj9JRVxaoZOy7H1q4e9l7echc0=
X-Received: by 2002:a05:620a:28c9:: with SMTP id l9mr1940310qkp.55.1617177807842;
 Wed, 31 Mar 2021 01:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210308171049.3962577-1-gmouse@google.com> <CADVsX8_e9GNeceV-op5HwbxEnzUG_68izC11K=g46YWvCZE2Ag@mail.gmail.com>
In-Reply-To: <CADVsX8_e9GNeceV-op5HwbxEnzUG_68izC11K=g46YWvCZE2Ag@mail.gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 31 Mar 2021 08:03:15 +0000
Message-ID: <CACPK8XfcHRkRew6O-r=BumPRAW5X8__k6XMy-4gnDhwxVqCVWg@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: nuvoton: Fix flash layout
To:     Anton Kachalov <gmouse@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anton,

On Thu, 25 Mar 2021 at 01:28, Anton Kachalov <gmouse@google.com> wrote:
>
> Gently ping
>
> On Mon, 8 Mar 2021 at 18:11, <gmouse@google.com> wrote:
> >
> > From: "Anton D. Kachalov" <gmouse@google.com>
> >
> > This change follows OpenBMC partitions' naming layout.
> >
> > Signed-off-by: Anton D. Kachalov <gmouse@google.com>

I believe you discussed what approach to take and this was agreed
upon. Can I get an ack from some other nuvoton people before I apply?

Cheers,

Joel

> > ---
> >  arch/arm/boot/dts/nuvoton-npcm750-evb.dts | 38 +++++++----------------
> >  1 file changed, 11 insertions(+), 27 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/nuvoton-npcm750-evb.dts b/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
> > index 9f13d08f5804..55c5a89592d7 100644
> > --- a/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
> > +++ b/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
> > @@ -78,8 +78,8 @@ partitions@80000000 {
> >                         compatible = "fixed-partitions";
> >                         #address-cells = <1>;
> >                         #size-cells = <1>;
> > -                       bbuboot1@0 {
> > -                               label = "bb-uboot-1";
> > +                       u-boot@0 {
> > +                               label = "u-boot";
> >                                 reg = <0x0000000 0x80000>;
> >                                 read-only;
> >                                 };
> > @@ -88,38 +88,22 @@ bbuboot2@80000 {
> >                                 reg = <0x0080000 0x80000>;
> >                                 read-only;
> >                                 };
> > -                       envparam@100000 {
> > -                               label = "env-param";
> > +                       u-boot-env@100000 {
> > +                               label = "u-boot-env";
> >                                 reg = <0x0100000 0x40000>;
> >                                 read-only;
> >                                 };
> > -                       spare@140000 {
> > -                               label = "spare";
> > -                               reg = <0x0140000 0xC0000>;
> > -                               };
> >                         kernel@200000 {
> >                                 label = "kernel";
> > -                               reg = <0x0200000 0x400000>;
> > -                               };
> > -                       rootfs@600000 {
> > -                               label = "rootfs";
> > -                               reg = <0x0600000 0x700000>;
> > -                               };
> > -                       spare1@D00000 {
> > -                               label = "spare1";
> > -                               reg = <0x0D00000 0x200000>;
> > -                               };
> > -                       spare2@0F00000 {
> > -                               label = "spare2";
> > -                               reg = <0x0F00000 0x200000>;
> > +                               reg = <0x0200000 0x580000>;
> >                                 };
> > -                       spare3@1100000 {
> > -                               label = "spare3";
> > -                               reg = <0x1100000 0x200000>;
> > +                       rofs@780000 {
> > +                               label = "rofs";
> > +                               reg = <0x0780000 0x1680000>;
> >                                 };
> > -                       spare4@1300000 {
> > -                               label = "spare4";
> > -                               reg = <0x1300000 0x0>;
> > +                       rwfs@1e00000 {
> > +                               label = "rwfs";
> > +                               reg = <0x1e00000 0x200000>;
> >                         };
> >                 };
> >         };
> > --
> > 2.30.1.766.gb4fecdf3b7-goog
> >
