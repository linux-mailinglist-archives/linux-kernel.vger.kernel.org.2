Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8062B38AF53
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241538AbhETM4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243551AbhETMyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:54:49 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333E7C068D9C
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:19:20 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id v12so17445090wrq.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vp8dJDjY2uxCfDOs0aEe2lY0ldvHAGMERMrzv0ubzjg=;
        b=uxT1WDGTgvjQY06WCtH0h/WZSWz8ixAv8Wz5NOT5Sg4wUo8cGjsBHjMhrpLjZEhEJx
         luwADTfcZEFzbjYWE250ywsmqmEoR320wH8VY3505s2BUBdew8auTtwmxPp+VQuGYZv0
         hmeLnB8TR6fPsVQMxU5J+IxQ9z40f2YhejT3Yk6uxIjhFfNQkKeMIct+tpmMLfNeUX+S
         QA3jNOOhDJoz7spmPgYYSzsMIZ/aCbZ8eKOjGvIuLpIo71FDBhMm+2D8p2eTPHjN/mTq
         8Mdcs7PnDwNC6skPib3k5pQJcm1hISi+fuAewuoFNh9rItC0HWVCByaz+9FgWagxkN2C
         ABjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vp8dJDjY2uxCfDOs0aEe2lY0ldvHAGMERMrzv0ubzjg=;
        b=nnYJfrfZJ4Uskojas8P/wW9/WM5MoMQqpmRDpBu5AbO8aJRxWyTrhGF6EcGHyeuD8C
         t7o4Q8XcFfF5iouixo8yfEttrytebm9gO2Av9mGZKqfIu2nchlthVscxS+YSRUExQsYg
         iYO0QmS5m53/Fr6nlkcfIxig9ZzB8dPVKJMj/1U8kO+cok7TTWoQ0lSpwtGTpJT9JVOs
         Pd3OFSjezdpIWMQdLXXmlG/qf1alrWq0XaCMtTYv6/SFaEIvEbqrkIHKiCT5w3vCzHm1
         07U23hcgear1NQLktXPIFeevTzxRVrVaDOolZ6Cvkdji5kkwu3LOEgzk/aBIeFGqdUUs
         GlzA==
X-Gm-Message-State: AOAM530fiOu1zYvXFB+LaMzx8pAD0ZYqae2VANAkPLlkKaJUalHqfgkZ
        6lAk8X2VzuMgCEncPOEay9NSSg==
X-Google-Smtp-Source: ABdhPJzH8mymsddYGXrgQfWZoS3B4ieYvCDkTLb2tXWzzp3R6qOzcy98jCVFzhtCHtvoNpDUzsOGKw==
X-Received: by 2002:adf:e110:: with SMTP id t16mr4027466wrz.359.1621513158802;
        Thu, 20 May 2021 05:19:18 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id f16sm3061161wrm.47.2021.05.20.05.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:19:18 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Subject: [PATCH 09/11] tty: serial: st-asc: Demote a kernel-doc formatting abuse
Date:   Thu, 20 May 2021 13:19:04 +0100
Message-Id: <20210520121906.3468725-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520121906.3468725-1-lee.jones@linaro.org>
References: <20210520121906.3468725-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/tty/serial/st-asc.c:73: warning: expecting prototype for Some of status comes from higher bits of the character and some come from(). Prototype was for ASC_RXBUF_DUMMY_RX() instead

Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-serial@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/serial/st-asc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index e7048515a79ca..62128bbd03151 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -65,7 +65,7 @@ static struct uart_driver asc_uart_driver;
 /* ASC_RXBUF */
 #define ASC_RXBUF_PE			0x100
 #define ASC_RXBUF_FE			0x200
-/**
+/*
  * Some of status comes from higher bits of the character and some come from
  * the status register. Combining both of them in to single status using dummy
  * bits.
-- 
2.31.1

