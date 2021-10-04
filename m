Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D042F42182A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 22:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235648AbhJDUIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 16:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbhJDUId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 16:08:33 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEC0C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 13:06:44 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id t17-20020a4ac891000000b002b612d6d5e9so5050219ooq.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 13:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=66dX0OvQYrrj3UairmmHI6a5MNBzAVnr6VxC1SQ5QfI=;
        b=hvEooSDKadJeMyTNjVqfQodNlOhWjjHiswUVR7NbCKMyO19iSeUcZbOHrUjmjbK3oO
         1ta52VaFo6NnyhIASZDZhNfGySCPzL0Z2TroxcJUGKcl6tYDFENjGp+7scdQ8w0fFm45
         Db+FFa9sDxTUCKuZi8fy0A2eGPOz9a8RrepwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=66dX0OvQYrrj3UairmmHI6a5MNBzAVnr6VxC1SQ5QfI=;
        b=hnO3ypaRCwfAMwZjwxrBD0VWCxF2YMWhtPf+EL/V1GaGUDp06dIaVcYmSz9LFzDu7s
         8XsIChPafCbYHuddBU7/GCsmhaRcDP0U+BTDSJ1JgTXwn8kWz3ZF15j62x6SzaT8H3fD
         0FDZGImNC2SStXcDQbHLRsJ1lqtfujHESasaJPBodRm26GQZuskBaAh77fDIf/8wHP/x
         2o2DhRKMIV4EDbQODJTJ0TCB6wQRu5L19R4XgQaTFPZarLiCETnnhjCl/G9lkwToJ4ap
         AD+Z2q8EVTYB/rKLa7h1FopUcXldXvjkEA28CdBpsaCJdTjZGfTj1N4HPhrelFyX9/7J
         fxuw==
X-Gm-Message-State: AOAM5302D3KDgdpsCiUwcIChH3QNNev9X0XT8rw5mWj40lDjfVZwLWcr
        rPQPfJp0VzecwOIpU5gpQMp/zQ==
X-Google-Smtp-Source: ABdhPJx2saE+pGtwu/Iro6kkqVG924H8S/kYPTHwf52PCKYl3E66oJ+Kn3xmvP+nZXyiDYjnVM38sA==
X-Received: by 2002:a4a:7059:: with SMTP id b25mr10598983oof.54.1633378003899;
        Mon, 04 Oct 2021 13:06:43 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id e12sm3123842otq.4.2021.10.04.13.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 13:06:43 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     agk@redhat.com, snitzer@redhat.com
Cc:     Shuah Khan <skhan@linuxfoundation.org>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dm: change dm_get_target_type() to check for module load error
Date:   Mon,  4 Oct 2021 14:06:41 -0600
Message-Id: <20211004200641.378496-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dm_get_target_type() doesn't check error return from request_module().
Change to check for error and return NULL instead of trying to get
target type again which would fail.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/md/dm-target.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-target.c b/drivers/md/dm-target.c
index 64dd0b34fcf4..0789e9f91d3a 100644
--- a/drivers/md/dm-target.c
+++ b/drivers/md/dm-target.c
@@ -41,17 +41,22 @@ static struct target_type *get_target_type(const char *name)
 	return tt;
 }
 
-static void load_module(const char *name)
+static int load_module(const char *name)
 {
-	request_module("dm-%s", name);
+	return request_module("dm-%s", name);
 }
 
 struct target_type *dm_get_target_type(const char *name)
 {
 	struct target_type *tt = get_target_type(name);
+	int ret;
 
 	if (!tt) {
-		load_module(name);
+		ret = load_module(name);
+		if (ret < 0) {
+			pr_err("Module %s load failed %d\n", name, ret);
+			return NULL;
+		}
 		tt = get_target_type(name);
 	}
 
-- 
2.30.2

