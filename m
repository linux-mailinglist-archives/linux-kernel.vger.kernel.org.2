Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73574338F42
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 14:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbhCLN60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 08:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbhCLN5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 08:57:51 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE381C061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 05:57:51 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id 68-20020a9d0f4a0000b02901b663e6258dso1421530ott.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 05:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AHfuJMq3vwyoBDCpgJM3KmGD2Pa3M60SW2r9HL22pz8=;
        b=Rjf8XQ0Dw01CTibeSyc80hYATpX7r/YNusQ346y14D4fdgTJC8oFBVn9kCP034LhJo
         f36wpX4iy0hMWhL57+nqiQHcQxLUk+QOEodFQYGUHEL6+iMGbkBoULTT3mKsP+RdIiRc
         QiL9dT41GQDoiH2C+qtvWAZwJa0k6KHd7cHSbm88XuhNcOJK7OGQ1nOq1VdGNYure3B6
         Wd/jiAiCQgitZ7ZoCWGOzKVWSsaUy1ZXUt2Fpo6kS+E5aOiRSehst66RTZ4qTsRu42Vr
         XxmTLXldUnvLErfmdIRBgE+Xieppn4ETd2LkR8/D1TQ+6X9bZ0vVvm5W02mDkYQ/S6VM
         hO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AHfuJMq3vwyoBDCpgJM3KmGD2Pa3M60SW2r9HL22pz8=;
        b=uOKzG0CIT/wpoBr9vPt7nA8pCQ43ocD8WB40IhfXnljZXK2g+1F2ms6a5up1d0Uj8t
         RtaFNG5h07jE5JXzwp0TH1b0py+IiIgE4uThgT3LqdcCOAKVdJLbGmeyhKRFwBvcIwv0
         gxcNtYPz93Xe8WeVnp69Xo92sWNyK62sbbUPne8S8BQqAdCiiVWnoJCEl4I6h1L8++7A
         hGXJG5KnSoj5yQzCDRtBZ98wIZFNu9KCi+dy3k8nIk9TH1lzCJNgNvbC3cHk0epxFio7
         vqFQa2UZqDPtRy3RsY2kgnyKr7BJJM82J8Ih3PqstGWuz1pFlKkHdrtcKqEDGdftpwCI
         oJpw==
X-Gm-Message-State: AOAM533EXwlAF/sYJ7Z7dTOLvQFJBz7nYGhLfmfd0+uug/zTVCPO/S2c
        O4b221U9IRACJ2KBj3cYh0Hy3A==
X-Google-Smtp-Source: ABdhPJxzya4dmltdm8KZIA1P9WELxRn5aNvoLOU3kE652omBKYVRZ+tQwb7uwYc4D6SBSSF8XWLRog==
X-Received: by 2002:a9d:3a4b:: with SMTP id j69mr3414145otc.47.1615557471058;
        Fri, 12 Mar 2021 05:57:51 -0800 (PST)
Received: from winterfell.papolivre.org (winterfell.papolivre.org. [198.58.116.17])
        by smtp.gmail.com with ESMTPSA id z14sm1341908otk.30.2021.03.12.05.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 05:57:50 -0800 (PST)
Received: from localhost (unknown [IPv6:2001:1284:f016:8458:4b63:e980:6768:80b4])
        by winterfell.papolivre.org (Postfix) with ESMTPSA id 53F811C2F43;
        Fri, 12 Mar 2021 10:57:49 -0300 (-03)
From:   Antonio Terceiro <antonio.terceiro@linaro.org>
To:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] tools/power/x86/intel-speed-select: drop __DATE__ and __TIME__ macros
Date:   Fri, 12 Mar 2021 10:57:46 -0300
Message-Id: <20210312135746.1695294-1-antonio.terceiro@linaro.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These macros introduce nondeterminism in builds, and break reproducible
builds.

Signed-off-by: Antonio Terceiro <antonio.terceiro@linaro.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 tools/power/x86/intel-speed-select/isst-config.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index 582feb88eca3..c50c754a656e 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -2791,7 +2791,6 @@ static void usage(void)
 static void print_version(void)
 {
 	fprintf(outf, "Version %s\n", version_str);
-	fprintf(outf, "Build date %s time %s\n", __DATE__, __TIME__);
 	exit(0);
 }
 
-- 
2.30.1

