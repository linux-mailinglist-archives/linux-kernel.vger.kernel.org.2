Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3067D44EF2E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 23:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235931AbhKLWZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 17:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235466AbhKLWZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 17:25:09 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED17C0613F5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 14:22:18 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id r8so13050390iog.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 14:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vBvf+NulIyt0LTL/apruhCuQuT1ch+DwHu+pDQ7AiQw=;
        b=RRVA0tA2+HDRrngBIjTLvD9iiLWFFT1PXs2jwihVCqapwBP30Z1UPD4y7M1mFe6/a0
         JUbWBeZneQDSyrIyrfApEJeP5ghlXt9aTIKWrEkGcx/RxzDsSePjQYF+PWL56N+9R5nx
         sQH49N0O764b40Uu1qaEvrqiD2512e/qtJMkp+0ER+byhlvT/pgVbWlSKjodwNJai4V1
         1sZ4ZsB9ApTlVmf3pTzMuP7PmOymMvM8P5qbJb2OyAVjU0DByqo3NYPg+AIdO5HwMHE1
         5e5SB+F3pRtVf2711swQy04i9maplbZ33qLkdWn2OhDBA6Pwd1YOVQGFR8cU05iO60lx
         01iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vBvf+NulIyt0LTL/apruhCuQuT1ch+DwHu+pDQ7AiQw=;
        b=LKPWlxFJnK4Uare6X27NiynjRofKeJPBRnlHOfm9IlNkkNPP3t4mcRqfD33KTU7lu1
         +tDzHPQY7sfbK/dVlBBtHB8d+pMI3BmNM9WluwKY1xYDUP6tuyuLAnTpRFvcnvmiIoaY
         xPzTc9HSmtvdcHj5Cwe9FiwdU0FxdgcL5i2FzLBSvILi/fID21jPTuvcc3ZF9qNaXj9E
         MiQbmzy1t5+sbyg3Ithi0ABuOMPggAj5tP8oTXKr9usUc1E33UUds1HFMGxxyOyk7gTq
         +/5tEOb3BBCPcAKlGrJSvwEWHVS5t5PoSxuebwP9Ij3ersMYVnMrju6Lny9/08W2F8D4
         ItRQ==
X-Gm-Message-State: AOAM533tTNG2liFXxe7UGjQZbILMlbaecxvJvS7ZEeHRoKerImGAQZBW
        mLd7OOKGUwpNLzTNjwIThtcY3Q==
X-Google-Smtp-Source: ABdhPJwWtlycZTqGisu6Ug8roHF41gN5Bw9kANuFsx+AcIeRV3NfUqORFWEADHDWMISB8wPg4692Sw==
X-Received: by 2002:a05:6602:140d:: with SMTP id t13mr12888620iov.120.1636755737658;
        Fri, 12 Nov 2021 14:22:17 -0800 (PST)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id y6sm5241117ilu.38.2021.11.12.14.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 14:22:17 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     pkurapat@codeaurora.org, avuyyuru@codeaurora.org,
        bjorn.andersson@linaro.org, cpratapa@codeaurora.org,
        subashab@codeaurora.org, evgreen@chromium.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 2/2] net: ipa: disable HOLB drop when updating timer
Date:   Fri, 12 Nov 2021 16:22:10 -0600
Message-Id: <20211112222210.224057-3-elder@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211112222210.224057-1-elder@linaro.org>
References: <20211112222210.224057-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The head-of-line blocking timer should only be modified when
head-of-line drop is disabled.

One of the steps in recovering from a modem crash is to enable
dropping of packets with timeout of 0 (immediate).  We don't know
how the modem configured its endpoints, so before we program the
timer, we need to ensure HOL_BLOCK is disabled.

Fixes: 84f9bd12d46db ("soc: qcom: ipa: IPA endpoints")
Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_endpoint.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
index 006da4642a0ba..ef790fd0ab56a 100644
--- a/drivers/net/ipa/ipa_endpoint.c
+++ b/drivers/net/ipa/ipa_endpoint.c
@@ -853,6 +853,7 @@ static void ipa_endpoint_init_hol_block_timer(struct ipa_endpoint *endpoint,
 	u32 offset;
 	u32 val;
 
+	/* This should only be changed when HOL_BLOCK_EN is disabled */
 	offset = IPA_REG_ENDP_INIT_HOL_BLOCK_TIMER_N_OFFSET(endpoint_id);
 	val = hol_block_timer_val(ipa, microseconds);
 	iowrite32(val, ipa->reg_virt + offset);
@@ -883,6 +884,7 @@ void ipa_endpoint_modem_hol_block_clear_all(struct ipa *ipa)
 		if (endpoint->toward_ipa || endpoint->ee_id != GSI_EE_MODEM)
 			continue;
 
+		ipa_endpoint_init_hol_block_enable(endpoint, false);
 		ipa_endpoint_init_hol_block_timer(endpoint, 0);
 		ipa_endpoint_init_hol_block_enable(endpoint, true);
 	}
-- 
2.32.0

