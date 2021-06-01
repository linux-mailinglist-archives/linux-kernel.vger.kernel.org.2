Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2AAF3947B8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 22:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhE1UEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 16:04:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:37928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229476AbhE1UEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 16:04:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 097B46108E;
        Fri, 28 May 2021 20:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622232156;
        bh=aoRfbiX1k99A9DONFyxs9o8ZYMTI4WvZ4hie4ER+JH0=;
        h=Date:From:To:Cc:Subject:From;
        b=fgpbc9kn8nllhKToLvC03nmoNRp8SCEGkChFLjxjrkmHGu6aRknSJgdQTRfNbnMMI
         wB/SS+5CjCRGYbVXG8gm6q/zFxrhfQJJSpIGnlfHYmEwFZcdAZaXyiPx3x/zenOcvS
         IRmIFdv5H4aNYG5qbCrNx2ztM2l+W5xmy8u88bTJo8oAMiHTdb7cBXi1PmJJc0v+co
         EYo8AoAnzbceDcsBYfUe8A76ONhd0fqG/WzQtfQP8mZ6FXiXmIEFYfvaWKzkt4hxhd
         wR6mq0yPZR3GGY1ZJ1jSfnBKc9fHjw8kxkw6gEta7w/fc1PHpmz0uxMOEfQAp7Y6PF
         AFuiTpVkfuwQw==
Date:   Fri, 28 May 2021 15:03:35 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Denis Efremov <efremov@linux.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2][next] floppy: Fix fall-through warning for Clang
Message-ID: <20210528200335.GA39252@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
by explicitly adding a break statement instead of letting the code fall
through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Link: https://lore.kernel.org/linux-hardening/47bcd36a-6524-348b-e802-0691d1b3c429@kernel.dk/
Suggested-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Add a break statement instead of fallthrough;

 drivers/block/floppy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 8a9d22207c59..803af2a72520 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -2123,6 +2123,7 @@ static void format_interrupt(void)
 	switch (interpret_errors()) {
 	case 1:
 		cont->error();
+		break;
 	case 2:
 		break;
 	case 0:
-- 
2.27.0

