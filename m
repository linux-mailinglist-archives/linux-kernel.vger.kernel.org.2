Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF063B02E8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 13:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhFVLlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 07:41:15 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:41672 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbhFVLlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 07:41:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624361934; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=ubuPrRb9yffwTL9uV+gjxvmLIZ/Hu8Q8LBMrZ1O4/DY=; b=ie+WBK1bMQfUpHukn/geTkcOW96TshvyjwDKuE0sci6RgZwKf/D8/MROcIpLBa/OY08aU+2i
 FnSbB+kwoiDJpMu338vmtxAL6DMP320AWg7yV7vz7/afg6GoWBgEpoSmUf4mdYzjHbnDO1x6
 dfoeiBTv9oyLOFi4JtzvkpMaXxk=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 60d1cb9c120032024186727c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 22 Jun 2021 11:38:04
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9573DC433D3; Tue, 22 Jun 2021 11:38:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from localhost (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1E309C433F1;
        Tue, 22 Jun 2021 11:38:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1E309C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=neeraju@codeaurora.org
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>
Subject: [PATCH] vringh: Use wiov->used to check for read/write desc order
Date:   Tue, 22 Jun 2021 17:07:53 +0530
Message-Id: <1624361873-6097-1-git-send-email-neeraju@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As iov->used is incremented when descriptors are processed
in __vringh_iov(), use it to check for incorrect read
and write descriptor order.

Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
---
 drivers/vhost/vringh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 4af8fa2..14e2043 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -359,7 +359,7 @@ __vringh_iov(struct vringh *vrh, u16 i,
 			iov = wiov;
 		else {
 			iov = riov;
-			if (unlikely(wiov && wiov->i)) {
+			if (unlikely(wiov && wiov->used)) {
 				vringh_bad("Readable desc %p after writable",
 					   &descs[i]);
 				err = -EINVAL;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
hosted by The Linux Foundation

