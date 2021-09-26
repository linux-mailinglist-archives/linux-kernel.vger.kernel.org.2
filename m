Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 360414189C1
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 17:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbhIZPMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 11:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbhIZPL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 11:11:59 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D65DC061771
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:10:20 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id c1so13364361pfp.10
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dl+2WiAkRdwhUv73I/z3KWYLmqDWZq8P4YzfiKdXsG8=;
        b=WDs2Z6Z7wQR6rE2g2hhEk5Y3ppFsNyMr12rqw7xuWkDyD1tdLsagVW2j+EAHqyR/Yd
         WC5Zy2Ndsw3RiSlsxU8OIhyErbRBj+bZplAgBBa0SbvJmjtjQdFHQDu1h7DecroZNy7m
         s1GQcvWL0pswB7knDv+LQf33fb6Gc6wVorpwhnJRUDBd+s9sqD6BDpUWySRKPELN2HfT
         lJSLuRo3WkgJXx8TEf+84BNPHlMYJfb08mDlcwemGKujw1ztCDFc2cT6c2mpp1ansBuu
         hXFJMVFzvUdjSzIcVt3VDldgtESUlDKROim1hPkYJE8ssPx8UW/heRDkrl2REANpmN8s
         89fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dl+2WiAkRdwhUv73I/z3KWYLmqDWZq8P4YzfiKdXsG8=;
        b=eA4qhnf5Wnz3kNVO72vTzGQsmZjQIzvywoIiBSWDQrlUyVs0UCgtbT5nSlGdgA5zac
         pQ1PUe7znRZ7DyrUy7mhnnUUIWOiA9RL5xVCLx4WJgoD4FN/akZFABDRQN+igd5AbgM/
         NiQZ05poP6N9mNFA7N3ZzcFGN5ZXWsbmvNZak2ShmMGtCsQTB1jpSt84lJej9wJIwqx0
         HHnJd28TAHbsx9GlgLEnMVp1R/XOxKinlIXhvuDQuraA72cRCkXJcSq4xXB8f/oq6mvw
         /xocYdoY9Wl9O7ZxzGc7Yy68keI1lcRc8bSPi1xRuSHfIFgNT2PldUcLtWfESVE4sycz
         j7tw==
X-Gm-Message-State: AOAM530McM2hhiM8LwpTQxudYG8f/NFn5deXhfWxSvHKj34/ccmM200W
        /WS4yAWKS76QUm79N+uT31bWFN0Jlh5ogg==
X-Google-Smtp-Source: ABdhPJwKBHHJRmC24T/a6Pwpue8SvxCRMtp6RiZ/6SjkAQRHC69+RUXpvSyMqghjrx3xCm64F71nGQ==
X-Received: by 2002:a62:5e44:0:b0:44b:1ab4:59c5 with SMTP id s65-20020a625e44000000b0044b1ab459c5mr18963131pfb.13.1632669019895;
        Sun, 26 Sep 2021 08:10:19 -0700 (PDT)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id p16sm11721479pfq.95.2021.09.26.08.10.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Sep 2021 08:10:19 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH V2 15/41] objtool: Allow .entry.text function using CLD instruction
Date:   Sun, 26 Sep 2021 23:08:12 +0800
Message-Id: <20210926150838.197719-16-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210926150838.197719-1-jiangshanlai@gmail.com>
References: <20210926150838.197719-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

The whole error_entry() will be implemented in C which has a CLD
instruction.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 tools/objtool/check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 84e59a97bab6..2c775317b864 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3103,7 +3103,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			break;
 
 		case INSN_CLD:
-			if (!state.df && func) {
+			if (!state.df && func && strcmp(sec->name, ".entry.text")) {
 				WARN_FUNC("redundant CLD", sec, insn->offset);
 				return 1;
 			}
-- 
2.19.1.6.gb485710b

