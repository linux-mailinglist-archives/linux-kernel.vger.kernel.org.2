Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4821143494F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 12:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbhJTKtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 06:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJTKtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 06:49:10 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A603C06161C;
        Wed, 20 Oct 2021 03:46:56 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id o24-20020a05600c511800b0030d9da600aeso9126558wms.4;
        Wed, 20 Oct 2021 03:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=whR0ZNxEwCyi9xlkSBMhZ6NrngLCDrmcZY7NCoPKafI=;
        b=KHlw1PTz/EehdeNVRNMFwWDJ7vt2hnQw25wlwHrN9gnP+ctgzou5509ivVB6IIdsal
         B7WPtuo5hjdBQPV5lCny+/HsOO1JOOCPGVG5wa+OUmRooES/mLtk9SKOJjmiuQ1lOcXC
         L99/inxTii8cG4TYDeDSUPotLcSyJgltHV6GTRJDVhJ/tTb/E7KcH2HyGnSI6hUXGN5Z
         RG+8SoB/STv4fW6M/nFTwXkncDHsLCv4ikGtuTihNexU1m/Q/lrpNJlEisDhsvaEh5uW
         NaayCWfojl0/QOKSjrZBnh9skENyIvD3bUhfWP/LhSUVrypNP7OWGFjlVu3zF/80wtfY
         /UhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=whR0ZNxEwCyi9xlkSBMhZ6NrngLCDrmcZY7NCoPKafI=;
        b=iW+W+0kfEybhH041VmjyjT/QfR8/1x1xP+AGzbEsrKnyA01hw/PFw1SVCVoTXBcZpU
         B3QPMdpgJypUz7/U4yEatle0VW+ginRqd7E+jYDLp2dKWZibDIAihRTZcyjX4mFA/k2a
         IqNMVzlBoyWdgD9ANrUnm3CDCMUmZIzxqBSFOiuMURAcODCLDWaezKy1TLFPbREx8Z2G
         Xq9jsOqUI/8r7xTXTRyIeq8FBuVnuiE30w+c2Ggs1JmZnGjV1FDTAedpf6Gua9aL0PSi
         IGOtpLkXWfn/5pnYi6Rj51G3C6Vwz/tqLwQX3lUjNnsPMQc3lq518rskbompf5GuWYig
         5E0w==
X-Gm-Message-State: AOAM532DP85gTvE+skLKTxHk5V6j8svGULOfXVQ1iUC8zdGq41gclyuG
        bOLP8idljaqv+E7ENUSWm10=
X-Google-Smtp-Source: ABdhPJwm+IrPO2y3xhTKkLSUO69xt4tsC/ZTGfrcTIjFDlthmuo3d7YIzc3kQ2pGtcqhrSLwM30n8Q==
X-Received: by 2002:a1c:3b44:: with SMTP id i65mr12766620wma.161.1634726814812;
        Wed, 20 Oct 2021 03:46:54 -0700 (PDT)
Received: from localhost.localdomain (i5C74E127.versanet.de. [92.116.225.39])
        by smtp.gmail.com with ESMTPSA id n68sm4599412wmn.13.2021.10.20.03.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 03:46:54 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        David Heidelberg <david@ixit.cz>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: rectify entry for PSTORE FILESYSTEM
Date:   Wed, 20 Oct 2021 12:46:47 +0200
Message-Id: <20211020104647.11556-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 89a5bf0f22fd ("dt-bindings: reserved-memory: ramoops: Convert txt
bindings to yaml") converts ramoops.txt to ramoops.yaml, but missed to
adjust its reference in MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about
a broken reference.

Repair this file reference in PSTORE FILESYSTEM.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on next-20211019

Please apply clean-up patch on top of commit above.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1ad9cbe46b53..cb84a0d46a24 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15336,7 +15336,7 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/pstore
 F:	Documentation/admin-guide/ramoops.rst
 F:	Documentation/admin-guide/pstore-blk.rst
-F:	Documentation/devicetree/bindings/reserved-memory/ramoops.txt
+F:	Documentation/devicetree/bindings/reserved-memory/ramoops.yaml
 F:	drivers/acpi/apei/erst.c
 F:	drivers/firmware/efi/efi-pstore.c
 F:	fs/pstore/
-- 
2.26.2

