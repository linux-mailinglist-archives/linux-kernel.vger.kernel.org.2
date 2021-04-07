Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B1E356A2B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240529AbhDGKqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:46:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:52186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351338AbhDGKp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:45:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B51276139C;
        Wed,  7 Apr 2021 10:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617792346;
        bh=yj3yyTkRa9B8WwPHCUCnUezOHuBkc+QW6M6s65oJtNA=;
        h=From:To:Cc:Subject:Date:From;
        b=YZJ2TQgdMs2WnNmUzjDRbtlZ57MEaQgYk3qj//hn8zmXPjC5gWuuNtcWvcf8/Kp91
         ceN/wzZHhQjaOMOOZaVy/IsIbx7hs3LV/6WgMZNIxgtfyLE+2QBUJaHMAkrK5XUVjt
         Pp9uznvT9jAhbTMHRZ1IHAFf7j4ltXp74ybK2DDIxnU5bTl44q/zVVzkjEA/tOYUhc
         N3kLMA1UdB+bYPLfMxCyLjKMmIphxANuQDS5UP0ItVYmK8lu1L4Ke8btfygLR1mY4N
         HLQbseXJ2vIxudbfTVM/a3YrnQPnK0bkTq6XxsEnFVqVcc5DCkE4eW4qkS2nuqSaek
         Ngwf0k7expIvQ==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lU5go-0000Ii-Jp; Wed, 07 Apr 2021 12:45:39 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] USB: serial: closing-wait cleanups
Date:   Wed,  7 Apr 2021 12:45:25 +0200
Message-Id: <20210407104529.1110-1-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all USB serial drivers supports changing the closing_wait
parameter through TIOCSSERIAL (setserial), we can remove the related
driver-specific module parameters and settings.

These depend on the recently posted TIOCSSERIAL series.

Johan


Johan Hovold (4):
  USB: serial: io_ti: drop closing_wait module parameter
  USB: serial: io_ti: switch to 30-second closing wait
  USB: serial: ti_usb_3410_5052: drop closing_wait module parameter
  USB: serial: ti_usb_3410_5052: switch to 30-second closing wait

 drivers/usb/serial/io_ti.c            | 7 -------
 drivers/usb/serial/ti_usb_3410_5052.c | 9 ---------
 2 files changed, 16 deletions(-)

-- 
2.26.3

