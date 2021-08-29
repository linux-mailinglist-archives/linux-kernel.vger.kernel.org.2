Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F683FAD57
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 19:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbhH2RBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 13:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhH2RBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 13:01:09 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AE0C061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 10:00:17 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id s29so5445636pfw.5
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 10:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=4R4J9rlvTKoWzxXXHOcB/bA1tGLKkMYkfbOBsCAW1c0=;
        b=nK0Fz/vWMlj+h/f1e/AMVns+P+Nlx0FsYwdUi34OD1gY4QxbF1zXDQ15+7tAwKK3Y9
         vE33tZpy7wZmQOxSE+kIsqnH/ZLQdMBUrvyX2YnI9K/OqVEw70vGlw4Y2IcUpDa77K8O
         n262CJAlO7e9GJbDiW9K9pG2O98mObCXwBb4GGkTh+DD6/Bxe4lKYENKITL9ECbVQLly
         IRGTkoGwGUaRq7I190MEaVIfU/+btdynTNgaLw6oBn5HVWDM1/5NXB9StrzTcw4EQkfS
         93TZByu3LFh7DBx0T+2hiJgVDSm5DtET8XD2yixkA6YgXdkMW5u1PwisSbiWAwPMGA/0
         kecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=4R4J9rlvTKoWzxXXHOcB/bA1tGLKkMYkfbOBsCAW1c0=;
        b=XcQPvI3krzVpXSul02yu8UtMbv+mUARcIc/vlg7J82aPWdeILE0Ar3kbfy9jW8YBEA
         xeUWOonXYbsHgZtRattGmjabkadn0TLI8nNN78I6AP/2yz4FkcSZmhQcJUKx/AJWMpxV
         0Om7GC0l0AXcPhao8uv8KiSjMoZ1EdA/sv1JeudTiBxZUqXROgUpge12/O8sFMwXlyZ2
         JCZg0OwktugK95dw5BdikI9ln/zwt9brB/C7QoDvo4acsjB0geqMfZqaCQr6HNnj471t
         5+JllU8hjwzgQZWqlaWlauyAPjKiGpL6qXtbvKrsBWg9fuAprZKh3JCILGySe6nU/Xii
         I95g==
X-Gm-Message-State: AOAM533W+DOva6+Va39JRQimOp8NxwDpzDUaEBOFUFo4X4JnpIHUvUWk
        aEmPJe+7Izv0i/7NGJiLqdU=
X-Google-Smtp-Source: ABdhPJym0I1PN2UCPPEzB9U4peV0Maxkqe55xorBpNwGFxR9FZpdQCnwBrl88776uCDZDnwsGGL73g==
X-Received: by 2002:a63:2f04:: with SMTP id v4mr17593682pgv.380.1630256416549;
        Sun, 29 Aug 2021 10:00:16 -0700 (PDT)
Received: from user ([117.98.200.228])
        by smtp.gmail.com with ESMTPSA id 10sm13062093pgd.12.2021.08.29.10.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 10:00:16 -0700 (PDT)
Date:   Sun, 29 Aug 2021 22:30:09 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        straube.linux@gmail.com, ross.schm.dev@gmail.com,
        saurav.girepunje@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH v4] staging: r8188eu: core: remove null check before vfree
Message-ID: <YSu9GQa1A3s6FYQx@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove NULL check. NULL check before freeing function is not needed.
Correct the indentation.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---

ChangeLog V4:
- Add Change log below --- line

ChangeLog V3:
- Add change log.

ChangeLog V2:
- Correct the indentation.

 drivers/staging/r8188eu/core/rtw_sta_mgt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_sta_mgt.c b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
index f6dffed53a60..c3600cb1790a 100644
--- a/drivers/staging/r8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
@@ -155,9 +155,8 @@ u32	_rtw_free_sta_priv(struct	sta_priv *pstapriv)
 		spin_unlock_bh(&pstapriv->sta_hash_lock);
 		/*===============================*/

-		if (pstapriv->pallocated_stainfo_buf)
-			vfree(pstapriv->pallocated_stainfo_buf);
-		}
+		vfree(pstapriv->pallocated_stainfo_buf);
+	}

 	return _SUCCESS;
 }
--
2.32.0

