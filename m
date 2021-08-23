Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 266833F507F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 20:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbhHWSmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 14:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbhHWSmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 14:42:37 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4E7C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 11:41:53 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id j4so4980935lfg.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 11:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r9aUcxb9sNUdrx8ObfHnrP051md775OcOXsd+ENGkHk=;
        b=Mu3u/9Ov+Flku44gHb4rLgMJ2q6sDKk3rmdIWWm2QBC0K/o5vYEZlJ1Iq5g/YsvQ9v
         Cb41OfkYvYtMZBBAd+OGE7oqJRGUzYC8yIn25Qv+vVpn3KYEnXFa8HW0TsLC3/7bp28E
         OA6tnyq00Q9F0EqdU+pGSUohNcJNCz2ttykmCuiX0cpKzV3llHFJ2wSQ/sqHTBD2i2gp
         08nyWRYlifmN88//RRTjBWUoXGZQY0YKVcFBsyPPyHYqHRKF9/1EjxOxTGj3HTFuEjw3
         leXlAont6Mfw7u32C0aCKckIi+wmysP0ynWR7eTyx8/zmVz9GPilDek2zOIKWIazjcW/
         Uq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r9aUcxb9sNUdrx8ObfHnrP051md775OcOXsd+ENGkHk=;
        b=AQFNttRcKHAuv3v1usUb+b3g9RdbuM2uIqAlXb27MaDY3sNwNzM0uFR/F/nTHnDTST
         +M2SHj/6sR2+rjTj2ajm6/PvpsDv0otYWBJDwKn+mWv4hNm6gVoX2sWRHlshF6TUXk5v
         x42qD6GwecRUfi4MnC8tTeZok5g2FuKBqGBow5IT8dkosfkUBY3Pf7C6z7hlGTJ6Kq1G
         L91TeRmN9VSTgB9CnI6ZcebCrDLmv/sN0gBd7qaeddSx0It1o/x5WuI21WmgJDmLfnyE
         /QXNOH+woZiilmhjZK1jn/d3mm/Yalo1gs6NzjeTpQRuLZdJiSAOQykt17MXCkcwwwDP
         UpVA==
X-Gm-Message-State: AOAM533Su97UUgxyJioNSLPQ4pWjEaoabTDisJPUeWp6W2U3bbAw7+ou
        Jk3nFbOwdgRZg1Ry8JyPVtsUOIXnmW1IFw==
X-Google-Smtp-Source: ABdhPJwk/o1nmEMAaon+9nddQadyZNbpw1E+JJZKImDdePnm9POzqopPyILRfKn8jFmUhxxhDha//w==
X-Received: by 2002:a19:5503:: with SMTP id n3mr25582947lfe.195.1629744112271;
        Mon, 23 Aug 2021 11:41:52 -0700 (PDT)
Received: from localhost.localdomain ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id w3sm230469ljm.13.2021.08.23.11.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 11:41:51 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH] staging: r8188eu: make rtw_deinit_intf_priv return void
Date:   Mon, 23 Aug 2021 21:40:59 +0300
Message-Id: <20210823184059.19742-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtw_deinit_intf_priv() always return success, so there is no need in
return value

Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/staging/r8188eu/os_dep/usb_intf.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index e002070f7fba..37694aa96d13 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -129,13 +129,10 @@ static u8 rtw_init_intf_priv(struct dvobj_priv *dvobj)
 	return rst;
 }
 
-static u8 rtw_deinit_intf_priv(struct dvobj_priv *dvobj)
+static void rtw_deinit_intf_priv(struct dvobj_priv *dvobj)
 {
-	u8 rst = _SUCCESS;
-
 	kfree(dvobj->usb_alloc_vendor_req_buf);
 	_rtw_mutex_free(&dvobj->usb_vendor_req_mutex);
-	return rst;
 }
 
 static struct dvobj_priv *usb_dvobj_init(struct usb_interface *usb_intf)
-- 
2.32.0

