Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B863EAE58
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 04:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236910AbhHMCAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 22:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbhHMCAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 22:00:30 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE4EC061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 19:00:04 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id cp15-20020a17090afb8fb029017891959dcbso18403854pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 19:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=ybEye3erQCPfxRHTMkvZ/e1edKMy3xAgKOf7xkRwPvg=;
        b=JUI2zm4v7yCcwYaCGhjNlBcAfc5deUJDbYG9DBZyM5BWS7TF8XVgaYgp+eT/tq1+kz
         fgfSg9DxhNeO3Eot91XANkOScdRkqxJbdVzwlf2UTmkmWruw608v3ObZ3Jq3XKlRw7BW
         CAXtDktR4+2JPJAkcuqA4Y08qUx+VowDQR6hZzD5LR8Vs0uR/+AhlOqVTfR4wKt7kW4e
         1+j7N336WuzVy5ZdePxCt7nfVoyiEL9SL2w8O6EMvRJyyIn/yal+XLe2iaEtSIgb5S1T
         pX8xkEfX5DfqH3v86bSf+BiqmFT8GuB+rBQV22z5qmumSDoHjLWbgQVOn63zdQk+5+JN
         s/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=ybEye3erQCPfxRHTMkvZ/e1edKMy3xAgKOf7xkRwPvg=;
        b=l/pfBU9SdHzYKxnlJef7WZsbhIB5gPgASl8uER2PiwO8dmd1F9IAr8Rst81LYGHzru
         d/psZJONxUG2rSuNV2gawVs15xhyEy5AvqGRub6O+LPaJixNAqUIwa/SDV5ILUA2iD57
         J49tmAwmC7jlsOIK1euhC621jOtPAPBQmgWfPEPq+ZnGSKMySlOkx+Cv1rlb4kyG4enR
         EJhgIhRbQasIaT8lQfPpcpzr9fII0rgyPltBK9Fic3+9nlj3zOAcD1No8e0ki1OaYus7
         15hs7/yjXfisgg5hTrQ116gf6EOUgENNxOGNkDc4E8Hdd1mTNUaq5rNg2v1HQ/UVGNNp
         PDmA==
X-Gm-Message-State: AOAM5305E/cPjx4jM/7f3DCqicbGO990LmKVdqqAZX/FwtdS97k0HZc+
        AqFHYsD7aO4jOwhBZxp87fE=
X-Google-Smtp-Source: ABdhPJxleBEI2b02jwlblqKGiBSThKU4pGnT2xD+wIsOCnNWbzqbHACHogeIwvyrRncu6H7ZccNzVg==
X-Received: by 2002:a63:2152:: with SMTP id s18mr28001pgm.25.1628820004254;
        Thu, 12 Aug 2021 19:00:04 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id s36sm157434pgk.64.2021.08.12.19.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 19:00:03 -0700 (PDT)
Subject: [PATCH] checkpatch: Fix MACRO_ARG_REUSE false positives for offsetof
 and sizeof_field
From:   Alexander Duyck <alexander.duyck@gmail.com>
To:     apw@canonical.com, joe@perches.com, dwaipayanray1@gmail.com,
        lukas.bulwahn@gmail.com
Cc:     linux-kernel@vger.kernel.org
Date:   Thu, 12 Aug 2021 19:00:02 -0700
Message-ID: <162881998124.70219.4038998149078838864.stgit@localhost.localdomain>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Duyck <alexanderduyck@fb.com>

The MACRO_ARG_REUSE check was generating false positives when run against
macros that made use of offsetof and sizeof_field. This was due to the fact
that the type variable was not being checked for and as a result they were
not being stripped from the final use count for the macro argument.

Reproduction steps below:
  # ./scripts/checkpatch.pl --strict --no-tree -types MACRO_ARG_REUSE \
	-f drivers/net/ethernet/intel/igb/igb_ethtool.c
CHECK: Macro argument reuse '_stat' - possible side-effects?
  #27: FILE: drivers/net/ethernet/intel/igb/igb_ethtool.c:27:
  +#define IGB_STAT(_name, _stat) { \
  + .stat_string = _name, \
  + .sizeof_stat = sizeof_field(struct igb_adapter, _stat), \
  + .stat_offset = offsetof(struct igb_adapter, _stat) \
  +}

  CHECK: Macro argument reuse '_net_stat' - possible side-effects?
  #77: FILE: drivers/net/ethernet/intel/igb/igb_ethtool.c:77:
  +#define IGB_NETDEV_STAT(_net_stat) { \
  + .stat_string = __stringify(_net_stat), \
  + .sizeof_stat = sizeof_field(struct rtnl_link_stats64, _net_stat), \
  + .stat_offset = offsetof(struct rtnl_link_stats64, _net_stat) \
  +}

  total: 0 errors, 0 warnings, 2 checks, 3498 lines checked

Address that by adding the type to the offset and sizeof_field checks so
that they will properly strip both the macro and the two arguments. With
this change the result is 0 checks as the two argument macros correctly
strip the type and argument.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 scripts/checkpatch.pl |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 461d4221e4a4..cda33bb71ad6 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5833,7 +5833,7 @@ sub process {
 			        next if ($arg =~ /\.\.\./);
 			        next if ($arg =~ /^type$/i);
 				my $tmp_stmt = $define_stmt;
-				$tmp_stmt =~ s/\b(__must_be_array|offsetof|sizeof|sizeof_field|__stringify|typeof|__typeof__|__builtin\w+|typecheck\s*\(\s*$Type\s*,|\#+)\s*\(*\s*$arg\s*\)*\b//g;
+				$tmp_stmt =~ s/\b(__must_be_array|offsetof\s*\(\s*$Type\s*,|\#+|sizeof|sizeof_field\s*\(\s*$Type\s*,|\#+|__stringify|typeof|__typeof__|__builtin\w+|typecheck\s*\(\s*$Type\s*,|\#+)\s*\(*\s*$arg\s*\)*\b//g;
 				$tmp_stmt =~ s/\#+\s*$arg\b//g;
 				$tmp_stmt =~ s/\b$arg\s*\#\#//g;
 				my $use_cnt = () = $tmp_stmt =~ /\b$arg\b/g;


