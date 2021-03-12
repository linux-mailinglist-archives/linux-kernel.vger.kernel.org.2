Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 114BD338ABE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 11:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbhCLK4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 05:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbhCLKzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 05:55:37 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE787C061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 02:55:36 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id y124-20020a1c32820000b029010c93864955so15515889wmy.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 02:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vi8YKLs5KwVaFxKjaiBjlz1cXBojpCCGEw35f+O4dtY=;
        b=j7z+uYOO70ltOQL4GOyJ9R0QdnV1jtke8K0pmYvPWlYRriz34DqdictipRn5zk3Mo/
         O0K0zDmcVf4uDDvFx5S23C84JTNRg7lOGV7+4f7qkvrBkkpIQStciOGUSHZkqnsDoL8C
         4IxxZi+EWkfaM5BuV6ann9TENAStt8F9Bxj7n3uwEqAbAiMYz/ajZVvvsF9BhgXBVoKi
         P76EL04h+oQXd7QgTqanT/t5HFnyk+GmYCKyA1z6vWKS8r2gToaHstOB/xGfUWlv8sd7
         K/ncTZjlObIicuM2fuKkgRtj2KIKSotBzfq9D/F0jCoECyGSeYobxNUrXOY/h/oZje2i
         ftMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vi8YKLs5KwVaFxKjaiBjlz1cXBojpCCGEw35f+O4dtY=;
        b=Rq2mrF1ZdNDIG7rxs8r1BJJXUuSzhQVzKdsedpyGL4Bz6dr35wYqWBs3CFzl6bv2ep
         a3hMQr8w5tYTFBl4LSDSbFj4CYo6oxo/7eERnVWSkGeRvR0EnI9XXitnecLfaM2hicIG
         kVS96WhpDoLcTGhS3urSZtYdkrUuJTwZsQL9LPPtX2om9uY93EmTo9GdFGOzF3g5QX3l
         U49uPCSMFStbWsJOvYCFGkTOpwAOobqpQNo9+B9bb9QvijY5p8Cfk9ArCRE+M7x5f3zy
         wmlw/tGUVWaMgzxZU81KScUzhus6cBTxPpk/+8Z+vrnoXenhD0P4iram9vSK9OuUNk6h
         91Sg==
X-Gm-Message-State: AOAM530D+7UfJonGyVeDbQQdXemAxQAcQP4hkg7O0CrtDIpFcQ9B4a+8
        cWFaBTw3vWDE+8rBVyaB+TtLjA==
X-Google-Smtp-Source: ABdhPJxufQqTU/7eaFRbbpeWTbLrnhEtXNOYhKwbYlwIz6JMrKAesY7QxYtH1T3od8aL7PF83B+Qhg==
X-Received: by 2002:a7b:c3c1:: with SMTP id t1mr12367552wmj.47.1615546535520;
        Fri, 12 Mar 2021 02:55:35 -0800 (PST)
Received: from dell.default ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id q15sm7264962wrr.58.2021.03.12.02.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 02:55:34 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 01/11] block: rsxx: core: Remove superfluous const qualifier
Date:   Fri, 12 Mar 2021 10:55:20 +0000
Message-Id: <20210312105530.2219008-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210312105530.2219008-1-lee.jones@linaro.org>
References: <20210312105530.2219008-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function returns a const string.

The second const qualifier is not required.

Fixes the following W=1 kernel build warning(s):

 drivers/block/rsxx/core.c:395:8: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]

Cc: Joshua Morris <josh.h.morris@us.ibm.com>
Cc: Philip Kelleher <pjk1939@linux.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/block/rsxx/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rsxx/core.c b/drivers/block/rsxx/core.c
index 5ac1881396afb..813b0a554d4a8 100644
--- a/drivers/block/rsxx/core.c
+++ b/drivers/block/rsxx/core.c
@@ -392,7 +392,7 @@ static irqreturn_t rsxx_isr(int irq, void *pdata)
 }
 
 /*----------------- Card Event Handler -------------------*/
-static const char * const rsxx_card_state_to_str(unsigned int state)
+static const char *rsxx_card_state_to_str(unsigned int state)
 {
 	static const char * const state_strings[] = {
 		"Unknown", "Shutdown", "Starting", "Formatting",
-- 
2.27.0

