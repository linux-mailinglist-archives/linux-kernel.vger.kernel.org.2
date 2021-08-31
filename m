Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C00E3FC97C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 16:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236898AbhHaOQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 10:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235924AbhHaOQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 10:16:05 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42036C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 07:15:10 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id s10so14012345lfr.11
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 07:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s8Ss3Cr4xHNtME0xOZmgxfT13qzdeDxtIo8mhtTPRdQ=;
        b=b1hAro+dRhhRTXDxtIMj73PUK/ldlNQJXp1ccCu3fLVFaK0T+HCmd8CbglRRjqo/1h
         PTuTGjbb6dnB+fKdBL1ZtycdDNCB0Fp+w2QpcxtnuMfvLiTLut3+h2jac1mIKL0uIb35
         t01YafrSMv63QK2aSgb0HK8ga23k4CuoBAAvbOaaEtdUx2D4gxY/GMxRkqeq19NT3BXl
         eXPFkIrar1FfILFiXiP2EjoVmssiTX4ilNQqrwd3I10SlvhRj1De1D0LbRTVhlMdtViP
         nOziC4LFkeIAm0gRFlGW9TM/ElEFmjLez1L6aH6U0TDdy3Cs3/FEzbEqndIvk4tM9oF8
         Tlag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s8Ss3Cr4xHNtME0xOZmgxfT13qzdeDxtIo8mhtTPRdQ=;
        b=BAInPZIywGAaKjBPoKJcPc8zN0RfRhbLIoTomvUKqrnFJ1pS4Fc3zkC70/wRuhTkCF
         0WN4nAtlAu7LcaxosCAso+NV9vBL5OB/gRMu7vovfgP7afeM6SAbyx73UvX7+Be3ox9Y
         2rULk9JEC5Z1ALAbB+wb6kTXGk0bl9MkohBz52xNbWXz4s6MzZRsWgUQFUSN8/pzefmM
         qbRSnqX/JXbzSnl8RWfgrSofG1bpBk95gP54R/Cf5TM3QS+YYId4tAXZriOgfid7eruZ
         eJJ0oa2JbjBuoVn8X0aTySD7JMo9KZwCc4EnM6jgaAfubjmcJlvbcrQkEEGrSMTx4Ijh
         l96Q==
X-Gm-Message-State: AOAM530P19DVp9jgszcvRINyk9H7q2vUUHVeSjq9Dokc7LEHhAy4N4C0
        b+y0TVIfh5j2ob3bHaA/U3I=
X-Google-Smtp-Source: ABdhPJzB7RfkQrcxwyQlc6PNN00NVi/fJI2Se5eJPpbeOqidinXCHrTFgfQ1uyIPFaf2ijaH5sQJ1w==
X-Received: by 2002:a05:6512:5d4:: with SMTP id o20mr3226924lfo.238.1630419308572;
        Tue, 31 Aug 2021 07:15:08 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id i30sm2202187ljb.48.2021.08.31.07.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 07:15:08 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] fs/ntfs3: Change right headers to lznt.c
Date:   Tue, 31 Aug 2021 17:14:33 +0300
Message-Id: <20210831141434.975175-7-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210831141434.975175-1-kari.argillander@gmail.com>
References: <20210831141434.975175-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is lot of headers which we do not need in this file. Delete them
and add what we really need. Here is list which identify why we need
this header.

<linux/kernel.h> // min()
<linux/slab.h> // kzalloc()
<linux/stddef.h> // offsetof()
<linux/string.h> // memcpy(), memset()
<linux/types.h> // u8, size_t, etc.

"debug.h" // PtrOffset()

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 fs/ntfs3/lznt.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ntfs3/lznt.c b/fs/ntfs3/lznt.c
index 3acf0d9f0b15..0bd3dd61d784 100644
--- a/fs/ntfs3/lznt.c
+++ b/fs/ntfs3/lznt.c
@@ -5,13 +5,13 @@
  *
  */
 
-#include <linux/blkdev.h>
-#include <linux/buffer_head.h>
-#include <linux/fs.h>
-#include <linux/nls.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/stddef.h>
+#include <linux/string.h>
+#include <linux/types.h>
 
 #include "debug.h"
-#include "ntfs.h"
 #include "ntfs_fs.h"
 
 // clang-format off
-- 
2.25.1

