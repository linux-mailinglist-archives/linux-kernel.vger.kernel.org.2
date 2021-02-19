Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854A531FB2F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 15:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbhBSOq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 09:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhBSOqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 09:46:52 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEA8C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 06:46:11 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id g20so3495091plo.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 06:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=slTXshU8vidGGVMSxD6AxHpQCaGZpeJQ08PMj6GSx14=;
        b=mOadbSwJ+lN9/8jOAuB+LIN+eQWxBpaU2nHGShDsNkBu2OSL8S3R+PzRAqWtxF/AyT
         MoZBbqj4PNdvabwxpbOinc8JfA6nKUqhMIZsz+x4ddILZLMsvl+giO01S5Y4tnL6ZKqc
         TDFhNs0uCazV1NrTKzk6q8TXXhGnfLtXzf/R1JxM/eDcceLtxhmInB2xavxQA7ihcMN/
         M8EW+PUuCgD3Zi9tnpVZfEqajheLedQjk9P4m3jHuhDmoeT1CmY+lechFOw+2K6zyTeu
         AKcKeVUEES2U/eS29EdHRxj/FNDu+X0Wae+KR1HXCMTFTCwaTFu95fQoh6M+MuIRN8m0
         Pe1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=slTXshU8vidGGVMSxD6AxHpQCaGZpeJQ08PMj6GSx14=;
        b=WDXPVPPNRp75SF4/ACvx4VbGQQgDvMM0DDuPwJNhP21LRSc0vqK5nYHmqJijKsgHok
         84pBXtTK3Come9HDtxFmffhYnP5wH5QtrB69d0OzOVUYv9SGnSUWRAt91Gqxh9grjqTl
         MzEJtyCNFSLsXfdaEedrO3roT7WYLFmOpwaHQeMCPci3opFZd1eV7MGDyLJIgbOELm7Z
         eym5cQA8WWPe13jJUYbvGmiQFPq0TT1J8LjYF0Rrbw5hzBtTcV8n9/7696Rv2lTNCh74
         dcme+6dM+lwMpLyVDau7NHP1SMGNAc9Fq1+B24m4QoLTsDTLD2V1wi37bOcNzJI5QBbI
         MGqQ==
X-Gm-Message-State: AOAM531bfGmzUhN0kVq9TvlZfHPmEJ1gYcZR0UvCWJs1b+NFOxXwZ5vR
        8GcrT8TqtTPxEzxy9vJ/iLk=
X-Google-Smtp-Source: ABdhPJyqHMbC6dTR+BB6SR6heG0MwTmAa5lseJ80Z8WddGX3n6NsiVuKO/5qiPoAnmthmOTWLND8Pw==
X-Received: by 2002:a17:90a:2a4e:: with SMTP id d14mr9797342pjg.36.1613745971421;
        Fri, 19 Feb 2021 06:46:11 -0800 (PST)
Received: from localhost.localdomain ([49.36.144.93])
        by smtp.gmail.com with ESMTPSA id k13sm10457329pfg.146.2021.02.19.06.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 06:46:10 -0800 (PST)
From:   Amrit Khera <amritkhera98@gmail.com>
To:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org
Cc:     greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Amrit Khera <amritkhera98@gmail.com>
Subject: [PATCH] staging: greybus: Fix blank line style issue in sdio.c
Date:   Fri, 19 Feb 2021 20:12:31 +0530
Message-Id: <20210219144230.32055-1-amritkhera98@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change fixes a checkpatch check for "Please don't use
multiple blank lines".

Signed-off-by: Amrit Khera <amritkhera98@gmail.com>
---
 drivers/staging/greybus/sdio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/greybus/sdio.c b/drivers/staging/greybus/sdio.c
index 0939f4a4c963..37bf04c22dbc 100644
--- a/drivers/staging/greybus/sdio.c
+++ b/drivers/staging/greybus/sdio.c
@@ -33,7 +33,6 @@ struct gb_sdio_host {
 	bool			read_only;
 };
 
-
 #define GB_SDIO_RSP_R1_R5_R6_R7	(GB_SDIO_RSP_PRESENT | GB_SDIO_RSP_CRC | \
 				 GB_SDIO_RSP_OPCODE)
 #define GB_SDIO_RSP_R3_R4	(GB_SDIO_RSP_PRESENT)
-- 
2.20.1

