Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5873A35B696
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 20:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236207AbhDKShA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 14:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235559AbhDKSg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 14:36:59 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858DCC061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 11:36:41 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id r12so16615546ejr.5
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 11:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rr8E+Q3FCa1M4riAo8GDxxlFhS6eYncmiHkHOyhsOSo=;
        b=kLGrW5+ir2nwKkLfv6Z2DtUSw1y+2DzF6B4wMkyx23E5Q51FF6kL+BVvI8akoH1sJv
         G0fhRDpWg4XMTd5blaLUu9JfkPO58nGgQcYbWHmG68wB760uBnHhqlkVNjZ+M3uswEON
         v248q91G9T5Y391+IYxmxQ+VLmBBZt4wgpETtcpPsFzGw9CBW2p4q3tyjgnOWaXrdOSQ
         2Hw7bC/EDuds6VWWjTvfLGi/dRLOegHM5ruEu08h85ArBO61QzrGpLZ6Jkldsr91xg30
         XCB+EegHMYzcpBoNIBIPKIyZJoQED2ID6aesBLaCSpEqfqZtf8fZdkcO+PFDtS4jke+x
         7Q5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rr8E+Q3FCa1M4riAo8GDxxlFhS6eYncmiHkHOyhsOSo=;
        b=iNcBxarOMH7tRzl/drrm0C/9D26ihWogKkFw4WfGpZ0DHJ0nc2rG/xONam8JtwEQYX
         0QAxpfY+/upnUPFmGiq//FeYd74Dn7Ykw67KViv8Ukz2rqKwPS+5R9tIcReMgCwmeBI5
         ClJu/spFrKRBeG3V1uq7T5VuWOTdaFqWvqk5XsN29DdIxMua/yiqZaXNeGkemFgS+W2x
         2kgzmIk7ESthue2UOEJU0sa7vfJKOwnaizlLNpEBRflZBiAEcHUovAbafs6PCbsJNU0X
         X2/7+Up88rVIoXMGrYD4QyGGlFONjuVlkqLWvHQCQqvX7aSnWuzHs8QtrgVGZpk17Ktp
         2tlQ==
X-Gm-Message-State: AOAM530kBP4H0xykUDKcC3GiFiMlN4K2yt6AVBFNJY7LXDTy34ZeMYrl
        kIK53s7b47hCkVsRKpOEii8=
X-Google-Smtp-Source: ABdhPJwp8lghXMEP+BI4cLYJGW6+UxBrqhI+++8j2fTBEyO9bYI4hauPYsKvj7NGqH42mUwwxwPcVQ==
X-Received: by 2002:a17:906:f8d7:: with SMTP id lh23mr24650525ejb.457.1618166200337;
        Sun, 11 Apr 2021 11:36:40 -0700 (PDT)
Received: from localhost.localdomain (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id g26sm4292277ejz.70.2021.04.11.11.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 11:36:39 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [Outreachy kernel] [PATCH v2] staging: rtl8192u: Remove variable set but not used
Date:   Sun, 11 Apr 2021 20:36:34 +0200
Message-Id: <20210411183634.18385-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove variable "int ret", declared but not used.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

Changes from v1: Change the text of the subject and log.

 drivers/staging/rtl8192u/r8192U_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index f48186a89fa1..30055de66239 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -902,7 +902,6 @@ static void rtl8192_hard_data_xmit(struct sk_buff *skb, struct net_device *dev,
 				   int rate)
 {
 	struct r8192_priv *priv = (struct r8192_priv *)ieee80211_priv(dev);
-	int ret;
 	unsigned long flags;
 	struct cb_desc *tcb_desc = (struct cb_desc *)(skb->cb + MAX_DEV_ADDR_SIZE);
 	u8 queue_index = tcb_desc->queue_index;
-- 
2.31.1
