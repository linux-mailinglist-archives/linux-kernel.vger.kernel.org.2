Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05AD244CDED
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 00:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbhKJXge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 18:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbhKJXgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 18:36:32 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4B0C061766;
        Wed, 10 Nov 2021 15:33:44 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id i12so2751467wmq.4;
        Wed, 10 Nov 2021 15:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pMN8Aea9HLB4e2JbJzUF/m9px+29MZxvB957BFSh8To=;
        b=iofhyXTuvPl/5qcFqQByHPQjJBgQulnLGQZSeh8tgLJeaoIVnQBRP9MJa/A4Uqfa2p
         5VRgC4SiU32HTWYrmJ9ec6txRu+B9dvsZUdFfhIUYv9+vSFdURe+3yORTp3ce1nrRrHl
         HszfKfknmsoQ/Lsiw90ZqkqUhsDU1O+LcO8owIGrxU0h8ytXDE7+jlnhhz8Pst1GpGaJ
         teVJqzCerN8E2KOZL57LIWDpbhmblA0GoMF6iX5SlAVWiNslCclHWKFoULzlkrV7TlVQ
         lho3zhxAvkLk9ZLkQcfDAf6Yz9pszukrOCWXfHqFUvOiS1VGsrueQGFX6S+tSF0i3G02
         fb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pMN8Aea9HLB4e2JbJzUF/m9px+29MZxvB957BFSh8To=;
        b=xH+rWCgN77Exkn2sA4GRvKqHmULz4V0F/2T0bAi4Dpj//TsPwpz3R+qCXf3PfDy3Uu
         PfCWe1jbUDLjhbYQPzUU+bEdaWw9IwGvenShVaB9BuvO0QL6L1o9xcRgSPfakF9uM50W
         xoD0Ghe+6XB3wbQPuxxNX+4egeUOuletLDl2KbqwGqhIo/LUDPXlILayfk1qs9VPb9U8
         FS2kwY+qVDPoPKe3yC6rowlQ4pFbSYxUASpyJwkVh355PD5JoELHjI9p6zxqHG5b7erP
         uFWpeb+dVb7sX4g+FPYstiJ+gHKa90kvK79xrvW0d2Y9x11ytyGPV6N1ZCcQPsdifDsa
         E1mw==
X-Gm-Message-State: AOAM5301t31chchkVjk6JpZMCVnTHS+enH/d/tdl0kwP3pGlH5sx7/3b
        vWn+Aw3Va4h3vzka9uDV+GqxkbBmJA==
X-Google-Smtp-Source: ABdhPJwFJGlrnExx+SIvQBkQR6NX3bhhbPm8+DcnUbuWiXhLgR1XKpadHZgu9uIdvB8Bv8vNmnzF3w==
X-Received: by 2002:a1c:f712:: with SMTP id v18mr20864900wmh.37.1636587223144;
        Wed, 10 Nov 2021 15:33:43 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id v8sm1201244wrd.84.2021.11.10.15.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 15:33:42 -0800 (PST)
From:   Colin Ian King <colin.i.king@googlemail.com>
X-Google-Original-From: Colin Ian King <colin.i.king@gmail.com>
To:     William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        speakup@linux-speakup.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2] speakup: remove redundant assignment of variable i
Date:   Wed, 10 Nov 2021 23:33:42 +0000
Message-Id: <20211110233342.1372516-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable i is being initialized a value that is never read, it is
re-assigned later on in a for-loop.  The assignment is redundant and
can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
V2: Use correct SoB
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

