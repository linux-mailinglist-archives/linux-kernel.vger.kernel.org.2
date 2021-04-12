Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC8F35D2EA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 00:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343629AbhDLWLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 18:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237058AbhDLWLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 18:11:11 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF493C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 15:10:52 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id u21so22735823ejo.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 15:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=u7+A9611KX/d7fl+X0bn0fJuUM2MabKl/oMezRCEDg4=;
        b=UWAcdW5bLKKN4epwHUJhBrH4fx5j3AzTmTbC4DN2at8k5Rvzs1HGdD8QJJstQErfQ3
         jHNQNSyKutP/vuQi3TkqDpE+mGp4wyi40Sf8XghT/Y1zxTOYJg1b/MtOzGpMmJKzMmIi
         kddm/qtxXYmpJBdr8GKFckUxH/1sS8BRI8y+nhBgx/t2e4H8lDij9x68Yxr59di2/jv0
         9tzncrPkU4g9NdZ94d5Wh1ID9+ICpLjrX4osjU7s/GXPJZM5L5E91F8zF6atDbKNjmOF
         UXV8+DCYPhZS12bPHFeIgVFLjaTxFK6Y7DXvrCVcpouqd9aRm/UcYZyYqv+G/Zw7e/sx
         UkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=u7+A9611KX/d7fl+X0bn0fJuUM2MabKl/oMezRCEDg4=;
        b=dxFex/Y7mz88LTIeshTCaW+a4CpYTI1eVGH1Smqkuuep0hO+jZ/DnVPn3b3hqr6d2U
         Tn7S5vinx3ap0xtLr+MaWT/gFTm89PYeIyWY6w0ALgy5dJ1gOcfkbPfLTf9dqzM1cj8d
         MIHRbuYSyVUyZqc8Lroe8ndwB41et2FK6BRx0liUpwx2dJx2ANau8e6ImTritCIrwy6d
         ssaj4gUdsjBGzn3hvTqjMeYHIpuUiNCVa2TczMB1Ci+c2ru1SspE2DY8b0+1115+arTT
         aexDl7ahVLAJ0KDiPO3ee+EMIQAMUqdxNCIilSDxC6kXpVXm7PwQX9QKfiCkAPfgk28/
         nung==
X-Gm-Message-State: AOAM531TWaU9jVzFU6RJJdJM5qJK8uWmzycDZp/IgGrTxvL7h4dwMXPl
        i0GuK0Jk+KrUyGPgs0K09A==
X-Google-Smtp-Source: ABdhPJxwOFIb1J8kE4ECYCXx9jLm9jugErAfupyANlKAjuOUYzhBJLKwC9nGKwqcpW3tlvNf2b30GQ==
X-Received: by 2002:a17:906:b118:: with SMTP id u24mr2576388ejy.331.1618265451332;
        Mon, 12 Apr 2021 15:10:51 -0700 (PDT)
Received: from fedora ([46.53.253.95])
        by smtp.gmail.com with ESMTPSA id qo16sm4590107ejb.64.2021.04.12.15.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 15:10:50 -0700 (PDT)
Date:   Tue, 13 Apr 2021 01:10:49 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] IDE: support QT Creator
Message-ID: <YHTFaSEVBccTf9SJ@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add little script to generate QT Creator project files, so that parsing
and navigating codebase mostly works.

The important part is to run 'make prepare' before opening project
so that generated headers are picked up and clone&fixup coding style
in the editor to match kernel coding style.

Then run

	$ ./scripts/ide/qt-creator.sh xxx

from top-level directory

Note:
ibmvnic.c is excluded from project files to workaround libCPlusPlus crash.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 scripts/ide/qt-creator.sh |   49 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

new file mode 100755
--- /dev/null
+++ b/scripts/ide/qt-creator.sh
@@ -0,0 +1,49 @@
+#!/bin/sh
+# Copyright (c) 2021 Alexey Dobriyan <adobriyan@gmail.com>
+#
+# Permission to use, copy, modify, and distribute this software for any
+# purpose with or without fee is hereby granted, provided that the above
+# copyright notice and this permission notice appear in all copies.
+#
+# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+
+# Generate Qt Creator project files.
+set -eo pipefail
+
+test -n "$1" || { echo >&2 "usage: $0 project-name"; exit 1; }
+p="$1"
+
+filename="$p.cflags"
+echo "$filename"
+echo '-std=gnu89' >"$filename"
+
+filename="$p.config"
+echo $filename
+cat <<EOF >$filename
+#define __KERNEL__
+#include <linux/kconfig.h>
+EOF
+
+filename="$p.creator"
+echo $filename
+echo '[General]' >$filename
+
+filename="$p.cxxflags"
+echo $filename
+echo '-std=gnu++17' >$filename
+
+filename="$p.files"
+echo $filename
+# ibmvnic.c: workaround https://bugzilla.redhat.com/show_bug.cgi?id=1886548
+git ls-tree -r HEAD --name-only | LC_ALL=C sort | grep -v -e 'ibmvnic.c' >$filename
+
+filename="$p.includes"
+echo $filename
+echo 'include' >$filename
+for i in arch/*/include; do echo $i; done | LC_ALL=C sort >>$filename
