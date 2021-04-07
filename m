Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC7835687A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 11:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350393AbhDGJxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 05:53:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:36698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350327AbhDGJwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 05:52:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA4FE613CC;
        Wed,  7 Apr 2021 09:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617789147;
        bh=CbEIx5LJAV/BiDF376r4zPA53xOufuRud1TK65RuSVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tkrw157maZ4TLwkx8wJaUjzhMBJzAv+dNBRor5TN6U7VjE5csCaVY/RkTHr1/bHaB
         rcDwB6SpxCl+dZEcP6A9jLzzQTV8BDrRLcC60E+FxnFjAG0mshye+2Dr/NdhahqQy5
         XEH3o3kDH4KTvNwXD0lUPFOOS8HP/xlvzPKFDP9WGqxvlTQfPV437Yvjq0jSeP/RY7
         hxUtr9DVpfNi6rqhtHKoiQcIAibjVK+P5o2IyE3xG72Eo1LRD8yIVIJSAMXkQe6PnQ
         r5Tif/wWKN7IzlMyNqM+VYj7aFr+KMDigIfGcpQ6z66oGZruD3FsjOTlpPVFc4dMIb
         uPv54TXk7SyhA==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lU4rE-0008IX-2h; Wed, 07 Apr 2021 11:52:20 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 4/8] tty: use pr_warn_ratelimited() for deprecated serial flags
Date:   Wed,  7 Apr 2021 11:52:04 +0200
Message-Id: <20210407095208.31838-5-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210407095208.31838-1-johan@kernel.org>
References: <20210407095208.31838-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use pr_warn_ratelimited() when warning about deprecated serial flags
instead of open coding.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/tty_io.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 7738514a15fe..e00efd299abd 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2626,9 +2626,6 @@ static int tty_tiocgicount(struct tty_struct *tty, void __user *arg)
 
 static int tty_tiocsserial(struct tty_struct *tty, struct serial_struct __user *ss)
 {
-	static DEFINE_RATELIMIT_STATE(depr_flags,
-			DEFAULT_RATELIMIT_INTERVAL,
-			DEFAULT_RATELIMIT_BURST);
 	char comm[TASK_COMM_LEN];
 	struct serial_struct v;
 	int flags;
@@ -2638,9 +2635,9 @@ static int tty_tiocsserial(struct tty_struct *tty, struct serial_struct __user *
 
 	flags = v.flags & ASYNC_DEPRECATED;
 
-	if (flags && __ratelimit(&depr_flags))
-		pr_warn("%s: '%s' is using deprecated serial flags (with no effect): %.8x\n",
-			__func__, get_task_comm(comm, current), flags);
+	if (flags)
+		pr_warn_ratelimited("%s: '%s' is using deprecated serial flags (with no effect): %.8x\n",
+				__func__, get_task_comm(comm, current), flags);
 	if (!tty->ops->set_serial)
 		return -ENOTTY;
 	return tty->ops->set_serial(tty, &v);
@@ -2841,9 +2838,6 @@ struct serial_struct32 {
 static int compat_tty_tiocsserial(struct tty_struct *tty,
 		struct serial_struct32 __user *ss)
 {
-	static DEFINE_RATELIMIT_STATE(depr_flags,
-			DEFAULT_RATELIMIT_INTERVAL,
-			DEFAULT_RATELIMIT_BURST);
 	char comm[TASK_COMM_LEN];
 	struct serial_struct32 v32;
 	struct serial_struct v;
@@ -2860,9 +2854,9 @@ static int compat_tty_tiocsserial(struct tty_struct *tty,
 
 	flags = v.flags & ASYNC_DEPRECATED;
 
-	if (flags && __ratelimit(&depr_flags))
-		pr_warn("%s: '%s' is using deprecated serial flags (with no effect): %.8x\n",
-			__func__, get_task_comm(comm, current), flags);
+	if (flags)
+		pr_warn_ratelimited("%s: '%s' is using deprecated serial flags (with no effect): %.8x\n",
+				__func__, get_task_comm(comm, current), flags);
 	if (!tty->ops->set_serial)
 		return -ENOTTY;
 	return tty->ops->set_serial(tty, &v);
-- 
2.26.3

