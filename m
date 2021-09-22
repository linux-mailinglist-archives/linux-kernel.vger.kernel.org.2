Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3036D4141E1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 08:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbhIVGbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 02:31:45 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48082 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbhIVGbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 02:31:40 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9DB2F20090;
        Wed, 22 Sep 2021 06:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632292209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=1zsB3duZqWfv/sa30HDlwaflLPJ+Ap3xb7PtYRKjg+4=;
        b=onBX6PcIvcpocXn8OWtyneUVy0u+n2LX77++Ydot+ULUq4ZmIL9j9p/HBpIUHfk3jXoCtH
        sAIBob1Zc586l1zgPSfBHhjcNSHZP0JHd15q7a14CHVR6z319H2Eg9r615ikD8WDxt3Wd/
        t7QI/SYLL9pBD6Ue1pQOYooNgLoAfDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632292209;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=1zsB3duZqWfv/sa30HDlwaflLPJ+Ap3xb7PtYRKjg+4=;
        b=o7EObpx87o0NvgyrGtn3oTvGh0P1MC8rTYvmdr51PWNvl4c8xoQRGBGr4+vfBJxzKc+Jxi
        3QR5+xlPEbF76eCw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 513D8A3BA0;
        Wed, 22 Sep 2021 06:30:09 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Peter Korsgaard <peter@korsgaard.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH v2] MAINTAINERS: usb, update Peter Korsgaard's entries
Date:   Wed, 22 Sep 2021 08:30:08 +0200
Message-Id: <20210922063008.25758-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter's e-mail in MAINTAINERS is defunct:
This is the qmail-send program at a.mx.sunsite.dk.
<jacmet@sunsite.dk>:
      Sorry, no mailbox here by that name. (#5.1.1)

Peter says:
** Ahh yes, it should be changed to peter@korsgaard.com.

However he also says:
** I haven't had access to c67x00 hw for quite some years though, so maybe
** it should be marked Orphan instead?

So change as he wishes.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Peter Korsgaard <peter@korsgaard.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-usb@vger.kernel.org
---
[v2]

- Change the e-mail in DM9601 instead of dropping the old one.
- Make C67X00 an orphan.

 MAINTAINERS | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2b990794ec35..aafc58437abd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19344,13 +19344,12 @@ S:	Maintained
 F:	drivers/usb/misc/chaoskey.c
 
 USB CYPRESS C67X00 DRIVER
-M:	Peter Korsgaard <jacmet@sunsite.dk>
 L:	linux-usb@vger.kernel.org
-S:	Maintained
+S:	Orphan
 F:	drivers/usb/c67x00/
 
 USB DAVICOM DM9601 DRIVER
-M:	Peter Korsgaard <jacmet@sunsite.dk>
+M:	Peter Korsgaard <peter@korsgaard.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 W:	http://www.linux-usb.org/usbnet
-- 
2.33.0

