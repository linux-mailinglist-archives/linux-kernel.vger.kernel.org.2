Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59556359DC4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 13:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbhDILrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 07:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbhDILrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 07:47:41 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9D9C061760;
        Fri,  9 Apr 2021 04:47:28 -0700 (PDT)
Received: from ip4d14bd53.dynamic.kabel-deutschland.de ([77.20.189.83] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1lUpbh-0005de-0H; Fri, 09 Apr 2021 13:47:25 +0200
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] MAINTAINERS: add regressions mailing list
Date:   Fri,  9 Apr 2021 13:47:23 +0200
Message-Id: <ecf1f0125399c5242ff213b827eacc6f93af3172.1617967127.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617967127.git.linux@leemhuis.info>
References: <cover.1617967127.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1617968849;7011f6d2;
X-HE-SMSGID: 1lUpbh-0005de-0H
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the newly created regression mailing list finally created after it
already had been agreed on during the maintainers summit 2017 (see
https://lwn.net/Articles/738216/ ). The topic was recently discussed
again, where an idea to create a broader list for all issues was
discussed, but Linus preferred a more targeted list:
https://lkml.kernel.org/r/CAHk-=wgiYqqLzsb9-UpfH+=ktk7ra-2fOsdc_ZJ7WF47wS73CA@mail.gmail.com/

Hence, the creation for that list was asked for and granted:
https://bugzilla.kernel.org/show_bug.cgi?id=212557

In the end it became regressions@lists.linux.dev instead of
linux-regressions@lists.linux.dev as 'Linux' would have been redundant
in the latter case.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
v1->v2
* use the approach suggested by Greg, which doesn't have a K: entry,
  but that is likely not much of a help anyway
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 83472755a255..2553fec1d272 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9730,6 +9730,11 @@ F:	include/uapi/linux/sunrpc/
 F:	net/sunrpc/
 F:	Documentation/filesystems/nfs/
 
+KERNEL REGRESSIONS
+M:	Thorsten Leemhuis <linux@leemhuis.info>
+L:	regressions@lists.linux.dev
+S:	Supported
+
 KERNEL SELFTEST FRAMEWORK
 M:	Shuah Khan <shuah@kernel.org>
 M:	Shuah Khan <skhan@linuxfoundation.org>
-- 
2.30.2

