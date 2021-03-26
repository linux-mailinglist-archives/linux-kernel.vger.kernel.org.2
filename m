Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96AC234A9DF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 15:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhCZOfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 10:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbhCZOfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 10:35:07 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D558AC0613BA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:35:04 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id o16so5920118wrn.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DBKiLgurMgloDH4dmthaQmSJlqRwCd+7wWZCtSqyx24=;
        b=bvITmmoWQkz/BAmA8clyA6v/M3+4LVQGjzfWYcjfQB8daWbjdZi/gq9mTkUXL2fw/W
         dW3SpncUQ97s56AZ3GH3+VJFN7bcHm/EADf3xINuOVau4zU3K8WwwIAD+g28RNoYrGN2
         AwYI4kqLEsWZ7rRn1m+Yd+TmBHbO4T0OOG2gWLu5SF/aLQwXLieq49mggUigXX7XRh9Y
         yBXuRgHE3KZnHY8QKTUQPz0FeWMzisZRBtF+nks1p3OoPj7yIgZ3kQIqNOIRyuGKAIWK
         p6qN1u9PEaJ9ZUoPhRKrzT3FFazBauvOgSMjB8fdSYkfyBoq3L6fdNBy+xo8zBMhRdB3
         +oqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DBKiLgurMgloDH4dmthaQmSJlqRwCd+7wWZCtSqyx24=;
        b=lcOrqvIJugy6Mfl4Kwhhq4KvJd6aQdQhUNjReO+Ij9GdIgudKrpU83EKFi+187RRhw
         ZuCjlEgJj1cSvuZDu6jOd+9Xz3VkoEHMNBDkV8J7UrM3wYwiYlwNQ39QZMsBbHdc0elI
         qDAYgMuoyUGLckPvg9Xitdypd4/rxd5H6S5elVEcHoUEL1ugKEU/d/W2oxJerD3XZUfj
         fSLD9BBWLuUZNpESLGCzp7nrrDKCLigiqEq3V+/uoYh3CNrpr6kSh1x+g6nuBzN75Ip5
         uVYpcC16p0CTbgpQaY2DKPEgnfyLEzvIDoCRuJU9BRPDcIFxJiNQLYT9+RGa+DGZqG22
         jKHA==
X-Gm-Message-State: AOAM531jtzeFv/6vj4Vam3sEGKgDVOwrvYaP8eV0+VP0uIWe2cun8Ecp
        zPU72IBpH2nDB+1fcWYLz4AIfQ==
X-Google-Smtp-Source: ABdhPJxwACsNiurDP1jau2TYaMay4rZXKsXCowrA5fXjZmBqZzO64ouadUb6/eu9bYXbgxk/H6PaiA==
X-Received: by 2002:adf:f4ce:: with SMTP id h14mr14682728wrp.257.1616769303585;
        Fri, 26 Mar 2021 07:35:03 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id j26sm12878225wrh.57.2021.03.26.07.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 07:35:03 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 01/25] HID: intel-ish-hid: Remove unused variable 'err'
Date:   Fri, 26 Mar 2021 14:34:34 +0000
Message-Id: <20210326143458.508959-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210326143458.508959-1-lee.jones@linaro.org>
References: <20210326143458.508959-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/hid/intel-ish-hid/ishtp/client.c: In function ‘ishtp_cl_disconnect’:
 drivers/hid/intel-ish-hid/ishtp/client.c:266:6: warning: variable ‘err’ set but not used [-Wunused-but-set-variable]

Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/intel-ish-hid/ishtp/client.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp/client.c b/drivers/hid/intel-ish-hid/ishtp/client.c
index 1cc157126fce7..c81a1f8a92685 100644
--- a/drivers/hid/intel-ish-hid/ishtp/client.c
+++ b/drivers/hid/intel-ish-hid/ishtp/client.c
@@ -263,7 +263,6 @@ EXPORT_SYMBOL(ishtp_cl_unlink);
 int ishtp_cl_disconnect(struct ishtp_cl *cl)
 {
 	struct ishtp_device *dev;
-	int err;
 
 	if (WARN_ON(!cl || !cl->dev))
 		return -ENODEV;
@@ -283,7 +282,7 @@ int ishtp_cl_disconnect(struct ishtp_cl *cl)
 		return -ENODEV;
 	}
 
-	err = wait_event_interruptible_timeout(cl->wait_ctrl_res,
+	wait_event_interruptible_timeout(cl->wait_ctrl_res,
 			(dev->dev_state != ISHTP_DEV_ENABLED ||
 			cl->state == ISHTP_CL_DISCONNECTED),
 			ishtp_secs_to_jiffies(ISHTP_CL_CONNECT_TIMEOUT));
-- 
2.27.0

