Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAD73BA2FA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 17:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbhGBP7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 11:59:38 -0400
Received: from mailgate.ics.forth.gr ([139.91.1.2]:62155 "EHLO
        mailgate.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbhGBP7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 11:59:36 -0400
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 162Fv1PL051420
        for <linux-kernel@vger.kernel.org>; Fri, 2 Jul 2021 18:57:01 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1625241416; x=1627833416;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=t0VSE4yvqzLzoGTJTNfADyTmW4ylvlyixsQMnViMXlE=;
        b=W1poDQWGMNUQdc02AMMYJSW6C6qUeRH/acUywkO/d4MD5tgcU/o9zF5+Py8WOclL
        trm5ZmcrwwzVK4p6jn0HpS5Fu2EVOWe5rdrsVUK5f4m856HJfHqlCAdFhMIzc8Mw
        qlXFnflYUcFaIFRQLtnAtTpR/RFAVQ6p2k+US/xgkE0dRnOb1QNb3VWB1skgzSuU
        IRGY4LBskN2z22ucXLRJ1hYPbxIYMyPjjcKxCvwTAikA6OF4CSPO5UuuqhQsc+B3
        hMWF7K5VDUgEyqADTZetuUeeyG9M8AujzOnpBfW+Nde7H1TsvLDIagHEjYiRLTXO
        zYReTKkrXBgvg7WKpeXrFQ==;
X-AuditID: 8b5b014d-96ef2700000067b6-a9-60df37486b8d
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id F8.F9.26550.8473FD06; Fri,  2 Jul 2021 18:56:56 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 02 Jul 2021 18:56:55 +0300
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     robh+dt@kernel.org, mick@ics.forth.gr, geert@linux-m68k.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, frowand.list@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] riscv: Remove non-standard linux,elfcorehdr handling
Organization: FORTH
In-Reply-To: <mhng-6db38728-4f82-45bd-9b17-c41da55c41e9@palmerdabbelt-glaptop>
References: <mhng-6db38728-4f82-45bd-9b17-c41da55c41e9@palmerdabbelt-glaptop>
Message-ID: <008ddfd79d256dcddd7c802e4eef6b5a@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.3.16
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42Lpjp6urOthfj/B4Mh+YYutv2exW7xf1sNo
        Mf/IOVaLmW/+s1k8u7WXyWLT42usFpd3zWGz2Pa5hc2i+d05douXl3uYLdpm8Vu07j3CbtFy
        x9SB12PNvDWMHm9evmTxONzxhd1j56y77B4PN11i8ti0qpPN49DhDkaPzUvqPS41X2f3+LxJ
        LoArissmJTUnsyy1SN8ugSvjVvNy5oJNghULWjuYGxj7+boYOTkkBEwk+tr3sXQxcnEICRxl
        lOhvuMQGkTCVmL23kxHE5hUQlDg58wkLiM0sYCEx9cp+RghbXqJ562xmEJtFQFXi2cmLYHE2
        AU2J+ZcOgtWLCKhLHHh9hxmi/iWTxK6/VSC2sICvxK+ZF9lBbH4BYYlPdy+ygticAn4SHS92
        Ad3AAXSQr8Tn6yYQJ7hI/N38lBXiNBWJD78fsIOUiALZm+cqTWAUnIXk0FlIDp2F5NAFjMyr
        GAUSy4z1MpOL9dLyi0oy9NKLNjGC44rRdwfj7c1v9Q4xMnEwHmKU4GBWEuENnXcvQYg3JbGy
        KrUoP76oNCe1+BCjNAeLkjgvr96EeCGB9MSS1OzU1ILUIpgsEwenVANT/6/LD0RTd+2v8D9Z
        96Z3S0fekS9aMs67BYLYbdo39SwyOb71rcM7LbW/DE0f7yo+992sIJvzO3rFnXaPTc1XGXZd
        ibz3dnrZef6tL765b70Y5RJqo79CNCzt6LO95r9nch91W/XLfW3P3lJxpZUb80ILRHPFDedZ
        HLm3siqiTjDszu8nuRosz+qVGDylIr1qfLoELjG9/aGksoN58q9So0tdp1jC/EqrNnW2boiV
        TZu+hV9l9dof9b1bCs+YbHvg49p+yMV/WhnrLLvJnHuU+2/9PJX74Uhb2baj36uLJ3Nv3PSQ
        XUT/SWbUT3EG1ZvJEa+eVJ3u1J2ulHjnuyyP+okfd4OCjFuzj3pE5hUqsRRnJBpqMRcVJwIA
        3+AlDBoDAAA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Στις 2021-07-01 05:52, Palmer Dabbelt έγραψε:
> On Wed, 16 Jun 2021 07:47:46 PDT (-0700), robh+dt@kernel.org wrote:
>> On Wed, Jun 16, 2021 at 4:43 AM Nick Kossifidis <mick@ics.forth.gr> 
>> wrote:
>>> 
>>> Στις 2021-06-16 10:56, Geert Uytterhoeven έγραψε:
>>> >
>>> > I can't comment on the duplication on arm64, but to me, /chosen
>>> > sounds like the natural place for both "linux,elfcorehdr" and
>>> > "linux,usable-memory-range".  First rule of DT is "DT describes
>>> > hardware, not software policy", with /chosen describing some software
>>> > configuration.
>>> >
>>> 
>>> We already have "linux,usable-memory" on /memory node:
>>> https://elixir.bootlin.com/linux/v5.13-rc6/source/drivers/of/fdt.c#L1011
>>> and it makes perfect sense to be there since it overrides /memory's 
>>> reg
>>> property.
>>> 
>>> Why define another binding for the same thing on /chosen ?
>> 
>> Go look at the thread adding "linux,usable-memory-range". There were
>> only 35 versions of it[1]. I wasn't happy with a 2nd way either, but
>> as I've mentioned before we don't always have /memory node.
> 
> I don't really understand what's going on here, but IIUC what I merged
> in 5.13 doesn't match the behavior that other architectures have.  In
> that case I'm happy moving RISC-V over to the more standard way of
> doing things and just calling what we have in 5.13 a screwup.
> 
> Sorry for the confusion.

Long story short:

a) We use "linux,usable-memory" on /memory node to limit the memory of 
the kdump kernel, it's a standard binding defined at:
https://elixir.bootlin.com/linux/v5.13-rc6/source/drivers/of/fdt.c#L1011

b) We used a reserved region (again a standard binding) named 
"linux,elfcorehdr" which has the same name as a property on /chosen used 
by arm64 for the same thing. With this patch we 'll use arm64's 
approach, although it's a bit worse since we'll need to add the same 
region twice on the fdt (once in /chosen as a property and another one 
in the reservation map so that it gets reserved during early boot).

Fortunately I (still) haven't posted the kexec-tools patches on the 
mailing list so we don't break userspace by doing this.
