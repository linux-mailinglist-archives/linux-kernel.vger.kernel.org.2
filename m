Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068084308A2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 14:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242183AbhJQM31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 08:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236317AbhJQM30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 08:29:26 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FFEC061765
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 05:27:16 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id e12so35802362wra.4
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 05:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=caezwCrYl8J1Db0QePppJD41dRvS6Lu7c4xekHw9rc4=;
        b=ogmUBzFMtrtluJm3LUTqmaT3xo5LmNaCfiKBDJfpkOna8f++9MsCVdJN50yligWLWW
         hEm3iq2vrBpiP2gERFUx9lJh/6lpuevO2zC29sADMUWrP0nWnEZiSAB5L1TXZrh3Uds0
         XWc4TkTPNc5LXYW7N4biGbzW1GdjvskA9F7tc4JE3PBLM+knEMGA232U23+XehALgJnx
         midr0kGTqtt4mVvi0WbsXIxdQ+dFlFX8Sos/HWGjyh2Zc10DHjYNS+ZgRNf5SnlxBbDH
         En5nPcptw02TFAlnGI/8JrcX5hWlzPcm/UFp4Z9F9DbLCzDdPgFvPxD/ZnJ3YeawQ5VS
         3jzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=caezwCrYl8J1Db0QePppJD41dRvS6Lu7c4xekHw9rc4=;
        b=vDWzPa+Mj0oNm9oqtJ5E8OmARG23DDtJgH/XrcZRCm2D9kKPnPpVyds4714pPEqZDV
         nDXeNqW324AwQ5QLEAxOX9OpokbZA35gK/91J6QukXDns+zKeVFAttdSATcuGHjG3qsU
         mH3jsc6cjHvracbZpflZC0FOfpR5QNXMhBt7BLfdeq0VCX0rv8776SvrnJSoyxXDMtNP
         GfmEQ/uutRnxQIl3wzTTgL+A6dhHfyXIWN6Eg90RDYNT9e1RyOUdvxrtqMGIEqNpYEZf
         qsDQlr2OCKgwLdfJxlN0FKNn51gXn6SCYBgmK5QkT0bL0op51sn2eZswn8b8Yhg7WHza
         LYpA==
X-Gm-Message-State: AOAM531Z71YSwI4tHEdWXbNt7IjN3ngH2o8Hy82LwmuvLUBrJQk6Jcf6
        CYnM3ydHPMLuNtR23/67WNIZlAWlB4i4jNfs
X-Google-Smtp-Source: ABdhPJzvGs5Kt+CDR6iUtIq0Pynnn7nw1r8K/anNW4nGI6k1FzSzZBcNGXx9uPVf0gRWbUHvA5OC8Q==
X-Received: by 2002:adf:aad7:: with SMTP id i23mr27699723wrc.209.1634473634405;
        Sun, 17 Oct 2021 05:27:14 -0700 (PDT)
Received: from Mononoke (56.red-88-27-247.staticip.rima-tde.net. [88.27.247.56])
        by smtp.gmail.com with ESMTPSA id o12sm9713965wrv.78.2021.10.17.05.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 05:27:13 -0700 (PDT)
Date:   Sun, 17 Oct 2021 14:27:12 +0200
From:   Sebastian Luchetti <luchetti.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rts5208: ms.c: Remove two udelay calls and use
 usleep_range instead
Message-ID: <YWwWoB3+4HQTD4/t@Mononoke>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the issue:
CHECK: usleep_range is preferred over udelay; see
Documentation/timers/timers-howto.txt
in two occurrences.

Signed-off-by: Sebastian Luchetti <luchetti.linux@gmail.com>
---
 drivers/staging/rts5208/ms.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rts5208/ms.c b/drivers/staging/rts5208/ms.c
index 2a6fab5c117a..7292c8f013fd 100644
--- a/drivers/staging/rts5208/ms.c
+++ b/drivers/staging/rts5208/ms.c
@@ -3236,7 +3236,7 @@ static int ms_write_multiple_pages(struct rtsx_chip *chip, u16 old_blk,
 			return STATUS_FAIL;
 		}
 
-		udelay(30);
+		usleep_range(27, 32);
 
 		rtsx_init_cmd(chip);
 
@@ -4158,7 +4158,7 @@ int mg_set_ICV(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 #ifdef MG_SET_ICV_SLOW
 	for (i = 0; i < 2; i++) {
-		udelay(50);
+		usleep_range(47, 52);
 
 		rtsx_init_cmd(chip);
 
-- 
2.30.2

