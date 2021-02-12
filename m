Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA7731A609
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 21:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhBLU2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 15:28:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:53202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229889AbhBLU2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 15:28:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A4D2B60200
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 20:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613161677;
        bh=O/X9dQZjDHQ2ePUZVKlmVj75JsQK8KDiPGA0G3MUFlA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NOPubWmEWQunBZaOFbYIA9f5UIrEMRXDM/v5LLsV7sTpFAsmflJOqRANt1jRdJ90m
         ZOrj6bEm2ohSpzza4OwMAYx36RWDqE7aCTTRfu49qJ24eao5nPl607f9Bs558APnnb
         ddZ4n8yZOukhTpjF9uh/vWZggd4x/gzYXLxWkaK0a8e6DwLcmPoHGsOv8Yz6R0Sdxp
         7UXj5hsnbLdN3IlNaogcwuCtPf2hL2fqyMpsnDdYQKacbrlHXhAjNz77AIoEHkOrW1
         bZld0+42DDboLe8T8+a5iRm0+7oazl5kH7twOE/UfLbKk0KUHtGAJxYrp+SvuoUP/n
         aPu8l0D4WtmqQ==
Received: by mail-oo1-f45.google.com with SMTP id h38so147222ooi.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 12:27:57 -0800 (PST)
X-Gm-Message-State: AOAM533COEZYJDbkOF3DZRZb2y6nmE/6AaPz/YQh3ZeJv8OooTCNJRDo
        HDPSW5MSZoLppNI7YjdiiGP2lKJs8c77lBA544U=
X-Google-Smtp-Source: ABdhPJwdWCY0ZYV8jTwHm+v0bd8w5OK7jKTRI1cjUJfaTmylBVuMAmZ68+INgpdTLBww3VP6PXNQAqwdaE/zltRzszo=
X-Received: by 2002:a4a:88c9:: with SMTP id q9mr3272717ooh.26.1613161676970;
 Fri, 12 Feb 2021 12:27:56 -0800 (PST)
MIME-Version: 1.0
References: <1613158348-19976-1-git-send-email-mihai.carabas@oracle.com> <1613158348-19976-2-git-send-email-mihai.carabas@oracle.com>
In-Reply-To: <1613158348-19976-2-git-send-email-mihai.carabas@oracle.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 12 Feb 2021 21:27:41 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1jNcy3d6amPwwF-FDGW41zjMUis20MbSN2O=RSABYuXA@mail.gmail.com>
Message-ID: <CAK8P3a1jNcy3d6amPwwF-FDGW41zjMUis20MbSN2O=RSABYuXA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] misc/pvpanic: split-up generic and platform
 dependent code
To:     Mihai Carabas <mihai.carabas@oracle.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 8:32 PM Mihai Carabas <mihai.carabas@oracle.com> wrote:
>
> Split-up generic and platform dependent code in order to be able to re-use
> generic event handling code in pvpanic PCI device driver in the next patches.
>
> The code from pvpanic.c was split in two new files:
> - pvpanic.c: generic code that handles pvpanic events
> - pvpanic-mmio.c: platform/bus dependent code
>
> Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>

> ---
>  drivers/misc/Kconfig                |   9 +--
>  drivers/misc/Makefile               |   2 +-
>  drivers/misc/pvpanic.c              | 111 ------------------------------------
>  drivers/misc/pvpanic/Kconfig        |  19 ++++++
>  drivers/misc/pvpanic/Makefile       |   8 +++
>  drivers/misc/pvpanic/pvpanic-mmio.c |  83 +++++++++++++++++++++++++++
>  drivers/misc/pvpanic/pvpanic.c      |  62 ++++++++++++++++++++
>  drivers/misc/pvpanic/pvpanic.h      |  17 ++++++


As mentioned, please use 'git format-patch -M' to make it easier to review

> +
> +config PVPANIC
> +       bool "pvpanic device support"
> +       help
> +         This option allows to select a specific pvpanic device driver.
> +         pvpanic is a paravirtualized device provided by QEMU; it lets
> +         a virtual machine (guest) communicate panic events to the host.
> +
> +config PVPANIC_MMIO
> +       tristate "pvpanic MMIO device support"
> +       depends on HAS_IOMEM && (ACPI || OF) && PVPANIC
> +       help
> +         This driver provides support for the MMIO pvpanic device.
...
> +#
> +obj-$(CONFIG_PVPANIC)          += pvpanic.o
> +obj-$(CONFIG_PVPANIC_MMIO)     += pvpanic-mmio.o

This solves the problem that Greg pointed out, but now the core pvpanic
driver is always built-in even when it is only used from loadable modules.

The easiest way to express what you actually want is with a Makefile
trick:

obj-$(CONFIG_PVPANIC)          += pvpanic.o pvpanic-pci.o
obj-$(CONFIG_PVPANIC_MMIO)     += pvpanic.o pvpanic-mmio.o

When you do this, pvpanic.o is built-in when at least one of its
users is built-in, and otherwise it a loadable module when there
is at least one user, but it will not be built twice or with the wrong
flags.

      Arnd
