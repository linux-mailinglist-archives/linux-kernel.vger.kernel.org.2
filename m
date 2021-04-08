Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEFBC3583BC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 14:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbhDHMv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 08:51:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:57476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231629AbhDHMv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 08:51:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64ACF610FC;
        Thu,  8 Apr 2021 12:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617886306;
        bh=ljlT9EMpX+4gzSQvzBI0okJqsMwdo/RBU25CJI+xd4Y=;
        h=From:To:Cc:Subject:Date:From;
        b=nYs4DOT6L8qSGGy1Ec+RpSWeHX4IV2Ei4pJsJ4wP8358bgRs1uf6GWG4x/sfr7YWd
         dXuT/zV9UVoe+N7Hw9hVEGp9HD6GJnhPIZRB2Zfssxfm1FxpkglcTeaqx8wF9Jzb3r
         klODRcE9DaBYiiN776bBW9o90rtKCJ7slp6pVJHE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH 00/13] tty.h cleanups
Date:   Thu,  8 Apr 2021 14:51:21 +0200
Message-Id: <20210408125134.3016837-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turns out there is a lot of tty-internal stuff in include/linux/tty.h
that do not belong there.  Create a internal-to-the-tty-layer .h file
for these types of things and move function prototypes to it instead of
being in the system-wide header file.

Along the way clean up the use of some old tty-only debugging macros and
use the in-kernel dev_*() calls instead.

Greg Kroah-Hartman (13):
  tty: create internal tty.h file
  tty: tty.h: remove tty_info()
  tty: remove tty_err()
  tty: remove tty_notice()
  tty: remove tty_warn()
  tty: remove tty_info_ratelimited()
  tty: remove tty_debug()
  tty: audit: move some local functions out of tty.h
  tty: move some internal tty lock enums and functions out of tty.h
  tty: make tty_release_redirect() static
  tty: move some tty-only functions to drivers/tty/tty.h
  tty: remove tty_driver_name()
  tty: clean include/linux/tty.h up

 drivers/tty/n_gsm.c       |   1 +
 drivers/tty/n_hdlc.c      |   1 +
 drivers/tty/n_tty.c       |   5 +-
 drivers/tty/pty.c         |   3 +-
 drivers/tty/tty.h         | 103 ++++++++++++++++++++++++++++++++++++++
 drivers/tty/tty_audit.c   |   1 +
 drivers/tty/tty_buffer.c  |   2 +-
 drivers/tty/tty_io.c      |  43 +++++++---------
 drivers/tty/tty_ioctl.c   |   3 +-
 drivers/tty/tty_jobctrl.c |   7 +--
 drivers/tty/tty_ldisc.c   |   3 +-
 drivers/tty/tty_mutex.c   |   1 +
 drivers/tty/tty_port.c    |   5 +-
 include/linux/tty.h       | 100 ------------------------------------
 14 files changed, 142 insertions(+), 136 deletions(-)
 create mode 100644 drivers/tty/tty.h

-- 
2.31.1

