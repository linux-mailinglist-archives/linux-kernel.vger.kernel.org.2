Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50144589BE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 08:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238727AbhKVH1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 02:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbhKVH1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 02:27:36 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811D6C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 23:24:30 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id u11so13313123plf.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 23:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FHPKEo5OIrRYlJIE6fzcRlVJnFV+bGBhYieXKHhfYaM=;
        b=Xx9+J7G4V0SLP0zt2j/0jmwLZjjVJivV3EhKxSEmHpXBu/h58t9pAQLOFHUxmc8Zmz
         MwCHw0b/q2rKtoFTkbWCkt0Ok3f+ryx5TV9S4DJLpXYw+CQm+xiaj1PGbNMrJCWCdsiv
         yyowPQ9Ma0qBv/05GL12xl3ejriHPQd+HQiVSHhoS0hXhZv+6d+e9+/vJaEBgImQfFk3
         eufr/UkWj8SAgT7B/tujZBdvJEfN9C7QSaRzAflbS3pOglzCmP3/XcYDUkbHBByZtlMF
         jcHbTKsW7fzxBYGqsb4MCV6LSwMa1Oy1HZDagsHxP5cvagacCD6HJZVwpE34DX7rDrt2
         hMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FHPKEo5OIrRYlJIE6fzcRlVJnFV+bGBhYieXKHhfYaM=;
        b=0UrG+v/OebxBF7qWy3bqyqC2Qo6stl93EvxcByCq/vtVzgkFozzcHZVSYhncgRR4rA
         3kNOwVbsxlkdlvABVNAGDUHR77YWJfXqtfgXYFl297or3E55L5JGtVJRl9NKLGDWJeMt
         m8y5YUWVuZSZ+gQL4w7nudvXOyrebzBAt7z2n2hBWT4cew3Mcy0m6HH9nBQUpFreaFS1
         9HuDkCbVbBNS82dZBfwY+jAbR3X79Fa5p5/8Y0lgxeVwVoAVwd+7SUplP7vfyGUAxp+q
         Z/mYwojMBwj2Wqu+pJrMN0lNgI1tkjEizbcAfd2pNt0x3g7vjIkxmFpNxxDEtVLJHJOs
         5PwA==
X-Gm-Message-State: AOAM532lY1/w22jGMwoS2BOI561+YFaknT4qURKFjH+tk/o2gqRd5Tau
        NW3p10gKqRhOcvfwayWQVnNwVG6Fs9ltiTY6
X-Google-Smtp-Source: ABdhPJwYyLOmTNlyFC9opPr6bqQ4vaZ7UhqH97H6j7uIgUPloBs28xczJN7icfi61q4jDaWUU65PBQ==
X-Received: by 2002:a17:902:d50d:b0:141:ea03:5193 with SMTP id b13-20020a170902d50d00b00141ea035193mr104636337plg.89.1637565869937;
        Sun, 21 Nov 2021 23:24:29 -0800 (PST)
Received: from localhost.localdomain ([156.146.34.70])
        by smtp.gmail.com with ESMTPSA id pc1sm1426628pjb.5.2021.11.21.23.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Nov 2021 23:24:29 -0800 (PST)
From:   Drew Fustini <dfustini@baylibre.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@intel.com>,
        Drew Fustini <dfustini@baylibre.com>,
        zuoqilin <zuoqilin@yulong.com>,
        Tom Saeger <tom.saeger@oracle.com>,
        Sven Eckelmann <sven@narfation.org>,
        tangchunyou <tangchunyou@yulong.com>,
        linux-kernel@vger.kernel.org
Cc:     "Gustavo A . R . Silva" <gustavoars@kernel.org>
Subject: [PATCH] scripts/spelling.txt: add "oveflow"
Date:   Sun, 21 Nov 2021 23:23:02 -0800
Message-Id: <20211122072302.839102-1-dfustini@baylibre.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add typo "oveflow" for "overflow". This typo was found and fixed in
tools/testing/selftests/bpf/prog_tests/btf_dump.c

Link: https://lore.kernel.org/all/20211122070528.837806-1-dfustini@baylibre.com/
Suggested-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 scripts/spelling.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index acf6ea711299..0c8b79cfb1bb 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -1046,6 +1046,7 @@ oustanding||outstanding
 overaall||overall
 overhread||overhead
 overlaping||overlapping
+oveflow||overflow
 overflw||overflow
 overlfow||overflow
 overide||override
-- 
2.27.0

