Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B523583C7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 14:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbhDHMwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 08:52:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231709AbhDHMwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 08:52:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6216D61106;
        Thu,  8 Apr 2021 12:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617886319;
        bh=m8yfJ2BCGLC2tHj64D68xhYmsWnH1r6vwIX6ULaf894=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IErunaMbrgVtJGmSPqbxrabcoFR+Tvt0EKgE3e8pu8JWD+oFmFjbiay9yvbu8bOVP
         GlxTyaKSNj7Y3JyeFB1hJQVeOhQCy1B9ViF/J+6vAhr3AIMjtK02I7Qfs+Xz5QFtcA
         cQ3ZqoBht5kdjqtjAwFszMCw6oteTEQcQFJgGUo4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH 02/13] tty: tty.h: remove tty_info()
Date:   Thu,  8 Apr 2021 14:51:23 +0200
Message-Id: <20210408125134.3016837-3-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210408125134.3016837-1-gregkh@linuxfoundation.org>
References: <20210408125134.3016837-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No one is calling this macro, and no one should, so remove it from the
.h file.

Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/tty.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/tty.h b/drivers/tty/tty.h
index f4cd20261e91..75624d7d84ae 100644
--- a/drivers/tty/tty.h
+++ b/drivers/tty/tty.h
@@ -10,7 +10,6 @@
 	fn("%s %s: " f, tty_driver_name(tty), tty_name(tty), ##__VA_ARGS__)
 
 #define tty_debug(tty, f, ...)	tty_msg(pr_debug, tty, f, ##__VA_ARGS__)
-#define tty_info(tty, f, ...)	tty_msg(pr_info, tty, f, ##__VA_ARGS__)
 #define tty_notice(tty, f, ...)	tty_msg(pr_notice, tty, f, ##__VA_ARGS__)
 #define tty_warn(tty, f, ...)	tty_msg(pr_warn, tty, f, ##__VA_ARGS__)
 #define tty_err(tty, f, ...)	tty_msg(pr_err, tty, f, ##__VA_ARGS__)
-- 
2.31.1

