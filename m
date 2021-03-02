Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7994432AE4F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1838111AbhCBXEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 18:04:31 -0500
Received: from mail.lindev.ch ([5.39.83.55]:48420 "EHLO mail.lindev.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2360342AbhCBWTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 17:19:33 -0500
X-Greylist: delayed 390 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Mar 2021 17:19:32 EST
Received: from lindev.ch (unknown [87.122.230.249])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bero@lindev.ch)
        by mail.lindev.ch (Postfix) with ESMTPSA id A1E5D3FDB5;
        Tue,  2 Mar 2021 23:12:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lindev.ch; s=dkim;
        t=1614723132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TUxpnoeeEAmGStcGyZVTJQci34Njw6wuoLazbxteiW8=;
        b=wtKjSnC3gNfEJtvMAGPqt8lHrnQ0v0rHJvBXa1w87prkCqiFFsKCg54SdVGtGADwzaHzkc
        FPtel9tRrC9keBhASU94jqII0kk8+IwRiAlCi1aGkUWCMo210Luk54fDHoIaGLvGARXNSY
        lRGWH64U1+zxlqhUTpEK6NENrj8XyBk=
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@lindev.ch>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@lindev.ch>
Subject: [PATCH] Fix ld-version.sh script if LLD was built with LLD_VENDOR
Date:   Tue,  2 Mar 2021 23:12:11 +0100
Message-Id: <20210302221211.1620858-1-bero@lindev.ch>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If LLD was built with -DLLD_VENDOR="xyz", ld.lld --version output
will prefix LLD_VENDOR. Since LLD_VENDOR can contain spaces, the
LLD identifier isn't guaranteed to be $2 either.

Adjust the version checker to handle such versions of lld.

Signed-off-by: Bernhard Rosenkränzer <bero@lindev.ch>
---
 scripts/ld-version.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/scripts/ld-version.sh b/scripts/ld-version.sh
index a463273509b5..4c042a306e22 100755
--- a/scripts/ld-version.sh
+++ b/scripts/ld-version.sh
@@ -49,6 +49,18 @@ elif [ "$1" = LLD ]; then
 	min_version=$lld_min_version
 	name=LLD
 	disp_name=LLD
+elif echo "$@" |grep -q ' LLD '; then
+	# if LLD was built with -DLLD_VENDOR="xyz", it ld.lld --version
+	# says "xyz LLD [...]". Since LLD_VENDOR may contain spaces, we
+	# don't know the exact position of "LLD" and the version info
+	# at this point
+	while [ "$1" != "LLD" ]; do
+		shift
+	done
+	version=$2
+	min_version=$lld_min_version
+	name=LLD
+	disp_name=LLD
 else
 	echo "$orig_args: unknown linker" >&2
 	exit 1
-- 
2.30.1

