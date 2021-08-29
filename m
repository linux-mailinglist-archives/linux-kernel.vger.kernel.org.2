Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 862833FAF1C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 01:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236087AbhH2Xqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 19:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbhH2Xqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 19:46:38 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AB2C061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 16:45:45 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u9so19860957wrg.8
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 16:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G0NXrISK+mcr2itODcfepntdJfu4OArow0xKYoZmmZI=;
        b=0GL1LNv57T3N7cNKbuW6/OS37gSr45WTRs3im0EByxm6dW1Cnmlx4sLsNuAZTNUxH0
         5+uzFiQyaHHZCxDqz6iqku3qN01L/4Z6iKOFm60maaLuylsgtaxCaFd9hqLCKBf/xBnV
         SzkNbOTZ/OHRcBSgvg15kGcQIcG6triG1BDoZzND1/tFEj5uZYxVo7KkArSzFkiwGtOW
         InSmgbgbJT3OuPZrT4RuQ8SIGwnpEoIN15gnGPvoQ2wiaeKsirJYiNqnTqUGEk7+me2J
         Nw4Ahm/V+LqZxu7pj+eq/Im3waOFOc5MbP+Gj1gRJbxXsc1mSWL3f0KFnuXSyc7RLjO5
         lpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G0NXrISK+mcr2itODcfepntdJfu4OArow0xKYoZmmZI=;
        b=bRtvmGlK1dPZwzVVPqQYQavbFzm7htubez8YAXywIOj02kQQxR6h1jdHZZpiBphagG
         ZcmoRMb0CcrC1uoFq94UJzbghgQtLuxt2UQxHuyo1YfV1jIqB/uLPIimlFUblOqgPMFn
         t+foP9yyjzdIFtzDwhdNlqtbU/8nZNQs5IHKiNntRj1vQ3D6dNCe/tnk+v66p2UpTt5K
         U81IAb26u0v8SgfJE9pYil5vncl+PUW01i7ebVG9QWQ0m2t/qVojaP0cRdzgFGmXoiTs
         qhtXW62zOUaLGG8VyujnWCKp/H4riG+RmLUs0ywkSEyPagNnZU5LVZEdkVKe/ecT5pMW
         iSnw==
X-Gm-Message-State: AOAM533OY/WM6bsMY1EhkQW5B1gpQBPZG1TBBwpffOV1LjuwEqn+u1Mc
        iM9GViJ8m63JkTjBZCzwOVcymQ==
X-Google-Smtp-Source: ABdhPJzERpL6mO8xHjhhZ+qhRZfKM4biSJquzfEwb+SU0HGBk4xcpe+okr2AvADXZcCnXiZB/3OXfQ==
X-Received: by 2002:adf:f984:: with SMTP id f4mr22681367wrr.331.1630280744394;
        Sun, 29 Aug 2021 16:45:44 -0700 (PDT)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id r25sm14500574wra.12.2021.08.29.16.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 16:45:43 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     straube.linux@gmail.com, fmdefrancesco@gmail.com,
        Larry.Finger@lwfinger.net, paskripkin@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] staging: r8188eu: remove c2h_handler field from struct hal_ops
Date:   Mon, 30 Aug 2021 00:45:39 +0100
Message-Id: <20210829234541.946-2-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210829234541.946-1-phil@philpotter.co.uk>
References: <20210829234541.946-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove c2h_handler function pointer field from struct hal_ops in
include/hal_intf.h, as it is never set in this driver, and remove
the check for a non-NULL value in the rtw_hal_c2h_handler wrapper
function in hal/hal_intf.c as well. As the function always returns
_FAIL anyway, just modify it to do this unconditionally.

The motivation for removing this field is that it is more code from
the unwanted HAL layer that can be stripped out.

Acked-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Acked-by: Michael Straube <straube.linux@gmail.com>
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---

V2: Same as V1, reissued as part of series for clarity.

---
 drivers/staging/r8188eu/hal/hal_intf.c     | 6 +-----
 drivers/staging/r8188eu/include/hal_intf.h | 2 --
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index a6d589e89aeb..0c835f9cd181 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -428,11 +428,7 @@ void rtw_hal_reset_security_engine(struct adapter *adapter)
 
 s32 rtw_hal_c2h_handler(struct adapter *adapter, struct c2h_evt_hdr *c2h_evt)
 {
-	s32 ret = _FAIL;
-
-	if (adapter->HalFunc.c2h_handler)
-		ret = adapter->HalFunc.c2h_handler(adapter, c2h_evt);
-	return ret;
+	return _FAIL;
 }
 
 c2h_id_filter rtw_hal_c2h_id_filter_ccx(struct adapter *adapter)
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index fa252540e596..4603f9212030 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -251,8 +251,6 @@ struct hal_ops {
 
 	void (*hal_notch_filter)(struct adapter *adapter, bool enable);
 	void (*hal_reset_security_engine)(struct adapter *adapter);
-	s32 (*c2h_handler)(struct adapter *padapter,
-			   struct c2h_evt_hdr *c2h_evt);
 	c2h_id_filter c2h_id_filter_ccx;
 };
 
-- 
2.31.1

