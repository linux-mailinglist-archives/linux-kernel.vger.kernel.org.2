Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A52013CF4C3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 08:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhGTGIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 02:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbhGTGHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 02:07:42 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB3BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 23:47:53 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id t2so26775362edd.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 23:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=2gzwOcrNzq5ovIdw97A9Su7K29oDFRX3eXqBoQ79x6w=;
        b=juQi7GMJ5MXSjzTSCvB5wbrOGuql5fmJ/bgcASd6sQr+iAl7iRhWD9Z/PcsaN3/AZv
         3Tp/tKGsNIdwHx1GW+YTAv7PuvlY56HYrCal78wo068WTMKIokFz/w60MoI/efThHefB
         I1nNVTYnRO+dYE12YDECvgFrM3iRfdPjTxrdRCQclnSFeEjeLeZUepBU+bJMrebLxa30
         ZC1Nrp+DWpLu6NuudFk3ghU8FVPDBafzS9VVqELr5aAxJsCElauo2qaUDZDroNM0whz2
         mbGoVm2Wb6MlO50oGFSSLfalapRpgFlinleYEwdeyGfyfW1+Cjbj+Og0yaUdeZuxP5Ez
         avSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=2gzwOcrNzq5ovIdw97A9Su7K29oDFRX3eXqBoQ79x6w=;
        b=LVzzYGQXFdD4ZRIdSnA9uwJO0W5HBhbBq+7w/PH7VV5ijSoTGhQbc8I3SJAUpPkTtc
         egsRwsZK2IfwZ8e/CeFNWPadsZ0WHHrL9VS+R/RtiDplCB81jD//AJWdQcd8z8PQlHuF
         aUK5lflLt8IEIIufblaLPW4bQ7+jr0Au+0Rhab8fixcSOdyjAugC4zC5cTrkLGeqEZ2a
         A8VGOwdk5Df2P/aR0qLRplpSZmV+SiSD/tWvt1lnJ0FV69Oysrzdkh2Yq0aQXXG/KuvL
         7jlYzR37sOHNRg7kdfw8IhCItDwa3fOEqMtqVU+AwP9Bif8kPjh82GyOtC0slf8V6kxw
         HHjQ==
X-Gm-Message-State: AOAM531CJe6dYJBDdqgVZRjdFDNDeSMbC4pdnbvrN4XDB0ZOVVlvJ64I
        4oHJNBt375NZL5nOe1hLDRngq+GsV6lqlye0IVU=
X-Google-Smtp-Source: ABdhPJwcmalFx/V4N0tyytW97xojfAuk3zMqBKK8zMqjD/pR0JVpDLUAdHaBx6BC/rqR1i1R11+hGjqDLPWU+8JgqP4=
X-Received: by 2002:a05:6402:4c5:: with SMTP id n5mr38588659edw.322.1626763671622;
 Mon, 19 Jul 2021 23:47:51 -0700 (PDT)
MIME-Version: 1.0
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Tue, 20 Jul 2021 14:47:23 +0800
Message-ID: <CAD-N9QVFnhKGfRYDDjWb0o_ty57AbjfzEnFPHZxEC5NOKL1ecg@mail.gmail.com>
Subject: Doubts about Patch "ipack/carriers/tpci200: Fix a double free in tpci200_pci_probe"
To:     lyl2019@mail.ustc.edu.cn, siglesias@igalia.com,
        jens.taprogge@taprogge.org, Greg KH <gregkh@linuxfoundation.org>
Cc:     industrypack-devel@lists.sourceforge.net,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have some doubts about the patch - "ipack/carriers/tpci200: Fix a
double free in tpci200_pci_probe".

> In the out_err_bus_register error branch of tpci200_pci_probe,
> tpci200->info->cfg_regs is freed by tpci200_uninstall()->
> tpci200_unregister()->pci_iounmap(..,tpci200->info->cfg_regs)
> in the first time.

From my code review, although pci_iounmap takes
"tpci200->info->cfg_regs" as its 2nd parameter, the implementation of
pci_iounmap may not use this parameter.

 Depending on if CONFIG_PCI defines, the "tpci200->info->cfg_regs" may
not be freed.

#ifdef CONFIG_PCI
/* Destroy a virtual mapping cookie for a PCI BAR (memory or IO) */
struct pci_dev;
extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
#elif defined(CONFIG_GENERIC_IOMAP)
struct pci_dev;
static inline void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
{ }
#endif

> But later, iounmap() is called to free tpci200->info->cfg_regs again.

Even if CONFIG_PCI is undefined, it is possible that
tpci200->info->cfg_regs is not freed at all. Therefore, this patch
would cause memory leak. Take a look at the following code:

void pci_iounmap(struct pci_dev *dev, void __iomem * addr)
{
        IO_COND(addr, /* nothing */, iounmap(addr));
}

#define IO_COND(addr, is_pio, is_mmio) do {                     \
        unsigned long port = (unsigned long __force)addr;       \
        if (port >= PIO_RESERVED) {                             \
                is_mmio;                                        \
        } else if (port > PIO_OFFSET) {                         \
                port &= PIO_MASK;                               \
                is_pio;                                         \
        } else                                                  \
                bad_io_access(port, #is_pio );                  \
} while (0)

If I make any mistakes, please let me know.

--
My best regards to you.

     No System Is Safe!
     Dongliang Mu
