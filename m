Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D943FC97A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 16:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236603AbhHaOQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 10:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235863AbhHaOQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 10:16:04 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EF2C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 07:15:08 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id y34so38826038lfa.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 07:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eOuXnASyI2WtXKZIGPGikBs28mgrhh5PKaySunE0Iuc=;
        b=h6hZX6BNledGIbqIuMUSHSrf+46C4OmsSwKZtqdjyBJKaRWbKCM42lSZV++DSEjOdO
         OIu5hIjv27BcaQjIOTbXGe80mjggT/+owSvjs8SbxC9hLGCUA17zwB+GV/DiWpz4fHqg
         wk7qkG4Le7t+66gwGCao5YvSpEoRV4eNw91DL5TuQf1sX7FbwLhcgKybBYxcc/zyd0u3
         Pb3QKVx8bnBbkXnSvadPLk4Bzt2LraDwlqnTGx/P8uc78WV0XUM/3KuB9260pD7Q2AoM
         Zpd3HJ7x1MHuGLaz1+Y0GqMa+0gmdFcl47NYxKLV1CSlNidYUiBFEdbDmRYlvwE4/xno
         j/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eOuXnASyI2WtXKZIGPGikBs28mgrhh5PKaySunE0Iuc=;
        b=Ytq39CSuBRwNq2QYNzhy19TNc4rol+gpd/Tlygq3sKpJ8kKGEaKW+NEI3x4YEwMMum
         scs0mhO1CpM+yk4vzCJi91Pu1yEFJ47hfwU72uHaGyNpysSnPpBgjokPL39RPqByCyHc
         DHPKoeMwWzGvCN4+CSWISpFvkPtX75DD6obDCYdgRPfdRKzlFaCPkZrr9qQRX/MHKPPB
         j1U4Xywwsmu1HRzx/C6CJfYrO2OncOXAOl0XBnJSNuNX/SFxbG5hjo9IXB8d5qSlY12e
         MM2SwXxzi+DzeTGGEsk+cbyJuRmzOKY9qghOq5SXMUxOwtrtlWmbo1RnQEsQMmNzEUez
         1aIA==
X-Gm-Message-State: AOAM5305zx+OjelV7zvPT4kS254FShj9G249kIWEPCm7IW/tfwNhfBnT
        BIFyPBlydNIhe5aT45SzwEM=
X-Google-Smtp-Source: ABdhPJz8zMVwYXFvfmlvM4RLbszLY0Q1wDSj1EdFK+pcD3hpkptb3tQYCOYc8zYKKM+6fDdaPJvWSA==
X-Received: by 2002:a05:6512:1094:: with SMTP id j20mr21738730lfg.197.1630419307373;
        Tue, 31 Aug 2021 07:15:07 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id i30sm2202187ljb.48.2021.08.31.07.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 07:15:06 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] fs/ntfs3: Change right headers to upcase.c
Date:   Tue, 31 Aug 2021 17:14:32 +0300
Message-Id: <20210831141434.975175-6-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210831141434.975175-1-kari.argillander@gmail.com>
References: <20210831141434.975175-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no headers. They will be included through ntfs_fs.c, but that
is not right thing to do. Let's include headers what this file need
straight away.

types.h is needed for __le16, u8 etc.
kernel.h is needed for le16_to_cpu()

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 fs/ntfs3/upcase.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/ntfs3/upcase.c b/fs/ntfs3/upcase.c
index eb65bbd939e8..eb815609fd0b 100644
--- a/fs/ntfs3/upcase.c
+++ b/fs/ntfs3/upcase.c
@@ -5,13 +5,9 @@
  *
  */
 
-#include <linux/blkdev.h>
-#include <linux/buffer_head.h>
-#include <linux/module.h>
-#include <linux/nls.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
 
-#include "debug.h"
-#include "ntfs.h"
 #include "ntfs_fs.h"
 
 static inline u16 upcase_unicode_char(const u16 *upcase, u16 chr)
-- 
2.25.1

