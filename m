Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5CE435DF3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 11:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbhJUJak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 05:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbhJUJaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 05:30:35 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FC8C06161C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 02:28:19 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id g141so340797wmg.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 02:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dbqiLL8aUgPksDHzHaUghNX/IFV5YGYn2GKMzSbGgXE=;
        b=FBVF3ZPIVUk9qKdxRPmrXVIhsOvmuadNOKFlxnp6cDew1DInimJnkB0oyvoLlJFRAs
         fsCPIobNZyb+gStsCk6BZeL1SwOw//LExuo+gAqwILbi5eK3c/tmCZ2DH69+o/UVhUWh
         VCrE4ReqQrolqyZzvSgryO6A8RySv2DYxjGzSSuLGV49C1NVnac2ciN87ja6yLwwyd7d
         VSw8LbbCLrKXDHJ5An3yOTK9iNMjyWv60FDoDVGJWqcQWiSlb+FoD52iq8oFHgUNzkea
         SyAfSN6mdgcoK34+LzSHCpGr2NxsCWR7KCdjvJZqbyy2VNs6/2gslC6cWTm5GCL3OKpy
         /WlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dbqiLL8aUgPksDHzHaUghNX/IFV5YGYn2GKMzSbGgXE=;
        b=Kte2GMGsR85D49iJsdrotQZamzHoOH7mcHImUv4APWkG4pAdE8cUlcs+IZW9FI299T
         EYFllw+ZV9hMgr0hv3Ek/rEgjvBHed4CQAIZXVdQlmBoUb61NvAjpnGVUlCaNsGcK9LC
         HuaJyC7XgoYDwRvYvnKBzHMgk55S08nEhSroFgkjOfVzqNEy1IIj65KER6AHxckXcfAB
         W6VjfhI461koH3msd8Z1q1yeCOvu/9IorE0kVIFSo/5zyjnRLmU78VU6cGEjtltZSI+p
         DwKvOF5Rn8tdUZ99I4o4qCzu2LoROfTob9a42H4ZybUZ6dFHAREn/pCqCr4vUWRKGX4I
         v46w==
X-Gm-Message-State: AOAM533c5OOsma7/owOryRGCp4KaJLu8W5tpulXmtWuwfUSlkhw3Ub8w
        ziMMOCHIG9ixP2zPl0sELJ8=
X-Google-Smtp-Source: ABdhPJxa776eBpnKqpKTSouJp7u9j7v5OrKMq3uCSxdmJaIzShj+sduCDyBVOSf/PM+GIhcK1cODWA==
X-Received: by 2002:a7b:c444:: with SMTP id l4mr19316174wmi.115.1634808497790;
        Thu, 21 Oct 2021 02:28:17 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id p19sm7198376wmg.29.2021.10.21.02.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 02:28:16 -0700 (PDT)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH] staging: vt6655: Use named constants when checking preamble type
Date:   Thu, 21 Oct 2021 10:27:53 +0100
Message-Id: <20211021092753.511863-1-karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compare `preamble_type` to a predefined constant, `PREAMBLE_SHORT`,
instead of a literal in `bb_get_frame_time` and `vnt_get_phy_field`
functions. Thanks to this change, it is clear that we check
the type of a preamble, not just compare it against an arbitrary value.
Remove a redundant comment.

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 drivers/staging/vt6655/baseband.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vt6655/baseband.c b/drivers/staging/vt6655/baseband.c
index 8f9177db6663..84fa6ea3e2e6 100644
--- a/drivers/staging/vt6655/baseband.c
+++ b/drivers/staging/vt6655/baseband.c
@@ -1717,7 +1717,7 @@ unsigned int bb_get_frame_time(unsigned char preamble_type,
 	rate = (unsigned int)awc_frame_time[rate_idx];
 
 	if (rate_idx <= 3) {		    /* CCK mode */
-		if (preamble_type == 1) /* Short */
+		if (preamble_type == PREAMBLE_SHORT)
 			preamble = 96;
 		else
 			preamble = 192;
@@ -1779,7 +1779,7 @@ void vnt_get_phy_field(struct vnt_private *priv, u32 frame_length,
 	case RATE_2M:
 		count = bit_count / 2;
 
-		if (preamble_type == 1)
+		if (preamble_type == PREAMBLE_SHORT)
 			phy->signal = 0x09;
 		else
 			phy->signal = 0x01;
@@ -1792,7 +1792,7 @@ void vnt_get_phy_field(struct vnt_private *priv, u32 frame_length,
 		if (tmp != bit_count)
 			count++;
 
-		if (preamble_type == 1)
+		if (preamble_type == PREAMBLE_SHORT)
 			phy->signal = 0x0a;
 		else
 			phy->signal = 0x02;
@@ -1809,7 +1809,7 @@ void vnt_get_phy_field(struct vnt_private *priv, u32 frame_length,
 				ext_bit = true;
 		}
 
-		if (preamble_type == 1)
+		if (preamble_type == PREAMBLE_SHORT)
 			phy->signal = 0x0b;
 		else
 			phy->signal = 0x03;
-- 
2.30.2

