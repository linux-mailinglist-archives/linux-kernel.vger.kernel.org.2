Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B39B316BFA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 18:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbhBJRBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 12:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbhBJRBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 12:01:08 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC1CC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 09:00:29 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id a16so4108176wmm.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 09:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZcMpsIok+hiSaO1SUKncalhw3n5LvdHZipOyoQRgJxQ=;
        b=zRfhwShUvUJfkBWUzkGm0izYVluBz/HUmhopEh5/rqELh1hr4uRlvYTEL/7ykXztDW
         503gCvXXekXn2mUViz10wEwU48OMpSf4Ms7cqukL4svm1VLXjuvHXhR+EDJy23E1k1jM
         MlygBUkOkMGDhw6lXdipkUwQFtQPcMqZ/marlTmAxv0AXzR/7se1gSDVxL2LbNvBAZ/F
         Ysr/OA9kMQ8k3pG+OODdRwX1HN6sKCu7HhEkjsDyJJaLV63ICSHvV+2LQ0+YHDpgy7vB
         xDC+ty4heEaiW6Bvk80Z+GUbJyDzs4/f/TLxa9eBkq7ujDnXVLZAzuH6OQhC4j1YrT4w
         Jr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZcMpsIok+hiSaO1SUKncalhw3n5LvdHZipOyoQRgJxQ=;
        b=m+xZtclIlChqz3QNrpt+E5K0RRKhhtxoit/yrzlpieUiKNTmwrrySxJ60oEYnEtqNZ
         inubsWNsg2UlofjeP8CSTvqmqqVOlNRq/gfpLyTGpLXhSmuqnNA8s4axGmI8lEGh7tZt
         MhTfOIaKTpHAHfJxdvzh1RhaJfwJfHRZSbT7M1yHiObyJ8iFUAAsIpqt5olX0+idbwTb
         Gqeu3E3HWqsG06VJwlI9Xdan43MGgGvv512YuHH/K3PKWfugt+zFErDYHduRBZ2TRtRD
         KhVCkD3YEm3V2mc19mr4UboX8qcksPopjZsSK81LpiSTTz2acTkrcpjirSU3tiOtbatz
         gmrA==
X-Gm-Message-State: AOAM533AUbirI4SWEdSDg39Nfmgm4WD+uPO9e+tQidvaZsx/paIKRTY4
        SzwVg+S0RKRoDDecA1QvpwGqTA==
X-Google-Smtp-Source: ABdhPJwoTNiNDBlw6GvBoxPFCy9ADtEZvxhrUgkoESKJ1QDiX6oG4WcQ/XlBSznWpYBqCKitRm6J1g==
X-Received: by 2002:a7b:cd08:: with SMTP id f8mr3755835wmj.142.1612976427988;
        Wed, 10 Feb 2021 09:00:27 -0800 (PST)
Received: from localhost.localdomain (2.0.5.1.1.6.3.8.5.c.c.3.f.b.d.3.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16:0:3dbf:3cc5:8361:1502])
        by smtp.gmail.com with ESMTPSA id u14sm4349739wro.10.2021.02.10.09.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 09:00:27 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: remove blank line from include/autoconf.h
Date:   Wed, 10 Feb 2021 17:00:24 +0000
Message-Id: <20210210170024.100937-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove additional blank line from include/autoconf.h, fixes one
checkpatch check notice.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8723bs/include/autoconf.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/include/autoconf.h b/drivers/staging/rtl8723bs/include/autoconf.h
index 8f4c1e734473..86cf09ca5f06 100644
--- a/drivers/staging/rtl8723bs/include/autoconf.h
+++ b/drivers/staging/rtl8723bs/include/autoconf.h
@@ -5,7 +5,6 @@
  *
  ******************************************************************************/
 
-
 /*
  * Automatically generated C config: don't edit
  */
-- 
2.29.2

