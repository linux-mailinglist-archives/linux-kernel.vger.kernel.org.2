Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE77366C2A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241994AbhDUNLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:11:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:49734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241430AbhDUNId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:08:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A73F61454;
        Wed, 21 Apr 2021 13:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010479;
        bh=HvXv3QwoSONDfzR2FF+Rx1NyAe9jrHfJafWGcU2f9mI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O26G0L2k3lbkcjU4oI+xH5e1qpaJKBV72oFQEaD+6YtaaiOLdaFLxrs6XcVBxOjkV
         U++ARMsw4xbqba+3mDHnJIZaqGkFMAIxvReo/eibFGn0wMJwguAQLPHQNRQKEaaPME
         nA6dWOvZifqdOH5u6FCg/8tYNnf1B6ybwe7zFg0A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aditya Pakki <pakki001@umn.edu>
Subject: [PATCH 144/190] Revert "misc/ics932s401: Add a missing check to i2c_smbus_read_word_data"
Date:   Wed, 21 Apr 2021 15:00:19 +0200
Message-Id: <20210421130105.1226686-145-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit b05ae01fdb8966afff5b153e7a7ee24684745e2d.

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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/ics932s401.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/misc/ics932s401.c b/drivers/misc/ics932s401.c
index 2bdf560ee681..733e5c2b57ce 100644
--- a/drivers/misc/ics932s401.c
+++ b/drivers/misc/ics932s401.c
@@ -133,8 +133,6 @@ static struct ics932s401_data *ics932s401_update_device(struct device *dev)
 	 */
 	for (i = 0; i < NUM_MIRRORED_REGS; i++) {
 		temp = i2c_smbus_read_word_data(client, regs_to_copy[i]);
-		if (temp < 0)
-			data->regs[regs_to_copy[i]] = 0;
 		data->regs[regs_to_copy[i]] = temp >> 8;
 	}
 
-- 
2.31.1

