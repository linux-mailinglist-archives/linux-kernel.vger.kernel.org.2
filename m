Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE5632FD01
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 21:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbhCFUIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 15:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbhCFUHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 15:07:50 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64B0C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Mar 2021 12:07:49 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id t13so3243232qta.11
        for <linux-kernel@vger.kernel.org>; Sat, 06 Mar 2021 12:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gzpByneoDkJg3MJrYQ4354sy3mr3VrFF8M1tj6LEHzI=;
        b=AS6FwllMDeuEXHAtzlT1eDnATHCAgDk+4ECymgYBvtdQ7Aixv0DVrjLeZ7snDRk2K1
         hXg40wbiemM2Hl3aIJ9rSP4qBlaSppI2I2rBTSZQDTMTki1L/+s4qfs5ndj4M85En0vA
         hKn9SnH51t8GUkTjy62nLdgnEZc+DoAIb4yiXTUtrEAWFucACoEkCm0WMvMHHrwMJe15
         FJsR9xvwcaVZrAJvN6zGc+NEJK9msoNaI+nnN39i8lunveM0YGBfjnBOYCXIy0nHtnUY
         msxf58sTmngevuqGOdX7V/EmSoBtbNNIFXPZv2WcrQkaQS2OH0bZ/r1sBnpE/NeAwNit
         9egQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gzpByneoDkJg3MJrYQ4354sy3mr3VrFF8M1tj6LEHzI=;
        b=mvALVZDTpLs8UhxuDWGP8U3P+KlSG4YT2lOxEuu6SWb9e1QtlmZwSBfXtcyebiC4g5
         A4C6yzvcqZVAcaBNf0p3HE0tJOS2xbzrpH18Np83KFHUxmWLgnC3kZ0kjC9ZMsM3BtMZ
         R7BIybnFKl9LBgAWBAhna8O8gQrcevIdOmdr/H9gensY3YZM1F85XqOpxnW2WHQwjkZu
         qkv4M9hYpMFGlzTXRMz12PCPhklko4QX6hLwl+I9KtkfHfm6opsEIdqMmDGv+t+/o6gn
         101gGDzV23IAyGlpp3MVrhH6NqAGNb2e7LZLSn2Y10Y8e3b/qvIoOsqFcnYROjywuakL
         TBrg==
X-Gm-Message-State: AOAM531ftj45KNGJQWKiaDyaXI+OT1Rrx58703tt86yO9fHa8LKghMAB
        eqHlOAMTld1IFT79tDuZWxE=
X-Google-Smtp-Source: ABdhPJwOKNwMpPNzj83qstahZs21WuEyQ5thg3OkWhWf0yfgAc6o/daNM7Jlf4TUF3uLXzerCcmf8Q==
X-Received: by 2002:ac8:4258:: with SMTP id r24mr14229765qtm.167.1615061267853;
        Sat, 06 Mar 2021 12:07:47 -0800 (PST)
Received: from darkstar.example.net ([2804:d45:9905:9600:c57:100:d8b8:6ad3])
        by smtp.gmail.com with ESMTPSA id c5sm4488658qkg.105.2021.03.06.12.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 12:07:47 -0800 (PST)
From:   Davidson Francis <davidsondfgl@gmail.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        Gilles Muller <Gilles.Muller@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     Davidson Francis <davidsondfgl@gmail.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] scripts: coccicheck: Fix chain mode in coccicheck
Date:   Sat,  6 Mar 2021 17:05:41 -0300
Message-Id: <20210306200541.3133-1-davidsondfgl@gmail.com>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As described in the Coccinelle documentation (Documentation/dev-tools/
coccinelle.rst), chain mode should try patch, report, context, and org
modes until one of them succeed.

It turns out that currently, the 'run_cmd_parmap' function, by failing
to run $SPATCH, rather than returning an error code, kills the execution
of the script by executing the exit command, rather than returning the
error code.

This way, when running coccicheck in chain mode, as in:
    $ make coccicheck MODE=chain

the first .cocci file that does not support one of the virtual rules
stops the execution of the makefile, rather than trying the remaining
rules as specified in the documentation.

Therefore, modify the coccicheck script to return the error code,
rather than terminating the script. When returning the error code,
it returns the same value obtained in run_cmd, instead of the
generic value '1'.

Signed-off-by: Davidson Francis <davidsondfgl@gmail.com>
---
Changes in v2:
* Use the same return value from run_cmd as the exit value

 scripts/coccicheck | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index 65fee63aeadb..165701657c5a 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -153,7 +153,7 @@ run_cmd_parmap() {
 	err=$?
 	if [[ $err -ne 0 ]]; then
 		echo "coccicheck failed"
-		exit $err
+		return $err
 	fi
 }
 
@@ -251,14 +251,14 @@ coccinelle () {
 	run_cmd $SPATCH -D context \
 		$FLAGS --cocci-file $COCCI $OPT $OPTIONS               || \
 	run_cmd $SPATCH -D org     \
-		$FLAGS --cocci-file $COCCI $OPT $OPTIONS --no-show-diff || exit 1
+		$FLAGS --cocci-file $COCCI $OPT $OPTIONS --no-show-diff || exit $?
     elif [ "$MODE" = "rep+ctxt" ] ; then
 	run_cmd $SPATCH -D report  \
 		$FLAGS --cocci-file $COCCI $OPT $OPTIONS --no-show-diff && \
 	run_cmd $SPATCH -D context \
-		$FLAGS --cocci-file $COCCI $OPT $OPTIONS || exit 1
+		$FLAGS --cocci-file $COCCI $OPT $OPTIONS || exit $?
     else
-	run_cmd $SPATCH -D $MODE   $FLAGS --cocci-file $COCCI $OPT $OPTIONS || exit 1
+	run_cmd $SPATCH -D $MODE   $FLAGS --cocci-file $COCCI $OPT $OPTIONS || exit $?
     fi
 
 }
-- 
2.29.1

