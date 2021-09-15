Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECEE40CA8C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 18:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhIOQlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 12:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbhIOQlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 12:41:44 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A0EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 09:40:25 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id x2so3550250ila.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 09:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=32C35ge3ezQOxz2E8eNdBMdK5XlIF/wlycoG44DtLks=;
        b=NHRzTsGjmqYJ0+TrGsA231y6qfakrz0259keU2ufrLcLQXFWfCb3hH5rKquFEiINiP
         bmKtByZGcOu4PxQOD9erbmiLpt3DWO0jiL1e/AU7SfqxiyDWFtNZ/wqE9zo4audBErZT
         dQtcn1/lArWDCr9k5xfQ6V7oVAWVv3A8CFqeHt89R6hYolaOzamDmnUs3rmAk2nj0nqJ
         3Agtd7M1pbXHZHY4ivOrDUPc03mMuTAUZTvCU9ABkU0Qml4MiiOMicLkbtfeRjfpGmfR
         HjUC49juGfgonOge98jrYQvzcI57AY8jiBBN+XYgJL0hsxc2CBzwgSRVSsBmZWQjg/0i
         ZHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=32C35ge3ezQOxz2E8eNdBMdK5XlIF/wlycoG44DtLks=;
        b=AwktjyeeBZVBWV9fi2v9E69v6QckekHmwplY/x96N35unXzost4XBZYcL1ky7Cxf24
         2kAru7woEy4R1+xk9JGI+HwtahBgy3FyxT6QvE6qY0vQZk+tvAG4JRLl1FmA4u5keY9S
         aVRct0/OSg/+NmfBA7dH5kYpMTRBl4KOU2SBH5iLjAuU9F+h9HGI9QPjrW5oSJ/TWWe7
         9NfxGoanNi+aANm0b1oItxYu/5VoNvI7oEgOlBczMiZw0OCnLT7LnKcchPPVaxKZxKBS
         Q7X+ED+7GXgWsMfOeBMOPRw45SmgMfRRAgkYyUut7nwdGVfIkqqGxjWR649EohUAbxTv
         WTPQ==
X-Gm-Message-State: AOAM5313iIO0ZM7fieiUF17sfL1crfjqf8k0EixX0wCS3HW/8LMckWm0
        NXpyRg/ioD3vb81369qr3Ho=
X-Google-Smtp-Source: ABdhPJwjz8Uhc6qTIZK5YwNaEF4pcLLq52VckbKKO19iOqGq7l0v3iCphUnCsZwa4VfJTs2/s/HW6A==
X-Received: by 2002:a05:6e02:2183:: with SMTP id j3mr700350ila.149.1631724024302;
        Wed, 15 Sep 2021 09:40:24 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id a5sm299540ilf.27.2021.09.15.09.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 09:40:23 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, daniel@ffwll.ch
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v8 01/16] dyndbg: add module to a vpr-info in dd-exec-queries
Date:   Wed, 15 Sep 2021 10:39:42 -0600
Message-Id: <20210915163957.2949166-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210915163957.2949166-1-jim.cromie@gmail.com>
References: <20210915163957.2949166-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dd-exec-queries accepts a separate module arg (so it can support
$module.dyndbg cmdline arg), add it to the vpr-info for more context.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index cb5abb42c16a..dfe1e6a857bc 100644
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

