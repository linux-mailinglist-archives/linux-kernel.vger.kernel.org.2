Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39844391873
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 15:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbhEZNDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 09:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234981AbhEZNCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 09:02:42 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96769C061342
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 06:01:05 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id n4so1059615wrw.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 06:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3jdajWMgqTEevQnjfYptjO2LrKj54lhAc8vIof71IVE=;
        b=QO85f8fSQ2woLVQ02nICRzFe1RXyo77E4GBSpDGDeLzwqyN2dWPu2dKJ1c/3QzqoVP
         pcYSovyiCXwGho+nvUEMJjxSJPvH+wI7l119e+1oRcY8Mwtsr3vad+x/DVEFX+3gdKts
         rC4qLro+xXDUpuaMU628QkULLoAAnwo+ywEiyg6ceCZWvPlbr74piwt+Yr4yECJB8rf1
         U1/QLJPtl9+v8Z3IDXGHKopVs3iJrrg417eS/OutESgHmXAVbURlAsbKfwyR7RrkzOCx
         tCTBkONR6X1PCTbP3lf9ZTCZ4LUGXj+C/IPF1vBcPo/9SYYw2cPNnwCnEqnT1OqRaj65
         IoDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3jdajWMgqTEevQnjfYptjO2LrKj54lhAc8vIof71IVE=;
        b=GMhu0peF2V+mLPP48MumNWLZdQ0FsTdY+IEKFS6xiq53oWgbbljVjCJsL/F31YNnZd
         UH6zDHl0JtXLnP7Ribh4LRXAHt8Kb2Gu2C9Tf6mAI2h7vgcK+HCTJ27Gi4qVkAzQR/Pr
         T3pQ830jSayfc0ELqNZjOMYFO6bhi9DYaIq5QznaYMTPBTeXD+VnPjrP/CUYfWmY5THK
         eAiL06K5azRy9Qy7tCYTXjOypxaUwvlOtOMbb0ghOu4/55pnytXDc2XCVfP8dO0szEam
         WKXjlIP+mE2OopLEAN5AhMgvfLXAO6gndplizK4Ja5aGFpn44dO9mSH+g/ssY5P3W8Xr
         CX3Q==
X-Gm-Message-State: AOAM531C5vKLHaeFkV+Emfg87yqd0J0dIaafnuLuZAhvnCTwLB+8IypS
        QcoTz2x2nTrZyNy00wgKW3RsXg==
X-Google-Smtp-Source: ABdhPJzsAmNhDuFQBE7dXWarbIFgbk+PFmqcRu/uTYJ+ik6VMUhseTcDyNRqrQyCOulgDbUQOxCKGQ==
X-Received: by 2002:adf:f0ca:: with SMTP id x10mr33633781wro.40.1622034064188;
        Wed, 26 May 2021 06:01:04 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id y14sm6430036wmj.37.2021.05.26.06.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 06:01:03 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH 17/24] usb: host: xhci: Remove unused variable 'len'
Date:   Wed, 26 May 2021 14:00:30 +0100
Message-Id: <20210526130037.856068-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526130037.856068-1-lee.jones@linaro.org>
References: <20210526130037.856068-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/usb/host/xhci.c: In function ‘xhci_unmap_temp_buf’:
 drivers/usb/host/xhci.c:1349:15: warning: variable ‘len’ set but not used [-Wunused-but-set-variable]

Cc: Mathias Nyman <mathias.nyman@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/host/xhci.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 27283654ca080..ac2a7d4288883 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1346,7 +1346,6 @@ static bool xhci_urb_temp_buffer_required(struct usb_hcd *hcd,
 
 static void xhci_unmap_temp_buf(struct usb_hcd *hcd, struct urb *urb)
 {
-	unsigned int len;
 	unsigned int buf_len;
 	enum dma_data_direction dir;
 
@@ -1362,10 +1361,10 @@ static void xhci_unmap_temp_buf(struct usb_hcd *hcd, struct urb *urb)
 				 dir);
 
 	if (usb_urb_dir_in(urb))
-		len = sg_pcopy_from_buffer(urb->sg, urb->num_sgs,
-					   urb->transfer_buffer,
-					   buf_len,
-					   0);
+		sg_pcopy_from_buffer(urb->sg, urb->num_sgs,
+				     urb->transfer_buffer,
+				     buf_len,
+				     0);
 
 	urb->transfer_flags &= ~URB_DMA_MAP_SINGLE;
 	kfree(urb->transfer_buffer);
-- 
2.31.1

