Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 970F638F8DC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 05:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhEYDeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 23:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhEYDeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 23:34:46 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013A9C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 20:33:17 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 66-20020a9d02c80000b02903615edf7c1aso5428468otl.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 20:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9c/jewxPCWAXySvELUdq/qwVXLJZWJe6/GqALNqnijY=;
        b=P51BN9UWEiTH1JRuhR1zbyy+bFHJM3tmKyIT6UwSsGlbBPiHyv/wTdsyWugW9Vy/e4
         EfjI++KlARFty7pwx3RgZO5wX+WS9qYmZQcDYxNfSQvxbuq+KyAo3BnrLor8D2SonUj9
         ISyhaEVbkB9iE8BxvVIjAe+lfN/qI+xy/quAcfM9BY15c1a1X3QkoZs/hcReXbEOJx+c
         yEOjgUJfwAAnVN6OBpH6HBPmGyrlpjQyTh9hKCrHJeESNn/Ioy1R3iU13X56jcP0Kblg
         sNCdYqUmT4wOUZNKYN71dlj5859a302g0sudb6SDNgM6xnAasddCpFQQd3T8b01odNFD
         Z5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9c/jewxPCWAXySvELUdq/qwVXLJZWJe6/GqALNqnijY=;
        b=oEUoyULLeUyLIe9u/Be4UwJJXD0eO/BsJo/vr1zRQm4lO5te0gnrNnqD9302EwhEDE
         oLakIOnW38TsUyAGOPBQicW1B6iYL1n+07stvHpaKi/E36HPajfHEsdZ/kB0W0qxYESQ
         U9bxR7MN4xj1fkIMuYXiInYN4hnIlYsHnjwA7PYHAmcvZzKth2p9Wp9vlxK5TnpN5VDj
         HM4TnnbM0HeXGa4Ajc76kxbni9o4X5Nb7zuTwnY8+ARwstZ/uSNpoaRM+0yLDWbBzFGT
         BhydEk1ThB9vG97+t+SarrDzThOaatn5LOJ9n1FmcL2SUo2cNnvQUNdHxDrqHL5/Mxr0
         Ujbg==
X-Gm-Message-State: AOAM530xNcoVK8UKx1ODNVETUqrM4+lMUA/kwm1hPv7PBErGHu7zKqXU
        EmYzAmXfg/iCauvmtZPMsN4=
X-Google-Smtp-Source: ABdhPJx3mpAOvvkYN9t8zlGNskQgQUhUwiFEZ8YQIExYi24mb2WHVasmZsNohuHmVCgYRSgGAQ8AOQ==
X-Received: by 2002:a9d:7e99:: with SMTP id m25mr21586982otp.37.1621913596283;
        Mon, 24 May 2021 20:33:16 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id z9sm3231074oog.25.2021.05.24.20.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 20:33:15 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH] dyndbg: display KiB of data memory used.
Date:   Mon, 24 May 2021 21:32:40 -0600
Message-Id: <20210525033240.35260-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If booted with verbose>=1, dyndbg prints the memory usage in bytes,
of builtin modules' prdebugs.  KiB reads better.

no functional changes.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 3a7d1f9bcf4d..ab8fc16911ae 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1117,9 +1117,9 @@ static int __init dynamic_debug_init(void)
 		goto out_err;
 
 	ddebug_init_success = 1;
-	vpr_info("%d modules, %d entries and %d bytes in ddebug tables, %d bytes in __dyndbg section\n",
-		 modct, entries, (int)(modct * sizeof(struct ddebug_table)),
-		 (int)(entries * sizeof(struct _ddebug)));
+	vpr_info("%d prdebugs in %d modules, %d KiB in ddebug tables, %d kiB in __dyndbg section\n",
+		 entries, modct, (int)((modct * sizeof(struct ddebug_table)) >> 10),
+		 (int)((entries * sizeof(struct _ddebug)) >> 10));
 
 	/* apply ddebug_query boot param, dont unload tables on err */
 	if (ddebug_setup_string[0] != '\0') {
-- 
2.31.1

