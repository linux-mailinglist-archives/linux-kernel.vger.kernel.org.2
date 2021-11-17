Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0DB8453DD0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 02:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbhKQBqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 20:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhKQBqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 20:46:07 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E916C061570;
        Tue, 16 Nov 2021 17:43:09 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id p17so777069pgj.2;
        Tue, 16 Nov 2021 17:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sWMSPBMtyIFC0lLdXJvwSDIx4AO8pHT8b+Bf11YktDw=;
        b=F5es+ubIv/7jrCsEpq06DRf934uo/qXWkVeGN6wZqHz38z7xJ/IDU26fPGzJlZHz6o
         Jrm0sZymTDaT36cgNqC7U04BZ+8AE7U9C2ydtvvQFvyPMGinDimq8N9666RqORO2pZty
         tDIU/R6SVCo1CUO6bKWFvdgoRAcugffATxSBtn1Ad57504Qn2hAvmeu8+EUGTDC4zKzh
         lJYvYlLh1VSnY36k2Wp6Nm8LEPhA7JE4puWe3RV1ZHMD5yIYpVpmVd/PrUKcRnrCpBZQ
         1+Crm22fWzcfShFFqnacARwnUcxAib5VJD6VbzxXP/7i0yd1DMuvWvIrg6BDZoVd8ghI
         HHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sWMSPBMtyIFC0lLdXJvwSDIx4AO8pHT8b+Bf11YktDw=;
        b=ip2+H/IyF45mPVMuuaRbhmzgEq3eizchyxn5sZX4QnX4IoBIJNuePLITTxIUcZDmo1
         pCZ+QBIF/6hE550YqkfLMxCYUWt8kuDJK6kdr0za1Mvy5IPporyF1l3nthIZ7FVTqJuO
         sVf29MKTewiO3vusenAPItJ6UE5V6nC4Ic9QIlCIIEdycE4oSaqQDAfrxlClHF0ISPUT
         W4Ct5b1gVW43+0cxEWWOETJvTSejgTWo+bs9qfS653wkapBB7wPbz2CO72CLDAOW6OAp
         WdCRJ0eI+CqiMtxyJijEL9abaPzeMdyVcW5IqjSTS1aFz2pdaxC6GdRAfo0xoh6xy8nb
         Y9Ug==
X-Gm-Message-State: AOAM532AoUoE68MRfaw3N53cYdGC8TQcOJ3Y9hnFKHzSdVe1SPAiF00p
        8elOiXT83GLHy4+eF4+l63k=
X-Google-Smtp-Source: ABdhPJwK31Bkj0OtCyasDL7dBEGy3weSPsA2OtD0tfLa01vVQX0Ppsu9KKCr3kmXMlKEcV3Now5HwA==
X-Received: by 2002:a65:45c6:: with SMTP id m6mr2551497pgr.425.1637113388686;
        Tue, 16 Nov 2021 17:43:08 -0800 (PST)
Received: from nickserv.localdomain (c-98-35-167-56.hsd1.ca.comcast.net. [98.35.167.56])
        by smtp.gmail.com with ESMTPSA id np16sm3783411pjb.6.2021.11.16.17.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 17:43:08 -0800 (PST)
From:   Nick Terrell <nickrterrell@gmail.com>
To:     Nick Terrell <terrelln@fb.com>
Cc:     linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        Helge Deller <deller@gmx.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 0/3] Fix stack usage on parisc & improve code size bloat
Date:   Tue, 16 Nov 2021 17:49:46 -0800
Message-Id: <20211117014949.1169186-1-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Terrell <terrelln@fb.com>

I'll be sending these patches to Linus through my tree. Just submitting them
for comment before I do so. I'm somewhat unsure of the correct workflow for
patches I submit myself, so let me know if there is something different I
should do.

This patch set contains 3 commits:
1. Fixes a minor unused variable warning reported by Kernel test robot [0].
2. Improves the reported code bloat (-88KB / 374KB) [1] by outlining
   some functions that are unlikely to be used in performance sensitive
   workloads.
3. Fixes the reported excess stack usage on parisc [2] by removing -O3
   from zstd's compilation flags. -O3 triggered bugs in the hppa-linux-gnu
   gcc-8 compiler. -O2 performance is acceptable: neutral compression,
   about -1% decompression speed. We also reduce code bloat
   (-105KB / 374KB).

After this commit our code bloat is cut from 374KB to 105KB with gcc-11.
If we wanted to cut the remaining 105KB we'd likely have to trade
signicant performance, so I want to say that this is enough for now.

We should be able to get further gains without sacrificing speed, but
that will take some significant optimization effort, and isn't suitable
for a quick fix. I've opened an upstream issue [3] to track the code size,
and try to avoid future regressions, and improve it in the long term.

[0] https://lore.kernel.org/linux-mm/202111120312.833wII4i-lkp@intel.com/T/
[1] https://lkml.org/lkml/2021/11/15/710
[2] https://lkml.org/lkml/2021/11/14/189
[3] https://github.com/facebook/zstd/issues/2867

Signed-off-by: Nick Terrell <terrelln@fb.com>

Nick Terrell (3):
  lib: zstd: Fix unused variable warning
  lib: zstd: Don't inline functions in zstd_opt.c
  lib: zstd: Don't add -O3 to cflags

 lib/zstd/Makefile                            |  2 --
 lib/zstd/common/compiler.h                   |  7 +++++++
 lib/zstd/compress/zstd_compress_superblock.c |  1 +
 lib/zstd/compress/zstd_opt.c                 | 14 +++++++++++++-
 4 files changed, 21 insertions(+), 3 deletions(-)

--
2.33.1

