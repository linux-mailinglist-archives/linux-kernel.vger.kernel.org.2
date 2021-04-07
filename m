Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75A6356870
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 11:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350348AbhDGJwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 05:52:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:36636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346322AbhDGJwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 05:52:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE046613A9;
        Wed,  7 Apr 2021 09:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617789147;
        bh=qw17fhKJ2skeqCKD7rOCmXbbGKIuta7msyteFdGR6/U=;
        h=From:To:Cc:Subject:Date:From;
        b=FRRnVimLIhm2fNG4+vlJO7ios+HxlHuFee34zVGmMOLENIsRv4MRV6DMJu/fFoRZa
         NDsW3A7kNkGZY3Qgl5zR5PLr8qV6xG9JU2yX2BqCoK/ThVwuiNHINhQvLYAkhAngmA
         865EZqm/kPLqGFGHHYy9FY9zbLtlLj1Srr73tOcUuAgqPc8tLasAmV3m0HXhF9ZiR8
         nEwOueV3lMQebYnWt19nYuMdR/REn8insI54woIzw5yCxacXFJPtjTb7EVOzqXgV2V
         dZeTADCWHQED+cpUAh/CGyp6gPBaJZ548gfc9lyJw+hmQljkQ9xx+RfRiAFHRnww5L
         7uBzrLRCIAlFA==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lU4rD-0008IN-Mb; Wed, 07 Apr 2021 11:52:19 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/8] tty: ioctl fixes and cleanups
Date:   Wed,  7 Apr 2021 11:52:00 +0200
Message-Id: <20210407095208.31838-1-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes and cleans up a few (serial-) ioctl-related issues.

Johan


Johan Hovold (8):
  tty: actually undefine superseded ASYNC flags
  tty: fix return value for unsupported ioctls
  tty: fix return value for unsupported termiox ioctls
  tty: use pr_warn_ratelimited() for deprecated serial flags
  tty: refactor TIOCSSERIAL handling
  tty: add ASYNC_SPLIT_TERMIOS to deprecation mask
  serial: core: drop redundant TIOCGSERIAL memset
  serial: core: return early on unsupported ioctls

 drivers/tty/serial/serial_core.c |  8 ++---
 drivers/tty/tty_io.c             | 53 ++++++++++++++------------------
 drivers/tty/tty_ioctl.c          |  4 +--
 include/linux/tty_driver.h       |  2 +-
 include/uapi/linux/tty_flags.h   |  8 ++---
 5 files changed, 33 insertions(+), 42 deletions(-)

-- 
2.26.3

