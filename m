Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E43F373248
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 00:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbhEDWXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 18:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbhEDWXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 18:23:38 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA749C061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 15:22:41 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id p15so122523iln.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 15:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=42RppknSRxsAJuvBLgB6qPkbHfT1VJYKsb4xtw0ymjQ=;
        b=JQlfXZAi0zkL1+Hjx0Cspaml4VwnHpWdVmY1NaCjorqYAUMrDO4pZqI74tsjBbXbpH
         /KfUgoncGhQB9T6MWoGQONE3V5hfomtYFzBXoQjCWRHYMgRrF72Dj+7s9yvKqCsZZES1
         FRXTgUEqC4Rb04oJB6LtdyPM1BellAw2Z1ScYnxxMxLeNlAywpOJMAXgE+S0Jp10yBgX
         zCDOpGVPYov6wjoxrnugy/2sKWPN387DfSO870RDs1HralQaRtGEwhqV6DbWXGZaNuhf
         jZMxiDiCaWEHFkG5v8QG5vd61GNK+K+/e768FD4VJRG2h0uJ8I6rQgAcpC9A21lCSV93
         4gjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=42RppknSRxsAJuvBLgB6qPkbHfT1VJYKsb4xtw0ymjQ=;
        b=GRi5NVA26foRQYZSWSSZ0SWRCcBVlBP9XzU1G3v8eFxfRWthU98+OMxFqHLSx07waV
         laOUYfAxA0fye5N59mYVAx4FGvIKvwTjNImoBtSz771wVNZUs0W/U/GGu7alLTghQX9e
         xsJw2L56jrqZaLzXpn9Unak2J1eUfwLlxtRFlUfO53hKrZlBFvE0YoOEzHvlPK0vC84Z
         bCtjttJ+7G8lRcxzPR2gekQ4NFLcyWU16SrYnWi91Yp99gmI1PilZC6J6bjkZnnksbpV
         879I3qNKdz+IUsXllvlVcM100DrGqkQnvjcJLNFV7i5WqkEK98cpMPpiPR4xYSZ/JBNW
         P6pA==
X-Gm-Message-State: AOAM532Uw3/CgkmIOX2dmygH/VcIRr6v9lEuQLhTQAzvLxpTYyMrV4sC
        Xb1LTzTf/3u1v96vYxoIjbo=
X-Google-Smtp-Source: ABdhPJy4vXE3aOOfy/RFLXm2YBAVwo0/Sor+uSIFAAxj7fffdKxIIY8m+SoNCX1ALMWSr/Zfeh+vcw==
X-Received: by 2002:a05:6e02:1348:: with SMTP id k8mr22559677ilr.124.1620166961162;
        Tue, 04 May 2021 15:22:41 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id j19sm1626337iok.51.2021.05.04.15.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 15:22:40 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 2/2] dyndbg: drop uninformative vpr_info
Date:   Tue,  4 May 2021 16:22:35 -0600
Message-Id: <20210504222235.1033685-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210504222235.1033685-1-jim.cromie@gmail.com>
References: <20210504222235.1033685-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a vpr_info which I added in 2012, when I knew even less than now.
In 2020, a simpler pr_fmt stripped it of context, and any remaining value.

no functional change.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index ede4a491ee87..3a7d1f9bcf4d 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -920,7 +920,6 @@ static const struct seq_operations ddebug_proc_seqops = {
 
 static int ddebug_proc_open(struct inode *inode, struct file *file)
 {
-	vpr_info("called\n");
 	return seq_open_private(file, &ddebug_proc_seqops,
 				sizeof(struct ddebug_iter));
 }
-- 
2.30.2

