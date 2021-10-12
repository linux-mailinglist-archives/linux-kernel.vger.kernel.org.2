Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0EC842AC13
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 20:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbhJLShf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 14:37:35 -0400
Received: from mail-il1-f169.google.com ([209.85.166.169]:37863 "EHLO
        mail-il1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbhJLShe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 14:37:34 -0400
Received: by mail-il1-f169.google.com with SMTP id x1so82540ilv.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 11:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rCzLCQGRkh3gXZ/jewnVG7ttaiK1hOvVuX7vkQLJGBo=;
        b=ObgO/jtAwYCLMHEYaYzKt3NL8QXTIvVryVtSzFv2O6tyRBcgp2wmMADt7VQUJF0pwr
         EMCir07wTarQcHq79X++kXYwQMsVsG7rtsoC0OAt1U50Xk98guZFkfjXQ0OOtZufsO3C
         KQPxbvtarx3Z552PR84SpEHcrYTzSw16ugqWum8jw5+zfjDFG0ls+64hcRSqrmSghGdk
         OuoQb3NmiIE6V7u29ZUwYih+F63VcL3tmqDVOOdC7pkUB0yiLdNggldVuyWvgkK+nbjG
         bbPFLVam37jAMxPdGU61LbHZTwu5MhpgIRsogP63/EJE6XqspPhzxIc3/FwW34pSDLXA
         WrYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rCzLCQGRkh3gXZ/jewnVG7ttaiK1hOvVuX7vkQLJGBo=;
        b=NK6ruSmMNyfBKc7ceUP6xieGiWDQwvUe4h7OBT2UW8WiPYsjW4daLaPBosHc/efTmm
         i/LomC04gsPCPvy1kCagFoL1n90ptQcuzrCP8Y9s9n0RJjDf56bqE69bogDJkEA7+g7J
         QwNYcT4SvjEJ3NWuQd5cNPCnjenZLSbmj38KsgP9sT6hFkPEZXQ/pcR6xsEbVjPbh4Cz
         oMHO6HGu+FLmDJCeWZUge4vhGFRzq34qGvYL21Oc1X2PeUtkE9CaxdGUQ+DhDgQikW7P
         qnscM/zLyDeLYf37C5whCdOxpKnGd3RUM7wTfujwleiCpARbfQZ/cRIpnmnpWXYpzkWE
         6RDA==
X-Gm-Message-State: AOAM533r63m5w/6buRtn5fopbxyzafoZTRqwLGzz5htTTBwuXeIJv6rm
        uVg5IwE8hzzJmp+Ig/U+pHM=
X-Google-Smtp-Source: ABdhPJyjDvYjWZ0yqn2mDIMRH/a1NMy8E2XeCDgfpoctGw9uhkLRurQSfk8F8WnbeswvDLvygXjSDQ==
X-Received: by 2002:a05:6e02:1486:: with SMTP id n6mr25766693ilk.195.1634063607753;
        Tue, 12 Oct 2021 11:33:27 -0700 (PDT)
Received: from samwise.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id x5sm2257999ioh.23.2021.10.12.11.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 11:33:27 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 1/5] dyndbg: show module in vpr-info in dd-exec-queries
Date:   Tue, 12 Oct 2021 12:33:06 -0600
Message-Id: <20211012183310.1016678-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211012183310.1016678-1-jim.cromie@gmail.com>
References: <20211012183310.1016678-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dynamic_debug_exec_queries() accepts a separate module arg (so it can
support $module.dyndbg boot arg), display that in the vpr-info for a
more useful user-debug context.

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

