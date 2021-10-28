Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBBBF43DF08
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 12:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhJ1Kip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 06:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbhJ1Kic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 06:38:32 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172A5C061767
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 03:36:06 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so4658633wmz.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 03:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Qso+1ON4rmrX1jJtTceQDXho/IqTPAJlT6pz5AB0mo=;
        b=JuDRzGWXJdwZnwyw9y3XuVYfdz9VmYyIut/q4Myqdp3crHDY9XEp/eNxGhslq4+exG
         4inLg7hkdi2hYEmQ0nicHhrvVC5TagslJf4PyfHnVkYeiYbyvO/sKmepIpC6EW6vrWyz
         iiwmEkT5J4MCTO5t83XOV8Ew1gr8w1Hi/IOh2GKNcWs6r+Gl6TecOn/w/psoQZoMVs9n
         7zvXFAzoPdxxUfqEMmsfk/VNe6u+hYhV7RlCcuUUOpW4ft6zogpfUspYUPAXh3MkAEsw
         x1BKCw6bmTyahZPmdz9P/ZMUdciHFLyenLHP4mOediicetow322D23uwFmDQ3E8x8hNz
         lpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Qso+1ON4rmrX1jJtTceQDXho/IqTPAJlT6pz5AB0mo=;
        b=hQOz7BQxfSpTosQ+7xhT0QK/10Ytwj4QK9aCwJTMe0SPkIBIg7X0nZaSwHW43DoxbB
         moPx6HPQcOwYwjRrar/Pq+2mqjoiao+segK+BV+56UkQVSEiU9hGRGDdsTCFbXBqCfE6
         d+fcARa8SLN7MyNT3l9tzzzvjr6cSYBwusW16CF9+qjuuDKOyXH8z5pNuJa0qEKgiWdn
         vGnU/kqe5zuq7+K2PzNCB6/yPKsVreNK7/6yskFTIwjvgkTh/6PXAXR66g476jcYDwYd
         O/Vem0STfZ8vazvUGi9yupPUn3vJYz9Xe5OFRq0r3R98MeBa6jtATLjFFDrnY8AmP7Zx
         6p7Q==
X-Gm-Message-State: AOAM532nt0s/U669CUti+z/i5F6nDkVyQpTH9546tdKzY610YO3n/353
        bmMuZ3pCF9CtYokbVbxksJs=
X-Google-Smtp-Source: ABdhPJzVmmyk3rICEmdjGQDKZco2RAgx2FID/jxIj3Qw0fF2RVVSg+bXEv/Q2llkGSua0Y/aboa5Uw==
X-Received: by 2002:a05:600c:ac1:: with SMTP id c1mr3464003wmr.99.1635417364756;
        Thu, 28 Oct 2021 03:36:04 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id 13sm3768083wrz.38.2021.10.28.03.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 03:36:04 -0700 (PDT)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH 7/7] staging: vt6655: Update comment for `rf_write_wake_prog_syn`
Date:   Thu, 28 Oct 2021 11:35:37 +0100
Message-Id: <353aa2ea26c64adc1d591a1fabdedd3d27cce3d5.1635415820.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1635415820.git.karolinadrobnik@gmail.com>
References: <cover.1635415820.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the function description to include the actual parameters.
Update the comment on the return type.

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 drivers/staging/vt6655/rf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
index 7caac1b44a68..fb31ec70c019 100644
--- a/drivers/staging/vt6655/rf.c
+++ b/drivers/staging/vt6655/rf.c
@@ -669,11 +669,11 @@ bool RFbSelectChannel(struct vnt_private *priv, unsigned char byRFType,
  *
  * Parameters:
  *  In:
- *      iobase      - I/O base address
- *      channel     - channel number
- *      bySleepCnt  - SleepProgSyn count
+ *      priv        - Device Structure
+ *      rf_type     - RF type
+ *      channel     - Channel number
  *
- * Return Value: None.
+ * Return Value: true if succeeded; false if failed.
  *
  */
 bool rf_write_wake_prog_syn(struct vnt_private *priv, unsigned char rf_type,
-- 
2.30.2

