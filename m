Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B380445548D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 07:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242805AbhKRGJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 01:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242748AbhKRGI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 01:08:59 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DBAC061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 22:05:59 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id v19-20020a4a2453000000b002bb88bfb594so2033482oov.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 22:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GH5DsMQ3QaWgiH0MtT4VPh8uW1FF7ANWq123A9PIt3o=;
        b=qmL3blZ9nlnWuevH3rA18HtJtKXlurKxYR/1Rp5rBHLDOU5JFq4dprX0iD2YNXF4al
         m0NyR+CqsknraoB6x92KS4a+OsNDUzqfqCxsArkrxNMsXNMYpaxg+pC3UGYh3Z43C+Tw
         wgikDxMfbXo9d9U4E256aDQjLLrv8WrVxdGBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GH5DsMQ3QaWgiH0MtT4VPh8uW1FF7ANWq123A9PIt3o=;
        b=30hScnfucD+Rt+0Zr0s+r/uCEO2q1vcrJB2oLEUfo/lp2adIa5vey4DTHkvc+TmfX6
         lR+GWW6n7jM/kdOhLZXitsQjWB46bov4JI5RDxifOoLQ+H4zCth6jAsfbtlmauvpG4CA
         gqk2Yjfys7z1mhb+TmR7+saE/YU2x8IC7DAd2XRENsHQ96MmqWpPPbuLeL04W1Siudrn
         4YIm060oJpK2yV/lWhcRdhchQgeEH1qy5zVN8jMDIA+sTLchLb1Xg27XJL7gMrScHmj/
         pLU3qC6XrXzLPNKf8qnpDWPTvXFSiJrsvG6vSwfvBREMALeh7U2ulIodQ7hMTAxMaDkT
         vyBw==
X-Gm-Message-State: AOAM532AZGsnYwXkTLqTCMEdjRcrTqvxrG2nRwbYQwVacLFACpPmq8Hw
        tPG65jKmM5lDXt67BsEtM8EKDZHIs0lq6h4=
X-Google-Smtp-Source: ABdhPJztZycF+YPOFZurRn2NUYVGfHgy2vIKmAmLQyQSIRA6iSyF9c1bLqOzpWJpW8w+rIrswzT1+w==
X-Received: by 2002:a4a:5842:: with SMTP id f63mr11953351oob.97.1637215558524;
        Wed, 17 Nov 2021 22:05:58 -0800 (PST)
Received: from fedora.. (99-13-229-45.lightspeed.snjsca.sbcglobal.net. [99.13.229.45])
        by smtp.gmail.com with ESMTPSA id j20sm395379ota.76.2021.11.17.22.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 22:05:58 -0800 (PST)
From:   Atish Patra <atishp@atishpatra.org>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@atishpatra.org>, anup.patel@wdc.com,
        kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH] MAINTAINERS: Update Atish's email address
Date:   Wed, 17 Nov 2021 22:05:01 -0800
Message-Id: <20211118060501.932993-1-atishp@atishpatra.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I no longer employed by western digital. Update my email address to
personal one.

Signed-off-by: Atish Patra <atishp@atishpatra.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a2345ce8521..b22af4edcd08 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10434,7 +10434,7 @@ F:	arch/powerpc/kvm/
 
 KERNEL VIRTUAL MACHINE FOR RISC-V (KVM/riscv)
 M:	Anup Patel <anup.patel@wdc.com>
-R:	Atish Patra <atish.patra@wdc.com>
+R:	Atish Patra <atishp@atishpatra.org>
 L:	kvm@vger.kernel.org
 L:	kvm-riscv@lists.infradead.org
 L:	linux-riscv@lists.infradead.org
-- 
2.33.1

