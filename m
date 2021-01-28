Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7013071C8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 09:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbhA1IjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 03:39:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:46034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231408AbhA1IjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 03:39:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 409A660235;
        Thu, 28 Jan 2021 08:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611823103;
        bh=Na31J9nclpZHliD68odUsckZm9auq5Sb++fcPHYYQ+Y=;
        h=Date:From:To:cc:Subject:From;
        b=Bk4Cdf7O3NUF1PbQDmjb0HJlLe+gnJmT7NqOSrXDK9CoLCn/TcCwQzwPfkY7aHfRQ
         s3QAQqrUQTl8uns64wH3rDf+ZPehPmLLIbIS/H7JSBWmC4yzxOhe+PBNHUI2iARd6+
         5liiY46lVO9OQ6annLxtUCr1KpKBd89wxTjr050Goj9mb4pv3DXqLErJRNEJhaGnml
         G8kyqhjsy/XI/IdmXpsT735svl373a5J/19pgOnvt5VbDH13OVJwCSQChNBsRrkWh3
         HOjP6hREYtqpObeZoId0DB9GSv73Qn9+Z4XWAtUrhnK5HoourvAMnbaDFL+sSmCtep
         DKoTPvf1uFdEQ==
Date:   Thu, 28 Jan 2021 09:38:19 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [GIT PULL] HID fixes
Message-ID: <nycvar.YFH.7.76.2101280935550.5622@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

to receve the following fixes for HID subsystem:

=====
- NULL pointer dereference regression fix for Wacom driver (Jason Gerecke)
- functional regression fix for pam handling on some Elan and Synaptics  
  touchpads (Kai-Heng Feng)
=====

Thanks.

----------------------------------------------------------------
Jason Gerecke (1):
      HID: wacom: Correct NULL dereference on AES pen proximity

Kai-Heng Feng (1):
      HID: multitouch: Apply MT_QUIRK_CONFIDENCE quirk for multi-input devices

 drivers/hid/hid-multitouch.c | 3 ++-
 drivers/hid/wacom_sys.c      | 7 ++++---
 drivers/hid/wacom_wac.h      | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

-- 
Jiri Kosina
SUSE Labs

