Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 462A944A68F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 07:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243015AbhKIGFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 01:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242994AbhKIGFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 01:05:51 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F8DC061764
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 22:03:05 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id az8so17859312qkb.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 22:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vrflsHLJJKbq5LcG2061Ju1pP8QpTtQawMVflvqYnAg=;
        b=Tu+mxOwGGkhzyt4zOMgbBhl1GWME8FakqXm75kpbrNkvjBdvtytjS7Qfx29wb0Qq5Z
         EE/pzjhQYIIc/4ff89sdCi/vbFePK1yw0X5yubsHvYHpzu8QBfBb2qi3abtPhnnxFbVQ
         4SSBt8T0wzPxiER4ym2WM7/IAHF0/FFTeK5qWs+WsBMpSXFpT8/vpp9mrWEFYzisLXDu
         tPrctDX/8X/RkExzgY2Mw6MQ0c/IWa+YdFZmzcSOeFbTBGQkHMqgBffCiSda4l/DFara
         IrFIk99BNp6bM2XfwWvE3aESJw0dvb8mMF6jXN+nDGaqsLym0OyaQbuqr1NSMGyxgcHd
         r/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=vrflsHLJJKbq5LcG2061Ju1pP8QpTtQawMVflvqYnAg=;
        b=31yW3Q2O8qXAqDXn0QgiQnd4iKvpDFQocl4WSvmzogzsXZFz4SUEIEROBSY/Kg+clR
         f9Z+8HScFjZvTe7nGqyv3Qii2cA9+Z5DfFdBKTjoIlzMogv3qSObdlYLXOgFDMuf3Rmo
         UjLZio0mXul5gui4b7euduUWwgF752NeiqV8Sgb+O71v5JCWNvOdG9ojqbovZfM3jmtL
         r7NGt3n+Nt+CEuz32o2jj+oaUHTYgWbtwBgdtkGbfCv53FMORTpkkCXAjswlFZmGJUJr
         PmZpVTfiv6HZVpTO3FwjgLuIt1hFqyh5Z+J398ManBl0NvrH0BUmf0hwt1l+PrRAw0H/
         N7ww==
X-Gm-Message-State: AOAM532IakhSvp4Xtgjf4CRM9vuo5nKSF3AhhzbU95G+RrSjd0UYEmGu
        D54VZsYxTDSx6+joeZ7tUsQNriPTtszfiHed53g=
X-Google-Smtp-Source: ABdhPJyVr8tb5D/HUggT/ic1KGv/omKrNlZQGe6f8VpKdiu2AOYiDPA5d5PJRgsZ4jmWbhlclm8w2w==
X-Received: by 2002:a05:620a:2444:: with SMTP id h4mr3943718qkn.398.1636437784757;
        Mon, 08 Nov 2021 22:03:04 -0800 (PST)
Received: from localhost.localdomain ([67.8.38.84])
        by smtp.gmail.com with ESMTPSA id h68sm10978703qkf.126.2021.11.08.22.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 22:03:04 -0800 (PST)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     linux@armlinux.org.uk, arnd@arndb.de, linus.walleij@linaro.org,
        geert+renesas@glider.be, mark.rutland@arm.com,
        akpm@linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        fazilyildiran@gmail.com
Subject: [PATCH] [PATCH v2] ARM: fix unmet dependency on BITREVERSE for HAVE_ARCH_BITREVERSE
Date:   Tue,  9 Nov 2021 01:03:02 -0500
Message-Id: <20211109060302.56362-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When ARM is enabled, and BITREVERSE is disabled,
Kbuild gives the following warning:

WARNING: unmet direct dependencies detected for HAVE_ARCH_BITREVERSE
  Depends on [n]: BITREVERSE [=n]
  Selected by [y]:
  - ARM [=y] && (CPU_32v7M [=n] || CPU_32v7 [=y]) && !CPU_32v6 [=n]

This is because ARM selects HAVE_ARCH_BITREVERSE
without selecting BITREVERSE, despite
HAVE_ARCH_BITREVERSE depending on BITREVERSE.

This unmet dependency bug was found by Kismet,
a static analysis tool for Kconfig. Please advise if this
is not the appropriate solution.

v2:
Changed this fix to remove the dependency on BITREVERSE from
HAVE_ARCH_BITREVERSE, since it isn't actually necessary.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 lib/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 6a6ae5312fa0..22975a87fef8 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -45,7 +45,6 @@ config BITREVERSE
 config HAVE_ARCH_BITREVERSE
 	bool
 	default n
-	depends on BITREVERSE
 	help
 	  This option enables the use of hardware bit-reversal instructions on
 	  architectures which support such operations.
-- 
2.30.2

