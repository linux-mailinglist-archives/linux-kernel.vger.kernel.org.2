Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5530041C15D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 11:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245022AbhI2JLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 05:11:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:37424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244990AbhI2JLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 05:11:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A429E613A7;
        Wed, 29 Sep 2021 09:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632906604;
        bh=vv4mo8J1bX3AUFMUVJnTejK3fSaF3X8P6DAZiJxdF/4=;
        h=From:To:Cc:Subject:Date:From;
        b=kn8GOKkpoAWz7u4/3EOSW5uI0/Tbn3GrruKOzUQT8fhYK6euU/vdgJrx3y9nlY5iX
         Ux7BzMmAYA1EoMNA007siVfFdhQApNeePnnWFCLIx5U0pcahgWgxZHjECPaGV9oFPM
         n3PA58g7aMKM4BjwhTpxoZP3AxXNAbc8QDZbapQjA3Nepe0urcNs/hAEPfjA9mmNSy
         WCLlvRe4z4cWTYHV7fPNet8yw6zVeOlIUDM1v9ta61eIP+PpPNfpKclBzgz8LSP5HW
         m16n+pRo3+bo52eOE40cg5a4LbQ+iAoEud2V1Qz2FpUihJbrPQzvaVBpryxqvhGU5n
         3Z6OaYbB0pJ8A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mVVbJ-0001wR-Kp; Wed, 29 Sep 2021 11:10:05 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/2] USB: cdc-acm: fix break reporting
Date:   Wed, 29 Sep 2021 11:09:35 +0200
Message-Id: <20210929090937.7410-1-johan@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a couple of bugs in the recently added support for reporting
break events.

Note that the offending commit was backported to stable.

Johan


Johan Hovold (2):
  USB: cdc-acm: fix racy tty buffer accesses
  USB: cdc-acm: fix break detection

 drivers/usb/class/cdc-acm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
2.32.0

