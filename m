Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79ADE31A85B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 00:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbhBLXa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 18:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbhBLXaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 18:30:14 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2B4C06178C
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 15:28:51 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id f20so887350ioo.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 15:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8w8XQdxn9R0vTUUYKwbH7//7X6JrjWFRUImHZ2qHCEA=;
        b=MsK4Yp5tiWM/fulpatrxLLYBqeCGXaamHRMCb6oq63sXWcNUVVP2iuH/EpRTU/P71N
         U5wVLxv4rRqyBLWYgo0h0gt5H8QyMeMDAyvdeKpgYBwlKGWxkRM7vtC8dzVJXzNqIv/F
         go9UPLuCyA4cdM5ZZwhtXWdBYV1CGlDpw4UV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8w8XQdxn9R0vTUUYKwbH7//7X6JrjWFRUImHZ2qHCEA=;
        b=faivqcU6VQ76S9k7o1mmmFZ0zMuBjwP5y5POLgAxecdBUXxrcW14V4PRyNTFah6NLh
         iC5EHBiCcNUW9G0BwTFQyecxB93EaZYMXFJThyPigP55qokrQ8+WdfYj4dvBUsTDXP8Y
         yIWGunOCUiu/mt1Fj34o9HTP9y8fpSLycmVXupZLXe6UuifLB64KS354MJRMpMn+2poJ
         pmS+FCXfOoyVdJcnWHza7oQCcKb6q6XSocN54zwA/ZZn/IqCxxOsMFjy0haQUga3cpMJ
         yYlm5jcqMXPIMNdhO6YtkcudaqJuoq37IFMV83OZ4GfaB7W7NA0eMJg+eSjx30DEC6Cm
         KTjw==
X-Gm-Message-State: AOAM532U37BJH4NVlOmB15UWuKodnuR4IGKhvjmQZ0uSDTFJOFUaR6Ud
        v6stBVKzfdAlX01vrb5GfeP7MQ==
X-Google-Smtp-Source: ABdhPJyflu0RNWiIV3nbQa149G0hby7tBp9QoVfXWvAf6vhrbVm0ZDp9jsGcpqvP08a3LAahnffRrg==
X-Received: by 2002:a05:6638:3c6:: with SMTP id r6mr4761929jaq.115.1613172530821;
        Fri, 12 Feb 2021 15:28:50 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i20sm5180328ilc.2.2021.02.12.15.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 15:28:50 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ath10k: detect conf_mutex held ath10k_drain_tx() calls
Date:   Fri, 12 Feb 2021 16:28:43 -0700
Message-Id: <0686097db95ae32ce6805e5163798d912b394f37.1613171185.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1613171185.git.skhan@linuxfoundation.org>
References: <cover.1613171185.git.skhan@linuxfoundation.org>
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

Link: https://lore.kernel.org/linux-wireless/871rdmu9z9.fsf@codeaurora.org/
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/net/wireless/ath/ath10k/mac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index c202b167d8c6..7de05b679ad2 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -4728,6 +4728,8 @@ static void ath10k_mac_op_wake_tx_queue(struct ieee80211_hw *hw,
 /* Must not be called with conf_mutex held as workers can use that also. */
 void ath10k_drain_tx(struct ath10k *ar)
 {
+	lockdep_assert_not_held(&ar->conf_mutex);
+
 	/* make sure rcu-protected mac80211 tx path itself is drained */
 	synchronize_net();
 
-- 
2.27.0

