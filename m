Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248FE33ECF4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbhCQJ0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbhCQJ0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:26:45 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9794C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:26:44 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id d20so38186678qkc.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IrBUuxJ0/tOe5JMdV3oCdZMLR5yrFFt6tQhg6SF9S0A=;
        b=dE1SinEo08zAhMWg4UnYbEdt73S+JsqxL7ePe//MGRGo/jF76RBPZksVsKotwsRkI/
         iDezvBg0TBTIrASc1UE0m6ayW9GSMfVhVDXpb0V5jWEjqVhoOclFuHADK+evUBlvAp72
         7Iqd1T8Z8NQ88yNmJTsX06/rzMi6gv+v4jEpPepPr16bLloTrdas1MKYQZe4IgO/fzzX
         rZdDLzx4acmNb/Be862nf2LM70PgxJxqgNCgBSjBi5WaZQHQ89HiWxxCLx2QqY5+9BRS
         qYb82yp9p76wIjj5XtSAi4PWIdUCeygHb6NNwQ3EMX4a/Lt4MLzjNoQRYlLPthhvnbo6
         qm9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IrBUuxJ0/tOe5JMdV3oCdZMLR5yrFFt6tQhg6SF9S0A=;
        b=nILLU76J/m9BJURY5GcAltQd2XHK8powvbaCx+ycJJfNV7yQ13TWI5TBKXXIKKtbwn
         6I937sOJhGs/GzGDiLSrN1X2KkeyL+6VgJk+inCiS+11kotrFXVmI0ARKuOw+hiB/pXl
         nFAvh8xbYfVXNjeknW9nCwK9PY1+pFsU5F1uIiMBVG80rlzK1mVAZWUqFRIv4fzVmGiY
         cqyBVrqCc/ofC8/Qdr11kRPeUAnIGdiMwhFqWqOsVD7tM12xw7pnPOXWPXN99TZnlgz+
         ACU9kj955Vk5mmdoGPpX+uOGjP3LQzXbCSRsvGw4WPIf/X6r6HQSFbsMCVeLEt2hfDjs
         vF2w==
X-Gm-Message-State: AOAM533UanTScl6r/UOPkKaPrQP3TprtMXIdr0Zfp68SMCDLtopBdVKm
        qp6u86Q2FJZ2WfKxyBtgl+q075quidgeWyA3
X-Google-Smtp-Source: ABdhPJxTZ/kq8GIiLUeaxd9POUK/w++5tslHHZ3DZ0Y4syQpAclRJmIdQKDKwVf2q9AX7OHPLAPEJg==
X-Received: by 2002:a37:7745:: with SMTP id s66mr3669503qkc.18.1615973203980;
        Wed, 17 Mar 2021 02:26:43 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.48])
        by smtp.gmail.com with ESMTPSA id 1sm7536340qtw.3.2021.03.17.02.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 02:26:43 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     gregkh@linuxfoundation.org, colin.king@canonical.com,
        davem@davemloft.net, johannes@sipsolutions.net, arnd@arndb.de,
        unixbhaskar@gmail.com, lee.jones@linaro.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] staging: wimax: i2400m: Mundane typo fix in the file driver.c
Date:   Wed, 17 Mar 2021 14:56:24 +0530
Message-Id: <20210317092624.1138207-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/procesing/processing/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/staging/wimax/i2400m/driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wimax/i2400m/driver.c b/drivers/staging/wimax/i2400m/driver.c
index f5186458bb3d..8091106212f9 100644
--- a/drivers/staging/wimax/i2400m/driver.c
+++ b/drivers/staging/wimax/i2400m/driver.c
@@ -96,7 +96,7 @@ MODULE_PARM_DESC(barkers,
  *
  * This function just verifies that the header declaration and the
  * payload are consistent and then deals with it, either forwarding it
- * to the device or procesing it locally.
+ * to the device or processing it locally.
  *
  * In the i2400m, messages are basically commands that will carry an
  * ack, so we use i2400m_msg_to_dev() and then deliver the ack back to
--
2.30.2

