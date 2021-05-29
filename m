Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B950394E0B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 22:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbhE2UEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 16:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbhE2UEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 16:04:08 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C196BC06174A
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:30 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id j1so195159oie.6
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sGm+mHu/Iw9QO3ywYD0xHTkTs8CcGHsabAospE3fhMw=;
        b=Zy76fbzIRLY8ilo917rBFU2shQsmf9JbS7aBlFHbfQmlRfiAhDvdEo0staYQNAk/Mm
         DZ6Jh47MTcRU2ycOrQ6Kk+glmBmXmyAR4Cdn49GuUaIg9OUpseM1T+6GDm898ZF0Y9nR
         lgruN+QLsQehorlOdCxhtYtnbpjH5OOrq+veD8HlWA8mO6oHtS4K5zISn82J9Hn84c53
         U+cV+wmXd9GgySUT5RmqdipYseaUGQL/4AJ2ULvH4jbyYdn9HP/eavP5Wh5yozozAM1N
         mZZxormfSG6/LrA1xScRwz10oAFrcecCbBnFTCpczygglVJDg5JjSKRb/OfVkGUpOsLK
         a6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sGm+mHu/Iw9QO3ywYD0xHTkTs8CcGHsabAospE3fhMw=;
        b=lyQOpyN4F2Ohmtv1XlabdBaFkUUwOXAfMtHrkxcTWtDIuOIyQATx+0OcAc8k5KGhaj
         pyHVREAy+6MBQa4H0clgy+JwPMV9sa4HiS+VlLSoxsow7y0Rqa1pc5IHh08tWVGTzwNx
         XBOLYV3kw6UE/dQ5hjPvJADTQW1tTg2xzzxpt0DnmxE2Qva+NAhLQZKf2dZ3fSib0QAE
         2yX0RFDyZhkdvYGobXZYGN/Q9hmvc3DpNYwgT8kXTLgh7iNLDtAuuS6PPuLuvRldeX4S
         9VT9BvhBboP7jBY4kGag1vVAzcKY2lxrnwK3nEFLOjLnbCa4qx7aZgNyvlqWX5tAZ5SK
         rD9A==
X-Gm-Message-State: AOAM533nSD23vA402D0oUkLC/Dp+osf3TyP8+4hhIY5Cr7ZYSjopwmkR
        QZ+szGD1b+9AGnrQ8jzbhL0=
X-Google-Smtp-Source: ABdhPJzDJHulkaNqPB6GCX+3OtZ5pgpils1uflNSyMKRhPSJC+3VC+2MQlJ+Dpm90VcNp+71ARa4Ig==
X-Received: by 2002:a05:6808:143:: with SMTP id h3mr10019797oie.96.1622318550210;
        Sat, 29 May 2021 13:02:30 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t39sm1868064ooi.42.2021.05.29.13.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 13:02:29 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v6 16/34] dyndbg: ddebug_add_module avoid adding empty modules
Date:   Sat, 29 May 2021 14:00:11 -0600
Message-Id: <20210529200029.205306-17-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210529200029.205306-1-jim.cromie@gmail.com>
References: <20210529200029.205306-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't create ddebug_table's for modules with 0 callsites.  This saves
memory, and avoids creating ddebug_tables with questionable contents,
which would then be iterated over for 'cat control'.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 7a15216e6bef..db7563a88d8a 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1033,6 +1033,12 @@ int ddebug_add_module(struct _ddebug *tab, struct _ddebug_site *sites,
 {
 	struct ddebug_table *dt;
 
+	v3pr_info("add-module: %s.%d sites\n", modname, numdbgs);
+	if (!numdbgs) {
+		v3pr_info(" skip %s\n", modname);
+		return 0;
+	}
+
 	dt = kzalloc(sizeof(*dt), GFP_KERNEL);
 	if (dt == NULL) {
 		pr_err("error adding module: %s\n", modname);
-- 
2.31.1

