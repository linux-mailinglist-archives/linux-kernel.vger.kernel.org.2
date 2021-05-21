Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D31238CE62
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 21:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbhEUTvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 15:51:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52201 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233595AbhEUTvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 15:51:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621626626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GPfnJGzP4OqGD0+wu1euBp+ahcfCCZpRemrfs0fPKWg=;
        b=P9gm/jvbiXwqPVL0AGUTkMgHmzzaV/rdDm04AJUAnxWsCvhRoxzJwxaR/M0gQYKpLNqtCE
        4CPsF+x4My8RwRG3oT0lXjItm1kqIoEC1PGrGWhmymOqWuIW20lNMZ39gN4aWR8LLOC/jC
        yu1R0CwOwjpsKN7ulSnYP7CGRLKKN/w=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-xklsL5kYOZmZfwjhXKNQCw-1; Fri, 21 May 2021 15:50:24 -0400
X-MC-Unique: xklsL5kYOZmZfwjhXKNQCw-1
Received: by mail-oi1-f198.google.com with SMTP id p5-20020acabf050000b02901eed1481b82so4196533oif.20
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 12:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GPfnJGzP4OqGD0+wu1euBp+ahcfCCZpRemrfs0fPKWg=;
        b=sBHox5UVM3QdbCzCWZb3+x5bnxdMA+btqpyh8bHIIBiGF7lGNFyOjAt6hWd839X5/M
         IKBTN5hjUtQLsJD4pIZWw3r2If2Lvi2c9p5o2O4aH7XBnlIbnlOF40BDv2/Z6sbbbJtX
         wM8//vVHNhiK9CeV98mfLnvZiV4Wltbf5X+O/DLhzgIquH8TpGwDYTCdBFENzPSMUt3S
         lcX6DaRZmpYrukdGY+Q2tJSA9otILLmwKWEe9+8i3TSif3iBPl/Iho/4wpZud1Ob0ijY
         GOflEEUzVA2IY9orLXQRvrHEzZTyrUUHFPiC+xP9ghBbtRK1/oJI2JqIEckTYlmU8EqI
         Xjag==
X-Gm-Message-State: AOAM531Yw5E0TLgnmMc4UDO/G+HmOHJ0l+zNMTNuSfGNeJlbOaM56q1C
        ipu5nll9AQ/DMnuwWuNaYssgzhcp+c5qEXPHtnxyNzhJfZobB5ka/tvANkpw9wnbhO366tBaxzh
        QgsDYz4Hb5w0IuAxltgfHS931
X-Received: by 2002:a9d:69c2:: with SMTP id v2mr9675691oto.186.1621626623967;
        Fri, 21 May 2021 12:50:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrhDz8hYcbq+CC3R6HOECEW0ZHmOtKTJgEQEzXiMKV0b8sWqr7I+euvwLLW/m5M5RWdTM3Rg==
X-Received: by 2002:a9d:69c2:: with SMTP id v2mr9675685oto.186.1621626623820;
        Fri, 21 May 2021 12:50:23 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id w4sm1549740otl.21.2021.05.21.12.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 12:50:23 -0700 (PDT)
From:   trix@redhat.com
To:     jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        davem@davemloft.net, kuba@kernel.org, jeffrey.t.kirsher@intel.com,
        sasha.neftin@intel.com
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] igc: change default return of igc_read_phy_reg()
Date:   Fri, 21 May 2021 12:50:19 -0700
Message-Id: <20210521195019.2078661-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Static analysis reports this problem

igc_main.c:4944:20: warning: The left operand of '&'
  is a garbage value
    if (!(phy_data & SR_1000T_REMOTE_RX_STATUS) &&
          ~~~~~~~~ ^

pyy_data is set by the call to igc_read_phy_reg() only if
there is a read_reg() op, else it is unset and a 0 is
returned.  Change the return to -EOPNOTSUPP.

Fixes: 208983f099d9 ("igc: Add watchdog")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/ethernet/intel/igc/igc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index b6d3277c6f520..71100ee7afbee 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -577,7 +577,7 @@ static inline s32 igc_read_phy_reg(struct igc_hw *hw, u32 offset, u16 *data)
 	if (hw->phy.ops.read_reg)
 		return hw->phy.ops.read_reg(hw, offset, data);
 
-	return 0;
+	return -EOPNOTSUPP;
 }
 
 void igc_reinit_locked(struct igc_adapter *);
-- 
2.26.3

