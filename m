Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84978344043
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 12:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhCVL4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 07:56:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230242AbhCVL4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 07:56:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5740D61993;
        Mon, 22 Mar 2021 11:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616414166;
        bh=v02+Q4Y/k5N5zyuH15US/OzUofNlFXTHJrTv94Wy354=;
        h=From:To:Cc:Subject:Date:From;
        b=HhEl8R7wxUe6N6+JjBywxIcTizWiUXEt1SOxVHC7RILixuJUgrUWRN3OS9QOhtXP+
         BLNmFhlvHGPRlqU0k3AqRRg/1Zu8AffkAp+cQ9PCpvJzlOr2W6xbVUChwACDnk9/5W
         8i0kkZZ5zSj4MCtxokKGXJVYQ7EaFMzwuJb9TDPCD1peJHsxwKhkQg5mEEil73yhfP
         hwnJ4i3TMEv7oo5Mh4k0jfVMAs5bDN1yxe33n4jACq2hCQ6yEwdx8TVjYXRKwyKUjn
         sbA2WUThcixS0dGT2U2hKNY1QJmVg7eJ3ohTLSzvHGqbXYVU8UQBhu/xdvFSU4mrc5
         K1ppWa6mTt7Eg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Prashant Malani <pmalani@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Guenter Roeck <groeck@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Azhar Shaikh <azhar.shaikh@intel.com>,
        Utkarsh Patel <utkarsh.h.patel@intel.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] platform/chrome: cros_ec_typec: fix clang -Wformat warning
Date:   Mon, 22 Mar 2021 12:55:55 +0100
Message-Id: <20210322115602.4003221-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Clang warns about using the %h format modifier to truncate an
integer:

drivers/platform/chrome/cros_ec_typec.c:1031:3: error: format specifies type 'unsigned char' but the argument has type 'unsigned int' [-Werror,-Wformat]
                typec->pd_ctrl_ver);
                ^~~~~~~~~~~~~~~~~~
include/linux/dev_printk.h:131:47: note: expanded from macro 'dev_dbg'
                dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
                                                    ~~~     ^~~~~~~~~~~

Use an explicit bit mask to limit the number to its lower eight bits
instead.

Fixes: ad7c0510c99e ("platform/chrome: cros_ec_typec: Update port info from EC")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/platform/chrome/cros_ec_typec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 0811562deecc..f07b7e946560 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -1027,8 +1027,8 @@ static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
 	else
 		typec->pd_ctrl_ver = 0;
 
-	dev_dbg(typec->dev, "PD Control has version mask 0x%hhx\n",
-		typec->pd_ctrl_ver);
+	dev_dbg(typec->dev, "PD Control has version mask 0x%02x\n",
+		typec->pd_ctrl_ver & 0xff);
 
 	return 0;
 }
-- 
2.29.2

