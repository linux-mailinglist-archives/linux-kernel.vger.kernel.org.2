Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3978A36A595
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 09:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbhDYHpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 03:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbhDYHp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 03:45:29 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271E2C061574
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 00:44:49 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 10so1489480pfl.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 00:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M0ShZ+VgTC4hGFkGb8SaDtr6ogRfGJGiJKk9ryazP1g=;
        b=A+//hf5+KkICzKb5BXjmnB1Jl8a0I33AkCtcPKJMQDvPdk/yellZ6MRoePlwPGW3NJ
         hpY8NTI8TewGR63AvCXmEKBzGXzGJZYVKvj2/606TM/f8IhHUs+skKiBpDYD+SGnX2r9
         RjI5fF0C8hjct3uBK+yLlnu2ji/KOf5sxsB9hjMuaYXCgs8J8TK2nPExSf1MBYLdHdTz
         r6W1ZJb1krV7p+5pHLTIacaNf/LSWj2XF6lXjfzR0goQtFta7ynepfAzUVnzwM4qdYfl
         VDPz6L38b+a+dtNORY3+LYopynDp4Xaw8XJScG0utFu50F/tsXTsWmX4++pHYVyLLGXH
         XT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M0ShZ+VgTC4hGFkGb8SaDtr6ogRfGJGiJKk9ryazP1g=;
        b=NrEkiGYFxQuT26hzKvq2H55g6aLSsyErmqgZxpXodPsZ05pRIuzQdnDBkRvLrNkSfW
         MFKYT6brbFEzYxtENnhwHtM3il8mM83Y6C6P7Ie6mdxQ/a9tb552aNOWvSFX6ynRZk66
         mOK5czdk4OQuO4KAVllFtLxMJOvBGK8VZiMwCiVmtZ25I6JFeFaQZ3cpaCXx0/vImoy1
         FPhU94tBzdH7BsaVasKR0kEiLcouFSY1f6YdO/rlQAJsA+XJb8MFLb07AMlcFtGqvDD0
         T2Pz3fdelGZqR4/kzYFl5w2q6hqBxoewn61T3tT5/v7lpOmnC99V51TMgyMnFKvBvxjT
         iqxQ==
X-Gm-Message-State: AOAM530WB7ySuhuidVJIMwhTAZ4n0y8ilwWJEAPjpH2BFAEciBLuTgoO
        xobkaPJQxMVOTyjAiEhQ2bS48LRHEphVTNyV
X-Google-Smtp-Source: ABdhPJzouyVkNoCYW5laNZxhiT2MBEwoi1sOs4XhZ+8uBPAW2VkQLYgjObGhXC8qL+ax4AHVBI9JGw==
X-Received: by 2002:a62:86c5:0:b029:25f:4e63:223b with SMTP id x188-20020a6286c50000b029025f4e63223bmr11708420pfd.19.1619336688536;
        Sun, 25 Apr 2021 00:44:48 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:9004:6b9b:1106:23bd:5fcd:29ca])
        by smtp.gmail.com with ESMTPSA id 63sm8215615pfx.202.2021.04.25.00.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Apr 2021 00:44:48 -0700 (PDT)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: [PATCH v2] checkpatch: fix uninitialized return value in raw_line subroutine
Date:   Sun, 25 Apr 2021 13:14:50 +0530
Message-Id: <20210425074450.6902-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case the second argument to raw_line subroutine is 0,
$line remains uninitialized and is returned back to the caller.
If the caller then tries to perform string concatenation with
that value, checkpatch throws an error:

Use of uninitialized value in concatenation (.) or string at
./scripts/checkpatch.pl line 1960.

Fix it by providing an empty string as the initial value
for $line.

Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---

Changes in v2:
- Change commit message

 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 23697a6b1eaa..a98217360375 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1943,7 +1943,7 @@ sub raw_line {
 	my $offset = $linenr - 1;
 	$cnt++;
 
-	my $line;
+	my $line = "";
 	while ($cnt) {
 		$line = $rawlines[$offset++];
 		next if (defined($line) && $line =~ /^-/);
-- 
2.30.0

