Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C5A3992EC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 20:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbhFBS5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 14:57:35 -0400
Received: from mail-pg1-f179.google.com ([209.85.215.179]:35750 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhFBS5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 14:57:34 -0400
Received: by mail-pg1-f179.google.com with SMTP id o9so200798pgd.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 11:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NoRVY6/XPQSKm3pzeRyT3STWFfhO5O5Fev7OgEnroHg=;
        b=jrVdxvnQQ+1MlC+dBhLUFeGcuxYJOWdl4lOobovmBjkcn0Ko3S8QenU9dvdU4uYxEZ
         wdY+0fbUyePZL2NJ6p/huTBsKqHC9ItUWRziS2je0odsw7GV/gl/XOMpQXF3eP7WgQNP
         WGJfZhmw2pOnZyzw7sg3dHMtV1oaeux0dThCnoBk5dA3xCVsdPSAaRKWZI7Ri2/7ynMf
         z1dXJ04eVFHhSmCJsX5JZtvqcEtB0X5rY8Oaby3uxT3DMi8RpIZt1KjpYk4dJra7gxxo
         TCZAs6bYzaNgDQWHR9l51y0KT1S6YbZ6XQBR1Y7E/0WOKFOff4BJpuRQCFwytUcQfHZQ
         dNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NoRVY6/XPQSKm3pzeRyT3STWFfhO5O5Fev7OgEnroHg=;
        b=S2+cU6bJvD1kULSR0RDVB38nG68mWbeXurOpucjazuuqp93hWAkZ4+iKalDlA3umeP
         Co46kE5L1nkcobjAIgVNpVoNPgpkn8YS7eid4t96pJLlvJKgtULHC1KN6LUrUxGt1YYK
         PBR/RrXD9EV0Tv/g5g+SyjIOlHxQoYnVoNc3zys9FG/mANE509diNGrDiDmKQJAXJsFj
         AtUm7hAX1E/vMoxVcjVqaRW3FH0g+ImT7P8PFbLTCysVrSuY1Ke+CH9OfBM/1bMmTEo5
         OV4OEuWA3K49FaH1SGNMQ7CyrXGCeojNlrrW/mpETqVO8r1NXBUN221KZPDtuzlVZauR
         vJIw==
X-Gm-Message-State: AOAM533/i/gVY979FyYxmKRRXddowDcYya03Hh7DcT1YcAT03BkEwTYw
        z8RVwH3I7yp2OZozbAB+J/Q=
X-Google-Smtp-Source: ABdhPJyaf4flJkDd1+asuqUlGpSV+y0S3q5aml4wagpjAaeI+hr6ip0se87BDEOcsccHOQGQKM2dCg==
X-Received: by 2002:aa7:84c7:0:b029:2e9:2d18:54a5 with SMTP id x7-20020aa784c70000b02902e92d1854a5mr28303272pfn.44.1622660080146;
        Wed, 02 Jun 2021 11:54:40 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:9005:8001:b3f5:4c36:85b:d07f])
        by smtp.gmail.com with ESMTPSA id u190sm302172pfb.151.2021.06.02.11.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 11:54:39 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     ysato@users.sourceforge.jp, akpm@linux-foundation.org,
        rppt@kernel.org, sboyd@kernel.org, geert+renesas@glider.be
Cc:     uclinux-h8-devel@lists.sourceforge.jp,
        linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] h8300: Remove unused variable
Date:   Thu,  3 Jun 2021 00:24:31 +0530
Message-Id: <20210602185431.11416-1-jrdr.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel test robot throws below warning ->

>> arch/h8300/kernel/setup.c:72:26:
warning: Unused variable: region [unusedVariable]
    struct memblock_region *region;

Fixed it by removing unused variable.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 arch/h8300/kernel/setup.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/h8300/kernel/setup.c b/arch/h8300/kernel/setup.c
index 15280af7251c..5745a763dc78 100644
--- a/arch/h8300/kernel/setup.c
+++ b/arch/h8300/kernel/setup.c
@@ -69,8 +69,6 @@ void __init h8300_fdt_init(void *fdt, char *bootargs)
 
 static void __init bootmem_init(void)
 {
-	struct memblock_region *region;
-
 	memory_end = memory_start = 0;
 
 	/* Find main memory where is the kernel */
-- 
2.25.1

