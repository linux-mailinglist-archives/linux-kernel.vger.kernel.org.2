Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD0343FD45
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 15:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbhJ2NTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 09:19:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:39242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229603AbhJ2NTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 09:19:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 03BB961177;
        Fri, 29 Oct 2021 13:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635513399;
        bh=RiA7v1UBw9bN85yztLRB2RKleXrpK0l0Cd+7QnD9leY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Yarp0kQCNE+EG0rFEoofE1AuKzcmUjWKynudNPh8dKdmbMCfIKy9oydTWhsAvgeVl
         +lKsutatCom53T0ZvT4SMtsziM3O2XsJeOGN7WkCkO2FbiIfDXN31kwmyuOiW3PiyJ
         ZkE+ijThFLp35gISDCAwldrkJ3PALUGpcS9WsxMuoz12tqf9eXMxgplodaar0NUtSX
         NBpVqL4u4JgGnmAGb9qas+iXnzrOqoMTyFGWjBAdXFpGfT8dcwlQbBeBwCOnvz2CAP
         JWFZt39BO3xR5ZnJaiGscn0r7E9iLkm5/Z59z9ZWH7mxi/phIjqgVwt+X6FIp/vu9z
         mW7wubYV3CfLA==
Received: by mail-ed1-f53.google.com with SMTP id w15so38685031edc.9;
        Fri, 29 Oct 2021 06:16:38 -0700 (PDT)
X-Gm-Message-State: AOAM5308U27S/+bjV6FeYHtvI+j+CPOmatrW6OM8a7GxHv+5z1iXvk+4
        X+ACBDwY6FDUtR5SuxMBLD9AIt3pijaiGBqJhQ==
X-Google-Smtp-Source: ABdhPJyOLH6l45ltb4SfKRRdLuabWqV3OWUGmPX9aWDIzlIp6GcBJWOo0KFheQcnkS09ZjdwlmPQhbLND7TBzXxOGYA=
X-Received: by 2002:a05:6402:206b:: with SMTP id bd11mr15475405edb.145.1635513397430;
 Fri, 29 Oct 2021 06:16:37 -0700 (PDT)
MIME-Version: 1.0
References: <20211029005802.2047081-1-frowand.list@gmail.com>
 <CAL_JsqJujq0K9tF+m3qQ5GhC-yo7-vj9HRhF69UmrWA7tZv7DA@mail.gmail.com> <e353b41d-48f9-5349-8b89-bafe9ab5101e@gmail.com>
In-Reply-To: <e353b41d-48f9-5349-8b89-bafe9ab5101e@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 29 Oct 2021 08:16:24 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJi8h+DnnZCb-S2apDfMGF6PimQC+ViXB+X0oa4fWPcJg@mail.gmail.com>
Message-ID: <CAL_JsqJi8h+DnnZCb-S2apDfMGF6PimQC+ViXB+X0oa4fWPcJg@mail.gmail.com>
Subject: Re: [PATCH 1/1] of: unittest: fix dts for interrupt-map provider
 build warning
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 10:07 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 10/28/21 9:07 PM, Rob Herring wrote:
> > On Thu, Oct 28, 2021 at 7:58 PM <frowand.list@gmail.com> wrote:
> >>
> >> From: Frank Rowand <frank.rowand@sony.com>
> >>
> >> Fix kernel build warning:
> >> drivers/of/unittest-data/tests-interrupts.dtsi:32.26-35.6: Warning (interrupt_map): /testcase-data/interrupts/intmap1: Missing '#address-cells' in interrupt-map provider
> >>
> >> A recently implemented dtc compiler warning reported the dts problem.
> >>
> >> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> >> ---
> >>  drivers/of/unittest-data/tests-interrupts.dtsi | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/of/unittest-data/tests-interrupts.dtsi b/drivers/of/unittest-data/tests-interrupts.dtsi
> >> index 9b60a549f502..8c2b91b998aa 100644
> >> --- a/drivers/of/unittest-data/tests-interrupts.dtsi
> >> +++ b/drivers/of/unittest-data/tests-interrupts.dtsi
> >> @@ -31,6 +31,7 @@ test_intmap0: intmap0 {
> >>
> >>                         test_intmap1: intmap1 {
> >>                                 #interrupt-cells = <2>;
> >> +                               #address-cells = <1>;
> >
> > Notice that we have 2 nodes with interrupt-map here. One has
> > '#address-cells' and one doesn't. Why? Because we need to test that
> > the code can handle both cases.>
> > The dtc warnings are more what should 'new' users do. I don't know
> > what DTs don't have #address-cells, but my guess is ancient ones.
> >
> > Rob
> >
>
> I had hoped to build all of the .dts files in the Linux tree, with the
> new dtc, but did not get to that today.  That should flush out any
> cases that would result in build fail from the new approach of treating
> all warnings as errors.  I may get to that tomorrow.

They are still just warnings. You mean the requirement to be warning
free? That's not new for dts files.

> If there any any existing .dts files that will trigger the interrupt
> map warning, will we require that they be fixed so that the build will
> not fail?

I already submitted patches for them.

Rob
