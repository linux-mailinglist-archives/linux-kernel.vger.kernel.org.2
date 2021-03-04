Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A5332D8EB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 18:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239969AbhCDRrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 12:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239589AbhCDRqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 12:46:35 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1686DC0613E7
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 09:45:33 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id e23so8825067wmh.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 09:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fqoAgrq4fJR4HLR5WghEXfCAYNkU/FugUfR5Q3syhNI=;
        b=qlMH0cAiJPI42edwa7vSynVTvwlt7RzKWBRJnfYew+7ItSFTZGvO+GflZH1ioB75VE
         7KwH/80xPrc6XmRzh+f9o1EuaBrM6O74hIx/arXEb6VSZTJuDVYKhc95T54asR64a5mx
         KDZuxHPG9+0fobf971+p3EgR6WvX4G44xnZSTSWgLKu+3EwLbJWTyEzyk6MB8pK8txhR
         S1cuFiOdYZX8UOfdssdUyHI/IxVhFdtmYvrDbELV/FRQZFvt6BiuQHuLTkCcpjH0iv8c
         dHrvHnJKyp4gdkVHTkXa44MOzxze864WvQpo2+jdOciSJANxt6Hl+4jk40ZpX7O/SvJc
         XQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fqoAgrq4fJR4HLR5WghEXfCAYNkU/FugUfR5Q3syhNI=;
        b=KYDrmEWZUPCWRlEs1xhANUiWlootDFm0q9XmO/S3dWV5n9s9GVokimvMPrYhFxuoB2
         GBVdOP3FsM/OD78Ku0m1HZ1s2cq3F72U8WS5BAtA6bXfXyQbuvIO6fNr9AexloAHESWw
         zDadsoGKWB1XTO+NFtZJ4d3l/aeNeAaOuxv7d+zsw35qcm4Frg3UfUZpUgIZs/pJUgmI
         70N+mBNJjdiawi9H8XBST0DiLAP8vKr1mBsaRtGdP5OYTEUHWW1NocmPvwEU8nwaeaMS
         wxQzasYIsiXwD13QRZV6MQWzC9ds5bz9B7/vtH8SBFNoy2nVBcnI72V+JWGX49OGhZmp
         hr9g==
X-Gm-Message-State: AOAM530faM6JLGS1UXhaPubccbQoP/p5q8QY9+4AsUCzXlRxoELht1lz
        /XlE+wXd8Nz963tXauRkIR/W6g==
X-Google-Smtp-Source: ABdhPJzUjkxf4oTl38XpoTuIZ90ldSKeCXuYNmoMUkpEQWZP8didLAO2Ul56bAwAhDv2VYbyZkl84w==
X-Received: by 2002:a1c:7407:: with SMTP id p7mr5107660wmc.51.1614879931659;
        Thu, 04 Mar 2021 09:45:31 -0800 (PST)
Received: from localhost.localdomain ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id a21sm271023wmb.5.2021.03.04.09.45.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Mar 2021 09:45:31 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH BUGFIX/IMPROVEMENT V2 5/6] block, bfq: keep shared queues out of the waker mechanism
Date:   Thu,  4 Mar 2021 18:46:26 +0100
Message-Id: <20210304174627.161-6-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210304174627.161-1-paolo.valente@linaro.org>
References: <20210304174627.161-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shared queues are likely to receive I/O at a high rate. This may
deceptively let them be considered as wakers of other queues. But a
false waker will unjustly steal bandwidth to its supposedly woken
queue. So considering also shared queues in the waking mechanism may
cause more control troubles than throughput benefits. This commit
keeps shared queues out of the waker-detection mechanism.

Tested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 8497d0803d74..c62dbbe9cc33 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5852,7 +5852,17 @@ static void bfq_completed_request(struct bfq_queue *bfqq, struct bfq_data *bfqd)
 			1UL<<(BFQ_RATE_SHIFT - 10))
 		bfq_update_rate_reset(bfqd, NULL);
 	bfqd->last_completion = now_ns;
-	bfqd->last_completed_rq_bfqq = bfqq;
+	/*
+	 * Shared queues are likely to receive I/O at a high
+	 * rate. This may deceptively let them be considered as wakers
+	 * of other queues. But a false waker will unjustly steal
+	 * bandwidth to its supposedly woken queue. So considering
+	 * also shared queues in the waking mechanism may cause more
+	 * control troubles than throughput benefits. Then do not set
+	 * last_completed_rq_bfqq to bfqq if bfqq is a shared queue.
+	 */
+	if (!bfq_bfqq_coop(bfqq))
+		bfqd->last_completed_rq_bfqq = bfqq;
 
 	/*
 	 * If we are waiting to discover whether the request pattern
-- 
2.20.1

