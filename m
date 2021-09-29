Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1B541CBFA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 20:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346301AbhI2Sjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 14:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346286AbhI2Sjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 14:39:32 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADB2C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 11:37:51 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id b10so4343742ioq.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 11:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Eo5SNHhjwDW6JtiCinew+Dd2N9GO5DKRKmecOBEWqEU=;
        b=PCfUd84kqbkG9jsy7QmwzvVk7khgo+C5tsLHq0WNSyICw+Cr+TX7kAlikv486H18Ly
         hmx3oSS1cppXlTf+g6xDnrbR4RIx6ehM3Z4M+jYAJDo73Aaqod5K7y4PilXSivS87Taf
         h+Ci7RFrQ+kv5wnOyznzunybFvdJ0R3ySjuyEKYi/GCr76+fJgSIV8BSN8/C/ml+VIv3
         jY2Gh3dODfJbrEclJtxBLANYjtBIU6EB0tYDqey5ow5LJlKol5+PMomblhP80l97w6RC
         pSvgf+oqtJYhxSNgcJWXwmDwLDj4+hG89ua2LeH5z8TzSfvf4hIw2d6xsDu5zuKTz3Vc
         o8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Eo5SNHhjwDW6JtiCinew+Dd2N9GO5DKRKmecOBEWqEU=;
        b=uuy9MKUQXMwGHI03znTJgO3kjO7zv9lg1LTN8woEGU9nhX/MPxjWnMax9Czc8TUaAS
         31b3UY95xosVhMHok/dod9rXZDOXJK041Nj6fNqRQTmHCQQUWE5U54gd2vVK8zr1xmQ1
         mqn6fLKIBvX/GnR443S/b+sTYaAdHPUo0kifvAWudlpOWgMTyIKiqDcPv9VTGRbeHdeC
         p2/vhcgRIQh7fT6YGI+e07hTqPsvSKSA1iJWQ0AT1SJc8aFBVKT5SoWOfju9PVINcxPf
         7za/7ckFC8RuFVTL7mBkb03II6ignz9z9slvCoF5rqztjZRkLocj/7Y3CvWLcPHwd+Xl
         6K9A==
X-Gm-Message-State: AOAM5320lHK96bKEup0HoUUlYkykSBLAPYA4+MdRnJ7e2309/+R7N4nL
        Beur/ccMoQnvZjZaNVg0SeJXYfNz/TY=
X-Google-Smtp-Source: ABdhPJxx9TckE4fF3cK9DWKgHzJb+GIccQ68VHd9ACasTwaFmfTYvmDWeTIoxSsl45miQ9qtGFP6aQ==
X-Received: by 2002:a6b:6610:: with SMTP id a16mr953141ioc.120.1632940670651;
        Wed, 29 Sep 2021 11:37:50 -0700 (PDT)
Received: from samwise.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id y2sm317041ioj.12.2021.09.29.11.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 11:37:50 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 2/6] dyndbg: show module in vpr-info in dd-exec-queries
Date:   Wed, 29 Sep 2021 12:37:31 -0600
Message-Id: <20210929183735.6630-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210929183735.6630-1-jim.cromie@gmail.com>
References: <20210929183735.6630-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dynamic_debug_exec_queries() accepts a separate module arg (so it can
support $module.dyndbg boot arg), show it in the vpr-info for a more
useful user-debug context.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 817a87e9c37f..5403a4515a4a 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -529,7 +529,7 @@ static int ddebug_exec_queries(char *query, const char *modname)
 		if (!query || !*query || *query == '#')
 			continue;
 
-		vpr_info("query %d: \"%s\"\n", i, query);
+		v2pr_info("query %d: \"%s\" mod:%s\n", i, query, modname ?: "*");
 
 		rc = ddebug_exec_query(query, modname);
 		if (rc < 0) {
-- 
2.31.1

