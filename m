Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D516032BEE9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 00:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386164AbhCCRqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243870AbhCCOhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:37:52 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95100C061A2B
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 06:35:08 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id a18so15722548wrc.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 06:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zaL0nEsFAcBhqqjVU0O9HWEXuIfJLm4ctcMaPZZ2Fv8=;
        b=RVPZjH9OeD0Q3vBT9F5IcbacI94H0pMjvBOauWacuWRPZTgfR3YfdqguV/ZnQDvyFH
         4P0qemUuKRuRUt8Yc8SZrnHKHvtKQ9cGaKJkpi6NIBBNCPROCfc4fEnXyOkHO7eExPHY
         4jDRu+U+3z9ZvSawgncZF2cWI5f5A6QI5pWIcPkxJnfCdOiabSq86MyGS5SDWrKHWd5z
         kT0NjYSc77OLA78GE73g5v2hWNoB+wAS1Z8FrnLXSYukpAFCPKifaMNkyHTCqOcVHCUZ
         hIW42ufS8aRvEBZPanIzd54n2vgOLTEKJsIyAp+6gfkoWBmEH+jOBHc2+9oOUOu+1ZW1
         7Xag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zaL0nEsFAcBhqqjVU0O9HWEXuIfJLm4ctcMaPZZ2Fv8=;
        b=FG3JKfs7hyMQ8054ln2zhbJoVdMRZQk/ojcStQcTrTt2Xrdr2jpx22oJE4Scj7mwNJ
         PtBPpuwVcmA6CAlO3OOl+WWuApVDpf1EJefiVR++0N4ApI5pB/sLsfWNq1fZ2KuiWSWy
         Nb7DejsWrublOJzT5157JWbi0K7lbud2A00uqnOo6jMvgcW9Fb8z9R2sJDouOQ8mE5Fz
         4hncxTmd3jywsZw1YTfv+fAo3YCqWfCG8ufsgx00XMGpnabGMwvrRvpQZdshgibgc1qt
         d8WqLwAQG4K8oRlCj16LbfOHYiHGGtQLE+kGNdexYSFYSLeJa45HLjmIBE8jHnj/iHDQ
         WNVA==
X-Gm-Message-State: AOAM532FCtaQqkylpjOKSBvbO0iQF2tg3TylNajtbBc3EIc3phgmqmVB
        i9toK/kaeKZVvl7MZJL5AllBfA==
X-Google-Smtp-Source: ABdhPJwQbG/PVOiQBFH9B+g96YC3rwRNfhn3v2PigcwjDAYvthlU9U1z+oAptkiiaqAR9SAvu/1tAg==
X-Received: by 2002:adf:8341:: with SMTP id 59mr3553695wrd.130.1614782107307;
        Wed, 03 Mar 2021 06:35:07 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id f16sm31475923wrt.21.2021.03.03.06.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 06:35:06 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Breno=20Leit=C3=A3o?= <leitao@debian.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Paulo Flabiano Smorigo <pfsmorigo@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Kent Yoder <yoder1@us.ibm.com>, linux-crypto@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 09/10] crypto: nx: nx-aes-cbc: Repair some kernel-doc problems
Date:   Wed,  3 Mar 2021 14:34:48 +0000
Message-Id: <20210303143449.3170813-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303143449.3170813-1-lee.jones@linaro.org>
References: <20210303143449.3170813-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/crypto/nx/nx-aes-cbc.c:24: warning: Function parameter or member 'tfm' not described in 'cbc_aes_nx_set_key'
 drivers/crypto/nx/nx-aes-cbc.c:24: warning: Function parameter or member 'in_key' not described in 'cbc_aes_nx_set_key'
 drivers/crypto/nx/nx-aes-cbc.c:24: warning: Function parameter or member 'key_len' not described in 'cbc_aes_nx_set_key'
 drivers/crypto/nx/nx-aes-cbc.c:24: warning: expecting prototype for Nest Accelerators driver(). Prototype was for cbc_aes_nx_set_key() instead
 drivers/crypto/nx/nx_debugfs.c:34: warning: Function parameter or member 'drv' not described in 'nx_debugfs_init'
 drivers/crypto/nx/nx_debugfs.c:34: warning: expecting prototype for Nest Accelerators driver(). Prototype was for nx_debugfs_init() instead
 drivers/crypto/nx/nx.c:31: warning: Incorrect use of kernel-doc format:  * nx_hcall_sync - make an H_COP_OP hcall for the passed in op structure
 drivers/crypto/nx/nx.c:43: warning: Function parameter or member 'nx_ctx' not described in 'nx_hcall_sync'
 drivers/crypto/nx/nx.c:43: warning: Function parameter or member 'op' not described in 'nx_hcall_sync'
 drivers/crypto/nx/nx.c:43: warning: Function parameter or member 'may_sleep' not described in 'nx_hcall_sync'
 drivers/crypto/nx/nx.c:43: warning: expecting prototype for Nest Accelerators driver(). Prototype was for nx_hcall_sync() instead
 drivers/crypto/nx/nx.c:209: warning: Function parameter or member 'nbytes' not described in 'trim_sg_list'

Cc: "Breno Leitão" <leitao@debian.org>
Cc: Nayna Jain <nayna@linux.ibm.com>
Cc: Paulo Flabiano Smorigo <pfsmorigo@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Kent Yoder <yoder1@us.ibm.com>
Cc: linux-crypto@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/crypto/nx/nx-aes-cbc.c | 2 +-
 drivers/crypto/nx/nx.c         | 5 +++--
 drivers/crypto/nx/nx_debugfs.c | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/nx/nx-aes-cbc.c b/drivers/crypto/nx/nx-aes-cbc.c
index 92e921eceed75..d6314ea9ae896 100644
--- a/drivers/crypto/nx/nx-aes-cbc.c
+++ b/drivers/crypto/nx/nx-aes-cbc.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * AES CBC routines supporting the Power 7+ Nest Accelerators driver
  *
  * Copyright (C) 2011-2012 International Business Machines Inc.
diff --git a/drivers/crypto/nx/nx.c b/drivers/crypto/nx/nx.c
index 1d0e8a1ba1605..010e87d9da36b 100644
--- a/drivers/crypto/nx/nx.c
+++ b/drivers/crypto/nx/nx.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * Routines supporting the Power 7+ Nest Accelerators driver
  *
  * Copyright (C) 2011-2012 International Business Machines Inc.
@@ -200,7 +200,8 @@ struct nx_sg *nx_walk_and_build(struct nx_sg       *nx_dst,
  * @sg: sg list head
  * @end: sg lisg end
  * @delta:  is the amount we need to crop in order to bound the list.
- *
+ * @nbytes: length of data in the scatterlists or data length - whichever
+ *          is greater.
  */
 static long int trim_sg_list(struct nx_sg *sg,
 			     struct nx_sg *end,
diff --git a/drivers/crypto/nx/nx_debugfs.c b/drivers/crypto/nx/nx_debugfs.c
index 1975bcbee9974..ee7cd88bb10a7 100644
--- a/drivers/crypto/nx/nx_debugfs.c
+++ b/drivers/crypto/nx/nx_debugfs.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * debugfs routines supporting the Power 7+ Nest Accelerators driver
  *
  * Copyright (C) 2011-2012 International Business Machines Inc.
-- 
2.27.0

