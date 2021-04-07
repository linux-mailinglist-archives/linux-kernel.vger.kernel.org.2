Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08EA3567E6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 11:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350085AbhDGJYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 05:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbhDGJWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 05:22:09 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1F4C061756;
        Wed,  7 Apr 2021 02:22:00 -0700 (PDT)
Received: from ip4d14bd53.dynamic.kabel-deutschland.de ([77.20.189.83] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1lU4Np-0004en-FZ; Wed, 07 Apr 2021 11:21:57 +0200
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 1/2] MAINTAINERS: add regressions mailing list
Date:   Wed,  7 Apr 2021 11:21:55 +0200
Message-Id: <f959331ed0e1a8ed59be9771fcab64378bd6977d.1617786974.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617786974.git.linux@leemhuis.info>
References: <cover.1617786974.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1617787320;560b1f82;
X-HE-SMSGID: 1lU4Np-0004en-FZ
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
linux-regressions@lists.linux.dev as 'Linux' is redundant in the latter
case.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
I was a bit unsure how to add that list to MAINTAINERS. I considered
adding a 'M:' with my name and email address there as well, but getting
CCed on a lot of regression reports might be a bit much. I also left a
'S: supported' out, as that doesn't make much sense in this case afaics;
and I checked, there are other entries that don't have those two (but
it's rare).

Ciao, Thorsten
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 03b2096a5f8f..dd5743d1f743 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15212,6 +15212,10 @@ F:	Documentation/devicetree/bindings/regmap/
 F:	drivers/base/regmap/
 F:	include/linux/regmap.h
 
+REGRESSIONS
+L:	regressions@lists.linux.dev
+K:	regression
+
 REISERFS FILE SYSTEM
 L:	reiserfs-devel@vger.kernel.org
 S:	Supported
-- 
2.30.2

