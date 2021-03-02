Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357B632A96E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 19:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1835215AbhCBSXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 13:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448708AbhCBPeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:34:22 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF53C0611C3
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 07:30:03 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id i14so2158630pjz.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 07:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9EqguA/mJ/5XIJaGQevLoJ3cln+41TNxK2n6DJaVpO4=;
        b=jbaxDvE4/gD8R+3xgh0+pFKqrFtwPQHpBk/Yk361LrSppOx9t80Wj0URRIKwAWA7WL
         fAnQ8/Do/nFBmVDJ96Z1pWKPxDQTBAD9R2uXPdAifqsCOPdqq7YLuK4r7za5M81sQyoZ
         2qtmBsi5CF9yx0wpr+S4TN2aFalwQNWZS9PZwHnS+rt5qfBTenn8f6RXyn+rwXAdFM/u
         ulDDOLRsfQIXSNlTVv9LLh2ifej/2WN5G0BJAIbXCizaDn+Rzt4ubpFGtGrzHXM26JK7
         bWdP8CkO2wUZo5/JLe0pjBzwe4JL7ipIEDZhiDfjERRMH5WSMLfsgpnSiJrY4YPEpLBx
         hI2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9EqguA/mJ/5XIJaGQevLoJ3cln+41TNxK2n6DJaVpO4=;
        b=b8+pxgoYeLbBBKm9WXrTL5aWfDc6uvGMaBGolfaxKnRULWckdnJCg1huA0jheF0bae
         dZ5/sIf6lz6yD2m791s8LCuIgn1Q/FsPXI/W5ovQ7UySkXtO1VT2Quj4uHdN4Ka1hEc5
         44JtZ0+B0mExkIdpuAqKu2kFBgOvzWJDyFIEecBMUCnKx5CQBAcGJ73DWn4n6Ak9qgP+
         DFs2zGqSngsrm6ipihNTXK0ntI8B8eaUk6rskII7sddBElbAwCOVSDqrMT1JVnIOZNi4
         WwfQdRhERo6I2XLr2S5rzh77bBVphwxO6hkErj8fjuDd2AeXOFCdku5FXsJJuYGeV99T
         UVvg==
X-Gm-Message-State: AOAM532PzL67Y1W1niXwYWyuip8XJ+QlSFmN6kfhijhyq4hutUF8qd6A
        J+cI2Eu0yfj4k4b/dLzwNgPwfDV2JWjLeoGU
X-Google-Smtp-Source: ABdhPJwWIv8yuaaq7RCoko+1zUz3RnLJ+4DY0SsEDNr8gFvwiDOdUG2DjapsUNakaF5t/qaYIsLfmQ==
X-Received: by 2002:a17:90a:d58a:: with SMTP id v10mr5062185pju.36.1614699002924;
        Tue, 02 Mar 2021 07:30:02 -0800 (PST)
Received: from PerrinsPC.modem ([2001:8003:8431:d200:220b:84b2:a334:cbad])
        by smtp.gmail.com with ESMTPSA id n27sm2780543pgd.31.2021.03.02.07.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 07:30:02 -0800 (PST)
From:   Perrin Smith <perrinjamessmith@gmail.com>
X-Google-Original-From: Perrin Smith <perrinjemessmith@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     will+git@drnd.me, dan.carpenter@oracle.com, tiwai@suse.de,
        yashsri421@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, perrinjamessmith@gmail.com
Subject: [PATCH] staging: rtl8192e: remove unnecessary break
Date:   Tue,  2 Mar 2021 23:29:03 +0800
Message-Id: <20210302152903.2930-1-perrinjemessmith@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Perrin Smith <perrinjamessmith@gmail.com>

removed unnecessary break at end of while loop

Signed-off-by: Perrin Smith <perrinjamessmith@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_rx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index b8ab34250e6a..2de6330b7737 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -460,8 +460,6 @@ static bool AddReorderEntry(struct rx_ts_record *pTS,
 			((struct rx_reorder_entry *)list_entry(pList->next,
 			struct rx_reorder_entry, List))->SeqNum))
 			return false;
-		else
-			break;
 	}
 	pReorderEntry->List.next = pList->next;
 	pReorderEntry->List.next->prev = &pReorderEntry->List;
-- 
2.26.2

