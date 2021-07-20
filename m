Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4BCC3D0531
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 01:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbhGTWip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 18:38:45 -0400
Received: from foss.arm.com ([217.140.110.172]:40802 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234240AbhGTWiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 18:38:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22F281FB;
        Tue, 20 Jul 2021 16:18:40 -0700 (PDT)
Received: from slackpad.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 855D03F694;
        Tue, 20 Jul 2021 16:18:38 -0700 (PDT)
Date:   Wed, 21 Jul 2021 00:18:03 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        Ali Saidi <alisaidi@amazon.com>,
        Jon Nettleton <jon@solid-run.com>
Subject: Re: [PATCH v2] hwrng: Add Arm SMCCC TRNG based driver
Message-ID: <20210721001803.303dfba1@slackpad.fritz.box>
In-Reply-To: <e494866f38e9dcd2834971d3867244fb1d7e6ceb.camel@kernel.crashing.org>
References: <20210720152158.31804-1-andre.przywara@arm.com>
        <CAMj1kXEW7DT3P3FuV+poFykf6wwm4FTJuV6emGSWabCp7UZX9A@mail.gmail.com>
        <20210720171631.071f84f5@slackpad.fritz.box>
        <e494866f38e9dcd2834971d3867244fb1d7e6ceb.camel@kernel.crashing.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jul 2021 08:02:42 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

Hi,

> On Tue, 2021-07-20 at 17:16 +0100, Andre Przywara wrote:
> > Yes, a similar idea was already brought up before. I think there is even
> > the potential for something like an artificial SMCCC "bus", where those
> > services presentable as devices could be auto-detected (by checking
> > known function IDs), the respective drivers would then probe
> > automatically?  
> 
> Sounds like a boot time killer...

How so? To be clear, at the moment there is basically just the TRNG
service we would probe for, maybe FF-A, then adding as we go. But in
any case it would be just a handful, and querying is very quick
(SMC/HVC, then just a switch/case on the other side, and ERET).
Is there any particular scenario you are concerned about? Quick
starting guests?

> can we instead describe them in DT and/or ACPI ?

I think part of the idea of SMCCC is that it does NOT need firmware
advertisement, but can instead be discovered, through a safe interface.

Cheers,
Andre
