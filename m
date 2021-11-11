Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D983644D2BD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 08:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhKKH41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 02:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbhKKH4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 02:56:25 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33490C061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 23:53:37 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id y7so5259359plp.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 23:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=diz0NWx3rdvWrK+h2Sf0MO5zGVzedXNR+hpSRRnycnA=;
        b=SXDf3XyP3dim1D2PY9KOt14+Waxr6N8f+Er0zIC8SzYnmyCedY7sUFLR7ebyk4zyc9
         /m48yQJesHORmAzZLhKDnDnJZZNKpwLDjrbbVTxH7p/xnaHMYgQDDYxG3v3KjJtoDYu4
         7+/HXysc08iGMvvioTVG6zlJ8AphXtbay+xxfyAe2kWLGNtA6bl6E45uHtcaiEzB80Z4
         415VdMz3gIkkVy1uDLuF4slJd6Q/861bIXqacu/mvK8RPdXAiBkKrwd8JttsUHHG1RTs
         TD2/hzZi6Q5ytIMhA6y17aOtaw/E+sBKHDILiHh/eWqIT0+l8dPQmSYeHONtNbO0/Bh7
         P6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=diz0NWx3rdvWrK+h2Sf0MO5zGVzedXNR+hpSRRnycnA=;
        b=oFhteJKvuI37wB5Lv7bXI53eXcxITj13+PGI4twF8RB2bZQv3qrH/4cC80FpoBqEil
         Qma7hSAe/v+49nvO35n500yj8eXTTzeb+3+bJ558IOCuhFrrmmDyKqO4QxZeP9IcGOat
         SRZjgR54iyjQtpwqMx7qk9A6i0TPAFhlOMxIHXQRfTWqgFQ9gWEZ6+dul1oQ8rKRNqEL
         w2xnJu/xhMm+6o4w9gfg5GnIqyyXQgtz3Suc0b6THpjXrD2fo1r4uXQS2K/oLw9bjoKm
         01ZKjQUFXbeWlwMwu7th3U24Lxfx3K5ecTb4LbGuB7nBIVDYJQSehvZ4kGzNUTUQghEw
         AQ0w==
X-Gm-Message-State: AOAM533+CvJCTr9ji1ACkVyvv0d4S5BGKJGrl5HydLc+jepAPtDSthjn
        ogUNxcjhUX7isXdbBRIHy5v8aLERpLU=
X-Google-Smtp-Source: ABdhPJx4gxlJQ++7M32dN0ueUqjuOYAZbpVnYJHLFS+S2wzEmX735KSmG143dJm161eSP05yi7z94Q==
X-Received: by 2002:a17:902:e9c6:b0:141:c588:99b2 with SMTP id 6-20020a170902e9c600b00141c58899b2mr5882063plk.63.1636617216784;
        Wed, 10 Nov 2021 23:53:36 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id il13sm4703883pjb.52.2021.11.10.23.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 23:53:36 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: ran.jianping@zte.com.cn
To:     agk@redhat.com
Cc:     snitzer@redhat.com, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org,
        ran jianping <ran.jianping@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] dm: remove unneeded variable
Date:   Thu, 11 Nov 2021 07:53:31 +0000
Message-Id: <20211111075331.158061-1-ran.jianping@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ran jianping <ran.jianping@zte.com.cn>

Fix the following coccicheck review:
./drivers/md/dm-ps-round-robin.c:91:5-7:Unneeded variable

Remove unneeded variable used to store return value.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ran jianping <ran.jianping@zte.com.cn>
---
 drivers/md/dm-ps-round-robin.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/md/dm-ps-round-robin.c b/drivers/md/dm-ps-round-robin.c
index 27f44c5fa04e..455fc02af1cf 100644
--- a/drivers/md/dm-ps-round-robin.c
+++ b/drivers/md/dm-ps-round-robin.c
@@ -88,7 +88,6 @@ static int rr_status(struct path_selector *ps, struct dm_path *path,
 		     status_type_t type, char *result, unsigned int maxlen)
 {
 	struct path_info *pi;
-	int sz = 0;
 
 	if (!path)
 		DMEMIT("0 ");
@@ -107,7 +106,7 @@ static int rr_status(struct path_selector *ps, struct dm_path *path,
 		}
 	}
 
-	return sz;
+	return 0;
 }
 
 /*
-- 
2.25.1

