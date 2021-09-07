Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA19402651
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 11:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242217AbhIGJox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 05:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240891AbhIGJov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 05:44:51 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D24C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 02:43:45 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id d5so5955476pjx.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 02:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LI0SXYREzj4VJhXtyJ/PF21xfObSJ3KLySRI6EJ3Txs=;
        b=ikD1iRwanMWbaRe4y47WhQhXX3116q1sOggjOm4wSU+1bCCr1x9cPzL0FK3cXJ+3ot
         /2UO605D23MGsQ7rCmi46haEznAje3SKOnryjODAbjma0v/1v8td8NtGUxKOKPR0EI8+
         WWq6J3lo3fC0eFsPexIPOvDEoQdT6xzFb4wY0iJJJWe2rgj60AuF6gVXkCzEpxJofyMe
         +61oPhlXlZewO/O09D/BMVEn2+UBklq61FCKmxfy3/6xBxzT/FthMVianpfImhvOmfLN
         FDTN2Yq96racl/zlNG0EtQKOuTEB5Bv+0bM7UImtn5NI0jjDpyxkV/4VgHtGpbO+YF+s
         jUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LI0SXYREzj4VJhXtyJ/PF21xfObSJ3KLySRI6EJ3Txs=;
        b=VP3IbTlAdwtulE1M70QNXrvbzNXrENFpWThdDWy0pLR/U24yOH3f/Em3IbnYCo0DRW
         Pite7NxlmQbuCFs53OUQs8FQzN7GWEhzmehqRjUd3eWi3pD8J3BQOB/udzW9L24eeZ+D
         AC/RNfRn42xYjAZFaaeQHJPmmbGauqgyDG55+ZlvMs1qESTOuXOEXL0sRw3I8K5Nrqg6
         uTG37ibTl8xubhhMgkix2XEq9E4v0ekrl5nEgwjQXOjctyZxiceCktbMY5WHy6UHdH3j
         lTyRnmlPN9en+iOkukHqCbVA+3womu3pfgAhB5fHoCDVRY3pYDrSPhXYBjiK9ZkzoEl5
         2RDA==
X-Gm-Message-State: AOAM531p87Ruxy8OJsXWmHosRAyDWHXV6DlCnpgQT3MapE3f8apszauy
        Ytr6LR77BkxLTWoiY96tSszJ76OTdfnhUXbYpMc=
X-Google-Smtp-Source: ABdhPJwTssI5IKswozFQMyOlZi8Ot3O1S+Rdv0Nmpj0AO+HT9pA4QsvQsCo5bdrhNEQmTlyJNAy6bQ==
X-Received: by 2002:a17:90a:482:: with SMTP id g2mr3555665pjg.93.1631007824872;
        Tue, 07 Sep 2021 02:43:44 -0700 (PDT)
Received: from localhost ([45.76.146.157])
        by smtp.gmail.com with ESMTPSA id f8sm2007179pju.30.2021.09.07.02.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 02:43:44 -0700 (PDT)
From:   Kortan <kortanzh@gmail.com>
To:     nathan@kernel.org, ndesaulniers@google.com
Cc:     clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        Kortan <kortanzh@gmail.com>
Subject: [PATCH] fix missing 'sys' package
Date:   Tue,  7 Sep 2021 17:43:36 +0800
Message-Id: <20210907094336.16558-1-kortanzh@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Kortan <kortanzh@gmail.com>
---
 scripts/clang-tools/gen_compile_commands.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/clang-tools/gen_compile_commands.py b/scripts/clang-tools/gen_compile_commands.py
index 0033eedce003..1d1bde1fd45e 100755
--- a/scripts/clang-tools/gen_compile_commands.py
+++ b/scripts/clang-tools/gen_compile_commands.py
@@ -13,6 +13,7 @@ import logging
 import os
 import re
 import subprocess
+import sys
 
 _DEFAULT_OUTPUT = 'compile_commands.json'
 _DEFAULT_LOG_LEVEL = 'WARNING'
-- 
2.33.0

