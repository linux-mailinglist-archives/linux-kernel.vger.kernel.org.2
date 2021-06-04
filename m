Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431E939BA81
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 16:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbhFDOFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 10:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhFDOFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 10:05:49 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C483FC061766
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 07:04:02 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id r13so5470661wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 07:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CDPZN9rXn/2sWgCtIlnaMwucM0ZhhnFzjW38voB8XP0=;
        b=AZ9qPpOgKNZFV/4UmgwQQfpWul55LoMX8bUmhqdDHjMx3cIZPNpJxDzscteLozut+a
         TRECh9nqt+y+e7BEktoprseEdvjebbZeWlErt/36JD9ar5D2LfVnU3b5cY+eZjqMSxOG
         h0zTwomuOWWLGcnTSpiid/qRa4syjH2qZkpehTiUCv5S69acA9VcYR/wrD3zlXBYDZ2F
         uj0cFVBbdzdN/BlhpVzp8NaxNMjCYhruFSR//4y1j0bTd0m+U7y0tdYei2oswMt2M+sZ
         Ymn22uhPCdeCMGV0LDadFKDUiP5rHwjJ2HGNvlX3OhIEtKfVO+BZlK/1WELTC6YjMGcS
         Xq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CDPZN9rXn/2sWgCtIlnaMwucM0ZhhnFzjW38voB8XP0=;
        b=N+HARxbbzwn+j50P8XVyXdcHVnJ6BM3gQUuHBjEvakTsdjwteQFpEl59bzJcUtq+bA
         qeAwzpxTBQGhEQfzJy0rzzf6b1TCwwJedo88V+XLcb7oimeOmVeaBNkvWOSOwwtc3qyZ
         HlYXbUV+ed2NB5pUqHyXUqBFmm9xkYwg1lA+7jlTc9ql9p2YVqFX4Xhh3ypg5OeLU+xt
         vyKw1d8Mm3uZ8KzcZg4FObfW1v9/0Q0l4z/QPiXm4pLWQQ9oOK/xDkiOW2rIX4RThnxM
         E3/ZAWZ+OWQx0tKH2fGQLy6cc0SnwAMGLw3DMY/hSAGBYm/G4I/6v6C7yUTYBVDdyKF+
         wbfg==
X-Gm-Message-State: AOAM532wKGddT2FjAqHVEtFfbLPsGmYGyGpiiMI7MvgEBvGTRl7ijuXk
        2DlQupF2oaqbJVc8lYEA+vgPeg==
X-Google-Smtp-Source: ABdhPJz6XYD0ouvZ2spj1i+HskfJEYeUlvOtKtkkuV4v4hqyWbkwEVFPqErNBxKEqheZXGCDnJTvtQ==
X-Received: by 2002:a1c:2456:: with SMTP id k83mr3867850wmk.87.1622815441364;
        Fri, 04 Jun 2021 07:04:01 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id m11sm5422559wmq.33.2021.06.04.07.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 07:04:00 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, sstabellini@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        wsa+renesas@sang-engineering.com, linux@roeck-us.net,
        treding@nvidia.com, arnd@arndb.de, xen-devel@lists.xenproject.org,
        patches@armlinux.org.uk
Subject: [RESEND 0/5] ARM/arm64: arm_pm_restart removal
Date:   Fri,  4 Jun 2021 15:03:52 +0100
Message-Id: <20210604140357.2602028-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a rebase/refresh of a set sent out, reviewed,
then forgotten about.  It's still considered useful.

Here is an excerpt from the previous attempt:

 "Hi Russell, ARM SoC maintainers,

 here's the full set of patches that remove arm_pm_restart as discussed
 earlier. There's some background on the series in this thread:

	https://lore.kernel.org/linux-arm-kernel/20170130110512.6943-1-thierry.reding@gmail.com/

 I also have a set of patches that build on top of this and try to add
 something slightly more formal by adding a power/reset framework that
 driver can register with. If we can get this series merged, I'll find
 some time to refresh those patches and send out for review again.

 Thierry"

Guenter Roeck (5):
  ARM: xen: Register with kernel restart handler
  drivers: firmware: psci: Register with kernel restart handler
  ARM: Register with kernel restart handler
  ARM64: Remove arm_pm_restart()
  ARM: Remove arm_pm_restart()

 arch/arm/include/asm/system_misc.h   |  1 -
 arch/arm/kernel/reboot.c             |  6 +-----
 arch/arm/kernel/setup.c              | 20 ++++++++++++++++++--
 arch/arm/xen/enlighten.c             | 12 ++++++++++--
 arch/arm64/include/asm/system_misc.h |  2 --
 arch/arm64/kernel/process.c          |  7 +------
 drivers/firmware/psci/psci.c         | 12 ++++++++++--
 7 files changed, 40 insertions(+), 20 deletions(-)


-- 
2.31.1

