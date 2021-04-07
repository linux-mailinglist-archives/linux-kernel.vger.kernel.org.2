Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66566356025
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 02:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347529AbhDGARo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 20:17:44 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:52354 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347538AbhDGARK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 20:17:10 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 4FFQ1n5bLDz9vC8s
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 00:17:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NSvcnZhKNceO for <linux-kernel@vger.kernel.org>;
        Tue,  6 Apr 2021 19:17:01 -0500 (CDT)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 4FFQ1n3kMYz9vC8t
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 19:17:01 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p7.oit.umn.edu 4FFQ1n3kMYz9vC8t
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p7.oit.umn.edu 4FFQ1n3kMYz9vC8t
Received: by mail-il1-f198.google.com with SMTP id y11so12796124ilq.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 17:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nqOH5zgJF7P4HyaMu6ydIUY7IV1etU3TYVY63b7sAa4=;
        b=C/aFQt6ZAt5MRtTXx/Fhtv/1mKJtdwjI4LgC2wAMy6oLuevcyqtBH2KHwZwOB+CNV4
         U1U3t0gwmA3f2k7EuGJXIXAhNRTnWWXrzwszp/zirNn2JQsJbIrq4CjiiKi4QapjjGUg
         NF2BARqpG1FmjAAqMj7H78yx145avlLZhiMtpH5Um9Ef6d198jmKLjTO6JgTTKgkHBY+
         IqHYWy974th4oicyfzI8QkPWoDCzBRQd3Mo9rv6hdHD09b/WSGH7FL1LD8s04vgP5INU
         CP/8OSJYSLkhaN6GpgQ7LKBG5BJQwXTV8nufxvDHDtp0fhwadi9vPHdM4EnpKi9HusaD
         srMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nqOH5zgJF7P4HyaMu6ydIUY7IV1etU3TYVY63b7sAa4=;
        b=tA3ehX5QtvTyxqgZN++saFLX6Qum1VAu1IzNpA/VS+dTkjq66t/+rrDU4Hq/iqoM6m
         S29tkO2XbO6ntC3fldt+mS0K7GVzKUibsxKdke6FSCDIflMGtA3b5TO3jQZdcGcY/kLh
         1EuSn2S/PsJv9UmqF5s1Sv4Lr0ddL5Cbcwta4hFXQVTdiBvNfiL/xFQSDqJC9JtVQknt
         Ux9V3MaqXEpcpU8U84Zf+DC45OCofdOedujW5BqSWgGTYWBjXtWgQ4lkiDZEz17DZKJd
         nokzKgxXKwJmMYAv4h8Ydkfon1VljCx10dfmuiOxKJkzAMb3HQniL2q7O9GJ2uRsgjJv
         sNmA==
X-Gm-Message-State: AOAM531DvdnEPpq5IFTUhVY/PvF0hOhscjBd+Z526edtiAJmagFfbAV/
        ePt9Wg8dv7ubhm50vhEQUkKVhbW+UlWCx6hpOMsF3hgOZRrEKuWUDbKOMQBuFeNknxGrCXt336K
        j7l2l/qtvWm/gNqTqRKK9RGbuSyDl
X-Received: by 2002:a05:6e02:1543:: with SMTP id j3mr596830ilu.39.1617754621144;
        Tue, 06 Apr 2021 17:17:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJync0sm3iznIgnH19+wOdfOZuEWNLZ2IA+S3HsDOJ1V6h+h25dE8WpGDnv9gMRXsXxfWLxUkA==
X-Received: by 2002:a05:6e02:1543:: with SMTP id j3mr596819ilu.39.1617754620931;
        Tue, 06 Apr 2021 17:17:00 -0700 (PDT)
Received: from syssec1.cs.umn.edu ([2607:ea00:101:3c74:6ecd:6512:5d03:eeb6])
        by smtp.googlemail.com with ESMTPSA id c5sm14522884ioi.0.2021.04.06.17.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 17:17:00 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Dave Wysochanski <dwysocha@redhat.com>,
        linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] SUNRPC: Add a check for gss_release_msg
Date:   Tue,  6 Apr 2021 19:16:56 -0500
Message-Id: <20210407001658.2208535-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In gss_pipe_destroy_msg(), in case of error in msg, gss_release_msg
deletes gss_msg. The patch adds a check to avoid a potential double
free.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 net/sunrpc/auth_gss/auth_gss.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index 5f42aa5fc612..eb52eebb3923 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -848,7 +848,8 @@ gss_pipe_destroy_msg(struct rpc_pipe_msg *msg)
 			warn_gssd();
 		gss_release_msg(gss_msg);
 	}
-	gss_release_msg(gss_msg);
+	if (gss_msg)
+		gss_release_msg(gss_msg);
 }
 
 static void gss_pipe_dentry_destroy(struct dentry *dir,
-- 
2.25.1

