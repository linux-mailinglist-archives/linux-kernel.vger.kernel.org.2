Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F02359676
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 09:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbhDIHgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 03:36:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:58606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229621AbhDIHgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 03:36:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 71F2F61168;
        Fri,  9 Apr 2021 07:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617953749;
        bh=tUUyn5yye+9bPZTq8k5gPuCkJ7JDJSHxire3zJvNpSY=;
        h=From:To:Cc:Subject:Date:From;
        b=bJl/WbbGGP9ZGR4vUnZ19dw7oiC5g1gzuuWBboLh+bUf0pnB+GERUZ0HFNMZflQuJ
         AX9DTQ99/3B34PgAo/njIks+IllMiSiTeCd/XVd3tzPypoS5kI8u1Do1dQQ9VwuXXi
         88JooGk2iJ6CXcR8E6bogFudNA57goNMdKXii99WcUdy4qVmFrQYLY4JTBaI1sCDzM
         /P5BSZ+pciujcpajL5uydMD2z0SROSc3qHxEzvIunTkCbwjWXjjDxCSTSdkOysKE1a
         eZXv1iZDs6gTTCwQciF6mUlFQURNbUWA0QYQQamlq9khHg2IZxMetwMduRfNnLOWxK
         ttv+tV9R3sqXw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lUlgA-0001ns-2S; Fri, 09 Apr 2021 09:35:46 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH] tty: clarify that not all ttys have a class device
Date:   Fri,  9 Apr 2021 09:35:12 +0200
Message-Id: <20210409073512.6876-1-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 30004ac9c090 ("tty: add tty_struct->dev pointer to corresponding
device instance") added a struct device pointer field to struct
tty_struct which was populated with the corresponding tty class device
during initialisation.

Unfortunately, not all ttys have a class device (e.g. pseudoterminals
and serdev) in which case the device pointer will be set to NULL,
something which have bit driver authors over the years.

In retrospect perhaps this field should never have been added, but let's
at least document the current behaviour.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 include/linux/tty.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/tty.h b/include/linux/tty.h
index 95fc2f100f12..178d8a3b18f2 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -284,7 +284,7 @@ struct tty_operations;
 struct tty_struct {
 	int	magic;
 	struct kref kref;
-	struct device *dev;
+	struct device *dev;	/* class device or NULL (e.g. ptys, serdev) */
 	struct tty_driver *driver;
 	const struct tty_operations *ops;
 	int index;
-- 
2.26.3

