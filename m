Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B92342E441
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 00:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhJNWib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 18:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbhJNWi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 18:38:29 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8DFC061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 15:36:24 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id m20so5585527iol.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 15:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fYtWjsvujMKhrJKB8ld9w1UXNt2DI3TQjPCiRFwc0iY=;
        b=W3WQMGrPhphgMRs0WneXZzDiwbwnGOgPS3WrftEqlChaJnm3B67V0ookEM+XTiVx0W
         Zhfn0w9mB9nlXvubHUKp4Ixw3ZQQxyuggEXuvYjQUYylCcBVC+Z9ZksEpPvwJxsL0i0M
         qHR/4OCmtTdFW3R53FQfbq4/aFqfmc0rK2QdLUUo/xhF0FPUlubIq4LPJ7ZzN2Vu3Iz+
         Q1XbDKbu3vMb9a6eMLqjmTqfZqQ+mcnARFeLJtWdPd2RBkZYWwoa3OKjd47bGNOZZrpG
         zXi+2RmpcFzRFhF6cTf/BBV7jWbMwWG8ibBK3kCDncWheuKC0ahrm9bXSbx3GDP2K4qS
         w+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fYtWjsvujMKhrJKB8ld9w1UXNt2DI3TQjPCiRFwc0iY=;
        b=mfDy95vLjuvkOgr/DsW4hvZ2oHPKfyw4ESCojhZXvcVwrlDKpRhufUBB7taGfAdIFt
         wH3SbPMvN+cJUvmDKRVonZNRertYLHJxGbVWfm+mYN3HTs39AGUKUjGTFqn01jk3a11s
         SBdcNwqsZteBgvmpB0svhdsfgTpu56LVqyz9ENA+IEwKhMMIb/IqwSGVLm5+BvXOKltm
         H5OJFXL7+M08CZrn+enOwCFPneiheM4RAYI13fO51tFkAHRRN9I9kprTR8kFC7AizYqd
         Rh0l6sQ3vLEmRj+YN9eQ4abYPzlvDdBxyi7XT//KVe64pgQo7u1A4PM3Ad6/rFfkmZMo
         cjsg==
X-Gm-Message-State: AOAM531u8HXDRf9/6m/891uDDHHVnVtBPykzXkmcpIiNPKa+0yqXM/tt
        2PgomRoiyLEW5Xl3ZiqGgw5Pp9b7eTU=
X-Google-Smtp-Source: ABdhPJxFLUjPAvJzOOp54GDJgF8ZHml7x12QQv4xeGrsGw5VEeHoZJBpqRs8QYOeaAPHAuuFL5jsuQ==
X-Received: by 2002:a02:a14d:: with SMTP id m13mr6083652jah.126.1634250983984;
        Thu, 14 Oct 2021 15:36:23 -0700 (PDT)
Received: from samwise.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id s18sm1829989ilo.14.2021.10.14.15.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 15:36:23 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 1/1] dyndbg: fix spurious vNpr_info change
Date:   Thu, 14 Oct 2021 16:36:14 -0600
Message-Id: <20211014223614.1952171-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <YWfxPLpBTQLzm6Bk@kroah.com>
References: <YWfxPLpBTQLzm6Bk@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cited commit inadvertently altered the verbose level of a
vpr_info, restore it to original.

Fixes: 216a0fc40897 ("dyndbg: show module in vpr-info in dd-exec-queries")
Signed-off-By: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index dfe1e6a857bc..9dd8efb5a756 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -529,7 +529,7 @@ static int ddebug_exec_queries(char *query, const char *modname)
 		if (!query || !*query || *query == '#')
 			continue;
 
-		v2pr_info("query %d: \"%s\" mod:%s\n", i, query, modname ?: "*");
+		vpr_info("query %d: \"%s\" mod:%s\n", i, query, modname ?: "*");
 
 		rc = ddebug_exec_query(query, modname);
 		if (rc < 0) {
-- 
2.31.1

