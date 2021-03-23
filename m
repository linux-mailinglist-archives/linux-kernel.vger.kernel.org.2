Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5F734597E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 09:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhCWIQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 04:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbhCWIQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 04:16:17 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341BFC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 01:16:16 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id bf3so22419078edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 01:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Mwg0fvxCZ6L8/n+TBQfYlrjlN45t3QL8W8OHl2T3fU=;
        b=XC+XohxwEQ4EC3iLfL4F72T66y6rkpnGP9Zx/3l5fRV3TA7xIp0/2hzUeFXzGeIbhC
         Y0uw/VyzDMSXyWIyNEQW/IYmv6Vns7hDiX0r5gb6Q+M/8CBNZPKjkNQRNt9OF+BYTmoX
         IIZSCOW8FQFRx8OnWhHiNLhkN9N+3ZejoG4n4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Mwg0fvxCZ6L8/n+TBQfYlrjlN45t3QL8W8OHl2T3fU=;
        b=c+bQgVHLtljeQ+o9NB8gCWafxnwv1FII8Z9z4sJ7aDWO2DaiFa2+TlyTpnFqilcMdg
         g8YlbDxi3Lq/IQLIFUWGxdygHKP/zASZ1Pd7pbZT23Q4Zw1cuYvXUA7u0lJ1O8bYLDxW
         oPyHumSacEAtg13s/8SaspuM7rkN7Y9F9a/Ds2lv97MyTGviWPTbtDLfapjsMNf7FGGw
         I7npOdecsk3TxoypymVmTh1d86dsUckw4jTY16b14bxdCYbvYLrVWApLj4lahJns/WwJ
         ZEXsQ7wAWjG4nJ774gyHPCmEL+8urjCgKzpDjsoMPOieYNd3l7ZvVAFH6gE4enQAReHs
         PtOw==
X-Gm-Message-State: AOAM530GIk31RW42ngIaFc91koqMK2EYgO/7oxGG81vACMS89pjlZ6cC
        iMqTxFvDarXFmWeYBZdANzT9fEqxqm9wVQ==
X-Google-Smtp-Source: ABdhPJzj4nukCw/m5UDChgKepwKDsXuAgrKBXHbwX1GD8mOge80QaubQJr+/QjNUMcvZjZ2QRUvqTQ==
X-Received: by 2002:a50:e80c:: with SMTP id e12mr3421590edn.229.1616487374899;
        Tue, 23 Mar 2021 01:16:14 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id g11sm12523356edt.35.2021.03.23.01.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 01:16:14 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Chen Gang <gang.chen@asianux.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: gadget: legacy: remove left-over __ref annotations
Date:   Tue, 23 Mar 2021 09:16:07 +0100
Message-Id: <20210323081607.405904-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These were added in commit 780cc0f370 ("usb: gadget: add '__ref' for
rndis_config_register() and cdc_config_register()") to silence
modpost, but they didn't fix the real problem - that was fixed later
by removing wrong __init annotations in commit c94e289f195e ("usb:
gadget: remove incorrect __init/__exit annotations").

It really never makes sense for a function to be marked __ref unless
it (1) has some conditional that chooses whether to call an __init
function (or access __initdata) or not and (2) has a comment
explaining why the __ref is there and why it is safe.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/usb/gadget/legacy/multi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/legacy/multi.c b/drivers/usb/gadget/legacy/multi.c
index ec9749845660..f6d0782e6fc3 100644
--- a/drivers/usb/gadget/legacy/multi.c
+++ b/drivers/usb/gadget/legacy/multi.c
@@ -182,7 +182,7 @@ static int rndis_do_config(struct usb_configuration *c)
 	return ret;
 }
 
-static __ref int rndis_config_register(struct usb_composite_dev *cdev)
+static int rndis_config_register(struct usb_composite_dev *cdev)
 {
 	static struct usb_configuration config = {
 		.bConfigurationValue	= MULTI_RNDIS_CONFIG_NUM,
@@ -197,7 +197,7 @@ static __ref int rndis_config_register(struct usb_composite_dev *cdev)
 
 #else
 
-static __ref int rndis_config_register(struct usb_composite_dev *cdev)
+static int rndis_config_register(struct usb_composite_dev *cdev)
 {
 	return 0;
 }
@@ -265,7 +265,7 @@ static int cdc_do_config(struct usb_configuration *c)
 	return ret;
 }
 
-static __ref int cdc_config_register(struct usb_composite_dev *cdev)
+static int cdc_config_register(struct usb_composite_dev *cdev)
 {
 	static struct usb_configuration config = {
 		.bConfigurationValue	= MULTI_CDC_CONFIG_NUM,
@@ -280,7 +280,7 @@ static __ref int cdc_config_register(struct usb_composite_dev *cdev)
 
 #else
 
-static __ref int cdc_config_register(struct usb_composite_dev *cdev)
+static int cdc_config_register(struct usb_composite_dev *cdev)
 {
 	return 0;
 }
@@ -291,7 +291,7 @@ static __ref int cdc_config_register(struct usb_composite_dev *cdev)
 
 /****************************** Gadget Bind ******************************/
 
-static int __ref multi_bind(struct usb_composite_dev *cdev)
+static int multi_bind(struct usb_composite_dev *cdev)
 {
 	struct usb_gadget *gadget = cdev->gadget;
 #ifdef CONFIG_USB_G_MULTI_CDC
-- 
2.29.2

