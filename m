Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC1540D5FF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 11:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbhIPJWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 05:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235250AbhIPJWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:22:54 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B82C061764
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 02:21:32 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id h9-20020a17090a470900b001791c0352aaso4082321pjg.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 02:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=NBtzEZifW27+Bam/6DmcRhJNC9sdME9/8Fw/NQPSKVk=;
        b=Mx8Rk17J6zCTDDsCbOYYNV1aKpkuf0jHe76vl0sYVU2VuyDTRCL03GzwhFo8Vzuqhy
         auOquOFB8zOmUn3KEQHvNO736szVrvQgFRyqy8CRIwN90Qed5RqnJ9yplmni9MXz2FPj
         6hRz4Key95JKk1ZhS5MypTFZJvhQ3PsJbZQmnJKCMMA1C/OT6Sv06C4nhLw2nhqI/FyB
         +T6gansIfaUWiwaweB1OTqGonphQ12dDwMqTF1c7FaQ2gGelKNL9xuEbxatQaU46NQRc
         +6TCCh1aziG42vvByrJzQAMIoiegeUZx+USXI7+//AnPvCNFAn7BCLsQQcOyU8AX2sNH
         cMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=NBtzEZifW27+Bam/6DmcRhJNC9sdME9/8Fw/NQPSKVk=;
        b=8NB2/M3ieUlpHUdHHXj0yeS0T2aDJhU8fN3/6oXW14N78VLuzxoGCbWLTAY6CIeSSN
         kDSvqLuOmNeCQsdz6mK9YL3DI/knRFfdjOU3BzVNgix0U3oy/eHfcHTp3QDD3lRrNDW3
         wHV50sw4UjkW9mRasAaCUr48QSvI0gWs3CYczNk1E/FS83DG6YzXGDWxsoRP9Qd0kEQO
         t+/2L8rKvLG51oy8G5n4B/9/XFFSeb0G/2p/ETJ+0YqnnWRDhur8zS0ca1HzqKxuJewT
         IEy1PHlDjznMwvBDcZOMRv4pmJUsfbYE1NwhTBbpxBwmzwXKk0iMz9EmlP7xG5o0B+5i
         3Lww==
X-Gm-Message-State: AOAM533ZhT+AcPN4QjM9PT/5Hm8pd2aEx2SjB59hp3dwtDDAMt62y8qJ
        Bof2XJlASwYn86fMyYUEvDuAcqXJLUTOFJ8=
X-Google-Smtp-Source: ABdhPJwZx5fXzbOcG2AkwKV3Z/3e9x/OUgdUUG1H8fWUva8o/4N3Nmclb5pI0lpdaA1DFJsfEA7zeJEW3tAqBOM=
X-Received: from ramjiyani.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2edd])
 (user=ramjiyani job=sendgmr) by 2002:a17:90b:1807:: with SMTP id
 lw7mr1251718pjb.217.1631784092357; Thu, 16 Sep 2021 02:21:32 -0700 (PDT)
Date:   Thu, 16 Sep 2021 09:21:22 +0000
Message-Id: <20210916092122.2374583-1-ramjiyani@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH] kbuild: Fix comment typo in scripts/Makefile.modpost
From:   Ramji Jiyani <ramjiyani@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Ramji Jiyani <ramjiyani@google.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change comment "create one <module>.mod.c file pr. module"
to "create one <module>.mod.c file per module"

Signed-off-by: Ramji Jiyani <ramjiyani@google.com>
---
 scripts/Makefile.modpost | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index eef56d629799..48585c4d04ad 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -13,7 +13,7 @@
 # Stage 2 is handled by this file and does the following
 # 1) Find all modules listed in modules.order
 # 2) modpost is then used to
-# 3)  create one <module>.mod.c file pr. module
+# 3)  create one <module>.mod.c file per module
 # 4)  create one Module.symvers file with CRC for all exported symbols
 
 # Step 3 is used to place certain information in the module's ELF
-- 
2.33.0.309.g3052b89438-goog

