Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465483A202F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 00:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhFIWha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 18:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbhFIWhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 18:37:16 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8189C0617AD
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 15:35:12 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id t6so21035890iln.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 15:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LZrDcpMMlqQu3fRlEZdQrN5iR4OJZ5NusdCMN67AVgE=;
        b=VbBBEnLk5xTZzb/Cb2h0QG052xVazdTaNFC9Ne4MPDWmHwZVI1eml2LfDSVsYrPYzQ
         0Lwmhh8zfTil+/PVpu9d1BOEVunxHLuNarzy7Iu61t+0fKku3GUIpX4Rl00/iqyxm2my
         yJ+lwHU61V8PmRCLijwoGkjbWG4X3OrQktTMo41JXZTvoVQDGAFpkQJTIa/x+lbWCt7k
         gLk/3Qyu2F4/jh/6hHojgXRgHXt8/AwPXwGWKhh5hWDsfVUrec6yNXI0vRyPK4n0iErD
         bCPNw+VgqJ1+D75PXzcjr60A4vpI3Gk0IPYrXTAyufM/i+SjmDtXKghUokm461nAXGFO
         8YPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LZrDcpMMlqQu3fRlEZdQrN5iR4OJZ5NusdCMN67AVgE=;
        b=YGPKDe+9Th/PxgoeNhgGN3wo4fqeQ1M7SGRc4kbk8iK9vm3YHSTVtbMoqdN4x5BoHB
         lT5rzO7GQFhQ0l5CBwWBvlwMwjmdimARSPzOmyyNhiMt1LdwuVJklMF7CZJtlNgfDAEm
         I0Y4/IEVz1YvYxRdR4obogZNUkST9eC5V/RwX7HMNy/P3lF7ZpWx850fiITGXjj4z9zN
         +9sWCqPLZnOGzB8DfrYor15pKEVM47xCznU0CLQqXrAmFagXqzJXm+c8l7BfzQivlJfV
         Gkr061pVpp8iDlQ8X3/FKwMUGKN5MRJTbE3ojPjCziokPmlBuMZjMqoKimjAaEDbKA04
         ctDw==
X-Gm-Message-State: AOAM533cVsp3Ds+E7AAiI+kGvPa/1VfZvBNZN3+nr1Jil9i7EsD+/YZA
        uQm2QMHbw5O0dA8NFMODQI2vIQ==
X-Google-Smtp-Source: ABdhPJwojNRR81zbsSbZ/Jyrq2irJoQxLzBQrqQbEYIrJZqjvlarKRQfq9Ipy0Y+MgW61CgekQY0pw==
X-Received: by 2002:a92:c68c:: with SMTP id o12mr1473796ilg.6.1623278112288;
        Wed, 09 Jun 2021 15:35:12 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id c19sm750165ili.62.2021.06.09.15.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 15:35:11 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 06/11] net: ipa: validate memory regions at init time
Date:   Wed,  9 Jun 2021 17:34:58 -0500
Message-Id: <20210609223503.2649114-7-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210609223503.2649114-1-elder@linaro.org>
References: <20210609223503.2649114-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the memory region validation check so it happens earlier when
initializing the driver, at init time rather than config time (i.e.,
before access to hardware is required).

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_mem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ipa/ipa_mem.c b/drivers/net/ipa/ipa_mem.c
index f245e1a60a44b..b2d149e7c5f0e 100644
--- a/drivers/net/ipa/ipa_mem.c
+++ b/drivers/net/ipa/ipa_mem.c
@@ -215,10 +215,6 @@ int ipa_mem_config(struct ipa *ipa)
 	ipa->zero_virt = virt;
 	ipa->zero_size = IPA_MEM_MAX;
 
-	/* Make sure all defined memory regions are valid */
-	if (!ipa_mem_valid(ipa))
-		goto err_dma_free;
-
 	/* For each region, write "canary" values in the space prior to
 	 * the region's base address if indicated.
 	 */
@@ -528,6 +524,10 @@ int ipa_mem_init(struct ipa *ipa, const struct ipa_mem_data *mem_data)
 	ipa->mem_count = mem_data->local_count;
 	ipa->mem = mem_data->local;
 
+	/* Make sure all defined memory regions are valid */
+	if (!ipa_mem_valid(ipa))
+		goto err_unmap;
+
 	ret = ipa_imem_init(ipa, mem_data->imem_addr, mem_data->imem_size);
 	if (ret)
 		goto err_unmap;
-- 
2.27.0

