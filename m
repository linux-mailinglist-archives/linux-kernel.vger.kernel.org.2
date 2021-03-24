Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1AB347153
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 07:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbhCXGBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 02:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbhCXGBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 02:01:15 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068C5C061763;
        Tue, 23 Mar 2021 23:01:14 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id i19so1261816qtv.7;
        Tue, 23 Mar 2021 23:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K3/uk/TEXXQyq/2kvzcOM4Gl8GXnaHgLfZcnsbb76QA=;
        b=qKG+Y9xuvPsiFYzwpVKFAMHT6c3iQb8seYFIFP+UzRNoHBcVzMoVEzPEf7pc0+aAO+
         qsuwabSmC4s6UY9AN+BUfo9sbS6mAlgIKYwvAEivZ+4NTCo3aUNiCXzNy9VnAI/LzPC4
         wDhoLrxkCwy5ETHyul+sEJwWGNdN+lZmnPLvF9MJtF4jHhDK7RIRQEc3cUQ7SMBmcTqs
         YfV1W1T3axD7BWqd18FxuGpk+VnS4SqsefTsP6eejzA4jI0J1KpLMTSFQSJnTttFchRf
         Wu3yGgYC0SSVff9o4ZROaWl78ZpAg8FhN6Jqx4Rt1S9zR6z78tSv3PHEcSTEFq3XX9nU
         4sXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K3/uk/TEXXQyq/2kvzcOM4Gl8GXnaHgLfZcnsbb76QA=;
        b=AGRpqfWSyP9hTGdLtz2HR5ze0MRqV8vSPyo2pPvgqxfXpZnPwJeBTMS8OSNnv4tZBZ
         ssb4NbjAf9mvWWmS0nLD+I2QcWOxn9rpk8HQ0I3VR7YmVu1A1vArxmPXgzbq/ARu84DE
         gr6cJreNpWccGF9KjOPkppwie2dyp9DTX6fptnc5GdwvGydINV/xhH2b14OMC2QwwoZt
         5Z5cPrzoA8VQ4UMUySOkmcjztKKDQD7Sb7tpL61rqQabkRA7eZzy8nPDgdoFEMo1EGuJ
         a6mAFiA0CP09QyJzkJzac5I8CukXpVFTln/+ZHZ02sMngI215jTqPn4CIQl2pqzKG7wx
         2/wA==
X-Gm-Message-State: AOAM533aKgAQZxjaTtlvN6kaLHHLTceLLEw/DRAyLBV3PuMNbi3cyB/X
        JD1dk1DAFolsnREPHZpkVDk=
X-Google-Smtp-Source: ABdhPJzKFAZqYiUCh79qgDf2o6sD9D85iRoGGTznKqDVFMhZCsVL2LmPSFdR3XLvKDbjZythGl3Prg==
X-Received: by 2002:a05:622a:15cb:: with SMTP id d11mr1644837qty.230.1616565674129;
        Tue, 23 Mar 2021 23:01:14 -0700 (PDT)
Received: from Slackware.localdomain ([156.146.37.194])
        by smtp.gmail.com with ESMTPSA id t188sm1007819qke.91.2021.03.23.23.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 23:01:13 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     davem@davemloft.net, akpm@linux-foundation.org,
        0x7f454c46@gmail.com, rob.gardner@oracle.com, rppt@kernel.org,
        unixbhaskar@gmail.com, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] sparc/traps_64.c: Mundane typo fixes
Date:   Wed, 24 Mar 2021 11:32:51 +0530
Message-Id: <20210324060251.24208-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/conditon/condition/
s/periof/period/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/sparc/kernel/traps_64.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index a850dccd78ea..2353ba7e1469 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c

-/* Return the highest priority error conditon mentioned. */
+/* Return the highest priority error condition mentioned. */
@@ -1853,7 +1853,7 @@ struct sun4v_error_entry {
 	/* ID of the CPU */
 /*0x24*/u16		err_cpu;

-	/* Grace periof for shutdown, in seconds */
+	/* Grace period for shutdown, in seconds */
 /*0x26*/u16		err_secs;

 	/* Value of the %asi register */
--
2.30.1

