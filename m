Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8301364ADC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 21:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241914AbhDST6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 15:58:14 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:53286 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235788AbhDST6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 15:58:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618862263; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=AvrEgEbjYaBKxlur+JILsbveSoz50Kp16VLzJNNL5+I=; b=W0a/mf/NC8S62QJpQRhzhhtWtJjVc2MHC8vz9tJhatjFCEnNgT+/TgQ88BPzHRk5GPWmnoTf
 /qWLdvL5vX/NQrWJ95bZn5HZ9z+pPcaVS4XFPVeLby1Jt7cgNxPBdMxcV6N+ZmssfW3IaHTz
 jCNFRMK2vnt3tNS79CMb7cz5GVs=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 607de0a5853c0a2c46058af6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 19 Apr 2021 19:57:25
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 860F1C433F1; Mon, 19 Apr 2021 19:57:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from wcheng-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 77B6BC433D3;
        Mon, 19 Apr 2021 19:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 77B6BC433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wcheng@codeaurora.org
From:   Wesley Cheng <wcheng@codeaurora.org>
To:     balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        jackp@codeaurora.org, Hemant Kumar <hemantk@codeaurora.org>,
        Wesley Cheng <wcheng@codeaurora.org>
Subject: [PATCH] usb: gadget: Fix double free of device descriptor pointers
Date:   Mon, 19 Apr 2021 12:57:20 -0700
Message-Id: <1618862240-5965-1-git-send-email-wcheng@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hemant Kumar <hemantk@codeaurora.org>

Upon driver unbind usb_free_all_descriptors() function frees all
speed descriptor pointers without setting them to NULL. In case
gadget speed changes (i.e from super speed plus to super speed)
after driver unbind only upto super speed descriptor pointers get
populated. Super speed plus desc still holds the stale (already
freed) pointer. Fix this issue by setting all descriptor pointers
to NULL after freeing them in usb_free_all_descriptors().

Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
---
 drivers/usb/gadget/config.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/gadget/config.c b/drivers/usb/gadget/config.c
index 2d11535..8bb2577 100644
--- a/drivers/usb/gadget/config.c
+++ b/drivers/usb/gadget/config.c
@@ -194,9 +194,13 @@ EXPORT_SYMBOL_GPL(usb_assign_descriptors);
 void usb_free_all_descriptors(struct usb_function *f)
 {
 	usb_free_descriptors(f->fs_descriptors);
+	f->fs_descriptors = NULL;
 	usb_free_descriptors(f->hs_descriptors);
+	f->hs_descriptors = NULL;
 	usb_free_descriptors(f->ss_descriptors);
+	f->ss_descriptors = NULL;
 	usb_free_descriptors(f->ssp_descriptors);
+	f->ssp_descriptors = NULL;
 }
 EXPORT_SYMBOL_GPL(usb_free_all_descriptors);
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

