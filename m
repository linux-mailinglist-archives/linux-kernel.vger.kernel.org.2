Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873AF3F4A39
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 14:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236721AbhHWMDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 08:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236663AbhHWMDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 08:03:06 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1C0C061757
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 05:02:23 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id z9so25849368wrh.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 05:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6c7Z3O8KmF7jzxCw0cKrH/VztUsnx4zaAeDumG/PPWY=;
        b=I7LrdSe2835qbknOvS9fsw6otV9T46YseAG+fdRtcLWdYCxR1g9Ei2ck1iTG+GnSox
         kLpDEdfigO7espyHhsVeATKu6y7IqDgtkLwMfToXFSHnQ5DS/AzPDfeZYXGNgIV3NoYv
         U4AarAF17FGZ33trE6Kvx2YZaU286b5lursSoUrp6vU6mIU5fwOWxn5kWhPEXkG5c1E7
         Rz1hNJpE44gwshk1ifE76s7xcDWHhmm3xDlokZj9gEkuX5B+plwdUy6CMmY9a+zeZets
         mFUH0YRVTb7zM7X/bWBbS37ckJL0NZ88crWLYdPIcZk2aw1mCmKcXuROkc2QwpoV4geA
         zqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6c7Z3O8KmF7jzxCw0cKrH/VztUsnx4zaAeDumG/PPWY=;
        b=BuhjBWd0vuN+xXv/ENUfdesCVrJ4ZYtURTFHBEDrij2al9jGAIJz2kwnppkccL+BpR
         qYKwpkA0URvBnI2QHnoOE2ISyFM0SFYAEMu7NmjVz57f+57k7id6YFPjErF0P3cIoIvq
         CblUaEAATuLuzIFyfzYtsACoJ28BIV09m2dm/yBUZBw6MT7Ruet+ZI3qaiIbZZkAOnY8
         RTQP0dkT8daVaelG+veLE3B6NKMSbMB0XW2kiAeHEJBRaxMakJJj+GcAkamwZHH3H/2s
         9foutaetOYJhC/loTojCP//PnxfXLlTbrR+4t3q2BXEC9ercbp1dlLM5Z3iWziGTp2E2
         cOFA==
X-Gm-Message-State: AOAM531RdyhaEE0Je00HncBio3UoxKkGi69csjH+eveAGK04h1OOz03z
        I0zfEVJpT+31D+o+zEGtfNlS0xMdco4=
X-Google-Smtp-Source: ABdhPJyUdaNYGnluWOd/CbjSDM+UiQAUhhzt6pbY5Tw21BQ1SKjC5HvXWmE5hjnbN1PVWPWuBnIibA==
X-Received: by 2002:adf:f704:: with SMTP id r4mr13532100wrp.389.1629720142236;
        Mon, 23 Aug 2021 05:02:22 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::3c39])
        by smtp.gmail.com with ESMTPSA id g5sm901332wrq.80.2021.08.23.05.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 05:02:21 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/8] staging: r8188eu: use is_multicast_ether_addr in core/rtw_mlme.c
Date:   Mon, 23 Aug 2021 14:01:00 +0200
Message-Id: <20210823120106.9633-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210823120106.9633-1-straube.linux@gmail.com>
References: <20210823120106.9633-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use is_multicast_ether_addr instead of custom macro IS_MCAST, the
buffer is properly aligned.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index c41312660054..1115ff5d865a 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -2121,9 +2121,9 @@ void rtw_issue_addbareq_cmd(struct adapter *padapter, struct xmit_frame *pxmitfr
 	struct sta_info *psta = NULL;
 	struct ht_priv	*phtpriv;
 	struct pkt_attrib *pattrib = &pxmitframe->attrib;
-	s32 bmcst = IS_MCAST(pattrib->ra);
 
-	if (bmcst || (padapter->mlmepriv.LinkDetectInfo.NumTxOkInPeriod < 100))
+	if (is_multicast_ether_addr(pattrib->ra) ||
+	    padapter->mlmepriv.LinkDetectInfo.NumTxOkInPeriod < 100)
 		return;
 
 	priority = pattrib->priority;
-- 
2.32.0

