Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D96EF44CD28
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 23:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbhKJW4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 17:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233634AbhKJWzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 17:55:53 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DACAC061766;
        Wed, 10 Nov 2021 14:53:05 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id az33-20020a05600c602100b00333472fef04so5105995wmb.5;
        Wed, 10 Nov 2021 14:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ol/nKO7r8NkQwHBDAbwV2ietksqRbkzg5QBtFCAI1hk=;
        b=Kt6Ej8Qc3hpUQ6mZrEBCqrWHdGyM8Sf9o7XfyWkjOTWd6Bdp+WlWk/p7t5dyoDs9Dd
         CpeSBYw/bB2/AXKS2WHj1M2yGNaSxDANMzGfhcf2mwgsVzSxHtBqUQ2VauUguw+6SHSo
         tug9BumlLZvj9BX3L9ogZuYQIKlAju9X0n+uQMBsLc4snFZVN8/3ATfQ04GRFH8pNxPh
         ZYBIGUSz3z7kExoBadilWOW0+jNR1MHDz0y5wya5VYehCn0sCmvnQFLTyv2yIdlUG1Io
         fr5bPRn7wn5VOg0P8nzX7fZ736sdmdO/8AKWrXPNPd4nvRxdIBQ2PtfKL0z9nkjE6fw5
         92nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ol/nKO7r8NkQwHBDAbwV2ietksqRbkzg5QBtFCAI1hk=;
        b=KJMvB5UheAoF2XR+AoSrBIMfjpBY3GUrj/hadH5FZvL6T0+s/+G+EYppSB+VOkn23n
         Xn3LyGmUEGNaAwXpznGw3vp2zIAxm8tUxkFl2edemns8gIggaDpk6aGbNIK7Us2Zi6zn
         StuPsVu1TVsEHYNIn7etBolVk9Ksl935uK71qQBv6BQziBDYfcRlIjdYpZVzhwTpSm8h
         mDc6fxn0yeh6Zvd6CK6Ai1SPk/N8gu6meSFk01f1KPzlyy9rMuknFbyhTNdc9sbMNbmM
         tJHBuuJEWRZStt6VVGg28jYcabdX5rf0dYXn48pw4Hp/oaOUFSW0HfPw8RvbxQtJnGrY
         Dz4g==
X-Gm-Message-State: AOAM5337q8MeisxwRnqOH1u5T9/i0+OmJI2rg7XGkrTRAvCJ1hrYiqgB
        BEn8HJcv08DqqHXh6BGK00e51ogKFg==
X-Google-Smtp-Source: ABdhPJxNnDHRcVK5veeRh2QQFTNmqTm7rbVEkM6YYYRZ096DcrlxQMaqRq7abozRbzbvR5vcRrExvA==
X-Received: by 2002:a05:600c:354f:: with SMTP id i15mr3060605wmq.59.1636584783674;
        Wed, 10 Nov 2021 14:53:03 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id o8sm1129299wrm.67.2021.11.10.14.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 14:53:03 -0800 (PST)
From:   Colin Ian King <colin.i.king@googlemail.com>
X-Google-Original-From: Colin Ian King <colin.i.king@gmail.com>
To:     William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        speakup@linux-speakup.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] speakup: remove redundant assignment of variable i
Date:   Wed, 10 Nov 2021 22:53:01 +0000
Message-Id: <20211110225301.315573-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable i is being initialized a value that is never read, it is
re-assigned later on in a for-loop.  The assignment is redundant and
can be removed.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/accessibility/speakup/speakup_acntpc.c | 2 +-
 drivers/accessibility/speakup/speakup_dtlk.c   | 2 +-
 drivers/accessibility/speakup/speakup_keypc.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/accessibility/speakup/speakup_acntpc.c b/drivers/accessibility/speakup/speakup_acntpc.c
index c1ec087dca13..023172ca22ef 100644
--- a/drivers/accessibility/speakup/speakup_acntpc.c
+++ b/drivers/accessibility/speakup/speakup_acntpc.c
@@ -247,7 +247,7 @@ static void synth_flush(struct spk_synth *synth)
 static int synth_probe(struct spk_synth *synth)
 {
 	unsigned int port_val = 0;
-	int i = 0;
+	int i;
 
 	pr_info("Probing for %s.\n", synth->long_name);
 	if (port_forced) {
diff --git a/drivers/accessibility/speakup/speakup_dtlk.c b/drivers/accessibility/speakup/speakup_dtlk.c
index 92838d3ae9eb..a9dd5c45d237 100644
--- a/drivers/accessibility/speakup/speakup_dtlk.c
+++ b/drivers/accessibility/speakup/speakup_dtlk.c
@@ -316,7 +316,7 @@ static struct synth_settings *synth_interrogate(struct spk_synth *synth)
 static int synth_probe(struct spk_synth *synth)
 {
 	unsigned int port_val = 0;
-	int i = 0;
+	int i;
 	struct synth_settings *sp;
 
 	pr_info("Probing for DoubleTalk.\n");
diff --git a/drivers/accessibility/speakup/speakup_keypc.c b/drivers/accessibility/speakup/speakup_keypc.c
index 311f4aa0be22..1618be87bff1 100644
--- a/drivers/accessibility/speakup/speakup_keypc.c
+++ b/drivers/accessibility/speakup/speakup_keypc.c
@@ -254,7 +254,7 @@ static void synth_flush(struct spk_synth *synth)
 static int synth_probe(struct spk_synth *synth)
 {
 	unsigned int port_val = 0;
-	int i = 0;
+	int i;
 
 	pr_info("Probing for %s.\n", synth->long_name);
 	if (port_forced) {
-- 
2.32.0

