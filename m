Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D46731FC68
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 16:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhBSPv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 10:51:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhBSPvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 10:51:54 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F0CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 07:51:13 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id r23so22695670ljh.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 07:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/DFMlkrlKAPVKNGX9tkzf+XGf19LwdcZfmqYome26jY=;
        b=uBS2cKH9qW9PEmRZFYHgD0+04R9BLox8kgC/Css492pBnVKv/ojUQwDUhd1D/tTVur
         33CMGsq/TNFRoRLBLu7dGJWObDrIU2radpUKhwmuJZsThdlY3LIRjtfgMzcbobw7B09q
         NAiRv5Ora91RRO7vLcxBYGer1tvxzjru+gxLXGyRPMqe3aCxB8PfRu524iFh8EniPrU+
         871izwGyROvY6O7md5RmrF11iRuPuobq9d93DiRoDFZQQSQ2Kdkfo8NJ0EEmgZ4aPGxQ
         O8n//+HyM9DatnqoDv1ErxSOF/vbb96Ora3ksXgS7lH32Jvjl3dOpY3pABWJn22ju+hq
         lPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/DFMlkrlKAPVKNGX9tkzf+XGf19LwdcZfmqYome26jY=;
        b=B3QyZmttiPI4iTlVffeirk5FaJU2+W6kaTZB/2WUs8cPDXiShjFPA6cmm8FyokaAvd
         IVENmSXCpQ/GtoyhWU6Br9cXCUeKCOX3hqDeY81Fye+xRVNnJWI1qIuAvAFX05eYCj1D
         NP4YqG4QcTU6auZCUssgAmgv3L+VvehO6trwcAxKKmNsMNr+R1v31HjdniO1O3a5gPwW
         0s83l8D/MVuyzQpV5ZK6+9iWyhZbyqcMD15SV0e0c5AIeLayF2XKHz2kMEY1R0/zGeCf
         PzGKkp8RJLkfYQwTP1C/zNWo4tltnkve+RXZj7vQIpo6mYDZRNGG36AFq6prqHVFPBvz
         vpJA==
X-Gm-Message-State: AOAM531+JdBUZ3FfkhCCsd2PozoBUU4jx5Bnsk7by2F3qzBTXROE7tJd
        HJU9U2D+HP9bZ2UQMZjgrm8=
X-Google-Smtp-Source: ABdhPJw95RAgf6JuPma0lqmnaUwqpYDJfnfVpbmoTqLjPufexGNReFxhevmJ5qYAetj3hSlIzo4Hcw==
X-Received: by 2002:a19:c201:: with SMTP id l1mr5776989lfc.613.1613749871514;
        Fri, 19 Feb 2021 07:51:11 -0800 (PST)
Received: from msi.localdomain (vmpool.ut.mephi.ru. [85.143.112.90])
        by smtp.gmail.com with ESMTPSA id v25sm1011690ljc.92.2021.02.19.07.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 07:51:11 -0800 (PST)
From:   Nikolay Kyx <knv418@gmail.com>
To:     gregkh@linuxfoundation.org, adawesomeguy222@gmail.com,
        dinghao.liu@zju.edu.cn
Cc:     Nikolay Kyx <knv418@gmail.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: fwserial: match alignment with open parenthesis
Date:   Fri, 19 Feb 2021 18:49:17 +0300
Message-Id: <20210219154917.23388-1-knv418@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210219092918.GV2087@kadam>
References: <20210219092918.GV2087@kadam>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following checkpatch.pl check:

CHECK: Alignment should match open parenthesis

in file fwserial.c

Signed-off-by: Nikolay Kyx <knv418@gmail.com>
---

Additionally some style warnings remain valid here and could be fixed by
another patch.

v2: Edited changelog, as suggested by Greg KH <gregkh@linuxfoundation.org>

v3: Moved comment about remaining warnings under the cut-off line,
as suggested by Dan Carpenter <dan.carpenter@oracle.com> 

 drivers/staging/fwserial/fwserial.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fwserial/fwserial.c b/drivers/staging/fwserial/fwserial.c
index c368082aae1a..137e97c9406c 100644
--- a/drivers/staging/fwserial/fwserial.c
+++ b/drivers/staging/fwserial/fwserial.c
@@ -1318,8 +1318,8 @@ static int fwtty_break_ctl(struct tty_struct *tty, int state)
 	if (state == -1) {
 		set_bit(STOP_TX, &port->flags);
 		ret = wait_event_interruptible_timeout(port->wait_tx,
-					       !test_bit(IN_TX, &port->flags),
-					       10);
+						       !test_bit(IN_TX, &port->flags),
+						       10);
 		if (ret == 0 || ret == -ERESTARTSYS) {
 			clear_bit(STOP_TX, &port->flags);
 			fwtty_restart_tx(port);
-- 
2.30.1

