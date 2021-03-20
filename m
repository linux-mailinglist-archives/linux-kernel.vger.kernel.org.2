Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB13342FB4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 22:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhCTVmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 17:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhCTVl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 17:41:56 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3F1C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 14:41:56 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id 7so6759367qka.7
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 14:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WmkUdc+UawEmOx8mi12mwBFnOrtbW4nko08btHWnCoI=;
        b=YAuo3BSi+3NWa3D5mBVIOLfRrTXExAkAEqdNmbM3eNy1opX039InfEUW4m/JLaIvg9
         FIVi/dYO1BMacEZRqhfW+BYkNkomhgu61Ct3vDNuG98omgTjDjTfx7YEBp0X7du+lmvI
         iX7r+DcMYoWpibnKMYx51v5X+1THO+JqJOfiAldxCGydCsyYAyW84WAxbR4AkB5b3dzW
         qRRSmj/v0OVG54ie+THbgdMGncQZKgXcyU46I5BKYHp+wgYbw+0Xp2sUyparHKa05Hl8
         TPn3O0yFVdZIjdVlMm98LYI0bZ0esaa/tReV98CR7Sb4LrATCBoKXXl1UK1CZwwUHNW6
         8snA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WmkUdc+UawEmOx8mi12mwBFnOrtbW4nko08btHWnCoI=;
        b=bc/ouSKxKqDOU2pzkkV+7YAFoEY15l1b2JgG/kvJtayGFUy85YziICbxui47duS8hn
         De35PmL0MDALOAhXezMCFFCjtN42z67eVOg0bz6YCo1jBapcPPefrz0VdoIkSW3mvgal
         EcDV1HvzXGKklCWPrXqkYMVZ0hwFl03tjRcQhSIBG4Bf8dfPAPa15uHwC21qASM1r5Bl
         phPv+fqcdVQ3YNd1ES2yNeY3NI3v1cttqc+NloykVZoTJAKOWfiuJAcCaA6an7Xi4EX7
         rpBJaEGJvnLw2u6Fj732677yObOZ9UVlxBhdp1Gtf78ci+85KDrXgaQ2V6z/GKB/ztgb
         EdYA==
X-Gm-Message-State: AOAM530y/xJYnuwFltFMgSmrzJuYirEQbpHN3euKKJOJ1os6kltds506
        gSZIkSCIKWefgCXx3BWPZqc=
X-Google-Smtp-Source: ABdhPJyjYUwycOeoDxVxu73dJR8lALyAyDQzNWrriNxrRZE0y1MYJEX3AlivH9L5AGZZl1XLfK0USQ==
X-Received: by 2002:a37:a48a:: with SMTP id n132mr4402949qke.359.1616276515381;
        Sat, 20 Mar 2021 14:41:55 -0700 (PDT)
Received: from localhost.localdomain ([138.199.13.205])
        by smtp.gmail.com with ESMTPSA id b21sm7380728qkl.14.2021.03.20.14.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 14:41:54 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        unixbhaskar@gmail.com, rdunlap@infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: epapr: A typo fix
Date:   Sun, 21 Mar 2021 03:09:32 +0530
Message-Id: <20210320213932.22697-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/parmeters/parameters/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/powerpc/include/asm/epapr_hcalls.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/epapr_hcalls.h b/arch/powerpc/include/asm/epapr_hcalls.h
index c99ba08a408d..cdf3c6df5123 100644
--- a/arch/powerpc/include/asm/epapr_hcalls.h
+++ b/arch/powerpc/include/asm/epapr_hcalls.h
@@ -65,7 +65,7 @@
  * but the gcc inline assembly syntax does not allow us to specify registers
  * on the clobber list that are also on the input/output list.  Therefore,
  * the lists of clobbered registers depends on the number of register
- * parmeters ("+r" and "=r") passed to the hypercall.
+ * parameters ("+r" and "=r") passed to the hypercall.
  *
  * Each assembly block should use one of the HCALL_CLOBBERSx macros.  As a
  * general rule, 'x' is the number of parameters passed to the assembly
--
2.26.2

