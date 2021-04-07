Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70BCA356974
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350968AbhDGKYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:24:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:44624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234751AbhDGKYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:24:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4EC00613A9;
        Wed,  7 Apr 2021 10:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617791030;
        bh=34TodTLk/VIckWwu+MXMhXACn6D2SHx7dl/QxJWtCh4=;
        h=From:To:Cc:Subject:Date:From;
        b=j3aUX0a2jRPk8uuSvr0bQAHZxKj43BMUM1/GCPNzXg9gD6wLgCVFByb5/A3oiBlsP
         YDuKh7eUXwAuZ6Gbu9U6YqadfasICaTsuDx89OtcH5tA2Hh/1xVWv3LOBfATGJomLJ
         v1iy3J3AnHaFO3ogEzmGvH19l8XXCPA5E1lrIoPyN7Oinl9wZxXOU7z3HUieBgO2SV
         RYr4p3QALLm1TRcb8whe8jHFW0kIny7SnPJlPB8bQsMdVNuN+xHrFqL8b030ja7DQ7
         HJnc1n2zWZLQEr+80x38NcnTRkmR6zEFQ0mLqmtcGqp5dWrPeUEZwgHKI8EhYAd/n1
         k0T3huxrFE74Q==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lU5La-0008Qz-Il; Wed, 07 Apr 2021 12:23:42 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-staging@lists.linux.dev,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 00/16] tty: TIOCSSERIAL fixes and clean ups
Date:   Wed,  7 Apr 2021 12:23:18 +0200
Message-Id: <20210407102334.32361-1-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TIOCSSERIAL is a horrid, underspecified, legacy interface which for most
serial devices is only useful for setting the close_delay and
closing_wait parameters.

This series fixes up the various ways in which driver authors have
gotten the implementation wrong over the years, like, for example,
jiffies conversions, permissions checks and error handling.

The de-facto standard for error handling is to ignore any unsupported
features and immutable parameters (cf. UPF_FIXED_PORT and deprecated
ASYNC flags).

Permission checking should prevent an unprivileged user from changing
anything but the ASYNC_USR flags (and custom divisor) by returning
-EPERM.

These patches are against tty-next, but the staging ones could otherwise
go through either tree.

I'll be sending the corresponding USB fixes separately.

Johan



Johan Hovold (16):
  staging: fwserial: fix TIOCSSERIAL jiffies conversions
  staging: fwserial: fix TIOCSSERIAL permission check
  staging: fwserial: fix TIOCSSERIAL implementation
  staging: fwserial: fix TIOCGSERIAL implementation
  staging: greybus: uart: fix TIOCSSERIAL jiffies conversions
  staging: greybus: uart: fix unprivileged TIOCCSERIAL
  staging: greybus: uart: clean up TIOCGSERIAL
  tty: amiserial: fix TIOCSSERIAL permission check
  tty: amiserial: add missing TIOCSSERIAL jiffies conversions
  tty: moxa: fix TIOCSSERIAL jiffies conversions
  tty: moxa: fix TIOCSSERIAL permission check
  tty: moxa: fix TIOCSSERIAL implementation
  tty: mxser: fix TIOCSSERIAL jiffies conversions
  tty: mxser: fix TIOCSSERIAL permission check
  pcmcia: synclink_cs: drop redundant tty-port initialisation
  tty: synclink_gt: drop redundant tty-port initialisation

 drivers/char/pcmcia/synclink_cs.c   |  2 --
 drivers/staging/fwserial/fwserial.c | 19 +++++++++---------
 drivers/staging/greybus/uart.c      | 16 +++++++--------
 drivers/tty/amiserial.c             | 25 +++++++++++++++++------
 drivers/tty/moxa.c                  | 21 +++++++++----------
 drivers/tty/mxser.c                 | 31 ++++++++++++++++++++---------
 drivers/tty/synclink_gt.c           |  2 --
 7 files changed, 68 insertions(+), 48 deletions(-)

-- 
2.26.3

