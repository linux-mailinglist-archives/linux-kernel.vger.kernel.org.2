Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1573A6DDE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 19:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbhFNSBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 14:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbhFNSBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 14:01:11 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC95EC0617AF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 10:59:08 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id u18so11106816pfk.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 10:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h/QDeFjtMgi1HBYFO8EOevMSeBwA/eWvtJzREuD3r1E=;
        b=mqYEDk2UGTZrPw22kRYjzzFv5rQbTOVIMkM2bha4BgEHZxECOrBuBLVEGFqh9ti/ok
         /a89zN9cz9ZOd0A58TqBsJKd3oWHG/dDh01pnsiRjFvr4x9oFWIhY6aumI2jgzYXuAa9
         mnzHchD++sIUzAbYWdWqcRrr4XpZ2AsaLkND9cvnjza7CAxt5ddVmaRqDkBHDJ9k80Wo
         VNG4duh+D6x9JkAA31pomcE5H8SDkYN0Fr0dWoFRBTPNKnNA8L6oyGYExE1s8BZC9taU
         9Fywz1a+1SfPkg8P98x7HV/dywEAYVPtxaAuoAa6/48h9MLMPkVzF1lg2uxIp+UIvTIa
         kQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h/QDeFjtMgi1HBYFO8EOevMSeBwA/eWvtJzREuD3r1E=;
        b=pT+R3qCIFMUMyGtpQFSdgxKHHYXrAAci7nMusPfochkczWLye8eLEHp01AGKbNfCQk
         VSeiVgWHnjeirDD905+6UEeQU395osRqYlJ06zUlzEpPbcKrLzaBE0tQaAm1iVwTZ6Tw
         PBE29nvZU6amlkf4gZKS0vwH8fDYK9z2RnbIelQL0f/JQr4+oy09Na2mmv/44WQ1HwCd
         e0uHwwrHTW+keJm+hwICu7Tb3X9UXDAh4t7BbzBVaKAilghTbLqo2rH6cSCmQCDpmvQb
         CHFmKFl2GEClIaqp0Eulq1FX8S1g0fs730ck5jyU6qNjNt1McxXEDMtkfNq1l1xM42+N
         cCRA==
X-Gm-Message-State: AOAM5328X1CGHUQGbK3nKArMX1AaA3VsZTOZJ2fnd3JYb06xgOZBDy6k
        ClE9Aw0EygJOzrGXVgNsMBqJydPcxopm3Q==
X-Google-Smtp-Source: ABdhPJyGO9L0NLxP7Tba9wBBPk0rRxMxgZFZMszfku14D7tcg/6c4VDuU+F23107hhX3RzcmuE9PTA==
X-Received: by 2002:a62:8c55:0:b029:2ea:2165:503d with SMTP id m82-20020a628c550000b02902ea2165503dmr264679pfd.68.1623693548295;
        Mon, 14 Jun 2021 10:59:08 -0700 (PDT)
Received: from p14s.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id z17sm13553246pfq.218.2021.06.14.10.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 10:59:07 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] coresight: core: Remove unnecessary assignment
Date:   Mon, 14 Jun 2021 11:58:58 -0600
Message-Id: <20210614175901.532683-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210614175901.532683-1-mathieu.poirier@linaro.org>
References: <20210614175901.532683-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Junhao He <hejunhao2@hisilicon.com>

Remove unnecessary assignment of "path" in coresight_release_path().

Link: https://lore.kernel.org/r/1620912469-52222-3-git-send-email-liuqi115@huawei.com
Signed-off-by: Junhao He <hejunhao2@hisilicon.com>
Signed-off-by: Qi Liu <liuqi115@huawei.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 20ea4aa619f0..3cb8680c5828 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -886,7 +886,6 @@ void coresight_release_path(struct list_head *path)
 	}
 
 	kfree(path);
-	path = NULL;
 }
 
 /* return true if the device is a suitable type for a default sink */
-- 
2.25.1

