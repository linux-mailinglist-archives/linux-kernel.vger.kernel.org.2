Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCD144D2C7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 08:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbhKKH7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 02:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbhKKH7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 02:59:52 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B9CC061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 23:57:04 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id c126so5015294pfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 23:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RyhYx0Yjx3c0gD9sFK1NOJQka/tEBMj1zX12qg04JEo=;
        b=RID5nb4wtCvW6jPmfGI3fZF0wYEc2cqH/6qM8oiSYeL9d3extZzAWCmQX2inLE6r3n
         RBZPVOs8TgEyGPu4QXHAtlf/wz8HbPHUnoXn/gv5cZT7BgJuQ79lCHqT+j1C5bYF6cZN
         n1AnuAvhoMwZGtqD1uhbhgA2pV/1XLtfGmmUACjHPsyv5D4dby3ijQrXX4NCnExhcrrE
         OjE/3ew5pOlPEEHcBTHXRgx7bnIHuLXxmLHCqCDDmRFdmNOfEkzIzntjgOZyjOP1GjYW
         XCBe4ly+DaDsgc6YA9vJ2frimr546sYmN+jNIWp975N7s1GH8K0kSGTv6Gtuk2PKqfbw
         SP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RyhYx0Yjx3c0gD9sFK1NOJQka/tEBMj1zX12qg04JEo=;
        b=JGXatyi26GdW6pxeAsCgwb/D4eeMP/6nCxBrq6Vx1UkZR3O1bQ1hLWqKb+6oOKgvVp
         8bc4tLdfkXIxa4t5RcnsFoYjIAHz3q58W3Olh+UeyK1RWNRTazv6KxpM6pUSkHVg9VIh
         VYQlWpmmha3FwC4XMba3Wwpxh2Btai9g8xjK0T47jK/ZySO2kRpSTCF1or+AIhJfa2BR
         TI6FzhNs3REuphBDn3mbVUWDslaQA4cAK9oHN1VdZ3S95Le1KfMFLnlJ6I976ddTPrjj
         22vngncaKFrCw2wwyfa96D1own8viq2y5dQ64jULWcVlXik0TQqvdHmCernm8RtgD6OV
         e/7A==
X-Gm-Message-State: AOAM531XXG01ywPalLTmwXUdTDUef0e9KzyXMC9kKr6BhmN+YhUleE6Z
        XXOy8El+yCBktBCHgsopHh+mX6b+/n4=
X-Google-Smtp-Source: ABdhPJz5D6/eJ1FPoLwGQME8M/qbVyHCI8LxgpxgV0fzYz9JLNtR/Xf2gwv/4ElW9L0AdRkzWYTBVQ==
X-Received: by 2002:a62:ea16:0:b0:47b:f3d7:7a9 with SMTP id t22-20020a62ea16000000b0047bf3d707a9mr5098046pfh.60.1636617423168;
        Wed, 10 Nov 2021 23:57:03 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id e24sm1938078pfn.8.2021.11.10.23.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 23:57:02 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: ran.jianping@zte.com.cn
To:     agk@redhat.com
Cc:     snitzer@redhat.com, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org,
        ran jianping <ran.jianping@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] dm snapshot: remove unneeded variable
Date:   Thu, 11 Nov 2021 07:56:59 +0000
Message-Id: <20211111075659.158155-1-ran.jianping@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ran jianping <ran.jianping@zte.com.cn>

Fix the following coccicheck review:
./drivers/md/dm-snap-transient.c:91:10-12: Unneeded variable

Remove unneeded variable used to store return value.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ran jianping <ran.jianping@zte.com.cn>
---
 drivers/md/dm-snap-transient.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/md/dm-snap-transient.c b/drivers/md/dm-snap-transient.c
index 0e0ae4c36b37..d95b59855da0 100644
--- a/drivers/md/dm-snap-transient.c
+++ b/drivers/md/dm-snap-transient.c
@@ -88,7 +88,6 @@ static unsigned transient_status(struct dm_exception_store *store,
 				 status_type_t status, char *result,
 				 unsigned maxlen)
 {
-	unsigned sz = 0;
 
 	switch (status) {
 	case STATUSTYPE_INFO:
@@ -101,7 +100,7 @@ static unsigned transient_status(struct dm_exception_store *store,
 		break;
 	}
 
-	return sz;
+	return 0;
 }
 
 static struct dm_exception_store_type _transient_type = {
-- 
2.25.1

