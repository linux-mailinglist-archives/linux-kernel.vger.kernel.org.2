Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C2D3AB509
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 15:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbhFQNll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 09:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbhFQNlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 09:41:36 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603B3C061767
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 06:39:28 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id z12so4113072edc.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 06:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ESEPPl9d4dEAVLZa/sUKUFHN4c28wM7cE+41nav9L7Y=;
        b=lUtLXBpt4NLsbS7Pq8vw6rZO5Ymafm7ihGaD5x554aAjZSb6HNaxIyh7IqrTB9oZh9
         SK6fKKx5c8nKoSkBpeFqBz8D9xsSKoEOnGarV+feen/EaVLB6WOk5Jg/09wnb/BM3QE2
         12FRnZFooqQPUeQuv9Fp3r//vyrkcghByj8mGovkjjioZZy/giMM94B1UNsZGJayIVrH
         US6NQJTxjOG4LT1cKdeaQaHGrTWuTUreD75NyBkXmdleUM7vNKhK8HdhcUiHCxHcVHcT
         cc68JIMNceRjHh7qYw/KStTfuVzZWjnohvctnEcU2EK2IsSrmrovSVovp3bEgfkGjGvg
         CUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ESEPPl9d4dEAVLZa/sUKUFHN4c28wM7cE+41nav9L7Y=;
        b=FeCU8hlJVLGNZFnIEnoDWDUW+FYSbU+9DcGcpYINyBJoU9XCGx1FJ5SSs/WWFN1HQh
         Sjt6pzy7mNXK5yiKwDbGpEc5FiDJq+BthThynFcU7ZjvI+Tf2QJSGnqOEZZYKQ0AJH5Y
         Zrl1BSAjMNCma335MBs+7MbTp3LEUyIQfT2qbO1MZ125Dg+o1eG8rRm73Ssc/ac2k+gD
         S8LZwdFmWtnx3vlSBnxf9ZgZEOhqyip/xLmTB1KmzxuI7IIAsSIpu22g2T+jdFlHkjr7
         fvij2F1vcyurxMjVekzvqt0gB9qShvyWEDPYS3oo2/Y3On6ESu21cNDntiCw2TR6xztl
         SoNg==
X-Gm-Message-State: AOAM531BLgQiPlJlaNcygwMCeneXQIgnJHDoQaLwe9O8Sgss4KkLbxA1
        fLDhO+K7SULCBunC8q+HngZuF3EdGLOP+4D/ahyujQ==
X-Google-Smtp-Source: ABdhPJy8zOR+7A2Z5OnmE05NwL+BiKr3dgm+2j/ug/AZ/jlG4cI68SkBuiJ4ynNuGURvVChxeepIuo7i3TGTjxhf2nM=
X-Received: by 2002:a05:6402:22fa:: with SMTP id dn26mr6438897edb.230.1623937166788;
 Thu, 17 Jun 2021 06:39:26 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 17 Jun 2021 19:09:15 +0530
Message-ID: <CA+G9fYu6er1nZ602gCnrY+-JNtDHrUJk-RH2biPmjRoe06_m4Q@mail.gmail.com>
Subject: [next] [arm64] allmodconfig build failed - xhci-plat.c:427: undefined
 reference to `onboard_hub_destroy_pdevs'
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.or, lkft-triage@lists.linaro.org
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arm64 allmodconfig build failed on Linux next 20210617 tag due to
the commit,

c950686b382d ("usb: host: xhci-plat: Create platform device for
onboard hubs in probe()")

build error:
------------
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
make[1]: *** [Makefile:1252: vmlinux] Error 1
make[1]: Target '__all' not remade because of errors.
make: *** [Makefile:222: __sub-make] Error 2
make: Target '__all' not remade because of errors.

steps to reproduce:
--------------------
tuxmake --runtime=podman --toolchain=gcc-11 --target=arm64 --kconfig
allmodconfig KCONFIG_ALLCONFIG=arch/arm64/configs/defconfig kernel
modules

Build:
--------
    git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
    git_sha: 7d9c6b8147bdd76d7eb2cf6f74f84c6918ae0939
    git_short_log: 7d9c6b8147bd (\Add linux-next specific files for 20210617\)
    arch: arm64
    config: allmodconfig
    toolchain: gcc-11

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

--
Linaro LKFT
https://lkft.linaro.org
