Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83412441CAE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 15:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbhKAOfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 10:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbhKAOfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 10:35:03 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDD5C061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 07:32:29 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id d72-20020a1c1d4b000000b00331140f3dc8so83031wmd.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 07:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lnE5IjZuGwXG6XS2XQreum/NO857Wg9hdT9kIZgNu3Y=;
        b=VEo78Gzyp2Np+8mDr3CsmDH++MVYntUnn4LV28IFTPKlzNiiZllZ+wDg9XHrqqAuJA
         /op9GHfE57btllrGf7tiBPiBU6XKmdyeqIhSWZAUP9f/FATZglqItBzp/ntKoqUmTQth
         84QLfPNb22YJMAqT798/kro6b87uXFPpZYfXs5P2YFvQgVjtIamK3tr3NpKBJNqWKUEt
         lP7xKa5WWwTFTJBEwYck00ueIXiZ138WBbN+GKZYU9ohHoMYv/GVzoQZZDe+ACy+WQyd
         dqgJXzIi9i6tL8HdYnilYjNpmuMSsWw0e6TM/9ogiZJmj+RqzuoWr7i3s1vTCOOUQ86d
         3KDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lnE5IjZuGwXG6XS2XQreum/NO857Wg9hdT9kIZgNu3Y=;
        b=V4PyJhqdOPpicv9v7ZtSaOfJgl7oxpUR0pqPjQIGwJiOudjBAS7aCQapelL+vy2e9K
         VD49galv4oJrbJPIRnqM7qsnk1bthtlgdqyqYpz1VXFz/yko8CxohuEr2pXWObW2zH0S
         eBy7Yd5Grs6Ya01V+fnFrt561BBqL+wn9KVcYhisSaHZOLZqPU6XvXCmRMwcudvB4mNv
         Qo64M/XEaEMhNQF5aCIGpJyOOuTWbGdT/duOfi7g5Fd+qVrKEgjlxQMMpQWN9i9RIOrR
         KySbRKzMhFynsZGq/MIHqzvw+/3NOErxXfaxjW9/BO4hEXEYOj6E+5JbT8ZnB8zzjGJ5
         3nmA==
X-Gm-Message-State: AOAM533nx5oZ+rcp8vPC34XOjDhFdRiRCzd1TidD5NtQ5xJ/u8hWkhPL
        zw8+RZV2G7WH1F9Y3KJtUYI=
X-Google-Smtp-Source: ABdhPJx/BIoKnyTQf6FH4n3jxaE+EuB0itaVTCIcxP6Tl+EpSS1fdZM3nA6QTWS6IqZed+WQs3Zi5g==
X-Received: by 2002:a1c:f405:: with SMTP id z5mr31420070wma.72.1635777148515;
        Mon, 01 Nov 2021 07:32:28 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id l8sm17157721wry.43.2021.11.01.07.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 07:32:28 -0700 (PDT)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH v2 6/8] staging: vt6655: Update comment for `rf_write_wake_prog_syn`
Date:   Mon,  1 Nov 2021 14:32:04 +0000
Message-Id: <bac06d44359d3634ad66b7ab46128366bb985426.1635773681.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1635773679.git.karolinadrobnik@gmail.com>
References: <cover.1635773679.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the function description to include the actual parameters.
Update the comment on the return type.

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 drivers/staging/vt6655/rf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
index 34fa54f7a92d..1fe073c5fb6f 100644
--- a/drivers/staging/vt6655/rf.c
+++ b/drivers/staging/vt6655/rf.c
@@ -669,11 +669,11 @@ bool RFbSelectChannel(struct vnt_private *priv, unsigned char byRFType,
  *
  * Parameters:
  *  In:
- *      iobase      - I/O base address
- *      channel     - channel number
- *      bySleepCnt  - SleepProgSyn count
+ *      priv        - Device Structure
+ *      rf_type     - RF type
+ *      channel     - Channel number
  *
- * Return Value: None.
+ * Return Value: true if succeeded; false if failed.
  *
  */
 bool rf_write_wake_prog_syn(struct vnt_private *priv, unsigned char rf_type,
-- 
2.30.2

