Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09BD43C3B34
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 10:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhGKIve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 04:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhGKIve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 04:51:34 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14257C0613DD
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 01:48:48 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id x16so13179862pfa.13
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 01:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xmBVNF3cEBAMpjIOzV2ide26sZ9VrHqywYMernlO7hs=;
        b=LkEkzqdLvypYuo/eqLIYSlLgNFVDbNLJpcjYRypiK9Ph7GStF0gf+bi1Fo5j1H4bbk
         ab6uSKGdSXkj0hYBtv4PKd+KkQy3LNTFX+WYIbgQlGCNxtpDtxzVezMA7VvKTcAu2AE9
         X/lJKjvIMiS5fHwM4NoDlytoTFToyG7TsaduEJ9UTgW3d4VYLVFGdmx/fHulF5uqRZjj
         RB/PX3OSJNLatH7lMR1x9X3FeMzovf8hxk6sLejA5dFQfiiBHsQc09gcVDZK6mW87MVC
         iinFXc61szICO0Kib9fz+j5O1m3Il+wm3+2jXGyX/9AyeIOXZbU0N+RMqEDHEAGIhZev
         uzqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xmBVNF3cEBAMpjIOzV2ide26sZ9VrHqywYMernlO7hs=;
        b=Ps55XAgnS8BC+fBEAeis+9EKu7jNGh39ohOexD/sNZ6A5u3ib4NwVhQvIU29gQOMbm
         7VqKaN7tgSobPt3ZkhH9RnBldQIMMZkYE2pXg0xRhT4ANtcUAPfK4uV/QsF77nnYLO4d
         lY9I/mOKt6OK/kBSHHGHTpLwPS9GN0PUu7SemgMlDFxafhv/9MEz76hz2KsCcA8tELm0
         7Q4QhbBgoSUqoqf4NGZz+Q/5amwoOx+Nu6g53sot3wsjIrHzS/sb2PnaZoqhrXw2xH7h
         TxLJKVTWlLRn8k42IAa+FldSy57hTYBlgFUJxJVUPDo+KvkgILrPCS7FJ8MytclWrLYb
         cSOg==
X-Gm-Message-State: AOAM530yL4lF1BBAu2k+cTCgsbsUxpSncHpa8s/nRSyYgx8loF8K6ZoU
        SuVKIMrN5PXo4sCYh1a5aTc=
X-Google-Smtp-Source: ABdhPJyvwqx3QOCEdzsxNk78mGBi5hTyzOowe2ourrWyab/rUaYP+DuL5+++J63nX9SFsbscrp0BGw==
X-Received: by 2002:a63:5802:: with SMTP id m2mr33046720pgb.171.1625993327511;
        Sun, 11 Jul 2021 01:48:47 -0700 (PDT)
Received: from localhost.localdomain ([49.37.51.242])
        by smtp.gmail.com with ESMTPSA id y5sm927018pfn.87.2021.07.11.01.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 01:48:47 -0700 (PDT)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org
Cc:     lukas.bulwahn@gmail.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: [PATCH] arch:powerpc:platforms:powernv: cleanup __FUNCTION__ usage
Date:   Sun, 11 Jul 2021 14:18:37 +0530
Message-Id: <20210711084837.95577-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__FUNCTION__ exists only for backwards compatibility reasons
with old gcc versions. Replace it with __func__.

Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 arch/powerpc/platforms/powernv/opal-imc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
index 7824cc364bc4..5bafbf34e820 100644
--- a/arch/powerpc/platforms/powernv/opal-imc.c
+++ b/arch/powerpc/platforms/powernv/opal-imc.c
@@ -211,7 +211,7 @@ static void disable_core_pmu_counters(void)
 					    get_hard_smp_processor_id(cpu));
 		if (rc)
 			pr_err("%s: Failed to stop Core (cpu = %d)\n",
-				__FUNCTION__, cpu);
+				__func__, cpu);
 	}
 	put_online_cpus();
 }
-- 
2.28.0

