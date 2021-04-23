Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD28368CD6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 07:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240426AbhDWF4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 01:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhDWF4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 01:56:43 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFBBC061574
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 22:56:06 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id s22so13380021pgk.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 22:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=mmA6Vp3R9Yzy8NAMi+3T3BUImkb39vxQ+mRKRyz+djU=;
        b=Nlqx/fH90FX0BbxBthrIddjCiNcBnP5j1oG0KIDMfLDn/Xi+haixH8grgjOrGwKbD6
         inKGNQNeHH/3gSrSN5wbidsKaQL2OTeekl5pqw64bpk38ReJy5gPcOKkTKrfeDNhD/Jd
         vcP0PVKbsijSSRpczj+l6CZdpMmxdBpt8xFIQywXdTl87BB0EIr8AfIVmZ+KC66ylzXa
         3m5XkiKSL/y8taGcKAjGR1DABZBqXX8L8SnMJxf6gs/s7rbglv+6HgLLGDhJJGMt1Ta1
         xTUjtYyqAr6sWFh7CWvhF1EbtmGWGLeydJ3uuAbrAcCX3h4MAooD0lvm1H9BSFA+MUg/
         jZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=mmA6Vp3R9Yzy8NAMi+3T3BUImkb39vxQ+mRKRyz+djU=;
        b=XlfzpII+sb8Pi258ssRfOyZkLmHu49xNQxCOKyx+4j+0ubU3YIDKsQ1ATSPL6BQIYX
         NXwoPKstoTIjI8PXH0hjV6CrInvWpnIBTE53oz5gVnuK4SmDvrYGlkNQiyZZfza9GhuW
         wPtCCAEoLWeotsw1o+nmDSsKGAPhTFz8ffjRbyKMSm3jSlmfj7h4FXi5TGx0Heqgcf+3
         gwpBQKzrNfo/gi5l8lxThLj0+UO9XMoM5grnJ8lVqLuAUQj+8bxNVrSFT1SjGszITfRv
         U1L83iVec8zFNKTlfPigt+sDX07KJ1Xbakw26SeHK6jrPzfJikOtu44ZwbQ+pXPlCYau
         8W3A==
X-Gm-Message-State: AOAM531I2LCwgPndGL1U4hb7H8XQ8s7wVWENbrrVwIM0vY9MZ9qmgUTK
        IlTF6wzp2RoL62V1HscqKWhuxQ==
X-Google-Smtp-Source: ABdhPJyGsJZhLU+QXGqeYV7J5jxgb/H86ZoIGXqKMsmwXFz3iiYUEyobiMzITH+Y4bWC0K7u+IcKpQ==
X-Received: by 2002:a65:4486:: with SMTP id l6mr2246741pgq.347.1619157365863;
        Thu, 22 Apr 2021 22:56:05 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id x83sm3544603pfc.219.2021.04.22.22.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 22:56:05 -0700 (PDT)
Subject: [PATCH] RISC-V: Don't build XIP kernels under allyesconfig
Date:   Thu, 22 Apr 2021 22:55:51 -0700
Message-Id: <20210423055551.447922-1-palmer@dabbelt.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Palmer Dabbelt <palmerdabbelt@google.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:         linux-riscv@lists.infradead.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

We have a fixed memory layout for XIP kernels, which means we can't
support very large kernel images.  This is good enough for now, as XIP
users aren't likely to build huge kernels.  It does, however, mean that
allyesconfig breaks which is an issue.

This makes XIP depend on !COMPILE_TEST.  That's a bit of a hack, but
there are some other !COMPILE_TEST dependencies.  This will result in
build bots getting less coverage for XIP, but it's the best I could come
up with.

Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>

---

I've squashed this into the XIP patch, which is on for-next.
---
 arch/riscv/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index eec1ede79609..66a03b38d12a 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -508,9 +508,6 @@ config PHYS_RAM_BASE
 config XIP_KERNEL
 	bool "Kernel Execute-In-Place from ROM"
 	depends on MMU && SPARSEMEM
-	# This prevents XIP from being enabled by all{yes,mod}config, which
-	# fail to build since XIP doesn't support large kernels.
-	depends on !COMPILE_TEST
 	select PHYS_RAM_BASE_FIXED
 	help
 	  Execute-In-Place allows the kernel to run from non-volatile storage
-- 
2.31.1.498.g6c1eba8ee3d-goog

