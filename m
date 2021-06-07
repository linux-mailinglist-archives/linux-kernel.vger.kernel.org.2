Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8AFA39DC62
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 14:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhFGMbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 08:31:10 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:62711 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhFGMbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 08:31:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623068958; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=nnMaHTNW7V6t61B/K4XmaWZEIIl32P8m6s5d/Jz9Kmk=; b=FDSFbe1N46NI6KAjMOfGgt5+5PIrraWDwqE1oyuTAmdSA1gwYIirGbFc+/1ESnGgGwbqin5H
 diBSu+nTQVemR3iNHPxqxdP3txdxX1oHbx+UpG/6FZ4AsGi/eL/aKU3QbPsGg5w3FVBipbUN
 XZYCOjqIFY0d3EE8hR1zFvUGwxY=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 60be11086ddc3305c4e2c85f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 07 Jun 2021 12:28:56
 GMT
Sender: linyyuan=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 89783C43217; Mon,  7 Jun 2021 12:28:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from localhost.localdomain (unknown [101.87.142.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: linyyuan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4B495C433D3;
        Mon,  7 Jun 2021 12:28:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4B495C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=linyyuan@codeaurora.org
From:   Linyu Yuan <linyyuan@codeaurora.org>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Linyu Yuan <linyyuan@codeaurora.com>
Subject: [PATCH][v2] usb: gadget: eem: fix wrong eem header operation
Date:   Mon,  7 Jun 2021 20:28:25 +0800
Message-Id: <20210607122825.3210-1-linyyuan@codeaurora.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linyu Yuan <linyyuan@codeaurora.com>

when skb_clone() or skb_copy_expand() fail,
it should pull skb with lengh indicated by header,
or not it will read network data and check it as header.

Signed-off-by: Linyu Yuan <linyyuan@codeaurora.com>
---
 drivers/usb/gadget/function/f_eem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_eem.c b/drivers/usb/gadget/function/f_eem.c
index cfcc4e81fb77..28dd5f1fd106 100644
--- a/drivers/usb/gadget/function/f_eem.c
+++ b/drivers/usb/gadget/function/f_eem.c
@@ -495,7 +495,7 @@ static int eem_unwrap(struct gether *port,
 			skb2 = skb_clone(skb, GFP_ATOMIC);
 			if (unlikely(!skb2)) {
 				DBG(cdev, "unable to unframe EEM packet\n");
-				continue;
+				goto next;
 			}
 			skb_trim(skb2, len - ETH_FCS_LEN);
 
@@ -505,7 +505,7 @@ static int eem_unwrap(struct gether *port,
 						GFP_ATOMIC);
 			if (unlikely(!skb3)) {
 				dev_kfree_skb_any(skb2);
-				continue;
+				goto next;
 			}
 			dev_kfree_skb_any(skb2);
 			skb_queue_tail(list, skb3);
-- 
2.25.1

