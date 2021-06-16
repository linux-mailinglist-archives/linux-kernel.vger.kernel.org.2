Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 643D83A9CE0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 16:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbhFPOFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 10:05:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41756 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbhFPOFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 10:05:30 -0400
Received: from mail-ed1-f72.google.com ([209.85.208.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <andrea.righi@canonical.com>)
        id 1ltW8Z-0007lV-8G
        for linux-kernel@vger.kernel.org; Wed, 16 Jun 2021 14:03:23 +0000
Received: by mail-ed1-f72.google.com with SMTP id h23-20020aa7c5d70000b029038fed7b27d5so1069773eds.21
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 07:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ulcePntEXh1DjVcMEcGKERN3uSnkzIPzKbXFTzr4xjw=;
        b=hiN+I+HVxxDdwaC2KXzJbaQCbZb3so3sG6WQ0/hhm8nwbqQug92Z+hb7Xrv27xLmC0
         JiyLeZGIS4/Vayr+HVAXrAkVeWFbO53/WYoOxohZ15tC9+ezw1C2H2RDDGEuSFkH2MZv
         BtJDxcvxGnvNuyF2RWZGmu7tP6pr1fhnz4Wkv+c5YFJK1mAsMR6G4V/D6QAMCNtf1eRy
         rnuGixaSq0vDx8oTtN2L9b3Kzd87B6ZkuA6gywhPgnT46Gho7DHb+AS/B3O3KwkRKnwc
         1B76/9+zUmr3QUz4Ftm7qH9mTebxJ1rRYwmUmvFBKLcBAzLLSEOSpynSnpbVR+Chma5X
         GytQ==
X-Gm-Message-State: AOAM531rjlKP3I+ynPlxezcqR85lRHyf6sdS1h62sVwNEucPLHH8xNfP
        X6vjH2PCUNi694HiteD03YAdMLU9u/dS5P2XJkalUJ34iTC8Phbd00LIobNy2y9wJht2yiRC3aG
        yOM6rW0JUOfTY5qkRvMbNnYh3lqKivIIakM21Ih3HpA==
X-Received: by 2002:a17:906:d0c9:: with SMTP id bq9mr5443090ejb.313.1623852202724;
        Wed, 16 Jun 2021 07:03:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhX/RfqULeqHuPnnvjuwgwmZQdILELg9ddA5TshSiRZRkWbfA+NJUX+hu9SaXOMBkG/zJ19Q==
X-Received: by 2002:a17:906:d0c9:: with SMTP id bq9mr5443065ejb.313.1623852202511;
        Wed, 16 Jun 2021 07:03:22 -0700 (PDT)
Received: from localhost (host-79-46-128-215.retail.telecomitalia.it. [79.46.128.215])
        by smtp.gmail.com with ESMTPSA id u21sm1604314ejm.89.2021.06.16.07.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 07:03:22 -0700 (PDT)
Date:   Wed, 16 Jun 2021 16:03:21 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Shuah Khan <shuah@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: net: veth: make test compatible with dash
Message-ID: <YMoEqdpCIQN209ty@xps-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

veth.sh is a shell script that uses /bin/sh; some distro (Ubuntu for
example) use dash as /bin/sh and in this case the test reports the
following error:

 # ./veth.sh: 21: local: -r: bad variable name
 # ./veth.sh: 21: local: -r: bad variable name

This happens because dash doesn't support the option "-r" with local.

Moreover, in case of missing bpf object, the script is exiting -1, that
is an illegal number for dash:

 exit: Illegal number: -1

Change the script to be compatible both with bash and dash and prevent
the errors above.

Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 tools/testing/selftests/net/veth.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/veth.sh b/tools/testing/selftests/net/veth.sh
index 2fedc0781ce8..11d7cdb898c0 100755
--- a/tools/testing/selftests/net/veth.sh
+++ b/tools/testing/selftests/net/veth.sh
@@ -18,7 +18,8 @@ ret=0
 
 cleanup() {
 	local ns
-	local -r jobs="$(jobs -p)"
+	local jobs
+	readonly jobs="$(jobs -p)"
 	[ -n "${jobs}" ] && kill -1 ${jobs} 2>/dev/null
 	rm -f $STATS
 
@@ -108,7 +109,7 @@ chk_gro() {
 
 if [ ! -f ../bpf/xdp_dummy.o ]; then
 	echo "Missing xdp_dummy helper. Build bpf selftest first"
-	exit -1
+	exit 1
 fi
 
 create_ns
-- 
2.31.1

