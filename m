Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF3C3ADF90
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 19:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbhFTRKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 13:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbhFTRKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 13:10:33 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56F2C061574
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 10:08:19 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id f70so24403314qke.13
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 10:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/KQCSrXn7Snr8NDCB1OeDv/W8BJoQGHFaqxPwgES5Fs=;
        b=mgw/sm7b3MFfIQ8QPFH5LNaaYW/guJDlJ7LZv5HxcLEtFqPEpRxu873XW8pKOfRJ7M
         qElBQSWj6e+O1XSk2AEZP3cxvXCY5GLzeHkp9WPHX6HbuFMhRXNaPW4E6tanQvJ5wiMy
         EwxJD2b65IYniXEI97RL2wFFY3xJhVhfeVp3Pv13d6HYQRj+/XJ0cJ/AGStjl+LhApOh
         xPVDJ3gZUoNXNEewS24CaYvNZHwflNf+UxUWVM+wUIOAYW4LcE5tMLVk9FkgrK0ysXz1
         6zcC7tPowS76HBk9PzJHRq4ogKyGuBsNYi1gf0EZUpkHkStsMOvRxyVx2Cw/ACr+DinT
         ZitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/KQCSrXn7Snr8NDCB1OeDv/W8BJoQGHFaqxPwgES5Fs=;
        b=mYiFqo6WmApXNFE8e2gRnen55kK913ThHD5OG6GHlCx/3eI4soFvjYO3suLjyLcvIa
         iE1ov3WaduOEShRa8CHIUM0szIUgtbWEhgomTvXDa4Lv13mvQ/EeAPXEDrM0FP/emazY
         3KIG2WvUJls4j5qzize1PTrAqCztwrqKt3w4IomMdrONKPrJYA/6uaHSq+7fivZNKhhA
         qQjSy1orABIiWbOqNWGmbaMGWjkR2Qb9lOFGYGdEu8SoKFMbR43twZF9C62ndWqvSNDn
         unQYKAW87q/YZcRnivDXByOvn5oolwDnPYE4YADmhx5lvkFakLlLy9qK2e7EgdhpQL2i
         qpag==
X-Gm-Message-State: AOAM532wp5cayoeD8WF/7xUkGd/wXbMUQLvRdy+T8ok3p4Qf/NS/LhW4
        qssPTovfD2Babaj6xwfNetREusP4qho7xyd3
X-Google-Smtp-Source: ABdhPJzRqCSTgPl7+wZi80hBoiN2fsqQkeTUpqWZrfIvIRE1M3vwuze3+Fei5RUtvV5LAcCyOCE6tg==
X-Received: by 2002:ae9:f310:: with SMTP id p16mr10026135qkg.328.1624208898896;
        Sun, 20 Jun 2021 10:08:18 -0700 (PDT)
Received: from localhost.localdomain ([207.244.102.200])
        by smtp.gmail.com with ESMTPSA id x8sm8318198qkh.130.2021.06.20.10.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jun 2021 10:08:18 -0700 (PDT)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     lukas.bulwahn@gmail.com, linux-kernel@vger.kernel.org,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: [PATCH RFC] checkpatch: extend unknown commit id check for multiple lines
Date:   Sun, 20 Jun 2021 22:38:01 +0530
Message-Id: <20210620170801.12940-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The check for unknown commit id cannot process commit references
split across multiple lines such as:

... via commit
3945ff37d2f4 ("linux/bits.h: Extract common header for vDSO").

Extend the check to handle the above.

Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 scripts/checkpatch.pl | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 0eb73e59e0b5..8d19beca3538 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3335,13 +3335,16 @@ sub process {
 		}
 
 # check for invalid commit id
-		if ($in_commit_log && $line =~ /(^fixes:|\bcommit)\s+([0-9a-f]{6,40})\b/i) {
+		if ($in_commit_log &&
+		    ($line =~ /(?:^fixes:|\bcommit)\s+([0-9a-f]{6,40})\b/i ||
+		     ($lines[$linenr - 2] =~ /\bcommit\s*$/i &&
+		      $line =~ /^\s*([0-9a-f]{6,40})\b/i))) {
 			my $id;
 			my $description;
-			($id, $description) = git_commit_info($2, undef, undef);
+			($id, $description) = git_commit_info($1, undef, undef);
 			if (!defined($id)) {
 				WARN("UNKNOWN_COMMIT_ID",
-				     "Unknown commit id '$2', maybe rebased or not pulled?\n" . $herecurr);
+				     "Unknown commit id '$1', maybe rebased or not pulled?\n" . $herecurr);
 			}
 		}
 
-- 
2.28.0

