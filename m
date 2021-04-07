Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC69356985
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351016AbhDGKYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:24:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:44812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350947AbhDGKYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:24:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 27C7B613C0;
        Wed,  7 Apr 2021 10:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617791031;
        bh=RjlzXkDmri64OQOjocp1PayJH/33h45Hk0UFMGKgoQ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eibbuh1k4QxhS/ZbcBbvkspFgJ1K8d4RL/3g6MoYxg3Po6sey6WmI9/ZO87PMWAbc
         DHdxnUQcKCN5dWPBi/gUC6g301c6Fzz70z++/BTlucW1NGbiq+HBUQ2PWy0FdTbs8c
         OeDfrp+wqjnTyNMwpLuE5I7Eke5U3avotdF/ZeosZH9natXVHzF8euSFTbVbSbHKZ9
         sf3A6wNH2j/r26sfyASemXK5dCSi+eSVge7Qle9hZTQ/TwAPrdHVuX7rOysu8xF3T7
         A6+oCFjYnEwDoDpcN0Gb50Glb60qHq1OsgJU/HBczumuNgglm5LwlaIAuS8SrPKxP7
         jHLX4dM5XbIoA==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lU5Lb-0008Rn-Uu; Wed, 07 Apr 2021 12:23:43 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-staging@lists.linux.dev,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 16/16] tty: synclink_gt: drop redundant tty-port initialisation
Date:   Wed,  7 Apr 2021 12:23:34 +0200
Message-Id: <20210407102334.32361-17-johan@kernel.org>
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
 drivers/tty/synclink_gt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index 1db908f62fde..994618618466 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -3511,8 +3511,6 @@ static struct slgt_info *alloc_dev(int adapter_num, int port_num, struct pci_dev
 		info->max_frame_size = 4096;
 		info->base_clock = 14745600;
 		info->rbuf_fill_level = DMABUFSIZE;
-		info->port.close_delay = 5*HZ/10;
-		info->port.closing_wait = 30*HZ;
 		init_waitqueue_head(&info->status_event_wait_q);
 		init_waitqueue_head(&info->event_wait_q);
 		spin_lock_init(&info->netlock);
-- 
2.26.3

