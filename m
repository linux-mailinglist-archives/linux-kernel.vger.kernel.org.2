Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D573042828C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 19:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbhJJRJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 13:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbhJJRI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 13:08:58 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718FEC06161C
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 10:07:00 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id n2so9596486plk.12
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 10:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Zic24KmF+O4W0E+3TVRE9p+lKanIJdCZ7zfPRm/dtqo=;
        b=FxwX8LVHUQxJJDwugVhc0LteGzluJbcZ/bdkhJkqWaa3PLjvqPx7RCwDgP3vde/Tjq
         WNXr4edQDfKDFovPd4DSwjXWERbEffmrWs22jGlFmF2SLK9pAqdkrr2llaDFgzNbKVtM
         aERDpo5hsFS8XD+A6NDzuNda7znC51AKWhH+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Zic24KmF+O4W0E+3TVRE9p+lKanIJdCZ7zfPRm/dtqo=;
        b=UiHLYhr6+vPgDySwoJ+E4+VQI3bD7Cu/Jowj4wNn/Y2V+ZBVb0ZFvDiSwdVeZKO1bo
         EV8Dlo+HoB6v3OXM07ygRiu+YTuo7PWCGkHvsCCF7Df7HtQ0dhDzYWNlk3qnNcqejVcf
         UAX0lN2zTugMtuTz/314EY+4u3u7grvOMNaHY9fcRkz3WEb0zP7HRLO2Ypbycw5ljL1g
         w1QOlYzmjIaDtmFq2fFBrUGOdayJm5h8zzu/Tee+I72c84wXd2N8hV6VJacfdd1sSHTP
         GOfRQ01yzPGMR4thvCWeusNUbe3FGdfjWfufICii6oXv5//H3Q9hgqdb3pW7IT7SXtWt
         KUqQ==
X-Gm-Message-State: AOAM533/q1WhcRfasM+CfZbOfgLV6DHpkB3Y8qVh6MQn2wsANXQteEBQ
        lCsnF5rkUBLkW8F0xW60j08dFQ==
X-Google-Smtp-Source: ABdhPJwuBjmh6pEj6fIjL7g48Orww2ccVcRJxxEkfPlajJV4XO2LQSYNCHtHKZNmg1pkWGzycOrNWQ==
X-Received: by 2002:a17:902:be0c:b0:13e:2b53:d3 with SMTP id r12-20020a170902be0c00b0013e2b5300d3mr20359826pls.86.1633885619917;
        Sun, 10 Oct 2021 10:06:59 -0700 (PDT)
Received: from ebps (cpe-75-80-179-40.san.res.rr.com. [75.80.179.40])
        by smtp.gmail.com with ESMTPSA id g4sm5478841pgs.42.2021.10.10.10.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 10:06:59 -0700 (PDT)
Date:   Sun, 10 Oct 2021 10:06:56 -0700
From:   Eric Badger <ebadger@purestorage.com>
To:     ebadger@purestorage.com
Cc:     Meeta Saggi <msaggi@purestorage.com>,
        Eric Badger <ebadger@purestorage.com>,
        Tony Luck <tony.luck@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        "open list:EDAC-SBRIDGE" <linux-edac@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] EDAC/sb_edac: Fix top-of-high-memory value for
 Broadwell/Haswell
Message-ID: <20211010170127.848113-1-ebadger@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.25.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The computation of TOHM is off by one bit. This missed bit results in
too low a value for TOHM, which can cause errors in regular memory to
incorrectly report:

  EDAC MC0: 1 CE Error at MMIOH area, on addr 0x000000207fffa680 on any memory

Reported-by: Meeta Saggi <msaggi@purestorage.com>
Signed-off-by: Eric Badger <ebadger@purestorage.com>
---
 drivers/edac/sb_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index 4c626fc..1522d4a 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -1052,7 +1052,7 @@ static u64 haswell_get_tohm(struct sbridge_pvt *pvt)
 	pci_read_config_dword(pvt->info.pci_vtd, HASWELL_TOHM_1, &reg);
 	rc = ((reg << 6) | rc) << 26;
 
-	return rc | 0x1ffffff;
+	return rc | 0x3ffffff;
 }
 
 static u64 knl_get_tolm(struct sbridge_pvt *pvt)
-- 

