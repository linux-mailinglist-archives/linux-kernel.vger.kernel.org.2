Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2A131D5DD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 08:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbhBQHpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 02:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbhBQHpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 02:45:44 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBF5C061574;
        Tue, 16 Feb 2021 23:45:03 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id r77so11905708qka.12;
        Tue, 16 Feb 2021 23:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gCYHkP1aaPC2ju2paPaY+eoqpfjSVcunRt30wEH2p8U=;
        b=AAHObVQGaERydM1DlwWubQJKTKTVnmQBfgoX0PGJn29iia5qcb/iGf1AoROZuZSqvl
         w+PMF3vUx06pWgQNfzENim4S9nkdJxlUW7hEpi6jIvu1/aO87i9jsX5dtWqRrJos722i
         NmAofX+BGRlEjlnFc/i1f4WoZSH26+35dlwUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gCYHkP1aaPC2ju2paPaY+eoqpfjSVcunRt30wEH2p8U=;
        b=B37HOIWPh9rX7M1MYITUSoECSwr0PXqnSOobchWKZjT7YZv23QmXFe/06YVCz6JUFx
         yXNe9Lfi0C691liTZlg+lhVTxNTdz44zNEV6h7+d4MDp15kbnyRrPiCDB+kV4XvUccde
         KBeR/GZ//KZMXd+b08zOWnofw+EKsvCN8xgrWmluR2FBAmiBo0f4+BsaEw3lSwivM2rI
         Zh0bDTddQ3ila/U9ohC0+H0+H7paqYqL1mG/QBFjoHSpUtphF/9o3TRMTk9yRODBJAEm
         BCmofcMb8b8f+TWzKi39alT3LtJCVO4Rc5zB4KLsLvLhg/AWNW//vv5KQpXNynrj/kH+
         QObw==
X-Gm-Message-State: AOAM531ve25XoGqAaIwtBkQvsMr5XRVE9FapwtreZGD6x/GefOnA6Yf9
        62EI6RNDBI/ihkcV66TREBFSBbNYHR0sb2stxrg=
X-Google-Smtp-Source: ABdhPJwZtu3Qq+3imBOs8bwV65/o2jyioHqrf93AnZbhcE4AEEgRRwSgKEqek1P9uLpKbbu/kI/mf9O2uP6SF4p1+PI=
X-Received: by 2002:a37:27d2:: with SMTP id n201mr19429138qkn.465.1613547903021;
 Tue, 16 Feb 2021 23:45:03 -0800 (PST)
MIME-Version: 1.0
References: <20210114131622.8951-1-chiawei_wang@aspeedtech.com>
 <20210114131622.8951-2-chiawei_wang@aspeedtech.com> <85f00459-4a39-441e-8119-8e12f8132cfe@www.fastmail.com>
 <HK0PR06MB3779B25984A461E4A1ADEF1191869@HK0PR06MB3779.apcprd06.prod.outlook.com>
In-Reply-To: <HK0PR06MB3779B25984A461E4A1ADEF1191869@HK0PR06MB3779.apcprd06.prod.outlook.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 17 Feb 2021 07:44:50 +0000
Message-ID: <CACPK8XdFLKg9k6snLSZrRzorxBeg1fLoqakm6J_8VCXh_=JEQA@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] dt-bindings: aspeed-lpc: Remove LPC partitioning
To:     ChiaWei Wang <chiawei_wang@aspeedtech.com>
Cc:     Andrew Jeffery <andrew@aj.id.au>, Lee Jones <lee.jones@linaro.org>,
        BMC-SW <BMC-SW@aspeedtech.com>,
        Haiyue Wang <haiyue.wang@linux.intel.com>,
        Robert Lippert <rlippert@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Corey Minyard <minyard@acm.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chaiwei,

On Wed, 17 Feb 2021 at 07:40, ChiaWei Wang <chiawei_wang@aspeedtech.com> wrote:
>
> Hi All,
>
> Do you have update on this patch series?
> Aspeed has subsequent LPC module upstream plan.
> We hope that the following patches can be on the basis of the fixed LPC layout.

Andrew has expressed his support for your changes. I will take time to
closely review your proposal this week.

We will set the goal of having this rework merged for the next merge window.

Cheers,

Joel


> Thanks.
>
> Chiawei
>
> > -----Original Message-----
> > From: Andrew Jeffery <andrew@aj.id.au>
> > Sent: Wednesday, January 27, 2021 8:25 AM
> > To: Lee Jones <lee.jones@linaro.org>
> > Subject: Re: [PATCH v5 1/5] dt-bindings: aspeed-lpc: Remove LPC partitioning
> >
> >
> >
> > On Thu, 14 Jan 2021, at 23:46, Chia-Wei, Wang wrote:
> > > The LPC controller has no concept of the BMC and the Host partitions.
> > > This patch fixes the documentation by removing the description on LPC
> > > partitions. The register offsets illustrated in the DTS node examples
> > > are also fixed to adapt to the LPC DTS change.
> > >
> > > Signed-off-by: Chia-Wei, Wang <chiawei_wang@aspeedtech.com>
> >
> > Any thoughts Lee? If you ack it would you be happy for the patch to go through
> > the Aspeed tree?
> >
> > Andrew
