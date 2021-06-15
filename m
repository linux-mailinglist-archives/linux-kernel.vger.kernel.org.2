Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4093A72EA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 02:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbhFOATj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 20:19:39 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]:45977 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbhFOAT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 20:19:27 -0400
Received: by mail-qt1-f174.google.com with SMTP id r7so1555593qta.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 17:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r0JJK8fDOBJh9zQ9xtXbOYn4ZOw91G+oEFwKabwQczg=;
        b=SnEFRG4pcAtqk2eMJGOiHSuVbgFd1QuW6HzPDMRKjwNhbCVwxU4kFA5DAYIXk1SLwA
         9/CNOwoTfPkEcK9zhCvAP1P/qGoljrCPLXXBFjg61K23ZHAECjXJdd3B9MaAkB4KRqFV
         Nl7sirBqXgI75nVir3j5rvyrOCimz5wV96Uy8CJIdKJwJHYf7oVmvQYUHS7jFsBRAy+t
         lEIOOsxZGfKQfSiVE35s5cp5he+N8/WTws9QLP7Xs3npIf9GYAMDSzcJhUypuFb/k2D0
         LQqTSgAcnwxREFXWfSogO2pwNS+wfPcomDzbIENJMSSKDvnW6SWdJproyMAeVa/D1diK
         FKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r0JJK8fDOBJh9zQ9xtXbOYn4ZOw91G+oEFwKabwQczg=;
        b=BBhju6sLPYIUYryRJi5APVlA8cGRWgm9E2jzQHWVzD6V4iv2varB+zEVwOGnQ4wNQB
         DO+v3iwyIzRo5cAiWtCZOYH1CTsPFE2yqKRUnyueTTQjnBokYqgBj7IeRVy7Tf2uyvk9
         T9MMWL6mJmGv/CLFIr+yX2PFGl0cM7CJq5gKnKpAW+K+6Tv8n15J1VwCCvC3UzLJRA7A
         kSaZRqD44BVmDnW4jbZhy6ZzYagCZtifmWHrBIHf92R8wDoiFitC2VP74kO1/bXJMexZ
         J85zHkOTbiJDLgZ3jPqh6zuT3PgG5oVHXS4fzgzMRgtpGsaZR+tc03wxkXJeuIH8bNKQ
         xNTw==
X-Gm-Message-State: AOAM5329+skW/UwRuPgX19cnNOdUTHdDpQhFJa5OckZROqyQYBA7aMNp
        vOICIRRsxHhz7Xko8jSvDEjtxg==
X-Google-Smtp-Source: ABdhPJy4C0Ko8XPTsxWR10re2ykvUSyH9XIdNzjeSyZGM6w6RoPkBBmGcu0DEDMnew6pvNIJTiQyoA==
X-Received: by 2002:ac8:5d47:: with SMTP id g7mr6698738qtx.351.1623716170337;
        Mon, 14 Jun 2021 17:16:10 -0700 (PDT)
Received: from localhost.localdomain (5.d.e.a.c.b.a.1.5.0.9.4.d.7.7.d.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:d77d:4905:1abc:aed5])
        by smtp.gmail.com with ESMTPSA id m199sm11244248qke.71.2021.06.14.17.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 17:16:10 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 16/28] staging: rtl8188eu: remove all DBG_88E calls from os_dep/rtw_android.c
Date:   Tue, 15 Jun 2021 01:14:55 +0100
Message-Id: <20210615001507.1171-17-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615001507.1171-1-phil@philpotter.co.uk>
References: <20210615001507.1171-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all DBG_88E calls from os_dep/rtw_android.c as this macro is
unnecessary, and many of these calls are dubious in terms of necessity.
Removing all calls will ultimately allow the removal of the macro
itself.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/os_dep/rtw_android.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/rtw_android.c b/drivers/staging/rtl8188eu/os_dep/rtw_android.c
index 99475be30702..298517530ed3 100644
--- a/drivers/staging/rtl8188eu/os_dep/rtw_android.c
+++ b/drivers/staging/rtl8188eu/os_dep/rtw_android.c
@@ -135,8 +135,6 @@ int rtw_android_priv_cmd(struct net_device *net, struct ifreq *ifr, int cmd)
 	if (IS_ERR(command))
 		return PTR_ERR(command);
 	command[priv_cmd.total_len - 1] = 0;
-	DBG_88E("%s: Android private cmd \"%s\" on %s\n",
-		__func__, command, ifr->ifr_name);
 	cmd_num = rtw_android_cmdstr_to_num(command);
 	switch (cmd_num) {
 	case ANDROID_WIFI_CMD_START:
@@ -202,7 +200,6 @@ int rtw_android_priv_cmd(struct net_device *net, struct ifreq *ifr, int cmd)
 	case ANDROID_WIFI_CMD_P2P_SET_PS:
 		break;
 	default:
-		DBG_88E("Unknown PRIVATE command %s - ignored\n", command);
 		snprintf(command, 3, "OK");
 		bytes_written = strlen("OK");
 	}
@@ -211,20 +208,14 @@ int rtw_android_priv_cmd(struct net_device *net, struct ifreq *ifr, int cmd)
 	if (bytes_written >= 0) {
 		if ((bytes_written == 0) && (priv_cmd.total_len > 0))
 			command[0] = '\0';
-		if (bytes_written >= priv_cmd.total_len) {
-			DBG_88E("%s: bytes_written = %d\n", __func__,
-				bytes_written);
+		if (bytes_written >= priv_cmd.total_len)
 			bytes_written = priv_cmd.total_len;
-		} else {
+		else
 			bytes_written++;
-		}
 		priv_cmd.used_len = bytes_written;
 		if (copy_to_user((char __user *)priv_cmd.buf, command,
-				 bytes_written)) {
-			DBG_88E("%s: failed to copy data to user buffer\n",
-				__func__);
+				 bytes_written))
 			ret = -EFAULT;
-		}
 	} else {
 		ret = bytes_written;
 	}
-- 
2.30.2

