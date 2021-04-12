Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4195C35C23E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 11:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243234AbhDLJlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239699AbhDLJID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:08:03 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006B8C0612F0;
        Mon, 12 Apr 2021 02:04:00 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0521005111e44f1de5d8d9.dip0.t-ipconnect.de [IPv6:2003:ec:2f05:2100:5111:e44f:1de5:d8d9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1A0991EC0283;
        Mon, 12 Apr 2021 11:03:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1618218239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=kqo/mEUIsgFPHBTwQoVjSeQqRbssq21btEFfXBtvsr4=;
        b=EtKz2ZFa0W88PxJQCHryW4MKQUBS0KHf+/xCfjisBI+HBLR31VZcSaGoBwuaQCUaf0FO4h
        2BFLPiupU5T8m9A/oke/T3qU53AnQ4Sa/W6AUle3gejyJ7A6dIijeSKs4F3lmbA0v89imU
        tmLPbF8rezcH6a5xI5kRTeS8oNYlKp0=
From:   Borislav Petkov <bp@alien8.de>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] MAINTAINERS: Remove me from IDE/ATAPI section
Date:   Mon, 12 Apr 2021 11:03:46 +0200
Message-Id: <20210412090346.31213-1-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

It has been years since I've touched this and "this" is going away
anyway... any day now. :-)

So remove me so that I do not get CCed on bugs/patches.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0ec903a142b5..8de7af2d709f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8611,7 +8611,6 @@ F:	drivers/ide/
 F:	include/linux/ide.h
 
 IDE/ATAPI DRIVERS
-M:	Borislav Petkov <bp@alien8.de>
 L:	linux-ide@vger.kernel.org
 S:	Maintained
 F:	Documentation/cdrom/ide-cd.rst
-- 
2.29.2

