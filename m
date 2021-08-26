Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65D93F800A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 03:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236473AbhHZBu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 21:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhHZBu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 21:50:56 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5715C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 18:50:09 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id lc21so2550995ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 18:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=80RKC35nU1+RD8O7RmvEN2Hh0WXweIkEFW8Ee2YLI4w=;
        b=vNRYxUYzc07cs3ZouSO8oHGLtJNMpg1T0+c4OS+qmQ9fGctVUYfIPA16xesPj2fYUB
         uRup2fqKKpm/AsonQ2FBN3RypC6oy7eN5GHa3SyXs7ht4/pfCPA8kpBxdNA1x02ncq/K
         nH0lLecLnDF35cXRXYBGu+dxSq5SmIZl/25YSJ4KxAvf1PclPfd6Ygl6FamgrVEIdDQM
         yOz0UWJ69wAWXfcPTl5Ok0OQZCo64YvxY2R3vRoGjiKbD8jowMoXkK8fas0jkRxQScqc
         yFVehrQH+kA2v8QNDO8jUPBCiALhSs2gjITOtF09NzO5r61HdpHu2EioMLTgT+m2FK1j
         zliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=80RKC35nU1+RD8O7RmvEN2Hh0WXweIkEFW8Ee2YLI4w=;
        b=au+3Jx8JrWsC4Qp5uKGZC5teNdSLtemCEY8DiHzmq1zJ8OZcW5Oaa4Itk8KFP0ja55
         omOS3PZk2sfnwgHFjn/yC2BRdDO1R2qbikNTX3QJ76y9Jw8cy4slE1AFS0CbD78FkRxE
         ZzRIyipR4MlAG/FDtgEAJLjvjccnGcE6rxDQ3LRk8LkJ/IrG0tcCwokcke8FtfBVtO+X
         TSXNQkvOyrKb7+9EheFadIarLGClQOeLXXdqVd+jMCVUAucQwZDr5vYL0FIax8KFP7Tl
         bhns/CqoMP3tYO/EkuI1Sn/JwjbdaOncxVBE5cenlTazvDiRizU2b+dqfWq67qGKMjY1
         wXmg==
X-Gm-Message-State: AOAM533Ry1GqTNSbZ9/WWmscDes6pQvWhe1p7gAw0xQHtPoVWY9yAMKA
        rCqfourPrr9eSgLs5+KRHhz0r7f/nkU=
X-Google-Smtp-Source: ABdhPJxFwcYTuMw8e9XJUjGCoAjWOF/JCHjjA/JhRYRxxUMxnFi/VoDMZzCsV3rrXVrLHREgI406eQ==
X-Received: by 2002:a17:906:9388:: with SMTP id l8mr1589658ejx.307.1629942607754;
        Wed, 25 Aug 2021 18:50:07 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id u9sm845358edo.37.2021.08.25.18.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 18:50:07 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] staging: r8188eu: Provide a TODO file for this driver
Date:   Thu, 26 Aug 2021 03:49:59 +0200
Message-Id: <20210826014959.26857-1-fmdefrancesco@gmail.com>
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

Thanks to Phillip Potter <phil@philpotter.co.uk> for for providing the first draft.

 drivers/staging/r8188eu/TODO | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 drivers/staging/r8188eu/TODO

diff --git a/drivers/staging/r8188eu/TODO b/drivers/staging/r8188eu/TODO
new file mode 100644
index 000000000000..4bccca69abac
--- /dev/null
+++ b/drivers/staging/r8188eu/TODO
@@ -0,0 +1,16 @@
+To-do list:
+
+* Correct the coding style according to Linux guidelines; please read the document
+at https://www.kernel.org/doc/html/latest/process/coding-style.html.
+* Remove unnecessary debugging/printing macros; for those that are still needed
+use the proper kernel API (pr_debug(), dev_dbg(), netdev_dbg()).
+* Remove dead code such as unusued functions, variables, fields, etc..
+* Use in-kernel API and remove unnecessary wrappers where possible.
+* Remove the HAL layer and migrate its functionality into the relevant parts of
+the driver.
+* Switch to use LIB80211 (This work is currently in development by Larry Finger).
+* Switch to use MAC80211 (This work is currently in development by Larry Finger).
+
+Please send any patches to Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
+Larry Finger <Larry.Finger@lwfinger.net>, Phillip Potter <phil@philpotter.co.uk>
+and CC linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org.
-- 
2.32.0

