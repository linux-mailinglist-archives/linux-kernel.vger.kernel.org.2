Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49C63F533F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 00:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbhHWWPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 18:15:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229467AbhHWWPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 18:15:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E694C61372;
        Mon, 23 Aug 2021 22:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629756863;
        bh=JF2HqacLwQICzgIPcy3oKNYo1NieMroVH2xKBOo9jQs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Mh7qVhOqfWqgekEWpZYtZIvKDq+9JXoqwF4f8tzK3xYycm/++Rnp5evNbnxxS+z0M
         gD2bbxiCudwua+g4iDOgrvNIlBRTF2hTIOVrgDyLwqcKf9d1+C/J3QuBbnuQDYvnWo
         Zhp2lZTSTgkWefgyhoKdcdUujkofK8z3WtpjGWQjgY8r67XkciAQxG3jk+rpHIBlIj
         fk1uh5KXR02DS23vkhMHgEE7fXTnUEHntro4PepjKxvtVY5Mm2Em+DcRToTLXyrLGL
         8+V2xPNVs649LHkQwrMmvGXuYrvH81eOnh2O0B/rOP/Y/V62VylERr7gvtyIONrtVc
         7CUU33t1aA6kw==
Received: by mail-ej1-f52.google.com with SMTP id bt14so40096101ejb.3;
        Mon, 23 Aug 2021 15:14:23 -0700 (PDT)
X-Gm-Message-State: AOAM530wcnLFUO42W9ISN4tQ3XWTJXLMztpyaaemDq8tm2yowIWW+2gR
        d7oOp61NbfUrK/mjwl8h8aTF+r21RR/Y2W8TOw==
X-Google-Smtp-Source: ABdhPJyh97aQd1btpsPulS7e70mmsnXpZbONnzuIUhwc6/N7l8tedcjFWMIpqEkIcjy8ExdaYuuixZDgTwslup/dBz4=
X-Received: by 2002:a17:907:b06:: with SMTP id h6mr5293665ejl.130.1629756862536;
 Mon, 23 Aug 2021 15:14:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210820144722.169226-1-maz@kernel.org> <a67743f9-869b-28df-d714-db15da4ebe06@gmail.com>
 <YSPtI//SJh1CpHRP@robh.at.kernel.org> <bcb2e89f-9768-8435-35d9-d02140628b9a@gmail.com>
In-Reply-To: <bcb2e89f-9768-8435-35d9-d02140628b9a@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 23 Aug 2021 17:14:11 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJs2ayHFpOo7kS4K96Sy3xDkxeWYNMTDF9Ssd9D79LKng@mail.gmail.com>
Message-ID: <CAL_JsqJs2ayHFpOo7kS4K96Sy3xDkxeWYNMTDF9Ssd9D79LKng@mail.gmail.com>
Subject: Re: [PATCH] of: Don't allow __of_attached_node_sysfs() without CONFIG_SYSFS
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 4:27 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 8/23/21 1:46 PM, Rob Herring wrote:
> > On Sun, Aug 22, 2021 at 11:01:15PM -0500, Frank Rowand wrote:
> >> Hi Marc,
> >>
> >> On 8/20/21 9:47 AM, Marc Zyngier wrote:
> >>> Trying to boot without SYSFS, but with OF_DYNAMIC quickly
> >>> results in a crash:
> >>>
> >>> [    0.088460] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000070
> >>> [...]
> >>> [    0.103927] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.14.0-rc3 #4179
> >>> [    0.105810] Hardware name: linux,dummy-virt (DT)
> >>> [  0.107147] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=--)
> >>> [    0.108876] pc : kernfs_find_and_get_ns+0x3c/0x7c
> >>> [    0.110244] lr : kernfs_find_and_get_ns+0x3c/0x7c
> >>> [...]
> >>> [    0.134087] Call trace:
> >>> [    0.134800]  kernfs_find_and_get_ns+0x3c/0x7c
> >>> [    0.136054]  safe_name+0x4c/0xd0
> >>> [    0.136994]  __of_attach_node_sysfs+0xf8/0x124
> >>> [    0.138287]  of_core_init+0x90/0xfc
> >>> [    0.139296]  driver_init+0x30/0x4c
> >>> [    0.140283]  kernel_init_freeable+0x160/0x1b8
> >>> [    0.141543]  kernel_init+0x30/0x140
> >>> [    0.142561]  ret_from_fork+0x10/0x18
> >>>
> >>> While not having sysfs isn't a very common option these days,
> >>> it is still expected that such configuration would work.
> >>>
> >>> Paper over it by bailing out from __of_attach_node_sysfs() if
> >>> CONFIG_SYSFS isn't enabled.
> >>
> >> CONFIG_SYSFS should be automatically selected when CONFIG_OF_DYNAMIC
> >> is enabled, and it should not be possible to disable CONFIG_SYSFS
> >> in this case.
> >
> > That used to be true, but isn't now.
>
> OK.  I agree with you, but when I investigated the original patch
> email I came to a different conclusion because of the way that I
> used make menuconfig to debug the situation.
>
> It is true when I start with a .config created from 'make qcom_defconfig',
> then select OF_UNITTEST, which is the only way I can see OF_DYNAMIC.  It
> is the "if OF_UNITTEST" that means SYSFS can not be disabled.

Not really. Disabling SYSFS has nothing to do with the DT code. It's
not super easy though. It required setting EXPERT and disabling
CONFIGFS_FS and things selecting it (PCIE endpoint and USB gadget).

> If I start with the .config that Marc supplied, then make menuconfig
> still does not show the OC_DYNAMIC option, but leaves it set since
> it was already set.  In this case SYSFS remains disabled because
> OF_UNITTEST is also disabled.

I don't see the relationship between SYSFS and OF_UNITTEST.

> Using '/OF_DYNAMIC' from within make menuconfig, to get more info
> about OF_DYNAMIC tells me that the prompt for OF_DYNAMIC is visible
> if OF && OF_UNITTEST.  This is due to the "if OF_UNITTEST" in line 58
> of drivers/of/Kconfig in the OF_DYNAMIC specification.
>
> Thus I can't figure out how to use make menuconfig to set OF_DYNAMIC
> without setting OF_UNITTEST.  I tried setting OF_UNITTEST, then setting
> OF_DYNAMIC, saving the changes, then another make menuconfig to
> disable OF_UNITTEST, which then has the side effect of unsetting
> OF_DYNAMIC.

Selecting OF_OVERLAY also.

> Would you accept a patch that removes the "if OF_UNITTEST" from
> the Kconfig entry for OF_DYNAMIC?

I guess. The purpose of making it visible was for compile testing, so
maybe make it 'if COMPILE_TEST' instead?


Looking at occurrences of CONFIG_OF_DYNAMIC, there's more than I'd
like. This for example is a common pattern:

drivers/spi/spi.c:      if (IS_ENABLED(CONFIG_OF_DYNAMIC))
drivers/spi/spi.c-
WARN_ON(of_reconfig_notifier_register(&spi_of_notifier));

Really, of_reconfig_notifier_register() should just return 0 if
!IS_ENABLED(CONFIG_OF_DYNAMIC).

Rob
