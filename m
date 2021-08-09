Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 066A73E4A2A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 18:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbhHIQpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 12:45:25 -0400
Received: from ixit.cz ([94.230.151.217]:45802 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232861AbhHIQpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 12:45:22 -0400
Received: from [127.0.0.1] (cst-prg-2-105.cust.vodafone.cz [46.135.2.105])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 873E72029F;
        Mon,  9 Aug 2021 18:44:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1628527499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E7/JxJCF3I8htGj5otgSU4ms7oBD7De+MejPb+8N/4E=;
        b=CuHLbyf0xTsbbSzeLV5IlS9kVT42IVAhLyhjH6dzxdM26C8VHjPAU50jgxgVdXeQs77GYN
        MsxFveLC74goWguOaxQ9YQ93Qsq/1P2/yrAxfKU48xIOgMkB/rN6HZaOszcti2PjWn4yEU
        FY6SzZSTAy/WHco6QYw1EKGA6YV6vMU=
Date:   Mon, 09 Aug 2021 16:44:57 +0000
From:   David Heidelberg <david@ixit.cz>
To:     Arnd Bergmann <arnd@arndb.de>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>
CC:     Jon Medhurst <tixy@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Nicolas Pitre <nico@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: atags_to_fdt: don't warn about stack size
In-Reply-To: <CAK8P3a0qB3Nj8-wKPiAJvPrnH9LZjeXdkQA1MfS998RYk5foRA@mail.gmail.com>
References: <20210809151021.5137-1-david@ixit.cz> <20210809152421.GU22278@shell.armlinux.org.uk> <CAK8P3a0qB3Nj8-wKPiAJvPrnH9LZjeXdkQA1MfS998RYk5foRA@mail.gmail.com>
Message-ID: <21CA0122-5D3C-4375-93DB-564126F1E352@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you, in next iteration I'll keep you as author and keep your S-off-by


-------- P=C5=AFvodn=C3=AD zpr=C3=A1va --------
Odes=C3=ADlatel: Arnd Bergmann <arnd@arndb=2Ede>
Odesl=C3=A1no: 9=2E srpna 2021 16:02:36 UTC
Komu: "Russell King (Oracle)" <linux@armlinux=2Eorg=2Euk>
Kopie: David Heidelberg <david@ixit=2Ecz>, Arnd Bergmann <arnd@arndb=2Ede>=
, Jon Medhurst <tixy@linaro=2Eorg>, Ard Biesheuvel <ard=2Ebiesheuvel@linaro=
=2Eorg>, Marc Zyngier <marc=2Ezyngier@arm=2Ecom>, Nicolas Pitre <nico@linar=
o=2Eorg>, Linux Kernel Mailing List <linux-kernel@vger=2Ekernel=2Eorg>, Lin=
ux ARM <linux-arm-kernel@lists=2Einfradead=2Eorg>
P=C5=99edm=C4=9Bt: Re: [PATCH] ARM: atags_to_fdt: don't warn about stack s=
ize

On Mon, Aug 9, 2021 at 5:24 PM Russell King (Oracle)
<linux@armlinux=2Eorg=2Euk> wrote:
> On Mon, Aug 09, 2021 at 05:10:21PM +0200, David Heidelberg wrote:
> > Signed-off-by: David Heidelberg <david@ixit=2Ecz>

Acked-by: Arnd Bergmann <arnd@arndb=2Ede>

(or keep my original Signed-off-by if you like)

> I assume Arnd never sent his v3 from what I see in the thread you link
> to above=2E

Yes, it's in my ever-growing backlog of things I plan to eventually resubm=
it=2E

In this case, I actually have a different patch in my tree, but that in tu=
rn
depends on other stuff I have to submit first (reorganizing the way that
warning options get handled based on compiler version etc), and the
version here is what works on current mainline kernels=2E

     Arnd

S pozdravem a p=C5=99=C3=A1n=C3=ADm kr=C3=A1sn=C3=A9ho dne
David Heidelberg
