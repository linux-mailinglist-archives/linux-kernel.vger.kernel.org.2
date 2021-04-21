Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBD9366890
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 11:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238832AbhDUJ41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 05:56:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:52426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238576AbhDUJ4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 05:56:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1FB8F61453;
        Wed, 21 Apr 2021 09:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618998936;
        bh=pa2npGgbk/pUlI/g0K19S40FBZbfELBPNGkOpCb7nns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PkqDH4cXM8jKE+FmS4H6DcmciIQcs7HSmin9B1+JcHhLv8gf4KuwK5XNl8uxmULh1
         vubx8ib1+3apmsiQ/lRAstEttPaoo1YNbeWx7O56RTfmMp352GLwTvusEqjT1yi0TP
         GhJI9742bjTh8WJEtN8RnXwNg9YAiblWgWoJMdCFc5u0YQRRCN4gNS9/JJJ6Yme818
         95xNXVf6de2PNZ3eba90xNqDDoaZohPtmADb06TE3nJGW0mO4cWbsauFbhlywICKa6
         oeTjdMy74c0JK1vBt7BuxFGu3UN0o8mjh7nBfJfsAjmvnVLBXABLxyNMUF+/dP6VLW
         XE8u4ca8wOV0A==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lZ9a6-0000oN-Pg; Wed, 21 Apr 2021 11:55:38 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 01/26] tty: mxser: drop low-latency workaround
Date:   Wed, 21 Apr 2021 11:54:44 +0200
Message-Id: <20210421095509.3024-2-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210421095509.3024-1-johan@kernel.org>
References: <20210421095509.3024-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 67d2bc58afdd ("Char: mxser_new, fix recursive locking") worked
around the infamous low_latency behaviour of tty_flip_buffer_push() by
simply dropping and reacquiring the port lock in the interrupt handler.

Since commit a9c3f68f3cd8 ("tty: Fix low_latency BUG"),
tty_flip_buffer_push() always schedules a work item to push data to the
line discipline and there's no need to keep any low_latency hacks around.

Link: https://lore.kernel.org/lkml/3018694794025219@wsc.cz/T/#m06b04c640a7b6f41afb3d34a4cf29b1df4935d3a
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/mxser.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 2d8e76263a25..16a852ecbe8a 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -2155,14 +2155,7 @@ static void mxser_receive_chars(struct tty_struct *tty,
 	port->mon_data.rxcnt += cnt;
 	port->mon_data.up_rxcnt += cnt;
 
-	/*
-	 * We are called from an interrupt context with &port->slock
-	 * being held. Drop it temporarily in order to prevent
-	 * recursive locking.
-	 */
-	spin_unlock(&port->slock);
 	tty_flip_buffer_push(&port->port);
-	spin_lock(&port->slock);
 }
 
 static void mxser_transmit_chars(struct tty_struct *tty, struct mxser_port *port)
-- 
2.26.3

