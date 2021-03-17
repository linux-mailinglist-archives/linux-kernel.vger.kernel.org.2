Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C5B33FA0B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 21:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbhCQUkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 16:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbhCQUjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 16:39:43 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC668C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 13:39:42 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id v23so153589ple.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 13:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1Sz1C+2ZFN+q+zvGzAvorWvnnUr4dg3QlHRxSjGhysc=;
        b=S3tPk3MQF11R+zuq0bgUR4hIronf/vGlpAZP8O0PrITEMiApnIaYB2gGRF8civJFzG
         uv42cNXJcclm8RiH2qgoBhDJjYxyuNJy5iLZLVXFNiivvS7hw+mHBI6Tzy72P62tGmvT
         1GkGK472gU41lrvh5Y6sVWwA1etkLBAwl+p5xionYlrn0yqSVJ6/urPFBIKcRdasEfBS
         svgv7YI2/O4JP31rdfnFpoUDJMo6/84COiIjgODO7m+rc+MrmceX556r95FFRHpe5kjd
         u9xcYqZqE+ODmy0EdhxPhYUbQY/+OIa7GZmvqUbtIplm5jjwULt7MKa73j7yI33VrvHd
         5J7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1Sz1C+2ZFN+q+zvGzAvorWvnnUr4dg3QlHRxSjGhysc=;
        b=gqL367fNmglHAmJ+OVIqmE+cxS7DWlevUpyobgGt2FkLA/kzv7UdcKF2hYlDMsXHtY
         oBVOVHxIFIBwrSt9PrU39ESXKPo6DH89CqtzKaFCeOOBJd11+holByQk8wAbgnErlU/h
         HEv/2H2e35Z1pAiaZyxWq6Vi4Z/cK2Cgl1SxSO+5BgYkBY7gqrkURPOJrYYfq6XoFCxj
         SJbfKmKcuYC0N8UqrlRnqfl92SVE/M/CdB2h9hA5sLMQOkdo//+v+C8leQPvDGoI2YkC
         nZfX4jhr4ilmAvEDWHRp12rkIk2Vv4q0qDXZ1B56ydm7z1S5mtcpIRfpNH90qA7KIEfh
         oh3A==
X-Gm-Message-State: AOAM532HaWNm1Jy8JEpuSoSwTm/Evg55WrxG6EwO6kLnK9GoSkmM7EEd
        7J8QJwu8CiWL0HH2p5UbABA=
X-Google-Smtp-Source: ABdhPJyHvqNXWYiQFlP6lBYKHTioS2TG/xF/vjbAFcAFZq1pVwHMhocEMc7WfbfkZ/8lZtxPaM3jiA==
X-Received: by 2002:a17:902:8c8d:b029:e5:e1fc:a587 with SMTP id t13-20020a1709028c8db02900e5e1fca587mr6300488plo.12.1616013582130;
        Wed, 17 Mar 2021 13:39:42 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:600d:a089:85d1:b0af:d6ff:42d8])
        by smtp.googlemail.com with ESMTPSA id x2sm14513099pga.60.2021.03.17.13.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 13:39:41 -0700 (PDT)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     alsa-devel@alsa-project.org
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org, perex@perex.cz,
        tiwai@suse.com, pierre-louis.bossart@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: ctxfi: fix comment syntax in file headers
Date:   Thu, 18 Mar 2021 02:09:32 +0530
Message-Id: <20210317203932.23993-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The opening comment mark '/**' is used for highlighting the beginning of
kernel-doc comments.
There are files in sound/pci/ctxfi which follow this syntax in their file
headers, i.e. start with '/**' like comments, which causes unexpected
warnings from kernel-doc.

E.g., running scripts/kernel-doc -none on sound/pci/ctxfi/ctresource.c
causes this warning:
"warning: wrong kernel-doc identifier on line:
 * Copyright (C) 2008, Creative Technology Ltd. All Rights Reserved."

Similarly for other files too.

Provide a simple fix by replacing the kernel-doc like comment syntax with
general format, i.e. "/*", to prevent kernel-doc from parsing it.

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
 sound/pci/ctxfi/ct20k1reg.h  | 2 +-
 sound/pci/ctxfi/ct20k2reg.h  | 2 +-
 sound/pci/ctxfi/ctamixer.c   | 2 +-
 sound/pci/ctxfi/ctamixer.h   | 2 +-
 sound/pci/ctxfi/ctatc.c      | 2 +-
 sound/pci/ctxfi/ctatc.h      | 2 +-
 sound/pci/ctxfi/ctdaio.c     | 2 +-
 sound/pci/ctxfi/ctdaio.h     | 2 +-
 sound/pci/ctxfi/cthardware.h | 2 +-
 sound/pci/ctxfi/cthw20k1.h   | 2 +-
 sound/pci/ctxfi/cthw20k2.h   | 2 +-
 sound/pci/ctxfi/ctimap.h     | 2 +-
 sound/pci/ctxfi/ctmixer.h    | 2 +-
 sound/pci/ctxfi/ctpcm.h      | 2 +-
 sound/pci/ctxfi/ctresource.c | 2 +-
 sound/pci/ctxfi/ctresource.h | 2 +-
 sound/pci/ctxfi/ctsrc.c      | 2 +-
 sound/pci/ctxfi/ctsrc.h      | 2 +-
 sound/pci/ctxfi/ctvmem.c     | 2 +-
 sound/pci/ctxfi/ctvmem.h     | 2 +-
 20 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/sound/pci/ctxfi/ct20k1reg.h b/sound/pci/ctxfi/ct20k1reg.h
index d4bfee499fb1..05bb006c0f4c 100644
--- a/sound/pci/ctxfi/ct20k1reg.h
+++ b/sound/pci/ctxfi/ct20k1reg.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/**
+/*
  * Copyright (C) 2008, Creative Technology Ltd. All Rights Reserved.
  */
 
diff --git a/sound/pci/ctxfi/ct20k2reg.h b/sound/pci/ctxfi/ct20k2reg.h
index af94ea66fdda..02f67828eabe 100644
--- a/sound/pci/ctxfi/ct20k2reg.h
+++ b/sound/pci/ctxfi/ct20k2reg.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/**
+/*
  * Copyright (C) 2008, Creative Technology Ltd. All Rights Reserved.
  */
 
diff --git a/sound/pci/ctxfi/ctamixer.c b/sound/pci/ctxfi/ctamixer.c
index d4ff377eb3a3..da6e6350ceaf 100644
--- a/sound/pci/ctxfi/ctamixer.c
+++ b/sound/pci/ctxfi/ctamixer.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * Copyright (C) 2008, Creative Technology Ltd. All Rights Reserved.
  *
  * @File	ctamixer.c
diff --git a/sound/pci/ctxfi/ctamixer.h b/sound/pci/ctxfi/ctamixer.h
index 4fafb397abed..4498e6139d0e 100644
--- a/sound/pci/ctxfi/ctamixer.h
+++ b/sound/pci/ctxfi/ctamixer.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/**
+/*
  * Copyright (C) 2008, Creative Technology Ltd. All Rights Reserved.
  *
  * @File	ctamixer.h
diff --git a/sound/pci/ctxfi/ctatc.c b/sound/pci/ctxfi/ctatc.c
index f8ac96cf38a4..78f35e88aed6 100644
--- a/sound/pci/ctxfi/ctatc.c
+++ b/sound/pci/ctxfi/ctatc.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * Copyright (C) 2008, Creative Technology Ltd. All Rights Reserved.
  *
  * @File    ctatc.c
diff --git a/sound/pci/ctxfi/ctatc.h b/sound/pci/ctxfi/ctatc.h
index ac31b32b277b..0bc7b71d910b 100644
--- a/sound/pci/ctxfi/ctatc.h
+++ b/sound/pci/ctxfi/ctatc.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/**
+/*
  * Copyright (C) 2008, Creative Technology Ltd. All Rights Reserved.
  *
  * @File	ctatc.h
diff --git a/sound/pci/ctxfi/ctdaio.c b/sound/pci/ctxfi/ctdaio.c
index 4cb47b5a792c..f589da045342 100644
--- a/sound/pci/ctxfi/ctdaio.c
+++ b/sound/pci/ctxfi/ctdaio.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * Copyright (C) 2008, Creative Technology Ltd. All Rights Reserved.
  *
  * @File	ctdaio.c
diff --git a/sound/pci/ctxfi/ctdaio.h b/sound/pci/ctxfi/ctdaio.h
index 431583bb0a3e..bd6310f48013 100644
--- a/sound/pci/ctxfi/ctdaio.h
+++ b/sound/pci/ctxfi/ctdaio.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/**
+/*
  * Copyright (C) 2008, Creative Technology Ltd. All Rights Reserved.
  *
  * @File	ctdaio.h
diff --git a/sound/pci/ctxfi/cthardware.h b/sound/pci/ctxfi/cthardware.h
index 9e6b83bd432d..f406b626a28c 100644
--- a/sound/pci/ctxfi/cthardware.h
+++ b/sound/pci/ctxfi/cthardware.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/**
+/*
  * Copyright (C) 2008, Creative Technology Ltd. All Rights Reserved.
  *
  * @File	cthardware.h
diff --git a/sound/pci/ctxfi/cthw20k1.h b/sound/pci/ctxfi/cthw20k1.h
index b7cbe82d71bd..ffb019abf651 100644
--- a/sound/pci/ctxfi/cthw20k1.h
+++ b/sound/pci/ctxfi/cthw20k1.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/**
+/*
  * Copyright (C) 2008, Creative Technology Ltd. All Rights Reserved.
  *
  * @File	cthw20k1.h
diff --git a/sound/pci/ctxfi/cthw20k2.h b/sound/pci/ctxfi/cthw20k2.h
index 797b13dcd84c..6993a3d5277a 100644
--- a/sound/pci/ctxfi/cthw20k2.h
+++ b/sound/pci/ctxfi/cthw20k2.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/**
+/*
  * Copyright (C) 2008, Creative Technology Ltd. All Rights Reserved.
  *
  * @File	cthw20k2.h
diff --git a/sound/pci/ctxfi/ctimap.h b/sound/pci/ctxfi/ctimap.h
index 79bc94bce4d5..49b1bb831410 100644
--- a/sound/pci/ctxfi/ctimap.h
+++ b/sound/pci/ctxfi/ctimap.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/**
+/*
  * Copyright (C) 2008, Creative Technology Ltd. All Rights Reserved.
  *
  * @File	ctimap.h
diff --git a/sound/pci/ctxfi/ctmixer.h b/sound/pci/ctxfi/ctmixer.h
index 770dc18a85e8..e812f6c93b41 100644
--- a/sound/pci/ctxfi/ctmixer.h
+++ b/sound/pci/ctxfi/ctmixer.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/**
+/*
  * Copyright (C) 2008, Creative Technology Ltd. All Rights Reserved.
  *
  * @File	ctmixer.h
diff --git a/sound/pci/ctxfi/ctpcm.h b/sound/pci/ctxfi/ctpcm.h
index dfa1c62f7d1e..8b39bdd262b4 100644
--- a/sound/pci/ctxfi/ctpcm.h
+++ b/sound/pci/ctxfi/ctpcm.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/**
+/*
  * Copyright (C) 2008, Creative Technology Ltd. All Rights Reserved.
  *
  * @File	ctpcm.h
diff --git a/sound/pci/ctxfi/ctresource.c b/sound/pci/ctxfi/ctresource.c
index 6d0a01b189e1..81ad26934518 100644
--- a/sound/pci/ctxfi/ctresource.c
+++ b/sound/pci/ctxfi/ctresource.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * Copyright (C) 2008, Creative Technology Ltd. All Rights Reserved.
  *
  * @File	ctresource.c
diff --git a/sound/pci/ctxfi/ctresource.h b/sound/pci/ctxfi/ctresource.h
index 93e47488a1c1..fdbfd808816d 100644
--- a/sound/pci/ctxfi/ctresource.h
+++ b/sound/pci/ctxfi/ctresource.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/**
+/*
  * Copyright (C) 2008, Creative Technology Ltd. All Rights Reserved.
  *
  * @File	ctresource.h
diff --git a/sound/pci/ctxfi/ctsrc.c b/sound/pci/ctxfi/ctsrc.c
index 37c18ce84974..bd4697b44233 100644
--- a/sound/pci/ctxfi/ctsrc.c
+++ b/sound/pci/ctxfi/ctsrc.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * Copyright (C) 2008, Creative Technology Ltd. All Rights Reserved.
  *
  * @File	ctsrc.c
diff --git a/sound/pci/ctxfi/ctsrc.h b/sound/pci/ctxfi/ctsrc.h
index 1204962280c8..1124daf50c9b 100644
--- a/sound/pci/ctxfi/ctsrc.h
+++ b/sound/pci/ctxfi/ctsrc.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/**
+/*
  * Copyright (C) 2008, Creative Technology Ltd. All Rights Reserved.
  *
  * @File	ctsrc.h
diff --git a/sound/pci/ctxfi/ctvmem.c b/sound/pci/ctxfi/ctvmem.c
index bde28aa9e139..7a805c4a58e1 100644
--- a/sound/pci/ctxfi/ctvmem.c
+++ b/sound/pci/ctxfi/ctvmem.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * Copyright (C) 2008, Creative Technology Ltd. All Rights Reserved.
  *
  * @File    ctvmem.c
diff --git a/sound/pci/ctxfi/ctvmem.h b/sound/pci/ctxfi/ctvmem.h
index 54818a3c245d..da54cbcdb0be 100644
--- a/sound/pci/ctxfi/ctvmem.h
+++ b/sound/pci/ctxfi/ctvmem.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/**
+/*
  * Copyright (C) 2008, Creative Technology Ltd. All Rights Reserved.
  *
  * @File    ctvmem.h
-- 
2.17.1

