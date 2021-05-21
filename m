Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB13A38BBA6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 03:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237007AbhEUBhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 21:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237001AbhEUBhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 21:37:45 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A98C0613ED;
        Thu, 20 May 2021 18:36:22 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id i5so11054362qkf.12;
        Thu, 20 May 2021 18:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=plkiWevmWcgL15Zlx+6OXKOK7VZtZ4qvyrWLBIIHSW8=;
        b=t/OTB+J7uvaj3nqyvThvm5YO2hd0vKCdMJwyej8eTk+e6W3EnL5/gRbDRSNIsvAvy0
         NSGOTX+Xw0w9RPyJxnSriP7WiTRQddleUcagQciLRyMrkoD80Iy/Z59qS+sUbx/mi/YR
         ygY+G2mdXrdoMxsWJn8ALr4roVwL4U6sjvn4GHRNRxpq22CbNNnW+PatAUtNlbYxq+PG
         qQcTrOb1OpVd+WSwbihVHHKkh53TJMl9yElhcvWPKKQKrJUyCEOtRH7ehv31oWr45SfI
         ycBfuyUHN8zRCAtMi0GdPdIdT4bxiG+V0wMGkVfUtdAZis4uvN/GQIzPwK7Ap55cxoyg
         efaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=plkiWevmWcgL15Zlx+6OXKOK7VZtZ4qvyrWLBIIHSW8=;
        b=O1uGa1CypKLahc5nKs6uxsvoUFhq1ZDaJtwT0D7BmPaMsXfdyFe1ohgQ5mwLwBLbIB
         7Qx00dkoUSUgzZBU2gAf7+XrXheG1JyQur+gjlXqbnDoSsqvIYNXgwVwJIj0/VTOLEnh
         lNdTJDPKqv+AVFm3QhpC+clvVUjRFLe0nakL1Y82352nl0O/uZhd+A60aU4agj+v044r
         SeRPVF78sWnkzSSPvrSg6vP1uvgxPvAWvvlw4R8SS7vBEw0faL8e/G8ErgH7U8rd0shK
         wWZstkKnx2dA5373FlkTZnps/hDlw+L0kuzcHHtDrDNxwrPkW7b5BX5Ge0p5pYG5uyJZ
         vKJA==
X-Gm-Message-State: AOAM531TYCZKzEI3EDi05CSaMrJhl+KpuQTkx09YdWKeMQU+f2PLmJi/
        sPQKb+K5ajgmAQtIK21QK3E=
X-Google-Smtp-Source: ABdhPJw/vBgtK5gioZHKFcavd/rXjNCmgkS3Qq+jmhnD2Nf4IZJsU/bpoZdrXcMNkngDQZjbZq3Y8A==
X-Received: by 2002:a37:e105:: with SMTP id c5mr8630580qkm.455.1621560981986;
        Thu, 20 May 2021 18:36:21 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:485:504a:74ed:8ad2:143d:dd84])
        by smtp.gmail.com with ESMTPSA id l197sm3496565qke.121.2021.05.20.18.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 18:36:21 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     stern@rowland.harvard.edu, linux-doc@vger.kernel.org,
        sfr@canb.auug.org.au, corbet@lwn.net, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] usb: Restore the usb_header label
Date:   Thu, 20 May 2021 22:36:08 -0300
Message-Id: <20210521013608.17957-1-festevam@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit caa93d9bd2d7 ("usb: Fix up movement of USB core kerneldoc location")
removed the reference to the _usb_header label by mistake, which causes the
following htmldocs build warning:

Documentation/driver-api/usb/writing_usb_driver.rst:129: WARNING: undefined label: usb_header

Restore the label.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: caa93d9bd2d7 ("usb: Fix up movement of USB core kerneldoc location") 
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 Documentation/driver-api/usb/usb.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/driver-api/usb/usb.rst b/Documentation/driver-api/usb/usb.rst
index 820e867af45a..2c94ff2f4385 100644
--- a/Documentation/driver-api/usb/usb.rst
+++ b/Documentation/driver-api/usb/usb.rst
@@ -123,6 +123,8 @@ are in ``drivers/usb/common/common.c``.
 In addition, some functions useful for creating debugging output are
 defined in ``drivers/usb/common/debug.c``.
 
+.. _usb_header:
+
 Host-Side Data Types and Macros
 ===============================
 
-- 
2.25.1

