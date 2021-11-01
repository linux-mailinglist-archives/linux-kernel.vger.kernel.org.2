Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD0ED44158A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 09:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbhKAIqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 04:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbhKAIqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 04:46:35 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C44C061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 01:44:03 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id a132so14744661qkg.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 01:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/X9QXRNDdyclz1/TInEobZseXLFJXvPreNFjueMyvDs=;
        b=LVJdpokNnRoyqlzV500kI7epNfT+ZTRSPnqh2RG08cdynB9em9+fLjbhewLxVncCXa
         ZxThLfsSxKkyGlpAhIBtR7fHzkAZ1XgIsSeBtwRnYKVsWx7A4yu+PKqhwu77EkL7vRHr
         rvrJo9ByPY8jxrvD7KXJlUJB9HAN6ercpVNtS4CljZO1eR7QZG6pfbzWtw39t+OE8nKH
         Ooq7HW5kwSZdfPmOreIM9UWun7+5IAdcxkac2nvoE7iK7GGh+05GoTUNHjc9sgCczbNN
         1XS+gomUNJ2Pfwb9ToBdl7VjJO4hqJpQqoxFG0vYQY5p+n35ZWM8OVryUmYHM/WXdDWF
         DTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/X9QXRNDdyclz1/TInEobZseXLFJXvPreNFjueMyvDs=;
        b=Ef/1rGjzokYFAhU3ZB3H+O72SKhUyyg+QagXrBvB2mxR25Pq6coIqrmS7abu11kehV
         ClNIIFQD/OE2rvUI9ZOtLPn3G6uOEg6TU9Uu4WKi4B1HQWvccwE09ZPXyTlZ1zLZWcic
         C0lbVJFn/UyZKWB/kjdUeGfQrnIJqO+v5O/NUozNPouMfJj7r+Tc4q4TakrXtnaNy7Nm
         8Mjl2XS6/itcA7MNZi9xpHk97DJempIxdRhYwf2TqwfmyFzrRCdDaFqEA618RDF5Rx3b
         3XJnSxlqLoG5+oy/DSE6KfW6zRV7UFkGo5/OoOnFy7nhU9Mb/yWrT9XyFGdSzZNg9eDS
         U6rQ==
X-Gm-Message-State: AOAM531h/BVuQFqm+iuaCLnS9fmqw1UrhsSrUGbEPKBBEivEAW1n3RkI
        UDH07oANEq9YJRT+dyJcr7E=
X-Google-Smtp-Source: ABdhPJzfwMH4NpzJkAlxoVClXk6GTAcN/YIOmZFUoKwcRn0alRR1BvRk6kbt41YFQ6BKBnYbYINKKA==
X-Received: by 2002:a37:6104:: with SMTP id v4mr94819qkb.201.1635756241852;
        Mon, 01 Nov 2021 01:44:01 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id br17sm9758248qkb.10.2021.11.01.01.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 01:44:01 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org, pmladek@suse.com,
        christophe.leroy@csgroup.eu, john.ogness@linutronix.de,
        npiggin@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
        sxwjean@gmail.com, arnd@arndb.de, clg@kaod.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] powerpc/xmon: replace DEFINE_SIMPLE_ATTRIBUTE with  DEFINE_DEBUGFS_ATTRIBUTE
Date:   Mon,  1 Nov 2021 08:43:52 +0000
Message-Id: <20211101084352.36641-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

Fix the following coccicheck warning:

./arch/powerpc/xmon/xmon.c: 4064: 0-23: WARNING: xmon_dbgfs_ops should
be defined with DEFINE_DEBUGFS_ATTRIBUTE

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 arch/powerpc/xmon/xmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index dd8241c009e5..875241bd216b 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -4062,7 +4062,7 @@ static int xmon_dbgfs_get(void *data, u64 *val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(xmon_dbgfs_ops, xmon_dbgfs_get,
+DEFINE_DEBUGFS_ATTRIBUTE(xmon_dbgfs_ops, xmon_dbgfs_get,
 			xmon_dbgfs_set, "%llu\n");
 
 static int __init setup_xmon_dbgfs(void)
-- 
2.25.1

