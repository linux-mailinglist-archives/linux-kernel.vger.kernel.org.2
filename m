Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D999530F1D4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 12:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235746AbhBDLPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 06:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235581AbhBDLM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 06:12:58 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF28C0611BE
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 03:10:28 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id o10so5705790wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 03:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qhRaK7PEb1+VQbMXp2izacC8TWHkvWpyOp/JFxz8PSk=;
        b=t5B27kseFaSQ07V34VI0+HtMHwzq/iu5wofl4aAA12lmp4bvmT9K7iM/vMiDXIvfmp
         5gVTdvI880u0uezN8PA5uIEwySqb7up76wrmGmKbG1myjs2VLsWE41EmwhWLr4HqTC1N
         dSWu8oC3jxsrIUtMphZ3UnYweS/gT1cGYPQro/LAqTh8PfiMVie9VOuiCMMw/FCWcRVp
         KYrsbsjbMBWMfB4KzcX4FNY+xNmfKOi2vhUA9bUpdllUDvj/CfDlineW9XKQ3Y3VG35l
         XWS4BgTzWKinSO0ZTFANwZbF6Ha33pKPf9YaE8v6ow6eiLsU6AlkdjcQfU9JeHTSEMv0
         eGgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qhRaK7PEb1+VQbMXp2izacC8TWHkvWpyOp/JFxz8PSk=;
        b=dxuhJog7OiM/XSsydYAncylWjQcQjwpzFSLhltSUR7zpgp99eOdhVLe7gwWPLllzO+
         KXyICTkU/VxB0nIl0YYiiVwaGV41EG46DfTUMDiqZWJm65qeJcsog8KcgKbu7K0/ueO2
         IFeAr0k/i8kG02cJDPpRK9xIsu1JINaRhBjXpK+vTl3gucmyGNGoUzuD9WRg5HMyA6Xw
         oQbEOFJMAELOsE36pT85sXE/AZVZqnXoCHyYIWSCiG8SuMX+AxmpkF06V5Wk0shPARu4
         ebmXMMkhKxwqCLemQVwLnqbpeZHJrdIIwl/84rSk4WpdsZtE3LoVzGbF5wGpd+QHkzPR
         3BiQ==
X-Gm-Message-State: AOAM533e5UXnupUc3cPM7GerNCHnutJhMwtl/tezbRa23FzgfPM/eTJr
        gjc5NAzIaWgJN4tkMi9NFc5NvA==
X-Google-Smtp-Source: ABdhPJy3ovJmVWJwfdQ/ifr6A3rN/+QEp57dStSFcBGixXRzwdnUgrj5/e3P+zqOCrmcKmI+TdyFRA==
X-Received: by 2002:a1c:6688:: with SMTP id a130mr6944242wmc.1.1612437025976;
        Thu, 04 Feb 2021 03:10:25 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id y18sm7696218wrt.19.2021.02.04.03.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 03:10:25 -0800 (PST)
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
Subject: [PATCH 19/20] crypto: nx: Demote header comment and add description for 'nbytes'
Date:   Thu,  4 Feb 2021 11:09:59 +0000
Message-Id: <20210204111000.2800436-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210204111000.2800436-1-lee.jones@linaro.org>
References: <20210204111000.2800436-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

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
 drivers/crypto/nx/nx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/nx/nx.c b/drivers/crypto/nx/nx.c
index 0d2dc5be7f192..010be6793c9fc 100644
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
-- 
2.25.1

