Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798D234EE61
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 18:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbhC3Qqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 12:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbhC3QpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:45:15 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646F3C061765
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:15 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so8784062wmj.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lKzeLqRR981m8Q6V7H7TUSXK4XL8F6YSqoxMJOt3/UM=;
        b=CZ8VOZicaTOYhbdTlCdlkirQwDA0C8iAR01FhKgjsn5f5EAnnxJGZQZdCklVBtschI
         P1kcbz0BNMUAp1VAqV9OTmJkz0JC7BmNMytlc3XZG5gTytEZC66al3/oehN4JoYUbGSr
         k7b+kF59TboFZdGiCO0ZbFLMHMrgxYL/lFX2xbQbFf9kUytTPCxJ9SzYidyUi/C+eFr4
         3dTCbjn0+K2WD5b7JOq96B2/fAIhvyi9uJnrWzjWQb+HEWuBWa2m8FYe72AfXjja2Pvu
         b222NaItAPNu/ai1OKi/Zz90fxeL+cEzRDheI6rty7Yv9TKprl4DNwWsMoY/YOU/tigx
         IF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lKzeLqRR981m8Q6V7H7TUSXK4XL8F6YSqoxMJOt3/UM=;
        b=k/IbUEBt06gACaRrrrNVZzr2X+GVGuG4/jYObcAAlNR1cwUJa0AVXCUdNNYxVtoPuC
         OeRh4FU3FbmiIlOdHX7VhC/E3jvFwQ8SORzEPBKSiH9BUH3eZ2+OemCjVzC7t/St9sy4
         ZxabxI5cv5i6nCjbI3TbVQKB4YTIMUyf2qz3E/jaT2X5nwDMGn+HjeSqPTK5lDLc7ZMY
         DSgNCuIwto8/dPFy6HO/B2clF6ao/TdKuK2VGrlB/FJSWIoI+P0ITqwsVfULyVWhTWnE
         qN8/o0KJ4YENAtU+Uy7wz1xEX/evewFiXEu0giAhh4MGsvp7RrzrPuUNYUPpz1dYkBTn
         LHWA==
X-Gm-Message-State: AOAM531UekJndznmAgUNjJheaCUWOHDxUj/i2MPPpAfqDBb8KIfBZDZL
        aHXYOa/A6L1XaU5n4S7OZPd2Uw==
X-Google-Smtp-Source: ABdhPJzYOfqHcp5iZeoFTTBh4RKohiuUthd/ehlMMRT478Fjj1e25yTDazs0OjWroVYX/5g/2GU5Vg==
X-Received: by 2002:a1c:c282:: with SMTP id s124mr4953590wmf.99.1617122714170;
        Tue, 30 Mar 2021 09:45:14 -0700 (PDT)
Received: from dell.default ([91.110.221.217])
        by smtp.gmail.com with ESMTPSA id a15sm25660805wrr.53.2021.03.30.09.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 09:45:13 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
Subject: [PATCH 13/31] fs: gfs2: quota: Fix incorrect param name in 'gfs2_quotad'
Date:   Tue, 30 Mar 2021 17:44:40 +0100
Message-Id: <20210330164458.1625478-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210330164458.1625478-1-lee.jones@linaro.org>
References: <20210330164458.1625478-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/gfs2/quota.c:1542: warning: Function parameter or member 'data' not described in 'gfs2_quotad'
 fs/gfs2/quota.c:1542: warning: Excess function parameter 'sdp' description in 'gfs2_quotad'

Cc: Bob Peterson <rpeterso@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: cluster-devel@redhat.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/gfs2/quota.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 6e173ae378c44..33520eed467c2 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -1534,7 +1534,7 @@ void gfs2_wake_up_statfs(struct gfs2_sbd *sdp) {
 
 /**
  * gfs2_quotad - Write cached quota changes into the quota file
- * @sdp: Pointer to GFS2 superblock
+ * @data: Pointer to GFS2 superblock
  *
  */
 
-- 
2.27.0

