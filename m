Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0246412F91
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 09:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhIUHgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 03:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbhIUHgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 03:36:20 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415BFC061767
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 00:34:44 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id k24so19908659pgh.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 00:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bF9+Kwfn7J49uwIO6g2s47av3jU4BAiRk3ofOE8TGxo=;
        b=aW64q1DW5XmITWIlAMoTrDOd28xiWhCwkhTwXudAdPo2nubWch8Ds4qlAVM0qgsp4P
         BItRrHsQXyRHxEl+NND6UVLQM0YEBW4lN3eHhb607y98YoifpIts0PfTnUKIjWcnxtOr
         thi7ThtvFhRQkhR4o4TbtME+FQ3m6ppcMaYYu4qQfLuPbPOaGbqfcG8kFvz6ruafqznx
         8QHtnBWlbvk+Zo2L3eHZ5tS220B29MrsMm1Ut19q67x5UaF2GBAFSaJGTrzI+BP3lL1f
         5pJ4AXs2iGIBPI3xnsLvZ2M/qUNwfyBX6yNYCVTaqIO72LCCmPj88Vzw9t8HP9toQC21
         hB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bF9+Kwfn7J49uwIO6g2s47av3jU4BAiRk3ofOE8TGxo=;
        b=TXbWofTtXdjLDp6eyUAaxSRU9a4joHnUKVBLvLs6QBtdQ62ODOV3t6v4TcJVL+i1dO
         YWMqQTWShyFJ3SA8AaunZ/eJYqpSTp6TEJcVFCdj3kabZ3CwZrFhJ1TkCSM7JZ5tM91o
         r/QQCzPhLjy/Ef9csQohxbxSLE9mKaFAPF/f/V9IiJTixgraLukRIsap1xTUIqqjRUog
         HjjWvdpYOZQ+lPZnVoNQ48DwcUo3qu5w6avPUKzxrqAMHqzlAMsLGkVpfKy7ls60qA+l
         UYnD/xqAjpvZqXbVCNJCZlcYhRsH/L3nUWwg+BVZvCNusIo3DGaHbeLzjT/81qXL3nsO
         HNiA==
X-Gm-Message-State: AOAM532u7FoXcDZssYVrR1bSkbC4MH2eCYDMEtWJ2f/yIP1/RHc3nLU9
        gqCdRtH0EJ95vTKS6rWgqMI=
X-Google-Smtp-Source: ABdhPJw6ZwGxaugEdf5GoQzLvqC+7wCzPFlZRYgxnMpnNl35ml83OQ3KSy7+llpYY5uG0Megdpz+dw==
X-Received: by 2002:a62:1dc5:0:b0:43e:f8a4:49a7 with SMTP id d188-20020a621dc5000000b0043ef8a449a7mr29648570pfd.26.1632209683801;
        Tue, 21 Sep 2021 00:34:43 -0700 (PDT)
Received: from localhost.localdomain ([2402:e280:2130:198:9b25:1cfb:9ff3:2a8f])
        by smtp.gmail.com with ESMTPSA id x8sm16565957pfq.131.2021.09.21.00.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 00:34:43 -0700 (PDT)
From:   Benjamin Philip <benjamin.philip495@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Benjamin Philip <benjamin.philip495@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] staging: rts5208: remove parentheses pair in sd.c
Date:   Tue, 21 Sep 2021 13:03:49 +0530
Message-Id: <4a56facd2c04a321b091d3b7dbea87168e8ddd6e.1632209460.git.benjamin.philip495@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632209460.git.benjamin.philip495@gmail.com>
References: <cover.1632209460.git.benjamin.philip495@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I had missed a single parentheses pair in the commit for sd.c.
This commit removes the pair I missed.

Signed-off-by: Benjamin Philip <benjamin.philip495@gmail.com>
---
 drivers/staging/rts5208/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rts5208/sd.c b/drivers/staging/rts5208/sd.c
index 71f04e317eff..d1fafd530c80 100644
--- a/drivers/staging/rts5208/sd.c
+++ b/drivers/staging/rts5208/sd.c
@@ -1335,7 +1335,7 @@ static int sd_switch_function(struct rtsx_chip *chip, u8 bus_width)
 			return STATUS_FAIL;
 	}
 
-	if (!func_to_switch || (func_to_switch == HS_SUPPORT)) {
+	if (!func_to_switch || func_to_switch == HS_SUPPORT) {
 		/* Do not try to switch current limit if the card doesn't
 		 * support UHS mode or we don't want it to support UHS mode
 		 */
-- 
2.31.1

