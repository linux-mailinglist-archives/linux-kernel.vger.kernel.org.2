Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6858B3F97D6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 12:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244780AbhH0KJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 06:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244720AbhH0KJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 06:09:10 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDADFC061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 03:08:19 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id e21so12615802ejz.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 03:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jnI6ejb/F595rwEWHsmajcOOd4gHWgyU2jky3IJ0C30=;
        b=TLdSSv+5B4Hy/ngmtJnmRScp7DT3LJWmh73I41q4LoYLyyv2j7qH3lFwpQCM277/RY
         p9R/hiVUyn+Fj0nJf7zrhgFQzUfaFymQXCTmxG2l4tJxC3xTYunw8qr0OzNhkCLTfzSd
         PvJ+5m/NASO2pPNq2yyJHjzY1cPKEgD0hUMW9qDIa5abidHP/DXS4dOoOFSxJQS5k4sx
         GbElzgeZXx7jcVevBVPX9O0NKavCTQQUIm4gZ8dIbDw3EAYMa1t+UOS3PXQrPhDbEjP7
         XyZNvYNQ52q3FKkt29Ga2tqdqcuwjhoKoGCxSrc73WPAJ4YN7YrqlGPAu+O/ZaTmPHzo
         lWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jnI6ejb/F595rwEWHsmajcOOd4gHWgyU2jky3IJ0C30=;
        b=tCOFgrK8Cn/w4fqufe62db62uRbdXNEqzUvVC1qAhrgkz5tlcbh/baAc0LolS6OUYZ
         8MFqF6Xz2ckyRXHxPtF6iV6C28oMvPY+MVIzBKf7C9qUAqRwKg4p9SLEjHTCFcSpRaYZ
         /nrpgk9fUHUfCmFnB6oOQsF3WVbtuC/nYicZtQtseWhaOvoBBjtORG0MXsj58INa+rx9
         /YdCgLsaTdXG5lzVsMRe5QTiqzz5Kj56Ju0g5TvzBc7wKNRAn4Ddt3dz8FJbMjUNaPIT
         uzps0qr4KpIfYzvA9uJSYIFQYGjyG2txMf5f5g8rhZlLcj9s0PBLzjPYXsT0KFbYKYtV
         6JTw==
X-Gm-Message-State: AOAM5312Kbq946UdBZueWhBlDSkLgXUA/B4F76Yzm79AqKFDWCi15iL3
        7nTV1XEmZ3fqYHYStcKIHlI=
X-Google-Smtp-Source: ABdhPJwLTi+C6z42Pg1PbWLJak2wemc2Gm2Jjj66jUN1q4ZjVZbNw7bikUw+G5Y3o4yCpp731CdFUg==
X-Received: by 2002:a17:906:22da:: with SMTP id q26mr9146073eja.473.1630058897742;
        Fri, 27 Aug 2021 03:08:17 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id x9sm2939159edj.95.2021.08.27.03.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 03:08:17 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, Fabio Aiuto <fabioaiuto83@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v3] staging: r8188eu: Provide a TODO file for this driver
Date:   Fri, 27 Aug 2021 12:08:13 +0200
Message-Id: <20210827100813.18610-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a TODO file that lists the tasks that should be carried out in
order to move this driver off drivers/staging.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v2->v3: Added a task suggested by Dan Carpenter
<dan.carpenter@oracle.com>.
v1->v2: According to reviews by Fabio Aiuto <fabioaiuto83@gmail.com> and Greg K-H
        <gregkh@linuxfoundation.org>, remove "[] is currently in development...",
        indent and properly wrap the lines, remove the unnecessary last paragraph.

 drivers/staging/r8188eu/TODO | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 drivers/staging/r8188eu/TODO

diff --git a/drivers/staging/r8188eu/TODO b/drivers/staging/r8188eu/TODO
new file mode 100644
index 000000000000..98f918480990
--- /dev/null
+++ b/drivers/staging/r8188eu/TODO
@@ -0,0 +1,13 @@
+To-do list:
+
+* Correct the coding style according to Linux guidelines; please read the document
+  at https://www.kernel.org/doc/html/latest/process/coding-style.html.
+* Remove unnecessary debugging/printing macros; for those that are still needed
+  use the proper kernel API (pr_debug(), dev_dbg(), netdev_dbg()).
+* Remove dead code such as unusued functions, variables, fields, etc..
+* Use in-kernel API and remove unnecessary wrappers where possible.
+* Fix bugs due to code that sleeps in atomic context.
+* Remove the HAL layer and migrate its functionality into the relevant parts of
+  the driver.
+* Switch to use LIB80211.
+* Switch to use MAC80211.
-- 
2.32.0

