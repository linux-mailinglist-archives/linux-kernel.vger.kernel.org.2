Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F19043AA92
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 04:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbhJZDBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 23:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbhJZDBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 23:01:05 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCA8C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 19:58:42 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id m14so12852856pfc.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 19:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=10iBP9jh9mkSwxIoTv0VVNQ92fx2y1+MEgwu/CyOFlM=;
        b=aTG1wyIkDrZ9a0nJBnaMNr5Y9EVfESyq+LWT/zYNIn4PdgLwKfeXd2deQM+k9Kwxra
         NwgPlB2+QnZ41d34SpIj2GSOMkTGsM5zrEgEPJone1cGqg25FXQNOAIM49LP6qw1lDtp
         HAz9oURmKZWr4Pp4I7qPuGIKRom23Q8HqoW+2kVtxLcAgvHmeBwQRijBIyi2j93Sc5QG
         2X9+DwvVjAo76PvwPwxw/WvyOicFe9zq9FvcmQdfIn7FfpYpVEhSEQyH0Ne7c0+ni65e
         E27gDAlyxDGQEpAd5xB8Q/NbSk4zghtwgCkCXzQhfwgVESvPs9lXLedOhJwxkAeS1+sL
         poqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=10iBP9jh9mkSwxIoTv0VVNQ92fx2y1+MEgwu/CyOFlM=;
        b=oMo9A5kV4uDIdnAdEDCwaUr2PnBLNNi08Gtk2gkJrGj/vfpEeU8Hp5yRwDUujgRd/l
         2JB5qsp4OAr+caxy6oqQSgNnU4VBgvAcFBM26SY4/p6o5w867um4wxj4+QfSAu36NsB+
         Jreib0psRnCOjl/0GxCQtaHCJPizQcoMmt9msHKrq164OMO6k4rlg1pjL6j++XqjtTm0
         AuPhlJ6MQMz9mH+C9pTGXFIvwMD2NC7pLbkp03QHz1trx+Yx81o88ogZ9bJZ29zOhJYF
         CMpvCI6g9B/7bXav5Av8Lt81Z7xmxLd8movBiI7pcFlft17aMx+l3RqvHLOKAwMSkkpX
         73ig==
X-Gm-Message-State: AOAM533TLwXfgAfKi6xL/bv9d+9NCOm2Ar2H5hXvjJyKvSHVt1mT7ueF
        8NRKSeC8cs+4KRIE3OmwkJNSbalB3hFMCA==
X-Google-Smtp-Source: ABdhPJw6guKsVoEp2aATvHsCLrNKLD/Ijd0OJs19x2EcTOpUiplKmQQaF/YTLR7OimDqRjyDSFK0wQ==
X-Received: by 2002:a05:6a00:198a:b0:44c:ae90:85fc with SMTP id d10-20020a056a00198a00b0044cae9085fcmr22874995pfl.1.1635217122167;
        Mon, 25 Oct 2021 19:58:42 -0700 (PDT)
Received: from FVFCG2APL414.bytedance.net ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id u3sm5125448pfg.77.2021.10.25.19.58.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Oct 2021 19:58:41 -0700 (PDT)
From:   Kunkun Li <likunkun@bytedance.com>
To:     minyard@acm.org, openipmi-developer@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, Kunkun Li <likunkun@bytedance.com>
Subject: [PATCH] ipmi: ssif: Add msleep in multipart test
Date:   Tue, 26 Oct 2021 10:58:34 +0800
Message-Id: <20211026025834.82766-1-likunkun@bytedance.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During multipart test, cmd(6,7,8) or cmd(6,7,7) will
be sent continuously.

The pressure test found some BMC systems cannot process
messages in time, resulting in read_response continues to receive
error messages from i2c.
Retry mechanism will takes 10s, and finally set not support
multipart transmit.

So, to work around this，add msleep after sending cmd 6 and
cmd 7 respectively. The problem did not appear again in
pressure test.

Signed-off-by: Kunkun Li <likunkun@bytedance.com>
---
 drivers/char/ipmi/ipmi_ssif.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 20d5af92966d..65841798fafe 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1453,6 +1453,7 @@ static int start_multipart_test(struct i2c_client *client,
 	ret = i2c_smbus_write_block_data(client,
 					 SSIF_IPMI_MULTI_PART_REQUEST_START,
 					 32, msg);
+	msleep(SSIF_MSG_MSEC);
 	if (ret) {
 		retry_cnt--;
 		if (retry_cnt > 0)
@@ -1467,6 +1468,7 @@ static int start_multipart_test(struct i2c_client *client,
 	ret = i2c_smbus_write_block_data(client,
 					 SSIF_IPMI_MULTI_PART_REQUEST_MIDDLE,
 					 32, msg + 32);
+	msleep(SSIF_MSG_MSEC);
 	if (ret) {
 		dev_err(&client->dev, "Could not write multi-part middle, though the BMC said it could handle it.  Just limit sends to one part.\n");
 		return ret;
-- 
2.11.0

