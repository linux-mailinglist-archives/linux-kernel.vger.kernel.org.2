Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF0F33E7AF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 04:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhCQDfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 23:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhCQDfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 23:35:09 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE6BC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 20:35:09 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id 94so506279qtc.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 20:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ySn92rVacxqUFtPdXq4yc7pn2gVheVfVYIffMPNFbV0=;
        b=bLOaJ1F8+YjvDMpiOtNTgWbeQ40c10FnBpZ1g2zm9MmcskW3FCo31JrZszWHUO8bsQ
         1AaeRq8rAoo3u1Uj90hdbs2LnKkHXIkUU+zPOEcdN5aTZRCtowtDaD03z1kEGxmbiERT
         vvznVi06JA+Xj4kXRbBPFX4WUrDtaOh2Ok8s+8Op0I8DpP9n3yYySj7ci5ruBmE1tCb3
         jjMFYh8hcAchcwaeng58YrgUVWyM4udy8D0iuYx18K7XzPgRYKxwMSAraeBxYYPtWDJt
         lsy2keCmO9gGZKTKcESt/3jS/YQfZcX5U/oDFawJQYxgwZaYm02Qn1jc+jf9bJU8hjkL
         mMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ySn92rVacxqUFtPdXq4yc7pn2gVheVfVYIffMPNFbV0=;
        b=jmvi2ookOnVoAmHwfhIuwTrkWMGelKkaoteAn6yKKUkSAPTqcR/Z7QGGb62KfRYWox
         ck1q+v967FmED7mhQFMlGTKR7I7tz/jZhk+oByXO9t/xOEJxehcX3z/nNc3l7QJvc/VG
         nU27JSopT7r91XjiJ+JDhtOmMpXn1aaLjpNw3UT6EaZI9jB+3GAgvzZ9cX3N2+hf49pQ
         4jouQhQH4o/wb2z/WhFlTQGPBxVjInyTMhvO/c+ze33hn5SdUs+ypDnuJ9ywPcORONVv
         R/Vb0Ohpm8QzHeiEiIVbUbQ4nUVzuPzM128T6c/6M/q431sA0CwVR5slmv8TDTR6xVLc
         M2qw==
X-Gm-Message-State: AOAM531NvQxnMV9GJWOM3tH6J1VX8BmRar/6seLrfY1Gm6DbaD/vlSN3
        SuRLL8ZKQHADiApGKgsWFNc=
X-Google-Smtp-Source: ABdhPJzdmYgEXGeEX/iVafSpMnlgCZjlXu64G1PS3cE1NK1piWkHyob8OBAPOSNYZ1TyrwnMCzaZiQ==
X-Received: by 2002:ac8:688c:: with SMTP id m12mr2086271qtq.74.1615952108296;
        Tue, 16 Mar 2021 20:35:08 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.5])
        by smtp.gmail.com with ESMTPSA id e190sm16555597qkd.122.2021.03.16.20.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 20:35:07 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] mm: Typo fix in the file util.c
Date:   Wed, 17 Mar 2021 09:04:39 +0530
Message-Id: <20210317033439.3429411-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



s/condtion/condition/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 mm/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/util.c b/mm/util.c
index 54870226cea6..f85da35b50eb 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -775,7 +775,7 @@ int overcommit_policy_handler(struct ctl_table *table, int write, void *buffer,
 	 * The deviation of sync_overcommit_as could be big with loose policy
 	 * like OVERCOMMIT_ALWAYS/OVERCOMMIT_GUESS. When changing policy to
 	 * strict OVERCOMMIT_NEVER, we need to reduce the deviation to comply
-	 * with the strict "NEVER", and to avoid possible race condtion (even
+	 * with the strict "NEVER", and to avoid possible race condition (even
 	 * though user usually won't too frequently do the switching to policy
 	 * OVERCOMMIT_NEVER), the switch is done in the following order:
 	 *	1. changing the batch
--
2.30.2

