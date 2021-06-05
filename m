Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A019439CAF6
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 22:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhFEUkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 16:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbhFEUkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 16:40:20 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8097CC061767;
        Sat,  5 Jun 2021 13:38:20 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id p17so18642451lfc.6;
        Sat, 05 Jun 2021 13:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mvsvZBk4agg2Oio0NRl/rYxpoG5Nh7NnnIBgPez+f1w=;
        b=Nyg4dNfpBjQZr6T+hOIhLA1zw34T9DI37bu1tjb1EjKBnqKizIWXDXYFpQ1Y7uVnZf
         GaxF8GC6Vtw45M/3c5XMAdGH+j3hUswPOMutEApwhURJyRWxd8OW1YGEH4g4QFGFClVj
         cFFoZMoMTr4RJPQcbBKJJBJwBN65ZpjETfwzSKdUIw0WVS5eMKARp9wfEwr0VTfflVT6
         9uHoJBdAjIMuF1rByB60V06Igitsc4hA5Rgt7OakRcS38hg/l5gZI6myAbCpKOs87sDr
         vtpy5asaEYUrgxYznwPTvNtV9MWPyiA9SINTSzh8VGEGnfdjs9px4R6nNdrOA3zSzvRy
         tKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mvsvZBk4agg2Oio0NRl/rYxpoG5Nh7NnnIBgPez+f1w=;
        b=lWE4rQUVLXA30K0L+/gKQs6dEyAYwWcXn+tA72tUiwHjfPyHfBQwdfRguSf5l6NkPy
         9qtHe6xvszeI2Cj7O2jJiq9CLN2tqTwj68b5P6uCO7w8PEvi+BpUt5quTFLwOpz/1Gyk
         W0PJxvzyWtJs17HRmtaAopRlYHTIvGICryJWxTtCjfjmpYgVf5WLYgZrJarwcescEVJ+
         q6aOt/jjR109epApxrV7hU+4tHBREkDhj4PmJEwQ/I+qS9v25JzynWefivJZ3EeHnidA
         7mi8mCY7Hkj51560tuYtK2nIRZsvMu7gSfmf8ZZCSqn+LUdrTVbWhFjrVHq2C+Hhj011
         BHcA==
X-Gm-Message-State: AOAM530QZ0Mfc7se5P8slaw5JuHhFKpH1XhuTDhwCd17mjMJg63S29XW
        p8DqzGDuFn54XJHARZLZbdQ=
X-Google-Smtp-Source: ABdhPJy5VwaUbcGzln4uc4bQNXmfm9NzcvT5TWh5hCteUOWDjTPoUN4jQNql4nDfOG7ld/1P/K5YFg==
X-Received: by 2002:a05:6512:330a:: with SMTP id k10mr7115219lfe.595.1622925498874;
        Sat, 05 Jun 2021 13:38:18 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-228-193.NA.cust.bahnhof.se. [98.128.228.193])
        by smtp.gmail.com with ESMTPSA id k24sm1170063ljg.43.2021.06.05.13.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 13:38:18 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Frank Seidel <frank@f-seidel.de>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Justin Ernst <justin.ernst@hpe.com>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Travis <mike.travis@hpe.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 2/4] platform/x86: intel_pmt_crashlog: Constify static attribute_group struct
Date:   Sat,  5 Jun 2021 22:38:05 +0200
Message-Id: <20210605203807.60547-3-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210605203807.60547-1-rikard.falkeborn@gmail.com>
References: <20210605203807.60547-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only use of pmt_crashlog_group is to assign its address to the
attr_grp field in the intel_pmt_namespace struct, which is a pointer to
const attribute_group. Make it const to allow the compiler to put it in
read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/platform/x86/intel_pmt_crashlog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel_pmt_crashlog.c b/drivers/platform/x86/intel_pmt_crashlog.c
index 92d315a16cfd..56963ceb6345 100644
--- a/drivers/platform/x86/intel_pmt_crashlog.c
+++ b/drivers/platform/x86/intel_pmt_crashlog.c
@@ -218,7 +218,7 @@ static struct attribute *pmt_crashlog_attrs[] = {
 	NULL
 };
 
-static struct attribute_group pmt_crashlog_group = {
+static const struct attribute_group pmt_crashlog_group = {
 	.attrs	= pmt_crashlog_attrs,
 };
 
-- 
2.31.1

