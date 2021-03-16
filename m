Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB1B33D0DC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 10:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbhCPJbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 05:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbhCPJbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 05:31:02 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B26C06174A;
        Tue, 16 Mar 2021 02:31:01 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id p8so70926360ejb.10;
        Tue, 16 Mar 2021 02:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=mKyD04bglr1Sf3KcK5qmVWfIuzVPHE5LxLl4KNgB9Hk=;
        b=GZ3Kt6bBjGkStAnyLKXXvKyyYGjZoQTUobzOi2CLdoKJlaxbQOHQ1D3ZB5JgJO8rdJ
         oce6ew3Z82zlghC4+f8sCeVQ2awNrMrgFVmP8ooNFeTZJtT+VQXhY0ZwxW7fq36bCKJk
         2QPFmlUB8CnU77AB8BX/3xQt3C3eMxX5rVNHyKIVl09F275O0ZgZPNSNkqnH6iWtPd1k
         GbCZOJ2GC0pQEssrd3z5nUCT/znzaXcYDTnrGGXpaiV6dGoZ+IMMz/bgQWhBgzKR0bV5
         hiDMYKX/tJ19sDRuuXZi/cG8ESXC7YCAUTuWEQ3sq3Cnq6cdbYuv7fWng2CbrL4k8cd8
         RzfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=mKyD04bglr1Sf3KcK5qmVWfIuzVPHE5LxLl4KNgB9Hk=;
        b=p2WLgC4EbFB2TEYQb273z8QkDoZ8Sy2MYcsNbHTvRzy93mEDMGX9+TyLbYC59w7S2B
         kN+O6TZNyfW39PTf3xm7j/ep0EXl7GB47U6vCowrlmEz9QBfpR3EJ49iNZ2FKmngMWzE
         nafxnsD9MZotwryNUdmmtOz4ueIirA2v+/3vqM0nREexv61Fnz9/FuZyys0GFkKtaRGr
         oem0HKLt1nR4AHyEdEfKmRhDBcGRpezRaghFl/Cl2rZTNmJqfDejupS8uiFmEB1NIyiu
         XrDep8ZHCQFurJs/9TXQU1zFFv82DTLTxg5htgodlsljmz3V9aO0eLrST3IKINGdUYu2
         MMPg==
X-Gm-Message-State: AOAM5322iZMn027hijXmsc6eIOB0027nq7Lsidi47lxypGpzjVcqybxw
        cs8NnySGoT9G/d6K1RFvPKw=
X-Google-Smtp-Source: ABdhPJyGC82p29PYH/4Aj46qdXhM0kD2BUKFUFNMkxLnTByq+zAVsDmSgc8Z2uVDcNMDCffcZJtjiQ==
X-Received: by 2002:a17:906:4d18:: with SMTP id r24mr28021342eju.493.1615887060439;
        Tue, 16 Mar 2021 02:31:00 -0700 (PDT)
Received: from LEGION ([27.255.58.138])
        by smtp.gmail.com with ESMTPSA id a9sm6340486eds.33.2021.03.16.02.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 02:31:00 -0700 (PDT)
Date:   Tue, 16 Mar 2021 14:30:54 +0500
From:   Muhammad Usama Anjum <musamaanjum@gmail.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     musamaanjum@gmail.com, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: Fix spelling mistake "initialisation" ->
 "initialization
Message-ID: <20210316093054.GA1081018@LEGION>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in a comment. Fix it.

Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
---
 arch/riscv/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index ea028d9e0d24..1ec014067855 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * SMP initialisation and IPI support
+ * SMP initialization and IPI support
  * Based on arch/arm64/kernel/smp.c
  *
  * Copyright (C) 2012 ARM Ltd.
-- 
2.25.1

