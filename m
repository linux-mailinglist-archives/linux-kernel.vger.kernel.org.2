Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 907713F73A3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbhHYKuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbhHYKuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:50:04 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE605C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 03:49:17 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1629888555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OrNb43ZzSHz1Ze2clgfxoPvFEQ2+7dJpVKQAD7qnx7I=;
        b=JKJ+QuQRviHy0cvSQpODpDsx4XmJTCduVHWkLrogEUa5j0E32QweP4vlygptiilpSTY0HG
        cz/r4rtJnIzLPTZRGkRagjPtQQiBon98aJkvRiyk9Hs1qczUNRnUt2+5wOdyiw4NUXJPgS
        plz7/cZvZBubgOHFxQ/VISrgOtQSs0M=
Date:   Wed, 25 Aug 2021 10:49:14 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   yajun.deng@linux.dev
Message-ID: <01d7cf96c63c05097ef28789e2e27d6f@linux.dev>
Subject: Re: [PATCH linux-next] arm64: PCI: Introduce pcibios_free_irq()
 helper function
To:     "Will Deacon" <will@kernel.org>
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com
In-Reply-To: <20210825100500.GC24546@willie-the-truck>
References: <20210825100500.GC24546@willie-the-truck>
 <20210825071612.21543-1-yajun.deng@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: yajun.deng@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

August 25, 2021 6:05 PM, "Will Deacon" <will@kernel.org> wrote:=0A=0A> [+=
Lorenzo]=0A> =0A> On Wed, Aug 25, 2021 at 03:16:12PM +0800, Yajun Deng wr=
ote:=0A> =0A>> Introduce pcibios_free_irq() to free irq in pci_device_pro=
be() and=0A>> pci_device_remove() that in drivers/pci/pci-driver.c.=0A> =
=0A> Please can you describe the problem you're solving?=0A> =0A=0Apcibio=
s_alloc_irq() will be called in pci_device_probe(), but there hasn't pcib=
ios_free_irq()=0Ain arm64 architecture correspond it. pcibios_free_irq() =
is an empty function in =0Adrivers/pci/pci-driver.c.So pcibios_alloc_irq(=
) and pcibios_free_irq() don't correspond.=0A=0A>> Signed-off-by: Yajun D=
eng <yajun.deng@linux.dev>=0A>> ---=0A>> arch/arm64/kernel/pci.c | 10 +++=
++++++-=0A>> 1 file changed, 9 insertions(+), 1 deletion(-)=0A>> =0A>> di=
ff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c=0A>> index 1=
006ed2d7c60..40da5aff4548 100644=0A>> --- a/arch/arm64/kernel/pci.c=0A>> =
+++ b/arch/arm64/kernel/pci.c=0A>> @@ -25,10 +25,18 @@=0A>> int pcibios_a=
lloc_irq(struct pci_dev *dev)=0A>> {=0A>> if (!acpi_disabled)=0A>> - acpi=
_pci_irq_enable(dev);=0A>> + return acpi_pci_irq_enable(dev);=0A> =0A> Th=
is means we'll now fail device probe if we can't enable the GSI. Is that =
a=0A> problem?=0A> =0AOh, It would be better that hasn't return.=0A> Will
