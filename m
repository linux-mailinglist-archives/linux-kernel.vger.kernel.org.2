Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4623D16CD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 21:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239573AbhGUSWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 14:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbhGUSWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 14:22:20 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07581C061575;
        Wed, 21 Jul 2021 12:02:56 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id qa36so4747238ejc.10;
        Wed, 21 Jul 2021 12:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bz+gGGTDR08X+AO/SbVQCNhU2kG51Ah3ryQBTD5eMuQ=;
        b=kXdFVki2Ry0Qh5deswzLJ0S8JSGB7N79Iy5ClQbvjmPZUJ0pDYTYM6eat85V8zdO//
         aeLllkfCgdoe76xPh2iolTABrqdqH3DwbVoeuq2z6Inwq3zwPB6pQN4OcG7OTcTea03i
         4VjCgQLHmtKvWYydflL1lWSyPEWDMJOeUEHEeJTQGFzqHosjVu/ztZF3WykSE0txnFuV
         yugJsktvXpU0P7nmitRTxtgegWIHoNsPWih6Hh88W2fILhGUgR6FeC1mhQ92n9mKN6Mc
         qjqnmnpzNW5n9BaLnos0bOft7NR784TuS2O8XdJAdBzV/tJIZ5+sW2A3M+bI1uHJs9KY
         f5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bz+gGGTDR08X+AO/SbVQCNhU2kG51Ah3ryQBTD5eMuQ=;
        b=pi9o8BEMWuOj6f8qE/fPNkkmLZgp/QpuMX1N87FkSqnM6UrDW3MJ4rmY5feSc1mMvf
         Ub7GLF/a/b6kfsGd2Fla81hfaKZSp6L9R/hJyBpGSBaCaBhwPkKTkVi2c0ySS91116xR
         F1P8XfB1H4I+o2HC1gCTxa236Uel5DbPid+GnXoWBPt1WM+eWQzPV6zD4xi7aTj1cvWu
         DtTVxO1mvjGHi0rrQThOy1NlfH3N6Njtml5r/uJEjAgNjLhYog1x95bbaBWGNju+2CDG
         Dz5YHQu07VORGJt2I98TzVOoiy4Cn9I47cJvuye1bb9SZAIWlcyVOjnaSqAPY930DBGP
         tPWQ==
X-Gm-Message-State: AOAM530oSHTMwyAooTD9IQGb49JgmRCKH9yydpECDO2qWSbYUAKR0KhF
        eR7NIK/rsQ4edTkYFfKk3pQ=
X-Google-Smtp-Source: ABdhPJywpZBOxUrcAA2ibda5nc6sB+szMz9PR3oDWSgdBzdM4+N7PEtUr/LYJyqBrD34NKnA4HfnRQ==
X-Received: by 2002:a17:906:c302:: with SMTP id s2mr39661610ejz.151.1626894174613;
        Wed, 21 Jul 2021 12:02:54 -0700 (PDT)
Received: from localhost.localdomain (host-79-27-97-200.retail.telecomitalia.it. [79.27.97.200])
        by smtp.gmail.com with ESMTPSA id a25sm11130868edr.21.2021.07.21.12.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 12:02:54 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Vineeth Pillai <Vineeth.Pillai@microsoft.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] admin-guide/hw-vuln: Rephrase a section of core-scheduling.rst
Date:   Wed, 21 Jul 2021 21:02:50 +0200
Message-Id: <20210721190250.26095-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rephrase the "For MDS" section in core-scheduling.rst for the purpose of
making it clearer what is meant by "kernel memory is still considered
untrusted".

Suggested-by: Vineeth Pillai <Vineeth.Pillai@microsoft.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 Documentation/admin-guide/hw-vuln/core-scheduling.rst | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/core-scheduling.rst b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
index 7b410aef9c5c..e6b5ceb219ec 100644
--- a/Documentation/admin-guide/hw-vuln/core-scheduling.rst
+++ b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
@@ -181,10 +181,11 @@ Open cross-HT issues that core scheduling does not solve
 --------------------------------------------------------
 1. For MDS
 ~~~~~~~~~~
-Core scheduling cannot protect against MDS attacks between an HT running in
-user mode and another running in kernel mode. Even though both HTs run tasks
-which trust each other, kernel memory is still considered untrusted. Such
-attacks are possible for any combination of sibling CPU modes (host or guest mode).
+Core scheduling cannot protect against MDS attacks between the siblings running in
+user mode and the others running in kernel mode. Even though all siblings run tasks
+which trust each other, when the kernel is executing code on behalf of a task, it
+cannot trust the code running in the sibling. Such attacks are possible for any
+combination of sibling CPU modes (host or guest mode).
 
 2. For L1TF
 ~~~~~~~~~~~
-- 
2.32.0

