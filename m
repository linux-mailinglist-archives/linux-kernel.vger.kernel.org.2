Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24C0C32668F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 18:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhBZRyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 12:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhBZRxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 12:53:42 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31335C061797
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 09:52:21 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id f20so10477675ioo.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 09:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yytI7x7nMwQqYfkH8zJk8MWsbajZm7+7KB4c/JWojUI=;
        b=AFIgbIR9M1LUoj6H3z378i+R7QUdBO3CwFoWO44Dx08yOT0wGXel220fIR+hJZ9bC5
         qhTaPNWmINhWlJDPNGmD3tn2Dy+m2DB4wl7DnYLCKPjmGJBk4X+F7WdaV00KhPSZeVOW
         4OXK8iZYoHlSc9Z+QLSm0BfI+yujpjqT4QNJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yytI7x7nMwQqYfkH8zJk8MWsbajZm7+7KB4c/JWojUI=;
        b=XGy0QJPh1CGce8eYm3yzFMbCdMAgpKohhUuPUiBB0VhPwF4AIfI/wPBMIWj4z/sXBK
         Mbl0pclf9zeS7ts4VL4LPkThY2oL3fWTCUhzjYZxsMoy1rMCy+muzdjkU3BNiSNmgGSv
         gMxdoiJJaOlXgv5xjgXXNRr2Pi8NImUN3CA9gzvuJ7cV9rh1n1BrRStx/gqhw60G+Y1l
         Lu1Gtq1UoX37aHUsoBipWAAfDtX9iF4cXwK+4vdipRydErEr5a8VeiccNpokJ+vQRu/t
         Tg9zIV0ILAzJM3BcD3Mu12PxWhdfl5qcIHTgwv5UlNmannHgTjIWjU4kSjUvzH0bY0d0
         KxxA==
X-Gm-Message-State: AOAM5313lYJHkRnA3aW4eRGSqkJ4mNKqTmPFtY9kstaCIG61nSXKKmDk
        PWPzYNkOhyqNMLmrMdJijgwCJw==
X-Google-Smtp-Source: ABdhPJzDvP35cqoe+MlNhyNJMg/N0vt8re7YhfzdHlkeva41movmV4gDLh1tDN7Jsfz/AJTW9RmZeA==
X-Received: by 2002:a5e:8f0a:: with SMTP id c10mr3842450iok.192.1614361940631;
        Fri, 26 Feb 2021 09:52:20 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y25sm5594060ioa.5.2021.02.26.09.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 09:52:20 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] ath10k: detect conf_mutex held ath10k_drain_tx() calls
Date:   Fri, 26 Feb 2021 10:52:15 -0700
Message-Id: <38eef822d97917db50068eb65eb71ae3b83eb43e.1614355914.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1614355914.git.skhan@linuxfoundation.org>
References: <cover.1614355914.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ath10k_drain_tx() must not be called with conf_mutex held as workers can
use that also. Add call to lockdep_assert_not_held() on conf_mutex to
detect if conf_mutex is held by the caller.

The idea for this patch stemmed from coming across the comment block
above the ath10k_drain_tx() while reviewing the conf_mutex holds during
to debug the conf_mutex lock assert in ath10k_debug_fw_stats_request().

Adding detection to assert on conf_mutex hold will help detect incorrect
usages that could lead to locking problems when async worker routines try
to call this routine.

Link: https://lore.kernel.org/lkml/37a29c383bff2fb1605241ee6c7c9be3784fb3c6.1613171185.git.skhan@linuxfoundation.org/
Link: https://lore.kernel.org/linux-wireless/871rdmu9z9.fsf@codeaurora.org/
Acked-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/net/wireless/ath/ath10k/mac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 7d98250380ec..a595ff4f0843 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -4567,6 +4567,8 @@ static void ath10k_mac_op_wake_tx_queue(struct ieee80211_hw *hw,
 /* Must not be called with conf_mutex held as workers can use that also. */
 void ath10k_drain_tx(struct ath10k *ar)
 {
+	lockdep_assert_not_held(&ar->conf_mutex);
+
 	/* make sure rcu-protected mac80211 tx path itself is drained */
 	synchronize_net();
 
-- 
2.27.0

