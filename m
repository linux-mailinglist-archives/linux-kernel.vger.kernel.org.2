Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED1C346A69
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 21:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbhCWUpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 16:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbhCWUpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 16:45:40 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F67C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 13:45:38 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id j17so11162373qvo.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 13:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RUgvO1rZctYMPdZPottzZ9JagbxcsrEkbruYu8o8cmo=;
        b=KTcJlCyGSOmooctjTz2tK6OWYwyoF63uzwiGE4kGwAdssi7d/ZhZE4T/d/fufa3w0F
         RAFsqNq/tPAC+P8VBK7KaTFqqqYXHJLUK5T4tkZ2vE/Eb3csdn+5s5546DopsUoSBn03
         DdMZP2nBor5my2zh2+cmAqpDMLBK35A6TI468FzsEoScipjT0sg7sIbEQz2IApLwahl/
         oXgTBSQVvuMUyeyuPQswd8LIr7riVLdX0MOJKAAvyRmKUZaOp5viMxWL0WHrpo8MHeUm
         uFuXS2J0XVjRhYlTgNiG3qfArq+u9atFWWnqQu71sTL3qEU0JQJJJx/xRxjwS3TmlAXX
         JhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RUgvO1rZctYMPdZPottzZ9JagbxcsrEkbruYu8o8cmo=;
        b=kO9L2mPo4Vx7fZZPmYsAPOyFU3eG8hzm1p2vTbZacPmGL2H+vPpxuHI+2bt5NBY8Ew
         ewaU4d1fg1yqzicE+RZlxCogQnD8wnDsziJfK1C0KiMU7njqhC02gYllU/f8dJ6/SWXC
         i4DGDZVoBLNHVSFaIt+TEDPV2LWn0nGnIS15qPz/96cde2FkktVlv+YIQL0N2hEODvrK
         FQdVNv/N7gqacUhO5wg7Q5bvQzjtYFB7fXNpKy9LFLApWESVsgJM8u9fG5o42FDV7skn
         35s6YyO/baGH3mZPfYMcibp6VHJb0yyvHSAEXPWaaJIgGY8IrU6ABOkf7JW54i2SVIbI
         VK+g==
X-Gm-Message-State: AOAM531+R/qkR8Xc+/YF2wbzgpEkNwr96SRPXJ4SQXSo6NBv1GbaWTeP
        GChZRXQ/3EnHBmnLbt+E9hq4VN/CLVO5j1dv
X-Google-Smtp-Source: ABdhPJy3r1AWvy/tj6UqYhI5mZoK/SHIM8KoJ20iKRDVrq3gLlrrWD37tIBBc2ZzUGGFYyZ4UxcqkQ==
X-Received: by 2002:a05:6214:16c1:: with SMTP id d1mr6999063qvz.29.1616532338069;
        Tue, 23 Mar 2021 13:45:38 -0700 (PDT)
Received: from Slackware.localdomain ([37.19.198.105])
        by smtp.gmail.com with ESMTPSA id j24sm26367qka.67.2021.03.23.13.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 13:45:37 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     benh@kernel.crashing.org, unixbhaskar@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] macintosh: A typo fix
Date:   Wed, 24 Mar 2021 02:16:52 +0530
Message-Id: <20210323204652.23059-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/coment/comment/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/macintosh/windfarm_smu_controls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/macintosh/windfarm_smu_controls.c b/drivers/macintosh/windfarm_smu_controls.c
index 79cb1ad09bfd..75966052819a 100644
--- a/drivers/macintosh/windfarm_smu_controls.c
+++ b/drivers/macintosh/windfarm_smu_controls.c
@@ -94,7 +94,7 @@ static int smu_set_fan(int pwm, u8 id, u16 value)
 		return rc;
 	wait_for_completion(&comp);

-	/* Handle fallback (see coment above) */
+	/* Handle fallback (see comment above) */
 	if (cmd.status != 0 && smu_supports_new_fans_ops) {
 		printk(KERN_WARNING "windfarm: SMU failed new fan command "
 		       "falling back to old method\n");
--
2.30.1

