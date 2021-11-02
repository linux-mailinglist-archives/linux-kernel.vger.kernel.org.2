Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26CFC442EA4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 13:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbhKBNCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 09:02:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:57508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231234AbhKBNBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 09:01:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A966760FC2
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 12:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635857955;
        bh=TLibQ2sAtuchOSgK2Ni0etFgDHTzqtxTyTAAiZxTceE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aaQFcL3qnIXciIl/fTtzlBFPb6ORcVMS3N2OHXBQFtITOM7WilAGSG8girIB7gK65
         UmQcFUsjDIMBcQa1RuwlUBYYzxP2plLjaZ5KJdEny3JmvuuyrKo05SZIpuhmyQxxah
         KnSgDaweQ8r8E0Cj0nD2H+eptIhPD2i76f4yToaVx1JdEsivUPNk1l4YsckfXBotiu
         6Ek6eIjJhuUeaKeeREPpug/o+eVNHzHNDdoH2q0WNzsEPWiq7XtuYq4wEESkaOHvGl
         5wS2UCLXoMUhULkcP4M/Mq7YjC/1NZ0zUtFvo6wewC8gVia4kV4iEO18OOvBv7ATiO
         BOTJ7VFO0C+Jw==
Received: by mail-ed1-f48.google.com with SMTP id z20so76034415edc.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 05:59:15 -0700 (PDT)
X-Gm-Message-State: AOAM531EY4tNdgyx9OmuWog/Npbo57Y4gimmtdcpkwvtNk3JI7mMezBp
        Lylk8+73HaGik/2yWfhzPhM0ZGlxiAta8l3fdg==
X-Google-Smtp-Source: ABdhPJwmer+eSqw0gozwh3gsBtNEiNXEBI/Ss90zfBiPdnFU6tby1sbtEINC2SPnN4GARQFGAiiVNk39RYtRrUishEk=
X-Received: by 2002:a17:907:980d:: with SMTP id ji13mr17255292ejc.466.1635857954130;
 Tue, 02 Nov 2021 05:59:14 -0700 (PDT)
MIME-Version: 1.0
References: <20211024013303.3499461-1-guoren@kernel.org> <20211024013303.3499461-2-guoren@kernel.org>
 <CAJF2gTSDTXu7HsABTHfTbCd2TNpHBpzSMqYGh9Av8kzJ+6AOPw@mail.gmail.com>
In-Reply-To: <CAJF2gTSDTXu7HsABTHfTbCd2TNpHBpzSMqYGh9Av8kzJ+6AOPw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 2 Nov 2021 07:59:02 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKRizEaqmgVnfMWr2A_AHMFLjDpYNTHahTLPgSAtGYCLg@mail.gmail.com>
Message-ID: <CAL_JsqKRizEaqmgVnfMWr2A_AHMFLjDpYNTHahTLPgSAtGYCLg@mail.gmail.com>
Subject: Re: [PATCH V5 1/3] dt-bindings: vendor-prefixes: add T-Head Semiconductor
To:     Guo Ren <guoren@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 1, 2021 at 9:21 PM Guo Ren <guoren@kernel.org> wrote:
>
> Hi Rob,
>
> ping? If there is no problem, could you help pick up this patch into your tree?

Generally DT patches go with the rest of the series. And you need to
send them to the DT list so that automated checks run and they are in
my review queue.

>
> On Sun, Oct 24, 2021 at 9:33 AM <guoren@kernel.org> wrote:
> >
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Add vendor prefix for T-Head Semiconductor [1] [2]
> >
> > [1] https://github.com/T-head-Semi
> > [2] https://www.t-head.cn/
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > index a867f7102c35..f532a8830693 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > @@ -1169,6 +1169,8 @@ patternProperties:
> >      description: Terasic Inc.
> >    "^tfc,.*":
> >      description: Three Five Corp
> > +  "^thead,.*":
> > +    description: T-Head Semiconductor Co., Ltd.
> >    "^thine,.*":
> >      description: THine Electronics, Inc.
> >    "^thingyjp,.*":
> > --
> > 2.25.1
> >
>
>
> --
> Best Regards
>  Guo Ren
>
> ML: https://lore.kernel.org/linux-csky/
