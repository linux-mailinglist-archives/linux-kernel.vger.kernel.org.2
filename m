Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C093AD0EE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 19:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236043AbhFRRIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 13:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236037AbhFRRIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 13:08:01 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D54C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 10:05:50 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id k22-20020a17090aef16b0290163512accedso7490526pjz.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 10:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=qTOYa6VhtAfYdU8yuXkzLLIRhZabeT449uqXhMg152g=;
        b=QiaqxIU8Yl801vg/PKgLpWP4/4pJfQSS16mpSkH3ha3rWxljiIckNqxVACbZDMIw9M
         UoHZGiovyuPVceko166WfFGi2VSAEW2gMOMdmLYVa9/vyuGLKl1YzT0t02+R+wSfG2fU
         PmjSzcWoRNv0C4JB3VqdAjoC5vNj3D1E9s7ng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=qTOYa6VhtAfYdU8yuXkzLLIRhZabeT449uqXhMg152g=;
        b=g2sBPYICa80lQ9T8CmJUtsBjaUkwVEDNu/IqjvAGqWb/Wdy/1geJSFCkBYjgFnYw2F
         ko9J2sOoNK3CtagkE0PEIw5uD31eHlt4ZEJN2CHaaOJF2V6gg/wJ7I1+RaD4JEk/Owxi
         oo3f1FRmb4eDaNjO1nfEqQpnMW2KNMYoF+BF4ff3gBUNNgjUtJDefjzZhvX9SHl9eD3g
         Q2hQocwstCkGcgdvDqrK424PeCHfTebTf+VUciZ0YWSO9PJyIzuogfogl4JghZflBYjg
         Ho4nTOMuu15etepSOqqr/9WbPBux1d3dBD7uC4YGLkW77uncY9ToY7tnbgmHzAEJtGWY
         Okpg==
X-Gm-Message-State: AOAM533/2xskJaDPPfP1gaxyl+fqWFQYaJzoEvs7Djka3IbUg0tc5CmA
        Q9reDsllqPc0V+l4H/BtBc78pA==
X-Google-Smtp-Source: ABdhPJztLCuOSgFk0F8O90YzsazxQC0I0zuxXibIagh43Pzx21u4sz6EtJQzvBYfddyvV1SOGtX4ng==
X-Received: by 2002:a17:90a:2a86:: with SMTP id j6mr15533375pjd.67.1624035950508;
        Fri, 18 Jun 2021 10:05:50 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:636c:38ca:1965:590a])
        by smtp.gmail.com with UTF8SMTPSA id o189sm1638432pga.78.2021.06.18.10.05.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 10:05:50 -0700 (PDT)
Date:   Fri, 18 Jun 2021 10:05:48 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Looking for help with Kconfig dependencies
Message-ID: <YMzSbDL+XvpLPaTb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm adding a new driver and have an issue with Kconfig dependencies
that I coulnd't sort out so far.

Patch https://lore.kernel.org/patchwork/patch/1444212/ adds the new
onboard_usb_hub driver which exports two functions,
onboard_hub_create_pdevs() and onboard_hub_destroy_pdevs(). It also
provides stubs for these functions which are used when the driver
is not selected (CONFIG_USB_ONBOARD_HUB=n).

The new exported functions are called by the xhci-plat driver
(https://lore.kernel.org/patchwork/patch/1444215/). Since xhci-plat
now depends on symbols from the onboard_hub_driver the following
dependency was added to its Kconfig entry:

  config USB_XHCI_PLATFORM
    tristate "Generic xHCI driver for a platform device"
    select USB_XHCI_RCAR if ARCH_RENESAS
 +  depends on USB_ONBOARD_HUB || !USB_ONBOARD_HUB

This generally seems to work, however when USB_XHCI_PLATFORM is
forced to be builtin by another driver that depends on it (e.g.
USB_DWC3) it is still possible to build the onboard_hub driver
as a module, which results in unresolved symbols:

aarch64-linux-gnu-ld: drivers/usb/host/xhci-plat.o: in function
`xhci_plat_remove':
drivers/usb/host/xhci-plat.c:427: undefined reference to
`onboard_hub_destroy_pdevs'
drivers/usb/host/xhci-plat.c:427:(.text+0x82c): relocation truncated
to fit: R_AARCH64_CALL26 against undefined symbol
`onboard_hub_destroy_pdevs'
aarch64-linux-gnu-ld: drivers/usb/host/xhci-plat.o: in function
`xhci_plat_probe':
drivers/usb/host/xhci-plat.c:379: undefined reference to
`onboard_hub_create_pdevs'
drivers/usb/host/xhci-plat.c:379:(.text+0x131c): relocation truncated
to fit: R_AARCH64_CALL26 against undefined symbol
`onboard_hub_create_pdevs'

Kconfig generates the following warning with this configuration:

WARNING: unmet direct dependencies detected for USB_XHCI_PLATFORM
  Depends on [m]: USB_SUPPORT [=y] && USB [=y] && USB_XHCI_HCD [=y] && (USB_ONBOARD_HUB [=m] || !USB_ONBOARD_HUB [=m])
  Selected by [y]:
  - USB_DWC3 [=y] && USB_SUPPORT [=y] && (USB [=y] || USB_GADGET [=y]) && HAS_DMA [=y] && USB_XHCI_HCD [=y]
  Selected by [m]:
  - USB_CDNS_SUPPORT [=m] && USB_SUPPORT [=y] && (USB [=y] || USB_GADGET [=y]) && HAS_DMA [=y] && USB_XHCI_HCD [=y]
  - USB_BRCMSTB [=m] && USB_SUPPORT [=y] && USB [=y] && (ARCH_BRCMSTB [=y] && PHY_BRCM_USB [=m] || COMPILE_TEST [=y]) && USB_XHCI_HCD [=y]
  - USB_XHCI_MVEBU [=m] && USB_SUPPORT [=y] && USB [=y] && USB_XHCI_HCD [=y] && HAS_IOMEM [=y] && (ARCH_MVEBU [=y] || COMPILE_TEST [=y])

I read through kconfig-language.rst and experimented a fair bit,
but haven't found a working solution. Any advice would be
appreciated.

Thanks

Matthias
