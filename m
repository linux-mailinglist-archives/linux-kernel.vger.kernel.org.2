Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5068E402800
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 13:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245186AbhIGLrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 07:47:52 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:45714 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243457AbhIGLru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 07:47:50 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210907114642epoutp036c0cc0ac8d26648ae2b951ce751f8a1d~ih69WuHsV0550005500epoutp03g
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 11:46:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210907114642epoutp036c0cc0ac8d26648ae2b951ce751f8a1d~ih69WuHsV0550005500epoutp03g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1631015202;
        bh=Q0+FaSETzHpzWVv0IEaYILCQdWqm5pSuLicbnvCJcrs=;
        h=From:To:Cc:Subject:Date:References:From;
        b=UTfLkszLw+B897ZqUMdcVdhbZIlBaj1O/yRxj2xyzF3gmc9v/+iwEr1QUiT+ZO0Oi
         sqReao5nQh3hwI2jxg52+jxdWFBvpSkCgypB2fZ8tdfyuLi+ixZBqj3xXPiS9/2A5k
         /tZtk1ZrSiKfcH+LywLNj6DqZChuadwfn2maF6sg=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20210907114641epcas5p4e5894961d1ef0958d1d98e3e453b3618~ih69Bj0rx0980409804epcas5p4d;
        Tue,  7 Sep 2021 11:46:41 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DD.5C.38346.12157316; Tue,  7 Sep 2021 20:46:41 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20210907114641epcas5p1d96f31466bd11399e98305865e05fc7e~ih68s0S_R2828128281epcas5p1_;
        Tue,  7 Sep 2021 11:46:41 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210907114641epsmtrp29f46e37575f90d62d68d28bb860e8065~ih68sQy0n2078020780epsmtrp2C;
        Tue,  7 Sep 2021 11:46:41 +0000 (GMT)
X-AuditID: b6c32a4b-251ff700000095ca-2f-61375121ea15
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        00.1E.09091.12157316; Tue,  7 Sep 2021 20:46:41 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210907114639epsmtip2fd04818242fd04ccde8414b4f45d1a1d~ih67IbAmI0705507055epsmtip2Z;
        Tue,  7 Sep 2021 11:46:39 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     apw@canonical.com, joe@perches.com, dwaipayanray1@gmail.com,
        lukas.bulwahn@gmail.com
Cc:     linux-kernel@vger.kernel.org, a.sahrawat@samsung.com,
        Maninder Singh <maninder1.s@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>
Subject: [PATCH v2] scripts/checkpatch.pl: remove _deferred and
 _deferred_once false warning
Date:   Tue,  7 Sep 2021 17:16:29 +0530
Message-Id: <1631015189-17053-1-git-send-email-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsWy7bCmhq5ioHmiwdlZ6hYXd6dafFirYbF+
        4TJmi9n3H7NYXN41h82i5Wg7i8Xh+W0sFodOzmV04PCY1dDL5rFz1l12jy+rrjF79G1Zxejx
        eZNcAGsUl01Kak5mWWqRvl0CV8aRI0EFdwQrJm9PbGBs5e9i5OSQEDCRuHuym7WLkYtDSGA3
        o8SDxa+YIJxPjBLT27awQDjfGCXenj/ABNNy/HoTM0RiL6PE/MYz7BDOF0aJpU9fMoNUsQno
        SazatYcFxBYRiJLoWnaWEaSIWaCLUWL1nu1gRcICcRIXZpxgBbFZBFQlPj64DmbzCrhLXG7c
        DLVOTuLmuU6wdRIC69glFv+9B5VwkTi5Yy8rhC0s8er4FnYIW0ri87u9bBAN3YwSG7qPsUA4
        MxglPh+8yghRZS/x5OJCoG4OoJs0Jdbv0gcJMwvwSfT+fsIEEpYQ4JXoaBOCqFaVaLm5AWqX
        tMTnjx9ZIGwPiT+tq8DKhQRiJe4v1pnAKDMLYeYCRsZVjJKpBcW56anFpgXGeanlesWJucWl
        eel6yfm5mxjBca7lvYPx0YMPeocYmTgYDzFKcDArifD+NTdLFOJNSaysSi3Kjy8qzUktPsQo
        zcGiJM6r+0omUUggPbEkNTs1tSC1CCbLxMEp1cAUaHz1l8KpaMkDBSIykj+fzkvaJ1h3tH99
        +JPZ7HeZDAurj2Zeq5XTmizs6rGqyGXzq2yzTt/9byfur9YQWrH7lOESn69fwsTtbLae/WbT
        aBevvaLqRnWg9rOduwwOaOipGmlcutZQcc8wbbf1bqZVuyfOTloXwrr7sOyZpCR9hvMpDDc3
        3F0/MZjvqn3Mzi8e98yyS3xOavVbHsxptJ0ia/dCrv7lnclmEj6zDL9IfNyo/YbpYvKnjLgb
        Qv/PRGvURAbNXmdhc/fTr5OvJzxLvHFwVbxgxLM9eqffOXZfvPfn8rWftd92tHc09r8/n3nP
        YknhzKvmRRxy/OF9clES+7ufyFXsrck9tfTi+wN/lFiKMxINtZiLihMBhaNy1mIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkluLIzCtJLcpLzFFi42LZdlhJXlcx0DzRoK+H3+Li7lSLD2s1LNYv
        XMZsMfv+YxaLy7vmsFm0HG1nsTg8v43F4tDJuYwOHB6zGnrZPHbOusvu8WXVNWaPvi2rGD0+
        b5ILYI3isklJzcksSy3St0vgyjhyJKjgjmDF5O2JDYyt/F2MnBwSAiYSx683MXcxcnEICexm
        lNh97D4rREJa4ue/9ywQtrDEyn/P2SGKPjFKHFoyCSzBJqAnsWrXHjBbRCBOYvLRJWCTmAX6
        GCUWfpjIBJIQFoiReH5iCVgRi4CqxMcH18E28Aq4S1xu3MwEsUFO4ua5TuYJjDwLGBlWMUqm
        FhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIEh5KW5g7G7as+6B1iZOJgPMQowcGsJML719ws
        UYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQamVU2JWz6J
        ii+4teDp6n1iZ069NzB/I36oNTH9osPNQm2nVLNLE2ex1u87Z7w1nLfQY87LV0uNFljM8/9g
        e15l+7XPTM3bf3PWPo25+ra1VNzv64S/14K33Wm2mfz7xByPNz8KizZ5d1xV+3ww3r/pdLSL
        xAGWz32zyg0vBX5nmnnxErd6KB/nBL/PzWcm34hwS2r2+ROwyfRo/Rf+62c+fbo41ZHxQWPG
        /KqG23OvypzLE0sUkak4JVvyTYQ/9/LlFW4fjQqv/qpqduvmb9nJf7QmqV6/+6nK9MzWPYxT
        V8+xMxL13ms9ydB+maBchaiX/p0v+7Zp5iY2BE+Pj5UI2up4zG6KQ5Roa1dM4DQOJZbijERD
        Leai4kQAtL18+ZQCAAA=
X-CMS-MailID: 20210907114641epcas5p1d96f31466bd11399e98305865e05fc7e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20210907114641epcas5p1d96f31466bd11399e98305865e05fc7e
References: <CGME20210907114641epcas5p1d96f31466bd11399e98305865e05fc7e@epcas5p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

printk_deferred and printk_deferred_once require LOGELVEL in argument,
but checkpatch.pl reports it as warning:

WARNING: Possible unnecessary KERN_ALERT
printk_deferred(KERN_ALERT "checking deferred\n");

As suggested by Andy, made 2 functions from logFunctions
1. logFunctions: with all checks
2. logFunctionsCore: without printk(?:_ratelimited|_once|_deferred_once|_deferred)
   checks

Call logFunctionsCore instead of logFunctions for checking of LOGLEVEL,
which will exclude checking of printk(?:_ratelimited|_once|_deferred_once|_deferred).

This way, there is no need to maintain same stanza at places for removing
printk flavours.

Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Signed-off-by: Vaneet Narang <v.narang@samsung.com>
---
v1 -> v2: made 2 functions to remove _deferred_once also
	as suggested by Andy Whitcroft.

 scripts/checkpatch.pl | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 161ce7fe5d1e..ebad442f29a0 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -559,8 +559,7 @@ our $typeTypedefs = qr{(?x:
 
 our $zero_initializer = qr{(?:(?:0[xX])?0+$Int_type?|NULL|false)\b};
 
-our $logFunctions = qr{(?x:
-	printk(?:_ratelimited|_once|_deferred_once|_deferred|)|
+our $logFunctionsCore = qr{(?x:
 	(?:[a-z0-9]+_){1,2}(?:printk|emerg|alert|crit|err|warning|warn|notice|info|debug|dbg|vdbg|devel|cont|WARN)(?:_ratelimited|_once|)|
 	TP_printk|
 	WARN(?:_RATELIMIT|_ONCE|)|
@@ -569,6 +568,11 @@ our $logFunctions = qr{(?x:
 	seq_vprintf|seq_printf|seq_puts
 )};
 
+our $logFunctions = qr{(?x:
+	printk(?:_ratelimited|_once|_deferred_once|_deferred|)|
+	$logFunctionsCore
+)};
+
 our $allocFunctions = qr{(?x:
 	(?:(?:devm_)?
 		(?:kv|k|v)[czm]alloc(?:_array)?(?:_node)? |
@@ -6252,8 +6256,7 @@ sub process {
 		}
 
 # check for logging functions with KERN_<LEVEL>
-		if ($line !~ /printk(?:_ratelimited|_once)?\s*\(/ &&
-		    $line =~ /\b$logFunctions\s*\(.*\b(KERN_[A-Z]+)\b/) {
+		if ($line =~ /\b$logFunctionsCore\s*\(.*\b(KERN_[A-Z]+)\b/) {
 			my $level = $1;
 			if (WARN("UNNECESSARY_KERN_LEVEL",
 				 "Possible unnecessary $level\n" . $herecurr) &&
-- 
2.17.1

