Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D255640C435
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 13:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237526AbhIOLQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 07:16:02 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:43616
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232540AbhIOLQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 07:16:00 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 7BFE94017C;
        Wed, 15 Sep 2021 11:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631704480;
        bh=Fp6H35IjoT3mECXHByd6yKzh01Y2sDKWM5xmkRDANwQ=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=gI98WkmyoQBxWNNT/QyrodHm9Um6RctiaN1H8Xfm7AUIrnB00hIxMCZ0zqg9eTxqT
         bLkoABCLAQE4b7WUyB2VYfi5qjQxXRRqxcpEVVsN6Z7tQjIqJS1h1Z29C1aPSrrve7
         sEWGIs9nVeZ8RK2ao1WHVegeTFvHtSejQtYXVobrrnGGl1gZ+0MMeyyy124O0IVvFa
         G1iH50Xd8/BL0JC80oiQRKfHNT0NgUzLseVgE+Du44YtbZwo0a41s9wJYu5PQwpFbN
         9bMlnTBWUfpbzvWaT7+PyNKuuhbYMXyK6SDWr136w/FNnCjIdGn/yrYgnJ7/xWMmkT
         aI2avB8G6nJjQ==
From:   Colin King <colin.king@canonical.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dm-clone: make array descs static
Date:   Wed, 15 Sep 2021 12:14:40 +0100
Message-Id: <20210915111440.12011-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the read-only array descs on the stack but instead it
static and add extra const. Also makes the object code smaller by 66
bytes:

Before:
   text    data     bss     dec     hex filename
  42382   11140     512   54034    d312 ./drivers/md/dm-clone-target.o

After:
   text    data     bss     dec     hex filename
  42220   11236     512   53968    d2d0 ./drivers/md/dm-clone-target.o

(gcc version 11.2.0)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/md/dm-clone-target.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-clone-target.c b/drivers/md/dm-clone-target.c
index 84dbe08ad205..29f74b2a5cd2 100644
--- a/drivers/md/dm-clone-target.c
+++ b/drivers/md/dm-clone-target.c
@@ -161,7 +161,7 @@ static const char *clone_device_name(struct clone *clone)
 
 static void __set_clone_mode(struct clone *clone, enum clone_metadata_mode new_mode)
 {
-	const char *descs[] = {
+	static const char * const descs[] = {
 		"read-write",
 		"read-only",
 		"fail"
-- 
2.32.0

