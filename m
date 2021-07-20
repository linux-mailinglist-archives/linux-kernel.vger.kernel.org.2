Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9C33CFCAA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 16:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237564AbhGTOKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 10:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239525AbhGTN5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 09:57:37 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 52997C061574
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 07:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID; bh=jstlg1OkIV+dXI2YL7TkI17AWwqIokJ73bq9
        059nTsE=; b=jNrphBq+WnYsFHfbR4jHK7OYsy6XYmDi+svXgc5BTH4lUL7IE/eo
        9t7jY1ty/UAHUPDpddgxyesF4SFdTpLpIkqqew7XgHDhYv5b3qYHQ31Vi+JxlY0c
        J4bGlq1iLEdDXv8bs0qzrJVCEgu1HykiV9FQFVxhGDnjZNB4XUCTyxE=
Received: by ajax-webmail-newmailweb.ustc.edu.cn (Coremail) ; Tue, 20 Jul
 2021 22:37:57 +0800 (GMT+08:00)
X-Originating-IP: [117.61.244.66]
Date:   Tue, 20 Jul 2021 22:37:57 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   lyl2019@mail.ustc.edu.cn
To:     "Dongliang Mu" <mudongliangabcd@gmail.com>
Cc:     siglesias@igalia.com, jens.taprogge@taprogge.org,
        "Greg KH" <gregkh@linuxfoundation.org>,
        industrypack-devel@lists.sourceforge.net,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Doubts about Patch "ipack/carriers/tpci200: Fix a double free
 in tpci200_pci_probe"
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT3.0.8 dev build
 20210401(c5ff3689) Copyright (c) 2002-2021 www.mailtech.cn ustccn
In-Reply-To: <CAD-N9QVFnhKGfRYDDjWb0o_ty57AbjfzEnFPHZxEC5NOKL1ecg@mail.gmail.com>
References: <CAD-N9QVFnhKGfRYDDjWb0o_ty57AbjfzEnFPHZxEC5NOKL1ecg@mail.gmail.com>
X-SendMailWithSms: false
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <77df3e1f.22e1.17ac45a1bd9.Coremail.lyl2019@mail.ustc.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: LkAmygDX3x_F3_ZgqsYEAA--.0W
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/1tbiAQsIBlQhn9BleAAAsj
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Dongliang Mu,

>  Depending on if CONFIG_PCI defines, the "tpci200->info->cfg_regs" may
> not be freed.
> 
> #ifdef CONFIG_PCI
> /* Destroy a virtual mapping cookie for a PCI BAR (memory or IO) */
> struct pci_dev;
> extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
> #elif defined(CONFIG_GENERIC_IOMAP)
> struct pci_dev;
> static inline void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
> { }
> #endif

I think only `CONFIG_PCI=n` and `CONFIG_GENERIC_IOMAP=y` cause pci_iounmap an empty
implementation. Actually, `CONFIG_PCI` is a default option when run `make defconfig`,
pci_iounmap() usually is acted as an extern function.


> Even if CONFIG_PCI is undefined, it is possible that
> tpci200->info->cfg_regs is not freed at all. Therefore, this patch
> would cause memory leak. Take a look at the following code:
> 
> void pci_iounmap(struct pci_dev *dev, void __iomem * addr)
> {
>         IO_COND(addr, /* nothing */, iounmap(addr));
> }

Here i am not sure this is the final implementation of pci_iounmap(),
because pci_iounmap() is re-implementated in many architectures.
Even so, i observed there still many call-sites of pci_iounmap() have reset
`the addr = NULL` after calling.
Can you have some ways to determine the actual implementation of 
pci_iounmap in our cases?


> #define IO_COND(addr, is_pio, is_mmio) do {                     \
>         unsigned long port = (unsigned long __force)addr;       \
>         if (port >= PIO_RESERVED) {                             \
>                 is_mmio;                                        \
>         } else if (port > PIO_OFFSET) {                         \
>                 port &= PIO_MASK;                               \
>                 is_pio;                                         \
>         } else                                                  \
>                 bad_io_access(port, #is_pio );                  \
> } while (0)
> 

Although the above codes is actually called, the addr might be freed 
if `port >= PIO_RESERVED` is true. The double free still existed.



If I make any mistakes, please tell me.
Thanks your report.
---
Lv Yunlong




