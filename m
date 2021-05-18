Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7AA38749A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 11:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347700AbhERJGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 05:06:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:36310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347059AbhERJGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 05:06:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3209761209;
        Tue, 18 May 2021 09:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621328736;
        bh=IM5NhaVNLdnTl/c0Hva53kexF4GIAfDK3JsXGk38oVw=;
        h=From:To:Cc:Subject:Date:From;
        b=r8+FRGmS/9jbwmmJkTSz1W5UfNRn33f+MlK7+SjhrtxMF8e838smb/hXFr0PLLm9T
         qZtBtM8q1XSrW6RFsbqBjElPXbgaYEjNCy6uERcuGC6Rte3plj6RKidaDZkgCkFLkK
         phpJN4/IOzaBQAUl3DLVPuT3Q6y8xo8oTy8lHVwiWrdXDN/GUPAcOuCJjsCFUfUigd
         Iad681QinsSLa8AvsQ39wZMFYvJcy9HuUVhe24uaRUmenQC2zCUVr1Hvq2XeAf9VLY
         NVzSV+vBXAKREEWH3X1cX8UqnuS9U6ZUiDDg2xGtqRvUn6HwFB4aGC+nQGEU+lTHTG
         Cc1jIFU6fPOVQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1livfO-006zQ3-6E; Tue, 18 May 2021 11:05:30 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Gilles Muller <Gilles.Muller@inria.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scripts: coccicheck: fix troubles on non-English builds
Date:   Tue, 18 May 2021 11:05:26 +0200
Message-Id: <1d3320d81fd7db23beaaea78888c389ab5f85ab8.1621328716.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When LANG is not set to English, the logic which checks the
number of CPUs fail, as the messages can be localized, and
the logic at:

    THREADS_PER_CORE=$(lscpu | grep "Thread(s) per core: " | tr -cd "[:digit:]")

will not get the number of threads per core.

This causes the script to not run properly, as it will produce
a warning:

	$ make coccicheck COCCI=$PWD/scripts/coccinelle/misc/add_namespace.cocci MODE=report drivers/media/
	./scripts/coccicheck: linha 93: [: número excessivo de argumentos

Fix it by forcing LANG=C when calling lscpu.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/coccicheck | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index 65fee63aeadb..caba0bff6da7 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -87,7 +87,7 @@ else
     fi
 
     # Use only one thread per core by default if hyperthreading is enabled
-    THREADS_PER_CORE=$(lscpu | grep "Thread(s) per core: " | tr -cd "[:digit:]")
+    THREADS_PER_CORE=$(LANG=C lscpu | grep "Thread(s) per core: " | tr -cd "[:digit:]")
     if [ -z "$J" ]; then
         NPROC=$(getconf _NPROCESSORS_ONLN)
 	if [ $THREADS_PER_CORE -gt 1 -a $NPROC -gt 4 ] ; then
-- 
2.31.1

