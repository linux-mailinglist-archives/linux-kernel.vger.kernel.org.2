Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DABD366BB4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbhDUNFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:05:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:45088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240602AbhDUNEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:04:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D68661452;
        Wed, 21 Apr 2021 13:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010243;
        bh=bva+QBwuCTLNa9Kd6OK2xVvhYq1YDxXvCcqUOdoV8lA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0GHLsbOk6//k3nKPtefRnpXR0cw5F/5emduScEG2MgVlP9sGNAWzJHEAudm7vFQpO
         kDcV1OmsDXdQPlFjO0v72H7P9prPYkoNEVsN83q4AH0uy/ly25RVqVv6RDfO3us3Bz
         BQf/D34yxONKX6QXwEjdYKXxDvKsZ/gHOfIaCxDk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aditya Pakki <pakki001@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 063/190] Revert "hdlcdrv: replace unnecessary assertion in hdlcdrv_register"
Date:   Wed, 21 Apr 2021 14:58:58 +0200
Message-Id: <20210421130105.1226686-64-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit a886ca6fcfffd337482352f383c1002c72786b17.

Commits from @umn.edu addresses have been found to be submitted in "bad
faith" to try to test the kernel community's ability to review "known
malicious" changes.  The result of these submissions can be found in a
paper published at the 42nd IEEE Symposium on Security and Privacy
entitled, "Open Source Insecurity: Stealthily Introducing
Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
of Minnesota) and Kangjie Lu (University of Minnesota).

Because of this, all submissions from this group must be reverted from
the kernel tree and will need to be re-reviewed again to determine if
they actually are a valid fix.  Until that work is complete, remove this
change to ensure that no problems are being introduced into the
codebase.

Cc: Aditya Pakki <pakki001@umn.edu>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hamradio/hdlcdrv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/hamradio/hdlcdrv.c b/drivers/net/hamradio/hdlcdrv.c
index 9e0058154ac3..d8df4e2b162e 100644
--- a/drivers/net/hamradio/hdlcdrv.c
+++ b/drivers/net/hamradio/hdlcdrv.c
@@ -687,6 +687,8 @@ struct net_device *hdlcdrv_register(const struct hdlcdrv_ops *ops,
 	struct hdlcdrv_state *s;
 	int err;
 
+	BUG_ON(ops == NULL);
+
 	if (privsize < sizeof(struct hdlcdrv_state))
 		privsize = sizeof(struct hdlcdrv_state);
 
-- 
2.31.1

