Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C6534795E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 14:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbhCXNQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 09:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234741AbhCXNPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 09:15:37 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9431C0613E6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 06:15:36 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id d2so21305113ilm.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 06:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FQFA2QStDKmo1XhVZ4KOEMpN+hi3li+F67WfkjwPMWs=;
        b=WeDb3w8CTitNL7fiuwx+cOti4cQKBLcjExxqeMWo37GnH6C6+LRup+izK3itSPaCJb
         A5anL4t6Ar5H7xQe7JJ3UC4nvW9CR2nVc6TBklSLUY4skzJO+/+vSM9/KBdKH6uh4eQX
         1wkSfJVsyVbwbe1UpQT4pCWIEkUNF/eW4+vSMVQ7cGDoArCop7lzkLv1y/pQ3/AF7AeU
         JPFYKXclr0SuCOnz1u4CiZpXoOH3oRrrMHaGZdpE/m4TMHUvJ8mvY70d5GlWRivr7wqA
         O/cAB5//lqMxT5ZqGHd/9VW1R8jBtI33CpRPWvaoupgYZvHrrcc7RGYB8KdfzkIrzTra
         rKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FQFA2QStDKmo1XhVZ4KOEMpN+hi3li+F67WfkjwPMWs=;
        b=jvadRJsC0+1DSX2nApIQ+LLs5FSh7I89sL1D2bsZlYEGJ7xm++1Hbm/D9c9qqsv55E
         fsvAX2n9uULlF8wydIBtIG7vgtKnJLQOTX3J5oxKj4Mu25p4Ef8CqpRG89uYJQqssadM
         JhaPTFLl7QpXxJQja4EabnuF5BSkhuWoTBBR08DZeKABuu5waqCyTXOVxrS6fVqYXBBy
         bttPzLCMSiNBG3SoGOOcQ5VSLri3DXS+ovTL5kNDDcS3Up4FCErmNY8wx249UD3hJGfd
         WbXAYxrzw8BvfUq2lw1nkhC7JQmAQhc9r8WW1Qomgr2WTN0AHFLejNvu1BhgIeVInZu/
         36CA==
X-Gm-Message-State: AOAM531x+Phti5Yn6UPgvxk1SmoA3irVj32JuEQi00UBQP03fqnuO3dU
        WmCDY8k7IGnlliwiPuAlAbzR9Q==
X-Google-Smtp-Source: ABdhPJxgqUoXVAUq3XhOK9/xiuwRElTHsbJ8mq0GmNX+XUfXi2axSbQ5PPrxXNjQyq0a1hn/+Ri1vQ==
X-Received: by 2002:a92:b011:: with SMTP id x17mr2598180ilh.113.1616591736340;
        Wed, 24 Mar 2021 06:15:36 -0700 (PDT)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id n7sm1160486ile.12.2021.03.24.06.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 06:15:35 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 6/6] net: ipa: increase channels and events
Date:   Wed, 24 Mar 2021 08:15:28 -0500
Message-Id: <20210324131528.2369348-7-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210324131528.2369348-1-elder@linaro.org>
References: <20210324131528.2369348-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increase the maximum number of channels and event rings supported by
the driver, to allow the maximum available on the SDX55.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ipa/gsi.h b/drivers/net/ipa/gsi.h
index efc980f96109e..d5996bdb20ef5 100644
--- a/drivers/net/ipa/gsi.h
+++ b/drivers/net/ipa/gsi.h
@@ -16,8 +16,8 @@
 #include "ipa_version.h"
 
 /* Maximum number of channels and event rings supported by the driver */
-#define GSI_CHANNEL_COUNT_MAX	17
-#define GSI_EVT_RING_COUNT_MAX	13
+#define GSI_CHANNEL_COUNT_MAX	23
+#define GSI_EVT_RING_COUNT_MAX	20
 
 /* Maximum TLV FIFO size for a channel; 64 here is arbitrary (and high) */
 #define GSI_TLV_MAX		64
-- 
2.27.0

