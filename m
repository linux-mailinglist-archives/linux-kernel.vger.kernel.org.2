Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815F733CCF2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 06:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235296AbhCPFJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 01:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235195AbhCPFIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 01:08:30 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37057C061756
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 22:08:29 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id a7so35825072iok.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 22:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lfjb2KQKpfPI/NczuRnwqBHpFb27gzw1bs7orOVs/n0=;
        b=pOeoNzawy9aznq9Zwf0L1Vze2vpRgs4TbtnBNVWpOE+tvR6Aqi9RrEeC/cObB+sIyr
         pIvC0e1L6ObhirUI8e3+5rGTlUE/VUDMsw9S4nOxQt5LkMrkgv8hLzHvO0QIAfDiV5Qq
         YR4XDe7X9MXqnWxwoMSELcEPH02B4WAmKANpHslZOnatrwS3S/BtZrYe0bcluJ45Kd17
         jqHAQy7DM/fCy2ToO35SRvY9sa0ROIzaaiKD7KvMu18B52Uz28LZA80XfafB6D0FqZxC
         3cXBp7x5XRJNOTy22zJmcPjioL0C6JHR5Fb7FGDnTrF7jCl5SWBn29RpZCoxMZDw0xhs
         CUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lfjb2KQKpfPI/NczuRnwqBHpFb27gzw1bs7orOVs/n0=;
        b=mcbpZCYs/tZnwgCmMuXSq/IjdNm+GJN4mZAnpsma694ROymYNygbJ2+peCQuJpV+4U
         XypIRnlc4XpUqmmLHMS38gXHa63pyTr06IDKHiMtNXujCFe/DzAZmegyKkxuZxtLWo4K
         2+M8hYMT5qvPz0LEFBjw3z8sCK5rreynOS/uSK143ChntW9U9SYOeug61N5r7i0AUdk3
         rrOxtHqkxZgSpSSr43P2dFFBneo2yNdRl49HtJ4q2YVgX91R6ld+QngRxiGGX6SzM221
         IjfkCHcM7sR9f2StTt1mdJ6y3bg7l8fQHxn/5c8ba/7I8UOztSaHRHoIpA2gc+i/Q1cT
         Bkqw==
X-Gm-Message-State: AOAM530dHzf2lpTr2bE/D+Z4dmD5Ze1WWEFs2WABFrhQ2pUdxUR5MByR
        S1HHkpuH8AHoHVkSktfLh2o=
X-Google-Smtp-Source: ABdhPJx/CJQsy94ETUcIoX5qwBuFd4/CZzPDFVR/Dh36t/Qp+pe4RHzJHgmn6ogPGkWPnAi2kn+GkA==
X-Received: by 2002:a5e:c913:: with SMTP id z19mr2073245iol.33.1615871308702;
        Mon, 15 Mar 2021 22:08:28 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id y9sm8587469ill.15.2021.03.15.22.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 22:08:28 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v3 10/18] dyndbg: avoid calling dyndbg_emit_prefix when it has no work
Date:   Mon, 15 Mar 2021 23:07:53 -0600
Message-Id: <20210316050801.2446401-11-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210316050801.2446401-1-jim.cromie@gmail.com>
References: <20210316050801.2446401-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wrap function in a static-inline one, which checks flags to avoid
calling the function unnecessarily.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index af9cf97f869b..2d011ac3308d 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -615,7 +615,7 @@ static int remaining(int wrote)
 	return 0;
 }
 
-static char *dynamic_emit_prefix(const struct _ddebug *dp, char *buf)
+static char *__dynamic_emit_prefix(const struct _ddebug *dp, char *buf)
 {
 	int pos_after_tid;
 	int pos = 0;
@@ -655,6 +655,13 @@ static char *dynamic_emit_prefix(const struct _ddebug *dp, char *buf)
 	return buf;
 }
 
+static inline char *dynamic_emit_prefix(struct _ddebug *dp, char *buf)
+{
+	if (unlikely(dp->flags & _DPRINTK_FLAGS_INCL_ANY))
+		return __dynamic_emit_prefix(dp, buf);
+	return buf;
+}
+
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...)
 {
 	va_list args;
-- 
2.29.2

