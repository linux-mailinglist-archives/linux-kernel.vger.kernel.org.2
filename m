Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E99130F80A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 17:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237046AbhBDQeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 11:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238146AbhBDQd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 11:33:26 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF39C061788
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 08:32:45 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id 7so4315084wrz.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 08:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=yFK+1MV3m0cXtRceuXKqnLy2r2w69ziUIu2mcYHCeP8=;
        b=Ti2FiS0Gse4C2Jz5tafEqiwdl22BoyaRWSkwfAPqGsEj4UpC3HKkuwbllggqVffsmL
         Ipm0NRxqROFF3+EdE+4ETzRl49fpw6pQ8x6unN+6RpL6aqJG6cA07zb7OhiZ7KiUkrEu
         jj/CmrbdFMT+OtJzCmvXW4FeSjWs/ZpBkDdng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=yFK+1MV3m0cXtRceuXKqnLy2r2w69ziUIu2mcYHCeP8=;
        b=m/2ivDkdg32gKhA/KSLrC6i/CEUsnTZ6X8IJ1XFxyPNZwbxLuEJ4PuIXS7NZiAOuCe
         U10yAKPGvXpqE4NaJ0O9eFd08xK8oj2URxLUHdYw3d6yzCt5J8/Z9GOwYr1PDQjHBNsK
         BIJ+WwLAe9Oz0i6VDAWhecygGKW7f8R+0X/sJSqI/sfH5k9Lqy5w0fhnAX/MohzLWXYZ
         3BBcZ6E1iTXOSnU4ufj29bSPrq2X13zMi7Jxu55B1yz01UELTsXWfEWvpGm/FVrBt6/h
         nPhv7lc2lPGjdQ3ai3adKoV0JVCJVfybbTmP1gHJLvJls+NNAP324QgNeXJpCCdILxo7
         Xt9g==
X-Gm-Message-State: AOAM530234CUEXDKVqDAbZRc9PrGP5jxOBn9wBTGeUAhAyoB1TPkttHk
        4lFtjscQ3HoKTgSRH852W58FVw==
X-Google-Smtp-Source: ABdhPJxcOpShSPrft7TF0SBKswX3MoQqgRczF9Bq+f9/NxxXThyuA9OUEmw5G2WKxDcOmK9+hvk7xA==
X-Received: by 2002:a5d:5005:: with SMTP id e5mr202698wrt.82.1612456363231;
        Thu, 04 Feb 2021 08:32:43 -0800 (PST)
Received: from localhost ([2a01:4b00:8432:8a00:63de:dd93:20be:f460])
        by smtp.gmail.com with ESMTPSA id p5sm5923205wmq.3.2021.02.04.08.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 08:32:42 -0800 (PST)
Date:   Thu, 4 Feb 2021 16:32:42 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH] checkpatch: Don't warn about colon termination in linker
 scripts
Message-ID: <YBwhqsc2TIVeid3t@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This check erroneously flags cases like the one in my recent printk
enumeration patch[0], where the spaces are syntactic, and `section:' vs.
`section :' is syntactically important:

    ERROR: space prohibited before that ':' (ctx:WxW)
    #258: FILE: include/asm-generic/vmlinux.lds.h:314:
    +       .printk_fmts : AT(ADDR(.printk_fmts) - LOAD_OFFSET) {

0: https://lore.kernel.org/patchwork/patch/1375749/

Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 4f8494527139..3bcffc5574ae 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5046,7 +5046,7 @@ sub process {
 				# A colon needs no spaces before when it is
 				# terminating a case value or a label.
 				} elsif ($opv eq ':C' || $opv eq ':L') {
-					if ($ctx =~ /Wx./) {
+					if ($ctx =~ /Wx./ and $realfile !~ m@.*\.lds\.h$@) {
 						if (ERROR("SPACING",
 							  "space prohibited before that '$op' $at\n" . $hereptr)) {
 							$good = rtrim($fix_elements[$n]) . trim($fix_elements[$n + 1]);
-- 
2.30.0

