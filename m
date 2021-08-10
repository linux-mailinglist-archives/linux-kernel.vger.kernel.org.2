Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 418BD3E8660
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 01:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235367AbhHJXTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 19:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235258AbhHJXTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 19:19:36 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17711C061765
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 16:19:14 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id t3so133983plg.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 16:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yCA36GlhulzbAlvlHtt61ilkxjPVScFxCkohpC2ykWk=;
        b=FTA5YoMorv370+N11Fvss0cbmgz8Dj0PUif6S7Mxwx4JFXKANXI2ABB1FsnT+o0aO7
         +2dmeWORjkoqKFVsB7/Qw6zRG/TQvMbVNiCXYy0hSkThjr1EZ39RPTNvShGWWI4kIWlw
         PQ5+QQnfLZVsH+kO/8KgAqDvSSZi0nd73MhtbXiSqDsZV1SW/nAK2uc+p76eAMgF5a2k
         Bh9h8RSzV0hSHuEA/rD5vjlvsiWxHlfme1acpRBbJeZYXHI831TMqbpR1O34+IhbXfBc
         naKZQ3GprWfaZMjIFowhjAFkoqnRgjzOPHc3nKdkiX9e0ox6fsr/OSMedr37X0R/wK/R
         hfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yCA36GlhulzbAlvlHtt61ilkxjPVScFxCkohpC2ykWk=;
        b=oHqxaHQwceY1yXcn6LGQh/5yLEqcinnRX/Qf5v0clAj2ujPaaIim6fMTGudwpvzBsq
         /CcDj6scwY4JSH102BAuslVb9AmDWqC+9uYVmOSkrppfdA1u36rgZAiqbtS+boOv8uzm
         OuZw/rKF7V3Ye50IuLFwn35xmtcBik6z1INhshHPZH8FAUQw/suTmzzdFMhPkM/a1qKb
         Cj7b5EC/l6q3mvK2bf9HMy3B7YstwvKolyOd+k8RU1BTIJTem4BdPmZmUwjiKlrxINyi
         Zeuos2KIM41c5IlQLmBwVDclwqT95VnM5Zjc/vNksnZM5e1JbIFgJwBdqFIKR6FpAsih
         rp7Q==
X-Gm-Message-State: AOAM5304tffxW2Tn3cdkNvt45AOZvboIaOTNGHDf45h39KW2+Ji+PdPV
        cAWozSwNuv0BDsjdCpdIX4x7+Dtkdbc=
X-Google-Smtp-Source: ABdhPJykvF+abU0cmxkNq6XfHYQRr39iVCwiQ1J/YrOLO9x2Pff7iT0stXbHoYKphiplr7M1q3e9wg==
X-Received: by 2002:a17:90b:3d8:: with SMTP id go24mr7433529pjb.235.1628637553712;
        Tue, 10 Aug 2021 16:19:13 -0700 (PDT)
Received: from octofox.metropolis ([172.56.38.87])
        by smtp.gmail.com with ESMTPSA id dw15sm23117348pjb.42.2021.08.10.16.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 16:19:13 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>,
        Abaci Robot <abaci@linux.alibaba.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] xtensa: ISS: don't use string pointer before NULL check
Date:   Tue, 10 Aug 2021 16:19:03 -0700
Message-Id: <20210810231903.5778-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move strlen call inside the if block that checks string pointer for NULL.
While at it also fix the following coccicheck warning:

./arch/xtensa/platforms/iss/console.c:204:10-11: WARNING comparing
pointer to 0.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/platforms/iss/console.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/xtensa/platforms/iss/console.c b/arch/xtensa/platforms/iss/console.c
index a3dda25a4e45..8f41c0088220 100644
--- a/arch/xtensa/platforms/iss/console.c
+++ b/arch/xtensa/platforms/iss/console.c
@@ -193,10 +193,10 @@ late_initcall(rs_init);
 
 static void iss_console_write(struct console *co, const char *s, unsigned count)
 {
-	int len = strlen(s);
-
-	if (s != 0 && *s != 0)
+	if (s && *s != 0) {
+		int len = strlen(s);
 		simc_write(1, s, count < len ? count : len);
+	}
 }
 
 static struct tty_driver* iss_console_device(struct console *c, int *index)
-- 
2.20.1

