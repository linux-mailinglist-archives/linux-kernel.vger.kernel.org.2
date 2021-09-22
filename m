Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC73413FC4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 04:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhIVCup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 22:50:45 -0400
Received: from out0.migadu.com ([94.23.1.103]:26640 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230229AbhIVCun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 22:50:43 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1632278953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SP3h9uvIfQUYyLgWGd0dYYt1XTjq02DEM9WtTipdzus=;
        b=AIgWb197+pb8H0WDkh0Ks1zqTEX0Fox34J3FV6wKYbPo589pBxczqyIavGAS8hGqdBOwSp
        hNMbPkCN2nQqIu6PcjWxaD5aeWH9N9lseQNYH3DxWMBjb4MV3/paql8a6SIgyuIcwAw+Jb
        RaL710wMrAu4kEQKdjI/G7YrdEQM1ZU=
Date:   Wed, 22 Sep 2021 02:49:13 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   yajun.deng@linux.dev
Message-ID: <b821ee0489f71a90a74c1d905c4fa530@linux.dev>
Subject: Re: [PATCH linux-next v2] arm64: PCI: Introduce
 pcibios_free_irq() helper function
To:     "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210921154731.GA2756@lpieralisi>
References: <20210921154731.GA2756@lpieralisi>
 <20210826060406.12571-1-yajun.deng@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: yajun.deng@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

September 21, 2021 11:47 PM, "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.c=
om> wrote:=0A=0A> On Thu, Aug 26, 2021 at 02:04:06PM +0800, Yajun Deng wr=
ote:=0A> =0A>> pcibios_alloc_irq() will be called in pci_device_probe(), =
but there=0A>> hasn't pcibios_free_irq() in arm64 architecture correspond=
 it.=0A>> pcibios_free_irq() is an empty weak function in drivers/pci/pci=
-driver.c.=0A> =0A> "pcibios_alloc_irq() is a weak function called to all=
ocate IRQs for=0A> a device in pci_device_probe(); arm64 implements it wi=
th=0A> ACPI specific code to enable IRQs for a device.=0A> =0A> When a de=
vice is removed (pci_device_remove()) the pcibios_free_irq()=0A> counterp=
art is called.=0A> =0A> Current arm64 code does not implement a pcibios_f=
ree_irq() function,=0A> and therefore, the weak empty stub is executed, w=
hich means that the=0A> IRQ for a device are not properly disabled when a=
 device is removed.=0A> =0A> Add an arm64 pcibios_free_irq() to undo the =
actions carried out in=0A> pcibios_alloc_irq()."=0A> =0A> This is a stub =
commit log. Then you need to describe the bug you=0A> are fixing (if any,=
 or it is just code inspection ?)=0A> =0AIt is just code inspection.=0A>>=
 So add pcibios_free_irq() for correspond it. This will be called=0A>> in=
 pci_device_remove().=0A>> =0A>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=0A>> v2: remove the change in pcibios_alloc_irq(), =
and modify the commit log.=0A>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=0A> =0A> Don't add versioning in the commit log, it=
 does not belong here.=0A> =0A> I don't think we should send this to stab=
le kernels straight away,=0A> it is best to make sure we are not triggeri=
ng any regressions first.=0A> =0A> Lorenzo=0A> =0A>> Signed-off-by: Yajun=
 Deng <yajun.deng@linux.dev>=0A>> ---=0A>> arch/arm64/kernel/pci.c | 7 ++=
+++++=0A>> 1 file changed, 7 insertions(+)=0A>> =0A>> diff --git a/arch/a=
rm64/kernel/pci.c b/arch/arm64/kernel/pci.c=0A>> index 2276689b5411..6ffd=
92126f65 100644=0A>> --- a/arch/arm64/kernel/pci.c=0A>> +++ b/arch/arm64/=
kernel/pci.c=0A>> @@ -29,6 +29,13 @@ int pcibios_alloc_irq(struct pci_dev=
 *dev)=0A>> =0A>> return 0;=0A>> }=0A>> +=0A>> +void pcibios_free_irq(str=
uct pci_dev *dev)=0A>> +{=0A>> + if (!acpi_disabled)=0A>> + acpi_pci_irq_=
disable(dev);=0A>> +}=0A>> +=0A>> #endif=0A>> =0A>> /*=0A>> --=0A>> 2.32.=
0
