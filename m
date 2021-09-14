Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77FCA40B364
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 17:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbhINPqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 11:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbhINPqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 11:46:10 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBC1C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 08:44:53 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id u16so20978837wrn.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 08:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rammhold-de.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xB5A2oEf3U8Ifr6DwVPVPmZXqJzCQ/TxKjqPJnOVvSw=;
        b=YEGAM5EzV/rMOgfYuWLuKDLUs2BwsuiLV1yNTyqJVb4AfvERwA8Ct4jCuJSKERT8Ze
         iTg6A14ro/tZbdpWiKYTcyRvjklT801kLYuQv5jVr1sJreT7aUp7h8YpXcvR0KanJISi
         JKWHr64A4Trz1RTCFNQ7o+k1E0UcOrNuNpo/gjPDdnoOCfoZRF/J1cBLeEdNm4YFyOxn
         b+06TZB92Yy4w5OhIRdxX+l0MayFSGMYWa0sIjQPlAwbMyIKQt5Uisvbn6e+oimQ769+
         Oq95AGHyOV3r+mi3CI0F+wRNNaR4ATaXNJ4EzjDe4umiDjcFIOwt2NiKcGed9N/1+DfG
         sZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xB5A2oEf3U8Ifr6DwVPVPmZXqJzCQ/TxKjqPJnOVvSw=;
        b=Cr8Eu9g3mXA8qQ9rvFlylI7Cos3IECcz9RcIgFxhMuf0xcTpavIfjMIJwEuKl6Ix3+
         XQHr/hqOKEaVdkiWdl/p+23f8OwGE1nJp/N9WFqgVUQ8/Baxc5x5Y+RIc8bbUDRAm0T/
         7kmx86QfGOojQjdLs+Lga4A9OHIZNn7CiElboO955c1/QC3FnuqcPndCrwjlsjybnBNO
         5HRJFwixKFFkLqYlQ3GyUS72LaShqoRq2Ori7U3RMrSDeyDWudWV/BYl6QAApIgA6usp
         K7fmFnvcuaLHXpS7okuUg6A22EJdkFVPdywoknhNPXwIPiRDNTEa67R0n28kN4MyDRnt
         6shg==
X-Gm-Message-State: AOAM531oBzQTY28oo6X8RA6pSawPlJ/KFujf8utgcKZHViQ5j3t0HYp2
        +Z8M/Kp12MevVZ5xV9aonABc2wWrWueC/g==
X-Google-Smtp-Source: ABdhPJzDau7pwVvLCpxszXC/rXBjGfaEgQZEqVtE/A1z/aUdFKjyOLxyw0A9z+XxnRsr7X7tc1nCnA==
X-Received: by 2002:adf:f805:: with SMTP id s5mr321672wrp.259.1631634291752;
        Tue, 14 Sep 2021 08:44:51 -0700 (PDT)
Received: from localhost ([2a00:e67:5c9:a:2e15:c474:2ef7:bc26])
        by smtp.gmail.com with ESMTPSA id j17sm10632383wrh.67.2021.09.14.08.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 08:44:51 -0700 (PDT)
From:   andreas@rammhold.de
To:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andreas Rammhold <andreas@rammhold.de>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gen_compile_commands: add missing sys import
Date:   Tue, 14 Sep 2021 17:44:40 +0200
Message-Id: <20210914154441.1726853-1-andreas@rammhold.de>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Rammhold <andreas@rammhold.de>

The sys.exit was being used at multiple locations within the script but
never imported. This lead to the script exiting with a error instead of
with the nicely formatted (useful) error output.

Signed-off-by: Andreas Rammhold <andreas@rammhold.de>
---
 scripts/clang-tools/gen_compile_commands.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/clang-tools/gen_compile_commands.py b/scripts/clang-tools/gen_compile_commands.py
index 0033eedce003e..1d1bde1fd45eb 100755
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
2.32.0

