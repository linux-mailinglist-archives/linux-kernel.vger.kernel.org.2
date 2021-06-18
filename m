Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E153AC385
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 08:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbhFRGTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 02:19:15 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59718 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbhFRGRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:41 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 80D4F21B6E;
        Fri, 18 Jun 2021 06:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CXiwtDda8WUvQ1B1TfIDLBye0GpMNWCf5AFEisaaqjY=;
        b=ll2w8VCWVACIvmIhuJeCn3pTYPYKDaXKZJy+9Nx/wdQhLHkgWNAEdYGlHEn1KcLuZcSXHc
        YL93IEfsSE5wDZTNvevoqgb+olpgsEJrc4DXDnKaW06YT+pwbYYRRyB7cuLQ0hP/bWhEKk
        iN8Kd9fdweovljq9/ASqjzSrokOgdxg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996923;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CXiwtDda8WUvQ1B1TfIDLBye0GpMNWCf5AFEisaaqjY=;
        b=1kQRBSuEXnSwzs1zYs8kKuZXbbXAkAdhrERNMdHhvi0xbC6EapVIcU/a7IttVkmfYiB3TN
        84cySdkMiCD+25BQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5AA6BA3BC2;
        Fri, 18 Jun 2021 06:15:23 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 30/70] mxser: remove MOXA_HighSpeedOn ioctl
Date:   Fri, 18 Jun 2021 08:14:36 +0200
Message-Id: <20210618061516.662-31-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1) The semantics are defined exactly nowhere.
2) The ioctl definition was never exposed to userspace, so noone should
   actually be reliably using this.
3) It's not even mentioned in any of the mxser utilities.

Provided the above, remove this mxser-special ioctl.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index ca417d9a03cf..586fa3575673 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -50,7 +50,6 @@
  */
 
 #define MOXA			0x400
-#define MOXA_HighSpeedOn	(MOXA + 61)
 #define MOXA_SET_OP_MODE	(MOXA + 66)
 #define MOXA_GET_OP_MODE	(MOXA + 67)
 
@@ -1495,8 +1494,6 @@ static int mxser_ioctl(struct tty_struct *tty,
 
 		return wait_event_interruptible(info->port.delta_msr_wait,
 				mxser_cflags_changed(info, arg, &cnow));
-	case MOXA_HighSpeedOn:
-		return put_user(info->baud_base != 115200 ? 1 : 0, (int __user *)argp);
 	default:
 		return -ENOIOCTLCMD;
 	}
-- 
2.32.0

