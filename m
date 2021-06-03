Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 247F939AD5A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 23:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhFCWBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 18:01:08 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:44846 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhFCWBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 18:01:07 -0400
Received: by mail-pg1-f182.google.com with SMTP id 29so6176691pgu.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 14:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E33VpkCicrhCD0xawQsjRc1s2X6KLPP55EFBcN78Cmc=;
        b=nd4t1yTL9raf7I8N8sAjsgYkU70Ab2nau6dmvWEfLhnanrinOsInyFOhBhumFZlseO
         lyMIV/jfFI4ED1tOQb60ZpS+dJXppW/3nJIge3AwipnFz3YqMJ/bgNbNuT5vKBITn+eB
         w6kwf/KK5HHx1/q8pXLk50QeWTpNu3HloDAGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E33VpkCicrhCD0xawQsjRc1s2X6KLPP55EFBcN78Cmc=;
        b=e2D22Rt/b8AQ5y5xO6qyPcEGarFgJFx5ZAMT5mg196Hf91jssJafrZogTVHAanq9Y6
         e2YFe87L/hpm0jYvnsqQY3E2Ou16zG0C667ciEARZXE5GdieJhTG1r+VOujJXyi4VRSZ
         n/pPQihwDEGcimkxz8eu1KBfaAgdDQg+cH7pjk5SYRLXxkeUH1nMt1QTstFjgK8oF4xT
         zWD4PdWhPur/RLACjZlL4No9s/siB8GiRaPFyBgVtNeztQvUK+nJGfDO1W5ITOmaKPc5
         qZrROFHqFNgerMiMgp/wKJs6cWPlPvesSEvPjwbtaQxb4JE+URm1zPZOZ+OATJ5/ZIm/
         LG3g==
X-Gm-Message-State: AOAM532ylKkZSIFyYSX2F/CduUW2LZBH4NI/ud+Jd3ROuyFwiLWNXziX
        suSsvcnvOGgj2+G590vp1uxrDg==
X-Google-Smtp-Source: ABdhPJygDyZYIs+VBgxVm5pLVAz896xD2LcmZZzYpzb/eyQ0hxw0nPGLcmTwWUQp9bMimcTR7TQQhw==
X-Received: by 2002:a65:584d:: with SMTP id s13mr1547265pgr.77.1622757502408;
        Thu, 03 Jun 2021 14:58:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v9sm56165pfn.22.2021.06.03.14.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 14:58:21 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Kees Cook <keescook@chromium.org>, Emma Anholt <emma@anholt.net>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/pl111: Actually fix CONFIG_VEXPRESS_CONFIG depends
Date:   Thu,  3 Jun 2021 14:58:19 -0700
Message-Id: <20210603215819.3904733-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=6b805c2a72c424d5883995daad5dea751e3e4227; i=DwQ2M6JPPIp1aqGMVRBW/n1FD/gTXx2QUVMc6SXkj4M=; m=uJeVtt0ygoQEka7D4SNZAzuRePykX/n9wjq3wzQ7W9A=; p=h0Hb7farsgywRDtpFu8qUGXsdKoc6UYbZMLMBkRugeI=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmC5UHoACgkQiXL039xtwCZOJw//S1J PbQg8xZKTtx+9Xkya3J7A1st3vMPy2XF9A56Uj3IXo7NSqHQJbBAJ1EbTuG4UbSOVCFOOuLqkVcmd YGgtoNZzhhy+YDuGuDZdlbuiP1f58Jea54BRb3IaN5v8LFRSNzN9wj5py1/YCqt9m0L+y+D6bzFjV LPvDImivp1i0z07MmRaCd1pHegHX0AhN9G1n5ApHyXROtb9yMVZA9bhTUUr0M2sRtihNblo5LkW7o 5ydp50FvtWjGdljCc/jwvRmzucQuZycEGxfh9/PnKTmb2AOzcw9gL2fexCYD9wjBk1WhsBTxt2vfM ZtfaMcCr6VZZ+8p9TCYrxrBx6qC/d586r9L8fckkoOVmXtuJonJYSfo4enbqe6YTh/fNC6jg/0Eal SpE/WHIZ/MEjK2ORJG8C8mKfQkffLZOnhYEEiniul7fq9+cN51yof3G1Uh3OuvfO9SduU/pqLobGB o2ajlYLZ6C8Y10t7k1Rt9F8/g5asRfXa6SKVn43u5J2TzjcxNt2dhC0lODJBnXF+qAHM5Uz3UJiGO K3BNzgcy1Xj4N+58hnpMMOG+2sBS7OBcvAGm7LUkI6QKv7tHmml7BV1SM3TAfeAGOghlU0YTeGQb6 d2CorJwF886Lf6m/fLNlvd85Xpg6pY7BHWKnXPkCfAA8a8vxIxIPth4jDZlweZpw=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VEXPRESS_CONFIG needs to either be missing, built-in, or modular when
pl111 is modular. Update the Kconfig to reflect the need.

Cc: Emma Anholt <emma@anholt.net>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Fixes: 4dc7c97d04dc ("drm/pl111: depend on CONFIG_VEXPRESS_CONFIG")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/gpu/drm/pl111/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/pl111/Kconfig b/drivers/gpu/drm/pl111/Kconfig
index c5210a5bef1b..b84879ca430d 100644
--- a/drivers/gpu/drm/pl111/Kconfig
+++ b/drivers/gpu/drm/pl111/Kconfig
@@ -2,7 +2,8 @@
 config DRM_PL111
 	tristate "DRM Support for PL111 CLCD Controller"
 	depends on DRM
-	depends on VEXPRESS_CONFIG
+	depends on ARM || ARM64 || COMPILE_TEST
+	depends on !VEXPRESS_CONFIG || VEXPRESS_CONFIG=DRM
 	depends on COMMON_CLK
 	select DRM_KMS_HELPER
 	select DRM_KMS_CMA_HELPER
-- 
2.25.1

