Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A78356984
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350998AbhDGKYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:24:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:44810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350946AbhDGKYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:24:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 15030613EE;
        Wed,  7 Apr 2021 10:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617791031;
        bh=7SlQDFpN8IwGX3V56eR2KHPnzDvhEiD1cEIzgKvu4jI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YOughuxls2IxSNAvOGOW4RgFjJO/oxySOIjgX55qO5J4rJvrpRK33TRl74bELp1DR
         56O6u/mOUR0oZZambCRqbKy3SC42Q0TLiLbBjNXFLVeZB0yD9psN7rPUZN9VAJvRKL
         Iqy8Ssm22UnY4k1CQk2/Q7opBnWRzmdlp23msYBjCwdL1hpxZcx2aP6bFIF9zNSwRA
         W+uZUXNiYMn6Gomja3V3q4jWQ3XkLptwPhQlihFOD0V5G/BNQ/Y5Xny3WdeMCdR15a
         hNEDN9j7EPoVZGtJ+5kBNNjeZWW/k4Hir2JwW6NLOt0YmO539h3CIYjyjPriyntsxa
         Pj4/t1GIMuK2Q==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lU5Lb-0008Ri-SN; Wed, 07 Apr 2021 12:23:43 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-staging@lists.linux.dev,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 15/16] pcmcia: synclink_cs: drop redundant tty-port initialisation
Date:   Wed,  7 Apr 2021 12:23:33 +0200
Message-Id: <20210407102334.32361-16-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210407102334.32361-1-johan@kernel.org>
References: <20210407102334.32361-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The port close_delay and closing_wait parameters have already been by
tty_port_init() so drop the redundant driver initialisation to the
default values.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/char/pcmcia/synclink_cs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
index 2be8d9a8eec5..3287a7627ed0 100644
--- a/drivers/char/pcmcia/synclink_cs.c
+++ b/drivers/char/pcmcia/synclink_cs.c
@@ -530,8 +530,6 @@ static int mgslpc_probe(struct pcmcia_device *link)
 	info->port.ops = &mgslpc_port_ops;
 	INIT_WORK(&info->task, bh_handler);
 	info->max_frame_size = 4096;
-	info->port.close_delay = 5*HZ/10;
-	info->port.closing_wait = 30*HZ;
 	init_waitqueue_head(&info->status_event_wait_q);
 	init_waitqueue_head(&info->event_wait_q);
 	spin_lock_init(&info->lock);
-- 
2.26.3

