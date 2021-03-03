Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF7732C22B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387834AbhCCTeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 14:34:23 -0500
Received: from mout.gmx.net ([212.227.17.22]:44005 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233691AbhCCTSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 14:18:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614799004;
        bh=+Xi60gtp6wEdgy6SzabHz5FEMHwalRSkrp3y+e8hoFo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Wj6w1+ICJkkc5wrpgy6n6Yz3EQiTHO3lov6MTWYkZMa1T8HiO5PGs3cf22wvVYjrV
         HKGbAHBWiMs1uhLs1UlnzkywBKF1NvJMvlSer36V+J7jSoumsZ+vQy7VgpdvJnzIR5
         R3P+AudYtRsxz3HIbnePaIO6sCXCWIrU/2cGBgzo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.134]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MryTF-1lc0Mw3pnZ-00nyHi; Wed, 03
 Mar 2021 20:16:43 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH] workqueue: Switch to new kerneldoc syntax for named variable macro argument
Date:   Wed,  3 Mar 2021 20:16:38 +0100
Message-Id: <20210303191639.3108237-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eIIcuzr6jU5uOHWO6vfYQ8x6v4LBOyprTT6AasB8xL0zYo8T6TO
 tHd69zCu2LTallvljEYJjW7OnWIzjGsPOJ89O1N7jnVWpiOlh+o/7aHsvfMDTgMDt7OzXJY
 Qbz+5VxMrxuiT+pnN0oSzPfNzn6VB5nCYTQmGcWVSy02yLbBue+s/lrEKYTEmxqkPnuwLnC
 lm+Qg77GsKcuo2MeRaBIA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DJwJw2nNe2I=:W+HE5XKtfY7y4470EIydtD
 fT8GHIrKXnQ+Kv6GjDaCiM/XW7IuWwDhxAE59pU8t8nO/c2jAK67qQbciSD6KKdeN3F3yctDW
 IEDOf6LNsddUdX2v5BNjzWO32kzP8HmUb6lpBlgOXLaaqAat0j3pCaeFgJHUPHiuyK4F2/azV
 I+cJ/Or3ZgsFdRIxCZTVnsBAhP1yofcG9CEwV6Lpk6gvLmHRmYJwMjoxqA6z2SIMjiWVl2wBC
 87z9/NVuglRUY1+2BA5wT9jlpKAKOyW5fgYjkM9HHDPwWgCPANlNBJlkDlkp8BId0L1Z9ElXT
 1oJ8vUTaE6xL4Cyia/SVmzPvaDlD3ML+gbwUS7UIg68GnqqjzI6neRRQeUIA1ffVs69c9afbn
 tWjKJszQW0xfvmHzAI8HS4yLj+1fP4nz1+YoldQ31eiLncnGWlqbcoOsKJXhAfx1gNJTIjeQJ
 M3o8oNUzHKqvJekUOgeZ+H465G49VKFr5Iz3uNzZCOhnGa5g7m6rjJ8p4JuSmOGxH0qGb9rtB
 /7rtw7dLEweixkeG+PJwHwdRQ99AF1891HBhic+S/A8ikWCXb19w03fflkEPxtDg9OYxjSRNn
 OIaYpXFlVJgvQc3Z3rlCuBr4c4/Sr0idt5/hYF/uUirQ2vpYIhCajL8azz/KTemXDrzIwQJoe
 YhZOUMayAdRXpaIU+e9lcMhncES/eT0OqdsR7IQRM+HhFZWyxrGZ7fTDqtzNe/JlntX0v62BG
 m8gJMxgvIe1ayJBSJ/QV0KTPdupeqmV0MAbuu4YaI5IUO/4MnC6kErRLFWvJQsdpygb7hkmTQ
 8D7525wosb1nHMqIhbmJcbGCcA7q8RZDkKpVl+GTCnxxVogf6KmzHBqi/h/9hzDpTnNycatgq
 LYORbtSr7lGpgUgW/fnQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The syntax without dots is available since commit 43756e347f21
("scripts/kernel-doc: Add support for named variable macro arguments").

The same HTML output is produced with and without this patch.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 include/linux/workqueue.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index d15a7730ee18b..83a51c5100e68 100644
=2D-- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -412,7 +412,7 @@ struct workqueue_struct *alloc_workqueue(const char *f=
mt,
  * alloc_ordered_workqueue - allocate an ordered workqueue
  * @fmt: printf format for the name of the workqueue
  * @flags: WQ_* flags (only WQ_FREEZABLE and WQ_MEM_RECLAIM are meaningfu=
l)
- * @args...: args for @fmt
+ * @args: args for @fmt
  *
  * Allocate an ordered workqueue.  An ordered workqueue executes at
  * most one work item at any given time in the queued order.  They are
=2D-
2.30.1

