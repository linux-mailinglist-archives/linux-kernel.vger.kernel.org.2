Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF3C32C23A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387926AbhCCTfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 14:35:05 -0500
Received: from mout.gmx.net ([212.227.17.21]:52603 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245240AbhCCTW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 14:22:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614799216;
        bh=qcKzTKCSddo160zYY1C/zfO0rIDl0AEk7qhy2DrxVVA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=JBPimAXLZ/PHsuY+hki5hSIusNm6hLczQ+6tQAl/5Bop/lM2heeT18kqI5n3Spw8y
         iy1+EN1rWSqSYL2JvN+vg8hnWiUwGCt36ZMQVsF0TnvA5ITeAOnDOydbZ3K/7D7fOl
         eHU8fbCrFjVoKDWaPJspCp5nLIMSRcpOAw7ZH1eU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.134]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mwwdf-1m0j0N1rGl-00yPAK; Wed, 03
 Mar 2021 20:20:16 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Haren Myneni <haren@linux.ibm.com>,
        Petr Mladek <pmladek@suse.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] kthread: Switch to new kerneldoc syntax for named variable macro argument
Date:   Wed,  3 Mar 2021 20:20:10 +0100
Message-Id: <20210303192012.3109811-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RsKtgBsGu57qUHJyTesYQOrcQuPbd9pwhgafMMfIJRXHzBG8X/X
 3+9D4VYql5P9Qbjxko9HvElSP/02G7bu/Y8LWCHlPjSf2SmLOWbyglX9WlQ33PiKG3aVQMF
 honI+XpE4rcnL39/l7DdKLI49SVXrrXrnSQ9uNitM4vgj1jQxHIeql13mH+9ovbPMmPx4aC
 C7j6g4pGHzEvUAztA8Fww==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lpFK58kNTgU=:2kbL3CNxFRgtdJL3hnO+0/
 6o/pcFQo0SGF9eD53QEsdVxN4/L2uj2M2p7eh8jBXtkYlv5qw450TftjWcLxR25NFupwnmqK/
 OWGjKveOBgyJhI+OpOnx83rPrKAK+A57HuyWcHiwAlTq3A+vNFwFe3dBV5m+Hfi3bFYpWc6U3
 rQTdH2a/u9pJDODfO5A9A1rBuryZzkTZeLg+NdU1GplrJrSifppCfu3Gwd4fx9xyGKxttw4Bw
 C2TQ6ftlkpWPf0k+9EVI8VceQ0amCGAbYWsCBg0J7q45Mjpa/Dj0b1C39ifPVEDZ2HDkw6wag
 UEUUoCS6bBYWKJf4ZLkD13I+QToevbuuuh2eiv0fbVqgALFDt0hJgmNOsuTTFTUiqCpw7t9Zh
 /AaTZNyM3GFD05L3H/5PfC0u6f/H1pKZdaV4WnCd8r29Ilr72LpRwkJlyY4ifm0tKhs/yOGKC
 oD7e2PkO5tJGTyZ2cyRMUTxNSu3dr2hRRKZiwoJNt2Y1yUtGwLA1wYb33K7328lrSua8FAmnP
 Ba2uW0hIl6HWaAs75E+qfNpesJ2jBVlLvfbKikRLQSUfbt4Gx4OZDZ00cODeGCSxV8YIdlrMc
 puBXg2+5oOy1gLT2/nZr/Gr4dff5pEgAb4AVOwTITSTM5YQ2F5oU7Zaex5IMj3KsZo9ZB7kqX
 ETJqNzFoK5xcxN0KHgpiZVCh4Jj/uiB4Z2f3QlsttOabqXQmcNIU/vM2YNKoPEuxY4JcbJtWs
 vcCg6tZnN0tPWfwuSDxYQ6bAqMj1e2z229XmjL5oeuTggnzoTrkO2QlxrQKBZncOEn9TNtCfV
 zusr4FCM0EIkeOn1rGQY+lfdeLvLD789RUbeIMT88p8rW411pQ3Lfhc/H483NwahviD9TiaqH
 4UWKQeAVHvTAxuzRZb8w==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The syntax without dots is available since commit 43756e347f21
("scripts/kernel-doc: Add support for named variable macro arguments").

The same HTML output is produced with and without this patch.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 include/linux/kthread.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 2484ed97e72f5..db3eafea168ff 100644
=2D-- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -18,7 +18,7 @@ struct task_struct *kthread_create_on_node(int (*threadf=
n)(void *data),
  * @threadfn: the function to run in the thread
  * @data: data pointer for @threadfn()
  * @namefmt: printf-style format string for the thread name
- * @arg...: arguments for @namefmt.
+ * @arg: arguments for @namefmt.
  *
  * This macro will create a kthread on the current node, leaving it in
  * the stopped state.  This is just a helper for kthread_create_on_node()=
;
=2D-
2.30.1

