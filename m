Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B7130DCF8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbhBCOha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbhBCOfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:35:14 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6AFC061356
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 06:33:20 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id d15so17609687qtw.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 06:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YJE2aPOEkLIKEj61l27Ctrd7+4+SFwAw4jzWQDD0G1c=;
        b=SJdUE6vYWhFUDqioD70Bas/UqqRLldg90N4oVMpwXEUF6VEH8kh7yyBgzz5rjSx1pJ
         a2gP2yoiqctYUMtHP9KuGiMKC+5IlB6SY2iujGxSe70FH5ex/qaY+BkgYgFkIn9jttYK
         wdWPF4nbDZfqW7NxJehEmslBC2Zrrr4YKqpe+NSHxxMaNjH5cADHUkf9euHOeV1VDIjO
         W2vf2dn2x28Uk708KnYDQSU8ZUh5YyyEAVZu+g+rWZ48Flz62f3ikVMnFjXb9Gtpkz0Q
         bjSX1nJBc1rYCeGu1A/Z0G+sj0BQJIna4mn3F/NRU7VAw7AK7sPo4FyOJMM/YX9nYIZE
         ApmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YJE2aPOEkLIKEj61l27Ctrd7+4+SFwAw4jzWQDD0G1c=;
        b=iUMCzVRJF3h+t4eJKAfw4lPEUy/+G/lj7zRlJH+YE0VpZxOeu4Kc+np8Te9OE3LPbw
         RtWZP2Sv1M42td7W23VGxL9jIK06/rNqGnSMwT73WlOqQCbV2qRetlO5kbejAUdBn+ia
         44o81G4eVry9VuILLHwytH0e7XEL9anplya0+P8XvZLvFLzxkuK2TvE/YKlPm9iWRp16
         e+k+tiREEMK0vvcbItqJnqd1qEgGLn7i2BnSXGkh+RhOE1lxzc4gLK710/ZhB03Hosix
         CP3pqMu+f8TobcWUwXBgSJjGJJhDXl+zrQmGefqAk867Z0ENJwnrE+M7Cbfe/yKy60V+
         x7AA==
X-Gm-Message-State: AOAM531TLeEDlVIF9mfcnE+5EVZBTk/PHBSknOUPFKCpc727fBNkWda5
        d0Kl5PzbO8JvcHV40Vcj2N0yHg==
X-Google-Smtp-Source: ABdhPJxHfVjx5+yi3N1T967Q6Ylxy/lC8PdXs9lSNKroQLsYPplpCwtlj+IXkPC9rhLv30IXV+WFzw==
X-Received: by 2002:a05:622a:1d4:: with SMTP id t20mr2577449qtw.281.1612362799777;
        Wed, 03 Feb 2021 06:33:19 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id v15sm1775433qkv.36.2021.02.03.06.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 06:33:19 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/11] crypto: qce: Remover src_tbl from qce_cipher_reqctx
Date:   Wed,  3 Feb 2021 09:33:06 -0500
Message-Id: <20210203143307.1351563-11-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210203143307.1351563-1-thara.gopinath@linaro.org>
References: <20210203143307.1351563-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

src_table is unused and hence remove it from struct qce_cipher_reqctx

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/crypto/qce/cipher.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/qce/cipher.h b/drivers/crypto/qce/cipher.h
index cffa9fc628ff..850f257d00f3 100644
--- a/drivers/crypto/qce/cipher.h
+++ b/drivers/crypto/qce/cipher.h
@@ -40,7 +40,6 @@ struct qce_cipher_reqctx {
 	struct scatterlist result_sg;
 	struct sg_table dst_tbl;
 	struct scatterlist *dst_sg;
-	struct sg_table src_tbl;
 	struct scatterlist *src_sg;
 	unsigned int cryptlen;
 	struct skcipher_request fallback_req;	// keep at the end
-- 
2.25.1

