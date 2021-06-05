Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02EBC39C9C9
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 18:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhFEQOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 12:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhFEQOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 12:14:23 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B101BC061766
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jun 2021 09:12:30 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id y15so9704710pfl.4
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 09:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SB8Es1s8//Aidpc3kP4aiiMmxoB2Nz/E7RIruO5aio0=;
        b=KIdxIp2A03moYiYwJHLpXJbg6dEXxo9CZGxA04iZ0lgnKQ67nRdoGsXOIF1nGPMEXj
         d1sWiYDE+9ntt+ArIMM2duYzRqd7O4InFLSqQBZ+RjF81YyZsGlMiKCFB3XmuelZvhHO
         qdy98p7LM+e0U1WFXbacuXvZYiXPRcdqMwKD3RJ1XB7ZSzUf2Fxc7L2aYS2EDaK4NulV
         B+3J6cN4P7OO9h16W4lBy8nFkIKrso+tP/CmsD7pZNXXpVFwRe5wJYUChoCVfwnpl+I+
         eSGPABO2RulJ85IC6hc25lLrv+OUCZ4Fb3d43rMACer3LVUP6lGCUSsmiXXANhJMAPYd
         EG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SB8Es1s8//Aidpc3kP4aiiMmxoB2Nz/E7RIruO5aio0=;
        b=q6dQrms/4qszUmOxqklM/yqlwnRsDfI29jdMHJlt/9SWKV4EFksfdTFMKXv/5Ht2ZI
         VOnDsxqajdXBOetIOEPPfHLoQlOjBHycG+XR+PMOfEc3MLpGxZG3N9YRbr7X1+eiwjYD
         BG7dcM7qC2qz9IqcYkU6KB/tIP8+4OdkkRx3BotuBxF3YgM22VBM8OHoaA442XzipB8S
         YXzQLPLoaVc4Fg3KQjmhISREY2dXer72JvjOZYXnFPk4M0Va+q+jn1IqsohCvAl8drdc
         dSFTTQE8l3shMP4gjnlGtlk0q6yENTAWcEBxDujpVWuzmNAO550FLLEr7//ilkWahCkO
         UPSw==
X-Gm-Message-State: AOAM531BvSoLmiS9PAKnHxBh/G8kQVOC1gEEQzIb1xoymKFXvN15dIy7
        M9z7+HlE8W4FQemzdifUO6g=
X-Google-Smtp-Source: ABdhPJydT9mMQgQyBzCT6dAMwBE2g4/Hgxzd6LX2gxEt3jGrxXIaly6aEiXMoZoVQ0Bq2Io9B6RLRg==
X-Received: by 2002:a63:6d2:: with SMTP id 201mr10636961pgg.293.1622909550057;
        Sat, 05 Jun 2021 09:12:30 -0700 (PDT)
Received: from localhost.localdomain ([49.37.1.243])
        by smtp.gmail.com with ESMTPSA id c3sm3955335pfl.42.2021.06.05.09.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 09:12:29 -0700 (PDT)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: [PATCH] checkpatch: Fix check for embedded filename
Date:   Sat,  5 Jun 2021 21:42:19 +0530
Message-Id: <20210605161219.26421-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When checkpatch is run on file contents piped through stdin,
it may generate false EMBEDDED_FILENAME warnings if the
--file flag is used.

Consider the following test file:
$cat test.c
int x = a - b;

$cat test.c | ./scripts/checkpatch.pl -f
WARNING: It's generally not useful to have the filename in the file
+int x = a - b;

So any instance of "-" in the file contents will trigger
an EMBEDDED_FILENAME warning.

Fix it by checking if $realfile is not "-".

Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 3e1795311c87..2f50fafa0ac1 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3619,7 +3619,7 @@ sub process {
 		}
 
 # check for embedded filenames
-		if ($rawline =~ /^\+.*\Q$realfile\E/) {
+		if ($realfile ne "-" && $rawline =~ /^\+.*\Q$realfile\E/) {
 			WARN("EMBEDDED_FILENAME",
 			     "It's generally not useful to have the filename in the file\n" . $herecurr);
 		}
-- 
2.28.0

