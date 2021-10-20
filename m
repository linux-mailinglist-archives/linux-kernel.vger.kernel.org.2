Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881734347FD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 11:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhJTJgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 05:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhJTJgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 05:36:18 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A352C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 02:34:04 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id s136so18757817pgs.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 02:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J16SUnC8hd6uyoXWMtzPvcEXzxrgy6IJEv77BM4lW4Y=;
        b=K0pSwbK2aNy2xVGgfyfP4UuZqZ2zoftn8vcZgJfXKSQ2bLpHInrKVF5qrLII3wcU35
         3jDrf7mGhjqlpnfxChI0rG2Ny9PQHgI3NycLJ9BcIy2ZovrKfnay4BDUKsXimkxoQHBT
         ehU7dAsMqj18ztVlAprlQiUdR8U1HMz4XBF5mI8IEuLLlUZSIoRG4qhhJtEIohxYq/0K
         006EYwCb56Ny8C/9CmNQimL6UkReDfTUM6y7T6PQRZZyFj3yWvGDO7X2nQ3vMDkmtIHG
         itpnCNYfRFUnGcDPYVDP8cJvqukUWxiWWgf0l2cqqX7m/9okKGAdThlc1ebyEAIxcNaH
         KgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J16SUnC8hd6uyoXWMtzPvcEXzxrgy6IJEv77BM4lW4Y=;
        b=aEhYGDDBkiWS/5IfqZbjGgmXG1gVQah6QIf0T89oz0myckV7ML3C/qkc6b24VmSS84
         CxlZweW0xTYk2MsunseA9WS+PmkhIkmGOBRBlRVxU9KNSrchejirNwqttdvmLRI71IM5
         4R0yLB5AXQ79KjB8R/3NvPZmEWk0klfEtAIfVg4LfwPpM7nXbK+e5Bp71vE2DOTPaXq+
         2qm9sSS90TOfhocAkpLA8+MBv6pRjRc9cODKpaVXcj6FemNbVJKRSL01c/RJka/ezXCs
         kGJ1WaTQkmlaH95hWVHZ8+KuoUrqRTkSTyKhaSkd6MG8z+qgAIlbWumsmiw7OdFpDY6T
         q7FA==
X-Gm-Message-State: AOAM531mAZS+pMSsnnzvS2UvmSHUQWhRXqEIf7cMLl2/mst6ewhlAnbZ
        XdZIXX4oc66jmGOEStYXvRqUzP9gijI=
X-Google-Smtp-Source: ABdhPJyQzWNbdfJKQxtDT0gNAM513SFShTRXVmmaucqq2i/nhDaPb8jgFel7weL1pfnNR1CbfA1KgQ==
X-Received: by 2002:a63:6f0e:: with SMTP id k14mr24182083pgc.351.1634722443688;
        Wed, 20 Oct 2021 02:34:03 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id oc8sm1974513pjb.15.2021.10.20.02.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 02:34:03 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ran.jianping@zte.com.cn
To:     linux-kernel@vger.kernel.org
Cc:     ran.jianping@zte.com.cn, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH bus] bus: remove duplicate include in bt1-apb.c
Date:   Wed, 20 Oct 2021 09:33:57 +0000
Message-Id: <20211020093357.1039575-1-ran.jianping@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ran Jianping <ran.jianping@zte.com.cn>

'linux/clk.h' included in 'drivers/bus/bt1-apb.c'
 is duplicated.It is also included on the 25 line.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Ran Jianping <ran.jianping@zte.com.cn>
---
 drivers/bus/bt1-apb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bus/bt1-apb.c b/drivers/bus/bt1-apb.c
index b25ff941e7c7..74b1b712ef3a 100644
--- a/drivers/bus/bt1-apb.c
+++ b/drivers/bus/bt1-apb.c
@@ -22,7 +22,6 @@
 #include <linux/clk.h>
 #include <linux/reset.h>
 #include <linux/time64.h>
-#include <linux/clk.h>
 #include <linux/sysfs.h>
 
 #define APB_EHB_ISR			0x00
-- 
2.25.1

