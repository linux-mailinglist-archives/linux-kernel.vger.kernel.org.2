Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C53CE3C3D47
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 16:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbhGKOSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 10:18:02 -0400
Received: from pv50p00im-zteg10011401.me.com ([17.58.6.41]:37998 "EHLO
        pv50p00im-zteg10011401.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233036AbhGKOSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 10:18:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1626012914; bh=JQUQaso2/FVgy/nNGEdoD9wGggaERJQPREhyo5D3rys=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=HWmdlwuSTcGOMQoO5r2iTLXQMaw6yfqQslqf782yxFngwLsE/5r1I5wl+IRbV8NBo
         artF8LnbO8jCGx7QTRUwpkvEZmQNlJB1FuzahrP5sj0z4HViLhZeUGcHz7Fr8xdMY2
         5S8g6o+6SHm8ZAh/8XWbj66Z/fnm3LJPfFJpqeB9tllJp2JodpUk4tdDk/i6TYqaCX
         U7Z1lChF9wsXGZY3xA/+M34WtAFeL1JIY8h2CTRINOkkSO4rM0OcCVjPK9kYEXSCRQ
         cl4VRT8Pp06Klqxfh5BHV5T+nnLEMJlrM/VrfBxNMzGrxMQ5lPO/ivGubEMQWFsJ9f
         Ikzlts9BDa6Lw==
Received: from xiongwei.. (unknown [120.245.2.75])
        by pv50p00im-zteg10011401.me.com (Postfix) with ESMTPSA id 066739002D4;
        Sun, 11 Jul 2021 14:15:10 +0000 (UTC)
From:   Xiongwei Song <sxwjean@me.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH v1 3/3] locking/lockdep,doc: Correct the max number of lock classes
Date:   Sun, 11 Jul 2021 22:14:30 +0800
Message-Id: <20210711141430.896595-3-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210711141430.896595-1-sxwjean@me.com>
References: <20210711141430.896595-1-sxwjean@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-11_09:2021-07-09,2021-07-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=849 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2107110118
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongwei Song <sxwjean@gmail.com>

The max number of lock classes is 8192.

Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/locking/lockdep-design.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/locking/lockdep-design.rst b/Documentation/locking/lockdep-design.rst
index 82f36cab61bd..5c2dcec684ff 100644
--- a/Documentation/locking/lockdep-design.rst
+++ b/Documentation/locking/lockdep-design.rst
@@ -341,7 +341,7 @@ Exceeding this number will trigger the following lockdep warning::
 
 	(DEBUG_LOCKS_WARN_ON(id >= MAX_LOCKDEP_KEYS))
 
-By default, MAX_LOCKDEP_KEYS is currently set to 8191, and typical
+By default, MAX_LOCKDEP_KEYS is currently set to 8192, and typical
 desktop systems have less than 1,000 lock classes, so this warning
 normally results from lock-class leakage or failure to properly
 initialize locks.  These two problems are illustrated below:
@@ -383,7 +383,7 @@ you the number of lock classes currently in use along with the maximum::
 
 This command produces the following output on a modest system::
 
-	lock-classes:                          748 [max: 8191]
+	lock-classes:                          748 [max: 8192]
 
 If the number allocated (748 above) increases continually over time,
 then there is likely a leak.  The following command can be used to
-- 
2.30.2

