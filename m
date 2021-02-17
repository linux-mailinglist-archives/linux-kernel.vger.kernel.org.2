Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 211EF31D592
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 07:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbhBQGyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 01:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbhBQGyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 01:54:04 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B038C061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 22:53:24 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id j12so7796193pfj.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 22:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=se5FUyCQzSsn7GYKjWN/TuB61TV8alAVKg2rTO/qIOQ=;
        b=eoq0XBv+owlqCY40+UOo/vTlCiZrwb173bhQ0mCH2cOO6HJiA2rDg2tw0kgeYUo37D
         iPcUgcdmigJGHITr9RGWcush5yHJ0u32CjASBqicd3+wXJAuTgZ/Hv6yx46/D5DphWu7
         zeo09aI+T+V8bKC15+2NKkYE/g85J8MD8fauJYuIbEAbLyh7djrZmdw2b0kjvzb/EA5t
         +Gn5Xc6fKSlq1OEwE26G+mvvR/4S/M1TVGWoQSaNMNHhlnnbP84ehRs+D/MxQ1MpbW51
         gQfkDgPiRMd4YVkgtg8yNq5qQRBZDWPzcZtZQqgSwK1sLTyiE18sB/0pdlks/2EU2CsJ
         +wSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=se5FUyCQzSsn7GYKjWN/TuB61TV8alAVKg2rTO/qIOQ=;
        b=japVfY2gDnwtJTtJpCfgpboEv8GLa6Dyj43jFUp8vN/Il8lg0UV8S7OhTpxV/8MHQ6
         p1dq/BnwhQOf81NohTU8uTvhfsBEQ4XbiikbYGJvhqSDsOKIDHW7HbWoohEDYTHTb6Y5
         2MijtJp4SlkCYhBBLZ3MP2gTOn1HD8qSEy0LKiyS/zD2bmrNCJ2/T5PDG7OLDZIUrUP/
         IU1rpmLiJyYHfspilFw6WzxK8Q/F8J1BnLtSNIflR4IHtU201OGi+dTPO1LXuJAX0dhp
         KT7y2k666zd1GGBygX4/a9cj9SFn6y/haN8An2E6XUGWUwMlBw0TwP3JeZqvUl3IWm1w
         3Bhg==
X-Gm-Message-State: AOAM531FI5Bj6I243VvujhCUeD3ZA7lrXEppKPyYnxuah4RKjr9VPVFq
        DlxoYxAU05LffJHdbxn9ghU=
X-Google-Smtp-Source: ABdhPJyGlF0SogcoGEpVNWPFeFGp/lRKtFhk0g+Aadxkk+MXmBubwnnjYJQ+bKdPRL/h1d6oey7HMg==
X-Received: by 2002:a63:4760:: with SMTP id w32mr22594631pgk.378.1613544803458;
        Tue, 16 Feb 2021 22:53:23 -0800 (PST)
Received: from localhost.localdomain ([116.73.175.128])
        by smtp.gmail.com with ESMTPSA id v1sm1273601pfi.99.2021.02.16.22.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 22:53:23 -0800 (PST)
From:   Selvakumar Elangovan <selvakumar16197@gmail.com>
To:     matthias.bgg@gmail.com, gregkh@linuxfoundation.org,
        sergio.paracuellos@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: mt7621-pci: pci-mt7621: fixed a blank line coding style issue
Date:   Wed, 17 Feb 2021 12:23:18 +0530
Message-Id: <20210217065318.6685-1-selvakumar16197@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed an unecessary blank line before closing brace reported by
checkpatch.pl

Signed-off-by: Selvakumar Elangovan <selvakumar16197@gmail.com>
---
 drivers/staging/mt7621-pci/pci-mt7621.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/staging/mt7621-pci/pci-mt7621.c
index c3532bc138fb..1781c1dcf5b4 100644
--- a/drivers/staging/mt7621-pci/pci-mt7621.c
+++ b/drivers/staging/mt7621-pci/pci-mt7621.c
@@ -521,7 +521,6 @@ static void mt7621_pcie_init_ports(struct mt7621_pcie *pcie)
 
 			if (slot == 1 && tmp && !tmp->enabled)
 				phy_power_off(tmp->phy);
-
 		}
 	}
 }
-- 
2.17.1

