Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1E7440278A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 13:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244829AbhIGLFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 07:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbhIGLFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 07:05:30 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF695C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 04:04:24 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id q22so3078650pfu.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 04:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d1ZWsvsllMtqufgBHUGiy/SAtXm8gBcPAywxqyHOyHk=;
        b=ehxnh0lg6+0W9nDxMNa2CgR142P0y0EWnpXJhk5soeyzsZ59vwa8Eq8JSrX243VdB8
         otCTjdaTobbyItJ29QJzj1lW81FxFo0kGhqk/YGGDP419X23N8W6am6iduvDT4pTLri6
         M1PXJBDHPHgB8uUXsiIqK3Tq/SJYQSS4rZNUPBvtgMcECtWgTY2sG9WI9ditMIPTf2f+
         3zBH2Xj/AT6QE+Ss366KnRNt5b4uyhk8rnYSBDPSvxfdz8LN2e2a/r74YFcF5w5Rc4hb
         ojaGP1kBX5R8LoL/++KClk6dl610rmy4GZtetLT9FN6qR/Ukod2hOnkp58a4jLsqS+Cg
         87Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d1ZWsvsllMtqufgBHUGiy/SAtXm8gBcPAywxqyHOyHk=;
        b=Cx8U3SYfg01MYmFcH/IfCyl+KhDyrfd3zKV9PTUL/7Ro3F4ZXxTYrsTZOQ1Y4zBxmx
         Iap8xOruRQKHeSBDGnsyJgV2Rfz+FcyVAgWnlSVtQ+jyFDVsqgcmhDu7ID7XWi5DHEYx
         N4Ojk8ZSEFKxLSTwnCL6D8BSkHFxONAuWpI4EPtueDnZZPjtEFwCZ0lYT+SbNxG3XFlg
         dk52qKGVQ1aePA+gTQilnxEMDaZKTUggB+h8QqZGDYKxDjVdfapEpKwPvXy85qzmrlxR
         M4sDRpIHTaI86dRcxeLOQaLxOhbO0GLZftJX7+ig7TkQjcQQeYABAF9cvvEzQk6kR5aD
         oxaQ==
X-Gm-Message-State: AOAM531ocEEC2U48Z+nN9xpjCjLtcPP3Qv1Qkau5ECZR1blFSJa7wFDI
        uEcDuHTGCcJ9Ayvrm3cUOxp9ADw1sufgJw==
X-Google-Smtp-Source: ABdhPJzhLiVCFQSb48H2l3spvPe7t2GiK0rzgSSCkJ26CHtSSIf2MtJ5R+4FNHnYL9LxKkcCth1a2g==
X-Received: by 2002:aa7:8610:0:b0:3fc:8645:509b with SMTP id p16-20020aa78610000000b003fc8645509bmr16101835pfn.44.1631012664316;
        Tue, 07 Sep 2021 04:04:24 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:6006:a148:d252:a9a3:a10e:5424])
        by smtp.googlemail.com with ESMTPSA id n15sm10969186pff.149.2021.09.07.04.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 04:04:23 -0700 (PDT)
From:   Utkarsh Verma <utkarshverma294@gmail.com>
To:     Andy Whitcroft <apw@canonical.com>
Cc:     Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org,
        Utkarsh Verma <utkarshverma294@gmail.com>
Subject: [PATCH] checkpatch: remove unused function uniq
Date:   Tue,  7 Sep 2021 16:33:43 +0530
Message-Id: <20210907110343.9330-1-utkarshverma294@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function uniq is not used anywhere.
Earlier it was used to remove the duplicate messages, when the
--list-types option was used. But after 'commit 52178ce01335 ("checkpatch:
add verbose mode")', it is not used anymore. So remove it.

Signed-off-by: Utkarsh Verma <utkarshverma294@gmail.com>
---
 scripts/checkpatch.pl | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 461d4221e4a4..44fbc4617394 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -145,11 +145,6 @@ EOM
 	exit($exitcode);
 }
 
-sub uniq {
-	my %seen;
-	return grep { !$seen{$_}++ } @_;
-}
-
 sub list_types {
 	my ($exitcode) = @_;
 
-- 
2.25.1

