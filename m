Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B60AD3EA912
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 19:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbhHLRDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 13:03:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52553 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234406AbhHLRDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 13:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628787793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=J954MLxa9gOHhPQ2vkkolUzmWyf9ox971ksqXH7Ids8=;
        b=flYSy+vZpHJIKc5BGvA4c6SZ0OXz61aZbKEpHxBBSSr8yTgH9ipR5Zhd/FOrNEl9W4TFj3
        YnYmxef2tGi5LjiqqYdmEaDW8IpGl5jsizh281CpqxWgZFJjq6vfv1lGcuw1EU0B1eZCY6
        cgue2HiGWQeCkQ+MEDrNMB/Ji6VqQPM=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-Ei50YrMlPeOgx49qroIpIA-1; Thu, 12 Aug 2021 13:03:10 -0400
X-MC-Unique: Ei50YrMlPeOgx49qroIpIA-1
Received: by mail-oi1-f197.google.com with SMTP id u34-20020a0568081522b02902681e945a49so1048701oiw.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 10:03:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J954MLxa9gOHhPQ2vkkolUzmWyf9ox971ksqXH7Ids8=;
        b=aZtdaOkwHlNPxHbQmF0jCn2HoDtIdEkD+QzKmMrrb3iv8/XgkHDgyzIFIMIc8tkfe1
         6Rq/pBFFt54sh+/PriJqTCqGyDLlFG0rwX1iDaSkdVu1fBqCzwhLFPKRXP+mH1vwwPqX
         sKF02b2EF6NdJ/EGdmDtkU2aXJxvF7XnctArhuW4B0v8Wnvaf0nJAsry5Vz9sqWEquPO
         pk08hdbQbvSd1pEoBEuB8TxwycFBuLA68E3xu39legcV1yxdvHtiOxghm7sEecWK4e59
         m27fF/Lq/dOdz/+NJZOS/Dk5W/qFhDdC87IhbIhevZ68cXFRoPfrapjFKf+KrfdsZEN+
         EY5g==
X-Gm-Message-State: AOAM533rd4/xJHOhhTrXAcJvH3Pu69/P1ngtRR04YjX2OAKGH3MAiHdM
        J+Vaia5RzrWKCPMCDWU5msiBWXjbKAOjwQPEcg6dwmatLkj4OqkXDrWCv/wb0ItxVzhjCzt9DqZ
        cQA1CRhm37bf2X8KN4DACzS0g
X-Received: by 2002:a05:6830:11d4:: with SMTP id v20mr4113236otq.358.1628787789318;
        Thu, 12 Aug 2021 10:03:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykzvJTl7IgT9ugEjGH3GRxKniSCfzdb1tXmDjHVTSGHXjRu3xi7zcEhXGhRmIzmuNwDKlWyw==
X-Received: by 2002:a05:6830:11d4:: with SMTP id v20mr4113216otq.358.1628787789169;
        Thu, 12 Aug 2021 10:03:09 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id g20sm733386otj.9.2021.08.12.10.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 10:03:08 -0700 (PDT)
From:   trix@redhat.com
To:     aspriel@gmail.com, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, chi-hsien.lin@infineon.com,
        wright.feng@infineon.com, chung-hsien.hsu@infineon.com,
        kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org,
        zhengyongjun3@huawei.com, linus.walleij@linaro.org,
        lee.jones@linaro.org
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] brcmfmac: Fix fallback logic to use firmware's canonical path
Date:   Thu, 12 Aug 2021 10:03:00 -0700
Message-Id: <20210812170300.1047330-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Static analysis reports this problem
firmware.c:709:6: warning: Branch condition evaluates to a garbage value
        if (ret) {
            ^~~

In brcmf_fw_get_firmwares(), ret is only set if the alt_path control
flow is taken.  Initialize ret to -1, so the canonical path is taken
if alt_path is not.

Fixes: 5ff013914c62 ("brcmfmac: firmware: Allow per-board firmware binaries")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
index adfdfc654b104..e11f1a3a38a59 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
@@ -680,7 +680,7 @@ int brcmf_fw_get_firmwares(struct device *dev, struct brcmf_fw_request *req,
 	struct brcmf_fw_item *first = &req->items[0];
 	struct brcmf_fw *fwctx;
 	char *alt_path;
-	int ret;
+	int ret = -1;
 
 	brcmf_dbg(TRACE, "enter: dev=%s\n", dev_name(dev));
 	if (!fw_cb)
-- 
2.26.3

