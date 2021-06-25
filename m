Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82ECF3B3A01
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 02:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbhFYALa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 20:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbhFYAKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 20:10:48 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9672CC061756
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 17:08:28 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id r7so6232713qta.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 17:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DfUY9qc7qSrtf22f7mM9ZbwmGSBb7Ia0+UkLiTdrwNA=;
        b=OR+ONDqBqVt6Bctv6IR0mFdKG8PaoB/hroxa0sNJAREw+IGrVrkXKHLsEYpC8BVMpj
         wiicg5YsOAfQ2e8nFnO6046JIwZeFVhHD+nsbkMTgdTrjkv9DJW8ncIffQ9AfMGZQC/e
         +lLaHLTdGjWpLXvWLZfa7Zh7jPCcCyWnNh67/DoI2tuLOlPXqiJ4CwDni/TNGwVvm5uo
         7XjBV/tSs/NxeLhpH4zP5IAkfDcc8Gr3T+b2mjPpBtrlWwHCCVu1E5syoNI7OlCiShKr
         RSsV7A9GAL6/pF0tG3+gH/vRkuyaLed03Q05YMy2ogtMI/HgITQcleJnbpZ2sxd9Vw4I
         eklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DfUY9qc7qSrtf22f7mM9ZbwmGSBb7Ia0+UkLiTdrwNA=;
        b=eTzZ+DkC7BtIfSpC5RcBRqaBYDq2DiFu/yWDZRX5/eJrvOpOMAiqJnW+WMN5Uuh6ze
         57y0bddJFSn5gSWCGNCha0RmjufYxopNlNi96oQ6EMPjzIKy2xcwU38bLBsFJXfpkheh
         zHAP2A/w9cYFuvdc33cIylp5Uoq2I5VJ3R3s8r9OkZkk+zgpmWHSJzM1CsZ7FykhS8p9
         62QBj2ardpdCD/rTcpM79iFHap8kFcLi4fVRCt5Ew91q1tqheWkfgXwB9WO/EQJNQZ+y
         zQyprDOcZkdwvjbi3a00rK0Wf/PJ4MG0DrJpE0raoLPUyLnf6yris/aNyVZkw7vKKipY
         G72w==
X-Gm-Message-State: AOAM533hERj8zKT8aR3pMQtdfEsVXs4rlluenj37xMwrTI28hyxfmcpi
        u8mzzU2LW/tUqfWOu8bKUQmKvA==
X-Google-Smtp-Source: ABdhPJzl8hjb+RxB1JQ8S3CyZ0MmZI7g/G5HIdyG0wiRc8Rp7vVz7ZWEt5Xi36SdifMiQQPQONs0gg==
X-Received: by 2002:ac8:7747:: with SMTP id g7mr7219895qtu.65.1624579707808;
        Thu, 24 Jun 2021 17:08:27 -0700 (PDT)
Received: from kerneldevvm.. (5.6.a.8.a.a.b.f.c.9.4.c.a.9.a.a.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:aa9a:c49c:fbaa:8a65])
        by smtp.gmail.com with ESMTPSA id m187sm3629014qkd.131.2021.06.24.17.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 17:08:27 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 18/23] staging: rtl8188eu: remove all RT_TRACE calls from hal/hal_intf.c
Date:   Fri, 25 Jun 2021 01:07:51 +0100
Message-Id: <20210625000756.6313-19-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210625000756.6313-1-phil@philpotter.co.uk>
References: <20210625000756.6313-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all RT_TRACE calls from hal/hal_intf.c as this macro is
unnecessary, and these calls are dubious in terms of necessity.
Removing all calls will ultimately allow the removal of the macro
itself.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/hal/hal_intf.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/hal_intf.c b/drivers/staging/rtl8188eu/hal/hal_intf.c
index 60cfd31e855a..f09620c54e69 100644
--- a/drivers/staging/rtl8188eu/hal/hal_intf.c
+++ b/drivers/staging/rtl8188eu/hal/hal_intf.c
@@ -25,9 +25,6 @@ uint rtw_hal_init(struct adapter *adapt)
 		adapt->hw_init_completed = false;
 	}
 
-	RT_TRACE(_module_hal_init_c_, _drv_err_,
-		 ("-rtl871x_hal_init:status=0x%x\n", status));
-
 	return status;
 }
 
-- 
2.31.1

