Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F18F3B534B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 14:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhF0NAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 09:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbhF0NAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 09:00:49 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0D1C061574;
        Sun, 27 Jun 2021 05:58:25 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id i4so7299291plt.12;
        Sun, 27 Jun 2021 05:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lSJb3ALiMvMZDvE7jtI1z/LDciUnieTeSH6iaR3sAZA=;
        b=nQ2T+qSs9k3+8Dp8q4ZlwnnXq7Ae57qHKWIs2vmFi1iPkRbO012+05cGlO3BJjNtrG
         iFhc48MXusGaH/L9rHYVPiIcmLYRK3zwovF4PXWm4eRgf1TksJTVD5rH28WGtrOiiWjY
         K5MckTU4PGZO0/pFtmfSiLHltpV/KMjtVjPD96WYbvJey6OMQKOgLmWrrK18eyssXBOq
         diOHUhcJuqv33O6dP9IfgMoMELUJ/gAKZ3EmVIHAHz+knTzGdbJU9lLo0f5qKxUuW8gT
         pHUaJnk0WS9nRNb1Q2VANbhBnicIE2cwgR1Ko5HfLPP6xm3V4z2VJBQbXyK0m9eLBcwL
         OONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lSJb3ALiMvMZDvE7jtI1z/LDciUnieTeSH6iaR3sAZA=;
        b=gJ4jvyQtxrJnYS5v8SxM0bST29Z/ghAxIXWFiLPQ+vogYIdNNUJzxyHzqW+Z0KWvZ3
         7f13rDhpcISd8ZsecR2rOtnsEBa4+B/5ZBr2OwPmDV/NiSlEmCVc10uB3YQnctC4LhFz
         mKtmrMfV+/YD5t5bpnKJPt0/ZbaRkGyOVZFqLorJmU1KlkSwOoX3KxcnI+VAubivM++I
         N1Av4m2l1q4vjT699uYaKkxsSYKGgXI0S7H8zVctfDT3W+RtBn7Zc6Dr/IDBToxi/hxm
         rM7C0xURT9/qxllqaa93p6pxnT1TiShx3cCTy5hzbiE6iOsM70aktJbTw25qo2r0Q4qA
         iDzQ==
X-Gm-Message-State: AOAM533/58oP4Y50iZ/qxXWbasYclvlvkf9FncecVNZ9am68H0UlVDg8
        LBjU4+bJ5PMzxaU48Y1RbYlQkUJWRTWx2pt0
X-Google-Smtp-Source: ABdhPJyos4zBFqhRfEAkxu6dTUOQhSZ24LvH+CaUIbEFwixXV9YeCh0kHQSZJCP+TZUDuYH5GK7u8A==
X-Received: by 2002:a17:902:8d92:b029:113:91e7:89d6 with SMTP id v18-20020a1709028d92b029011391e789d6mr18011699plo.85.1624798705379;
        Sun, 27 Jun 2021 05:58:25 -0700 (PDT)
Received: from localhost.localdomain ([113.76.110.29])
        by smtp.googlemail.com with ESMTPSA id c5sm11270260pfi.81.2021.06.27.05.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 05:58:25 -0700 (PDT)
From:   Kelly Devilliv <kelly.devilliv@gmail.com>
To:     gregkh@linuxfoundation.org, shubhankarvk@gmail.com,
        lee.jones@linaro.org, gustavoars@kernel.org,
        chunfeng.yun@mediatek.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kelly Devilliv <kelly.devilliv@gmail.com>
Subject: [PATCH 1/3] Revert "usb: host: fotg210: Use dma_pool_zalloc"
Date:   Sun, 27 Jun 2021 20:57:45 +0800
Message-Id: <20210627125747.127646-2-kelly.devilliv@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210627125747.127646-1-kelly.devilliv@gmail.com>
References: <20210627125747.127646-1-kelly.devilliv@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit cb6a0db8fdc12433ed4281331de0c3923dc2807b for the
same reason as commit 43b78f1155c868208a413082179251f5fba78153 in the
ehci-hcd driver.

Alan writes:
    What you can't see just from reading the patch is that in both
    cases (ehci->itd_pool and ehci->sitd_pool) there are two
    allocation paths -- the two branches of an "if" statement -- and
    only one of the paths calls dma_pool_[z]alloc.  However, the
    memset is needed for both paths, and so it can't be eliminated.
    Given that it must be present, there's no advantage to calling
    dma_pool_zalloc rather than dma_pool_alloc.

Signed-off-by: Kelly Devilliv <kelly.devilliv@gmail.com>
---
 drivers/usb/host/fotg210-hcd.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/fotg210-hcd.c b/drivers/usb/host/fotg210-hcd.c
index 9c2eda0918e1..bb50a7a7318a 100644
--- a/drivers/usb/host/fotg210-hcd.c
+++ b/drivers/usb/host/fotg210-hcd.c
@@ -1857,9 +1857,11 @@ static struct fotg210_qh *fotg210_qh_alloc(struct fotg210_hcd *fotg210,
 	qh = kzalloc(sizeof(*qh), GFP_ATOMIC);
 	if (!qh)
 		goto done;
-	qh->hw = dma_pool_zalloc(fotg210->qh_pool, flags, &dma);
+	qh->hw = (struct fotg210_qh_hw *)
+		dma_pool_alloc(fotg210->qh_pool, flags, &dma);
 	if (!qh->hw)
 		goto fail;
+	memset(qh->hw, 0, sizeof(*qh->hw));
 	qh->qh_dma = dma;
 	INIT_LIST_HEAD(&qh->qtd_list);
 
@@ -4111,7 +4113,7 @@ static int itd_urb_transaction(struct fotg210_iso_stream *stream,
 		} else {
 alloc_itd:
 			spin_unlock_irqrestore(&fotg210->lock, flags);
-			itd = dma_pool_zalloc(fotg210->itd_pool, mem_flags,
+			itd = dma_pool_alloc(fotg210->itd_pool, mem_flags,
 					&itd_dma);
 			spin_lock_irqsave(&fotg210->lock, flags);
 			if (!itd) {
@@ -4121,6 +4123,7 @@ static int itd_urb_transaction(struct fotg210_iso_stream *stream,
 			}
 		}
 
+		memset(itd, 0, sizeof(*itd));
 		itd->itd_dma = itd_dma;
 		list_add(&itd->itd_list, &sched->td_list);
 	}
-- 
2.25.1

