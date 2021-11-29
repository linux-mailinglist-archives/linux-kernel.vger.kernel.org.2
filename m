Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F34460C89
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 03:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244150AbhK2CEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 21:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbhK2CC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 21:02:28 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19FAC061574
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 17:59:11 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id be32so31621116oib.11
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 17:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oeKwFtOiBgQzl0fM8a66LLg6cP1sgTL7B7UOAO86Ygs=;
        b=LqEXmA4+e4eHq/P18dbtKudm0MbeWQc+9MqB+9h6IHpAnqzWHJOJon8sNnGfJ8NcN9
         hEYJpHRc52Ab+CN9vXG+FAogW1/zOGTlivwVOZGxanmMFxLmEhaSLEspUORLejq/sSN0
         YpO8sZyifkCTdGKq7US6v+vM/6jO/WhKXjumFF+5WVT8vdJKLr5nbsTiJhoHGjQuBqz/
         Csao1B7QMPNwNyCPIDeXWjTf6nS2RzqYglYliOTF3cP8Ny21g6DmwHmSHmJ/CNB5+8pL
         P52bTo3sLAYOou9tk6ZGS2xlvAcYdARxSSbhP/ux/wo+OguHpBF78AWcs5Kp8UYltUet
         bd/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=oeKwFtOiBgQzl0fM8a66LLg6cP1sgTL7B7UOAO86Ygs=;
        b=sj4YMQsKz8GXkIAOZQANY8gC47Igw1JZ+EOsIGeu4UGXhHszkKy5kHN6JcMTtJawQ/
         MJl2KSlwLBZrxkrE5+O8hBTTVPo1m/xKj2cJPnUfgs7IqH/JWu+U+SqBopOFUyfCFaAl
         93l6qThT8s73vAqDbbYXqLduLuCjBko+tL8zFiuw/hCnnbdbL2IZd0xs+dv+lqUTbbz9
         JBAgUJdu2LR965Mj7SZ0wnuRiG455O84Y6zx/2IW4A7OxaQQNgnOVPgm7whVXcDUkg4U
         /EiuIEAyk+5PD2EA6TuLcgVXpXjlsrAUDIN7er/HYpx1h8+r1B8Q+49V9YGj+NpONaL9
         Jl9A==
X-Gm-Message-State: AOAM532YBK7S1JM4cCtOmJb4E0kmyzZ/Q/d111jKzX4KWRhPFzML5EPr
        xb3K2vA9UERTeUpQbGISl98=
X-Google-Smtp-Source: ABdhPJyb0p0V0x/lyRiV81628Ny7l/ti20uxDxDf9oT9EKoXmEjyl54HT/klAfj3pupIB8+o2YIXXA==
X-Received: by 2002:a54:4819:: with SMTP id j25mr37042266oij.66.1638151151166;
        Sun, 28 Nov 2021 17:59:11 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 16sm2678550oix.46.2021.11.28.17.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 17:59:10 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 28 Nov 2021 17:59:09 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: Linux 5.16-rc3
Message-ID: <20211129015909.GA921717@roeck-us.net>
References: <CAHk-=wgtC_D-irsmyC89JPE1mnAAGJTc8qaNwaqcNUrt66TDMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgtC_D-irsmyC89JPE1mnAAGJTc8qaNwaqcNUrt66TDMw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 28, 2021 at 02:21:20PM -0800, Linus Torvalds wrote:
> So rc3 is usually a bit larger than rc2 just because people had some
> time to start finding things.
> 
> So too this time, although it's not like this is a particularly big
> rc3. Possibly partly due to the past week having been Thanksgiving
> week here in the US. But the size is well within the normal range, so
> if that's a factor, it's not been a big one.
> 
> The diff for rc3 is mostly drivers, although part of that is just
> because of the removal of a left-over MIPS Netlogic driver which makes
> the stats look a bit wonky, and is over a third of the whole diff just
> in itself.
> 
> If you ignore that part, the statistics look a bit more normal, but
> drivers still dominate (network drivers, sound and gpu are the big
> ones, but there is noise all over). Other than that there's once again
> a fair amount of selftest (mostly networking), along with core
> networking, some arch updates - the bulk of it from a single arm64
> uaccess patch, although that's mostly because it's all pretty small -
> and random other changes.
> 
> Full shortlog below.
> 
> Please test,
> 

Build results:
	total: 153 pass: 152 fail: 1
Failed builds:
	mips:allmodconfig
Qemu test results:
	total: 482 pass: 482 fail: 0

Building mips:allmodconfig ... failed
--------------
Error log:
ERROR: modpost: missing MODULE_LICENSE() in drivers/pci/controller/pcie-mt7621.o
ERROR: modpost: "mips_cm_unlock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
ERROR: modpost: "mips_cpc_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
ERROR: modpost: "mips_cm_lock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
ERROR: modpost: "mips_cm_is64" [drivers/pci/controller/pcie-mt7621.ko] undefined!
ERROR: modpost: "mips_gcr_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!

There is still no fix for the mips:allmodconfig build problem as far
as I can see. It is a bit odd, because the fix would be as simple as

 config PCIE_MT7621
-	tristate "MediaTek MT7621 PCIe Controller"
-	depends on (RALINK && SOC_MT7621) || (MIPS && COMPILE_TEST)
+	bool "MediaTek MT7621 PCIe Controller"
+	depends on SOC_MT7621 || (MIPS && COMPILE_TEST)
 	select PHY_MT7621_PCI
 	default SOC_MT7621
 	help

Context: tristate doesn't make sense here because both RALINK and
SOC_MT7621 are bool. Also, RALINK is redundant because SOC_MT7621
already depends on it. The compile failure is due to missing exported
symbols, and it is only seen if PCIE_MT7621=m - which is only possible
if COMPILE_TEST=y. In other words, the dependencies above are set such
that test builds, and only test builds, fail.

The problem was introduced with commit 2bdd5238e756 ("PCI: mt7621:
Add MediaTek MT7621 PCIe host controller driver"). Copying some of
those responsible to see if we can expect a solution sometime soon.

Guenter
