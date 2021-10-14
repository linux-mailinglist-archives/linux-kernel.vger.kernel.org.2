Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3F442D410
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 09:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhJNHxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 03:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbhJNHxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 03:53:05 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587ACC061746
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 00:51:01 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id n8so23054169lfk.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 00:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dQ+smrx5UpIbCB5YMnN/G9AjmFDPPtEY4nsT5amIqG4=;
        b=khfhiOqDp1S235yPXagCxIiD97EXuQoDbbqxeCGYtj8QPoio/b/HZv7jHF8xelnEfB
         6A0srjeqw1GUtlH25vsGsT6WbH2G7YwcRg4nQDcleqA+iRwbmzotJ3HR+MNyy/iG3Fjk
         QqdYfKRvj6iVJj775mEwTEkeDhncPFOf15BG5eBmegwXJ2ZXrU9VcEYH00ztDDkts1vF
         rdoDxSWDv3CFB6vdt9pkDUqEtP0sWaFSuJVD8ujlSMJ09xp6SrEEj64DlvTWsgJkn83F
         s/QRhNMnOcjjnBSBHhkj5xt3MO3iKzKwhveLETHDYbcPk9MTJQAUAnBk47sa/6MXhhL6
         LPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dQ+smrx5UpIbCB5YMnN/G9AjmFDPPtEY4nsT5amIqG4=;
        b=LFGX69peGPrFB8KaUMvPVAZZLjGiEUityLrb1RRtGlFXqQHuJdv3GnuBBFRTqDafai
         oZpM247G3FSuicscfyRGKeyJhLID7tI7oYANmj0/3TwZ9j91tOYPyFtYbWf86kR2O64t
         +xQvkJSH9rzw10CHa5WAU87YgTVRmYZbdXbd8xecZwJsVHBze6jN0xNa0wKKn7U+DnFU
         hVca7IwHafscpnQrRTAZtlvcJDNhzEcliZDCtM18mWMPqMFw1NBI3T8D4nGh3S8XE0K5
         3MI7h0h5OnZMb5fzmEtpJ2cgHr0V3Z71piOY9tY9/5Ke8d6LzV/Tu19Ec4Ce9RwmDGQx
         uj5w==
X-Gm-Message-State: AOAM5311Igrv+6//ZVm9Yf30toxHik8mEFw0hoVKUcxrj8prlPFSfQV4
        PXBLvOJag09uhDaJH3q5DSM=
X-Google-Smtp-Source: ABdhPJyAbESyIsPWaL9vzUA/oXYgRfpc1VwOuH3Waco1zdTMNtzWVFrEWQdbh8vNEqlZMEc9JvA5sw==
X-Received: by 2002:a05:6512:3048:: with SMTP id b8mr3649810lfb.517.1634197859420;
        Thu, 14 Oct 2021 00:50:59 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-5.NA.cust.bahnhof.se. [158.174.22.5])
        by smtp.gmail.com with ESMTPSA id t82sm172281lff.50.2021.10.14.00.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 00:50:58 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 1/2] mm/damon/vaddr: constify static mm_walk_ops
Date:   Thu, 14 Oct 2021 09:50:41 +0200
Message-Id: <20211014075042.17174-2-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211014075042.17174-1-rikard.falkeborn@gmail.com>
References: <20211014075042.17174-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of these structs is to pass their addresses to
walk_page_range(), which takes a pointer to const mm_walk_ops as
argument. Make them const to allow the compiler to put them in
read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 mm/damon/vaddr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 953c145b4f08..65d4f115fa66 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -476,7 +476,7 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
 	return 0;
 }
 
-static struct mm_walk_ops damon_mkold_ops = {
+static const struct mm_walk_ops damon_mkold_ops = {
 	.pmd_entry = damon_mkold_pmd_entry,
 };
 
@@ -572,7 +572,7 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 	return 0;
 }
 
-static struct mm_walk_ops damon_young_ops = {
+static const struct mm_walk_ops damon_young_ops = {
 	.pmd_entry = damon_young_pmd_entry,
 };
 
-- 
2.33.0

