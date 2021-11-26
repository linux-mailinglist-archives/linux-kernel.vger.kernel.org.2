Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C9645EC9F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 12:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241914AbhKZLbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 06:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240373AbhKZL3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 06:29:30 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14BDC0613F1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:47:14 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id r130so8609225pfc.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=5zt1lmJFectTsnLHzmOZ9GyGtXhL/9xC4zKQUE3vgfw=;
        b=JKbpJFgm2oHpPfBjgi5/HJ9sqr5gAFsaATXaFL/KO2Gi2e2Jivop14ss8+OZrAyDoG
         JQwlV8WNtPTLd8hhyYg2+cUth4XzjRHLcXIsUVnu1qh46+Dzz1Tpuc40yjY7bA8iLj3Q
         uO5B53BBoz5PSwFfjuxWal5l2gIN90RipjVdAdr3K1h/zqGnVFfmXOhIPIVGlmvhh5Pu
         I19rPfa2LAQbMe7l1bZUnJhlBgjwGCws7YnfNqgyrYG9pIlnTNkYXPILLFPuiX6/NbKE
         yXOhbOc6ij1kJ2mn+spYaI7HgImX2gp9WB5M4SIzpWn6GXpzQHkeJGPZseyZmdXxINP1
         IL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5zt1lmJFectTsnLHzmOZ9GyGtXhL/9xC4zKQUE3vgfw=;
        b=Up5PGQ/SoqyU5cmOuLHsZlkU7dxoJgOUYCPN1Mb36VpIIZEMjevh5YPh9T06EwklOd
         LaOG8TnUgyI5fMQi4FNU/9Y8Md/Om6rQkXS1FGH27biFGVNMRFUb3N68m/gYM4y3odej
         OUhyjMdynLCwG/1OpvHhDNcU30cdfgwZc7ukNAJHtmFxLcDAVsYDR51ROKWExsnyEuOR
         PzNDY8Et/cTWzIH6wizn3vHH7U2wLRDaiXsBTxL29cTeIZTavNXNNSjd4Sg1YFICqSvw
         1hSsYjGyF+QajmzkK2PQGlcheQb23lIrMsz1hPXm1lYcTpoCYCCl1IKx1T5B9p9heuCo
         xcng==
X-Gm-Message-State: AOAM530M5VYbTR7YdP+ZH3kwxS8n5tSadRHu0Cgovknu4gKog5Thr0cG
        PSNFZwK/GgOIl7v1meaZids=
X-Google-Smtp-Source: ABdhPJxr4NKvfp4L4vIqoShSk4lC2VIbUd1P0/H+4dipHTPIGfCyWsqH3y42mGKiUsXBpVmiWYI1FQ==
X-Received: by 2002:a63:8748:: with SMTP id i69mr15019473pge.158.1637923634200;
        Fri, 26 Nov 2021 02:47:14 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id mm22sm5154897pjb.28.2021.11.26.02.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 02:47:13 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] tracing: Fix possible memory leak in __create_synth_event
Date:   Fri, 26 Nov 2021 10:47:08 +0000
Message-Id: <20211126104708.7899-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before goto err, call argv_free to handle argv in order to prevent
memory leak.

Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 kernel/trace/trace_events_synth.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 22db3ce95e74..fe2e37564c9b 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -1261,6 +1261,7 @@ static int __create_synth_event(const char *name, const char *raw_fields)
 			 */
 			if (cmd_version > 1 && n_fields_this_loop >= 1) {
 				synth_err(SYNTH_ERR_INVALID_CMD, errpos(field_str));
+				argv_free(argv);
 				ret = -EINVAL;
 				goto err;
 			}
@@ -1268,6 +1269,7 @@ static int __create_synth_event(const char *name, const char *raw_fields)
 			fields[n_fields++] = field;
 			if (n_fields == SYNTH_FIELDS_MAX) {
 				synth_err(SYNTH_ERR_TOO_MANY_FIELDS, 0);
+				argv_free(argv);
 				ret = -EINVAL;
 				goto err;
 			}
@@ -1277,6 +1279,7 @@ static int __create_synth_event(const char *name, const char *raw_fields)
 
 		if (consumed < argc) {
 			synth_err(SYNTH_ERR_INVALID_CMD, 0);
+			argv_free(argv);
 			ret = -EINVAL;
 			goto err;
 		}
-- 
2.17.1

