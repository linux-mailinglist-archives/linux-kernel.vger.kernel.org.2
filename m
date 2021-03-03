Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C0732BA75
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 21:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351595AbhCCLXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 06:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237829AbhCCCFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 21:05:36 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6D3C061797
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 18:04:45 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id t26so15204961pgv.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 18:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uSV5pC2Oc46URYUg4vRkVcFkmbh0BpY3IJRMt1c2+RQ=;
        b=a5waVDHv4yhDO34gEPR0QkqxIymU5LbWrUN3KxzjJoc5BQ/Oy83Uk6S0EIlJcPwUnC
         /VS3QTghu6jk3nWMPzthUlOeTiA5CAk45JPP8NYh1oTGIMaFNBR40j5+SO1oYci4aXDL
         oTzmrx7g9BFjX4FzE7Pi0CphiEZOAjzWXv3A+DaeO38y9QZe5c5WAOQ6sht8nMl2ei9p
         kk+Wa0ejQ6lZ4vE7fLqGYrMb4phGP6sJkD7D/omCxlIIiNTEkMATgLYkD6gFBfBFhiXL
         OB+LHNvCGZsPP1gzllKDHooGfdYCdk47aZe3Nz1oFuJbuoKSynI7oYi1UUpfGkLAzF97
         8Pvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uSV5pC2Oc46URYUg4vRkVcFkmbh0BpY3IJRMt1c2+RQ=;
        b=pn/bSXAI1vQsXSa3b4lW61vx0DV4kHkINezgwcyEgfpZIAW6ex7/fSx2D6hD0etVZF
         KIomaLZtJ7AxR09Cb+GFqf6e9HRk6pIUrYH+kDleiOfS8dcxpKtoCi0EgZeZH53BCcSV
         9JsWUsFwqcVYtp5XJ6Nv+KsLYJSg2+aFIXDSJyDospD9q3sf/HOLoKw/K2EXPPu9uuRp
         NP/cerjWf1NsfJmbSn+/KSqASmHSVzBlfMxnNdZRZvh2JlXLKZjnyG2ksG/kgEdanW45
         4/I7OlaPngoHhtHDRtLIDrkgd9244iLTOtw0WphQO99hmxMDzNItKuJo6Af8vpbg8tGB
         oxiQ==
X-Gm-Message-State: AOAM533prWp3csI2FOmjbC1fb6l87fgLl8Jf1ymXc3cfadS4UbKWLyRV
        Dn04YdzftInIpsUp5fhvnFc=
X-Google-Smtp-Source: ABdhPJwqGtelapVjpvam/hBjAyZNqg0eqlG90fnPODcVfqj//UTkiV7mgc3tYE4CCFrOVleZ69yXOA==
X-Received: by 2002:a63:2604:: with SMTP id m4mr52605pgm.423.1614737084651;
        Tue, 02 Mar 2021 18:04:44 -0800 (PST)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id h3sm20747929pgm.67.2021.03.02.18.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 18:04:44 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: zhang.yunkai@zte.com.cn
To:     vladimir.murzin@arm.com
Cc:     linux@armlinux.org.uk, akpm@linux-foundation.org, rppt@kernel.org,
        maz@kernel.org, geert@linux-m68k.org, anshuman.khandual@arm.com,
        zhang.yunkai@zte.com.cn, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] module: remove duplicate include in ./arch/arm/include/asm/pgtable.h
Date:   Tue,  2 Mar 2021 18:04:22 -0800
Message-Id: <20210303020422.174818-1-zhang.yunkai@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Yunkai <zhang.yunkai@zte.com.cn>

'asm-generic/pgtable-nopud.h' included in 'pgtable.h' is duplicated.

Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
---
 arch/arm/include/asm/pgtable.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index c02f24400369..f3124e57be83 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -9,15 +9,14 @@
 
 #include <linux/const.h>
 #include <asm/proc-fns.h>
+#include <asm-generic/pgtable-nopud.h>
 
 #ifndef CONFIG_MMU
 
-#include <asm-generic/pgtable-nopud.h>
 #include <asm/pgtable-nommu.h>
 
 #else
 
-#include <asm-generic/pgtable-nopud.h>
 #include <asm/memory.h>
 #include <asm/pgtable-hwdef.h>
 
-- 
2.25.1

