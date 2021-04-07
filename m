Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3635835697D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbhDGKYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:24:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350941AbhDGKYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:24:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D51F1613E8;
        Wed,  7 Apr 2021 10:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617791031;
        bh=9mED6a1UlsVjOYWV/gSUridu6zpw0Q762+4/qNjFRyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F3PiCA5B/ziquY8xvHTE8r6n30qKooTfu4EJ9EYaGp4vNxzgZczCJtR3bAp0XzZxm
         f1QasQrS7YDFlRkX+LXYVQnweEcVlSNAb0GJOLTgOrxs6MXlmIzGyaGVXRDDHARKt1
         Xy+GX5nMqiJ86hYDI2yAUqXnqaF7/pVtRIAu8tC8dtL3vCjJZsykE7iHALO7fsXtft
         JBIz4RrVZwV9I1bk6RXOPADoR7ICjphyoTTjb9AlkgrGNW4923lj8i3Qnh5osDTedN
         N9q7zrChSSUcjjrn+wcmWveD3nKoAk5LKDuG6ahYFUN/CL93qfV/+STzzUpbpCCo5o
         qB1ykaNoqmDUg==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lU5Lb-0008RZ-Jh; Wed, 07 Apr 2021 12:23:43 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-staging@lists.linux.dev,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 12/16] tty: moxa: fix TIOCSSERIAL implementation
Date:   Wed,  7 Apr 2021 12:23:30 +0200
Message-Id: <20210407102334.32361-13-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210407102334.32361-1-johan@kernel.org>
References: <20210407102334.32361-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TIOCSSERIAL is a horrid, underspecified, legacy interface which for most
serial devices is only useful for setting the close_delay and
closing_wait parameters.

A non-privileged user has only ever been able to set the since long
deprecated ASYNC_SPD flags and trying to change any other *supported*
feature should result in -EPERM being returned. Setting the current
values for any supported features should return success.

Fix the moxa implementation which was returning -EPERM also for a
privileged user when trying to change certain unsupported parameters and
instead return success consistently.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/moxa.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
index 63e440d900ff..4d4f15b5cd29 100644
--- a/drivers/tty/moxa.c
+++ b/drivers/tty/moxa.c
@@ -2055,11 +2055,6 @@ static int moxa_set_serial_info(struct tty_struct *tty,
 	if (!info)
 		return -ENODEV;
 
-	if (ss->irq != 0 || ss->port != 0 ||
-			ss->custom_divisor != 0 ||
-			ss->baud_base != 921600)
-		return -EPERM;
-
 	close_delay = msecs_to_jiffies(ss->close_delay * 10);
 
 	mutex_lock(&info->port.mutex);
-- 
2.26.3

