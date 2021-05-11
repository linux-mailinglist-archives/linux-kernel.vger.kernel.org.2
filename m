Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD5037AECA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 20:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbhEKSxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 14:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbhEKSwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 14:52:50 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A73C061345
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:51:36 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e14so18026711ils.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0akxANKNkbeQrtz/Nl9c6Kx9Ebh3LtjGjFZCG1KZ/Qw=;
        b=VX6dmSWJmZjkV1Rhp9aEogYuhqVXAsUR9aVeobbq22ovtj7fXTCQyxSllKzJT4mH96
         p0fsLzFvvYUYxOzUGRB/VztsCI8y4/GRYK915XL2CQ7KdgfP1SD2PSMu0tWtYDlFg7zk
         I4gjTSFA/YsER9BONCczRiOpQR87c7/arpJftFNKJZqucVpd3fmPrrEjjjNgdS1MU3BF
         RUMtD0gfTVCIah3Ohue09qagSO7APCFWHSm80sgjQs/C15DvW78C4+RZ+XvMUAqDkteO
         qLXF0vYIESojXqkqRJbb+bPfcVKq9REgizFZ3uCTVaQWsaxycsVTHMQYUWgDLpszTHEa
         GzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0akxANKNkbeQrtz/Nl9c6Kx9Ebh3LtjGjFZCG1KZ/Qw=;
        b=tXm+KhuHaFOVapdWntyqioDO1OJtcpIiYU1IWhdQ0rdWdFADd3jS0W5WwA9LP4P4lX
         7pdGq+xBtRAmIXU31KAwPUQwss7XRzeFZhLM8Mzb1OFb/jbGLnz6xXJm67o+e+2SWIfV
         xvkuVDK4Lvls9VL6rmBo5RLsmodBUhFL60tyiFM8IIarZWmJ5D6utwMlsT/VfeIApEY9
         BLQe1M0GRBgM3ObLbKVK1SbxV6enx4C59geeB4SqulT8KTV99PyKeVHNgf8aB/Kh2zzh
         pov5KdDPDFoiVNRIIIu/guaulvLMwNbIAMBoAkxhmta5MiOmCULfLCMnvt7aCX2/UCuR
         0ZAw==
X-Gm-Message-State: AOAM532Zft7Prql3Ehgm3ckqU35z8Kb8JM0tPDkDVFXHV6p44j13Sd1s
        gzFak/dRMeKhMQpJ4R51c64=
X-Google-Smtp-Source: ABdhPJzEqx3UMwEioPfdqtJkFucKMAHNwHuJDWooC/COz4fEzHQN50FHXHQCY3bxq0VaORRmj0Fa6Q==
X-Received: by 2002:a92:650d:: with SMTP id z13mr13363441ilb.193.1620759095707;
        Tue, 11 May 2021 11:51:35 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t10sm405096ils.36.2021.05.11.11.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:51:35 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v5 15/28] dyndbg: ddebug_add_module avoid adding empty modules
Date:   Tue, 11 May 2021 12:50:44 -0600
Message-Id: <20210511185057.3815777-16-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511185057.3815777-1-jim.cromie@gmail.com>
References: <20210511185057.3815777-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't create ddebug_table's for modules with 0 callsites.  This saves
memory, and avoids creating ddebug_tables with questionable contents,
which are then iterated over for 'cat control'.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 90bea97c0da1..77c5135879c2 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1033,6 +1033,12 @@ int ddebug_add_module(struct _ddebug *tab, struct _ddebug_site *sites,
 {
 	struct ddebug_table *dt;
 
+	v3pr_info("add-module: %s.%d sites\n", modname, numdbgs);
+	if (!numdbgs) {
+		v3pr_info(" skip %s\n", modname);
+		return 0;
+	}
+
 	dt = kzalloc(sizeof(*dt), GFP_KERNEL);
 	if (dt == NULL) {
 		pr_err("error adding module: %s\n", modname);
-- 
2.31.1

