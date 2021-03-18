Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D8F3405EF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 13:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbhCRMpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 08:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbhCRMoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 08:44:39 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52850C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 05:44:39 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id e9so5384416wrw.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 05:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4foJK0tE+WL3lsMryI6KM5lFp3YWmzugBxJCQxMDWAg=;
        b=KjxlBIL/5+bh5fCH7X6TiEm7gUUM3pQbhOECaOyCDUnlciMaN1ctbqgcMIBXwrnAix
         dEnoldKG99BkcDQji16mtek9bLZ2WbPFggh6TrJBcd993prFyPlOYME5ezAzuyLIZpZb
         Hfuost30WbKwgh03ZN1jcoo6VrNFfwSOhB14knCXVBoc6oW4lb9E0gtPquJSEHOv8EdB
         8qC9cfLnT6Y6MakvSODWSZjn6RN0HA1ZfTeVvb2WvpqSqqOqnxK6Skkm/AQVvbPJXSnU
         haEHCQIN2IRct3EXsXdJMjsZf16uARxNIPS2KvH3wlHfaxb017igCrGak719QHLDy36i
         Dvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4foJK0tE+WL3lsMryI6KM5lFp3YWmzugBxJCQxMDWAg=;
        b=MdMtVjUXQLEi7cMzs47dT/mMANOk8ZQGcRftlmjxrW+nuCq85dRiz8z5/eAbYBe/5t
         cxv6Dryqifc1q4uR+jybIOvgkgTItfsyuToh2WAcNu78vuLmmxCH8hUZwTbIgFxnkLUU
         nKeSqSKW3J19oFeFPKJBZg6EHhIS3axWBCm3u5r6uzPQHwowv60vgvhcYboKHreq28Pt
         HQVlHwfGbIsQVoK237cB5mbwMGFk6Zo9G3H5XPGZRnO2iGwCkZITVRCcqQZ1ZVXx0RMj
         R9yozDEDkMbgorUHtdFF9hoAUh1RN2SLJdjao0mCvLNijxskzNZSS8WlmCnZOTJmAOkh
         dfdQ==
X-Gm-Message-State: AOAM531xHYS+WDnZQ39JgCMPjdEhT5uWhrN7YepNtt6EcFkut7oklS6y
        OlOXmMv3FrHGHz9v/aCIUbKPiA==
X-Google-Smtp-Source: ABdhPJzMvwSvkYM8ayiGVbfuAWWsOBZ/YUhWo0aTK8kgiiyjoTePFruMU6I3YjYgOX4ZpbmmIBxTbg==
X-Received: by 2002:a5d:4fca:: with SMTP id h10mr10054325wrw.70.1616071478056;
        Thu, 18 Mar 2021 05:44:38 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id q15sm2813900wrx.56.2021.03.18.05.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 05:44:37 -0700 (PDT)
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
        Henrique Cerri <mhcerri@br.ibm.com>,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 08/10] crypto: vmx: Source headers are not good kernel-doc candidates
Date:   Thu, 18 Mar 2021 12:44:20 +0000
Message-Id: <20210318124422.3200180-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210318124422.3200180-1-lee.jones@linaro.org>
References: <20210318124422.3200180-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/crypto/vmx/vmx.c:23: warning: expecting prototype for Routines supporting VMX instructions on the Power 8(). Prototype was for p8_init() instead

Cc: "Breno Leitão" <leitao@debian.org>
Cc: Nayna Jain <nayna@linux.ibm.com>
Cc: Paulo Flabiano Smorigo <pfsmorigo@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Henrique Cerri <mhcerri@br.ibm.com>
Cc: linux-crypto@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/crypto/vmx/vmx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/vmx/vmx.c b/drivers/crypto/vmx/vmx.c
index a40d08e75fc0b..7eb713cc87c8c 100644
--- a/drivers/crypto/vmx/vmx.c
+++ b/drivers/crypto/vmx/vmx.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * Routines supporting VMX instructions on the Power 8
  *
  * Copyright (C) 2015 International Business Machines Inc.
-- 
2.27.0

