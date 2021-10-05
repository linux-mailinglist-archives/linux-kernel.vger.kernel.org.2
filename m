Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A9E421B37
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 02:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhJEAmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 20:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhJEAmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 20:42:18 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF159C061749
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 17:40:28 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id w6-20020a4aa446000000b002b5795cca03so5924402ool.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 17:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rie+2DAf6VVtFPVz6Ysf5Ngf4vUTHVjtvqwUA9u6BU4=;
        b=bz1cDjLmB84TpNtf4LfAYOjorNexPPlF0cucsAEf4ajXmm/ZCbFdnhDQViB69S/kJH
         lo85VYBdj57JDwoLTO3wPmpQ1aUBrq0Qd8Hy1ORAy3Xh3LyoOuWkLWbQfuGzfbfhQUw2
         LCSIX1s+93jZR6z0I+4K+YvyjaSKeKP+y0rBFTSI6IA3QohpYPPRz1GfJ4jNxPGIuJOc
         be45Ep9xAmcNGiFr7ymBKaS/zf7w6guEIpAHStk/hO+fjQiTwmwRqxIxqx+AbAOKzmKk
         +kBlNhiwrG3qKbHkfF0WgvzT7JuObfVrAlSAvrk3SNJ/t+VYVZ3MEXjxk/jAKNvN3k7B
         pYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Rie+2DAf6VVtFPVz6Ysf5Ngf4vUTHVjtvqwUA9u6BU4=;
        b=20XTQrvcargPqKJmlydDSawD6pvKaZ6zupKBbhrcd1yLslSRO4POFS4/IApwNQPbqN
         l9LQAE3ngQr9S8oY0L617NWKkPs9TxbhwarIQHn1+GTf6paut5PvTcAqdw6nby2ueSq4
         k1fAnxsvp6Ok7eI4gJzNGhysA7yQgu/seXimdziMGv5IsqKUwdNN4pWrihR5XsdC6Hmz
         NXAoO5Pdl0JNRr0JjJ6Enie5Lz3rB12oyHfMYtWkyjgHyWd+Ro+N7tiY6BaMteC2OOLs
         afTADYVwg3m41f1IeqKcdPeb1wA8lEeUW600rlYG9ZK6dCEBzJJ4PpeaBD+Jq7pf9EfO
         IlzQ==
X-Gm-Message-State: AOAM5327gqp2NK6QvKDzbaRwQ25Hi/UYEl9Hr17ytccFiEc7zx8VMWg/
        CULZzC6BZmo0/oB1KAUFfnVtCABDiA==
X-Google-Smtp-Source: ABdhPJwlUbmNi9sibDjTTqJi71gZQkpQxYfZBHcNdpgwEahNbmt2iwNWUUYDbQSipxOkMCpiIwAnXA==
X-Received: by 2002:a4a:e292:: with SMTP id k18mr11139972oot.80.1633394427977;
        Mon, 04 Oct 2021 17:40:27 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id e16sm3006902oie.17.2021.10.04.17.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 17:40:26 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from t560.minyard.net (unknown [IPv6:2001:470:b8f6:1b:1ce5:3fb4:8fe9:30d1])
        by serve.minyard.net (Postfix) with ESMTPA id 181271800F1;
        Tue,  5 Oct 2021 00:40:26 +0000 (UTC)
From:   minyard@acm.org
To:     openipmi-developer@lists.sourceforge.net
Cc:     Andrew Manley <andrew.manley@sealingtech.com>,
        linux-kernel@vger.kernel.org, Corey Minyard <cminyard@mvista.com>,
        Corey Minyard <minyard@acm.org>
Subject: [PATCH 1/5] ipmi: Export ipmb_checksum()
Date:   Mon,  4 Oct 2021 19:40:15 -0500
Message-Id: <20211005004019.2670691-2-minyard@acm.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005004019.2670691-1-minyard@acm.org>
References: <20211005004019.2670691-1-minyard@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Corey Minyard <cminyard@mvista.com>

It will be needed by the upcoming ipmb direct addressing.

Signed-off-by: Corey Minyard <minyard@acm.org>
Tested-by: Andrew Manley <andrew.manley@sealingtech.com>
Reviewed-by: Andrew Manley <andrew.manley@sealingtech.com>
---
 drivers/char/ipmi/ipmi_msghandler.c | 3 ++-
 include/linux/ipmi.h                | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 13988f88f1b0..ad1a8fc379b9 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -1710,7 +1710,7 @@ int ipmi_unregister_for_cmd(struct ipmi_user *user,
 }
 EXPORT_SYMBOL(ipmi_unregister_for_cmd);
 
-static unsigned char
+unsigned char
 ipmb_checksum(unsigned char *data, int size)
 {
 	unsigned char csum = 0;
@@ -1720,6 +1720,7 @@ ipmb_checksum(unsigned char *data, int size)
 
 	return -csum;
 }
+EXPORT_SYMBOL(ipmb_checksum);
 
 static inline void format_ipmb_msg(struct ipmi_smi_msg   *smi_msg,
 				   struct kernel_ipmi_msg *msg,
diff --git a/include/linux/ipmi.h b/include/linux/ipmi.h
index 52850a02a3d0..163831a087ef 100644
--- a/include/linux/ipmi.h
+++ b/include/linux/ipmi.h
@@ -335,4 +335,7 @@ extern int ipmi_get_smi_info(int if_num, struct ipmi_smi_info *data);
 
 #define GET_DEVICE_ID_MAX_RETRY		5
 
+/* Helper function for computing the IPMB checksum of some data. */
+unsigned char ipmb_checksum(unsigned char *data, int size);
+
 #endif /* __LINUX_IPMI_H */
-- 
2.25.1

