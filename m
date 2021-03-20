Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11134342DD8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 16:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhCTPi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 11:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhCTPiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 11:38:46 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33672C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 08:38:46 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id hq27so14372814ejc.9
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 08:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=eDFYaGy9sPGd+Betf+442g9mM/qXlhknKOKuzgIa1Vs=;
        b=mS8yvzHOfVkAC2cdEyGeDjB02AOuHm3kmShne2ZeBfoFCyA6/GhWSvnGo0ehN3MCLp
         5Fn9fGP23gYtTTwy/KAA6jiOaj2D5tsYOQHbhTSbqBKvBrUfsahyUhwazwFx0v7qsXqi
         h8vfEK2GkiYQ3yUg2Zk1BV+2RGFxUbvZuYmg2j0BCt02zzpJ8FYlfihRNVc202RwyhoL
         8KsKv1QDRUPDdA38Vfsh2t1Lypu4gaf5TZXQIccWnRJvFSrSivJBP02YE824s3ilgJxo
         ep0dR3eDDuQHvfQ/DgK9QQ3lY/Xb7rVWeuLw0MTmjqbaORdsCwTMPyGje3KzJgxWcjTB
         J7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=eDFYaGy9sPGd+Betf+442g9mM/qXlhknKOKuzgIa1Vs=;
        b=mHDeqB3tb9YgtCpJ2Y921gCo5aE6nBM3ABXww+yQZQVSa0gqPV9WSOWrwgKZDWPo4K
         9vdrhGpESKmR3Pn3BQNpkpfddNq8fL9SIkaToGWOBEMtl0BlJ4qsGElgqN5gjokgqGcT
         4kL0HKzCCyd4Qk3TwkqaUF1jfF8XrcZCh6lf8Qpz9AXVlykS3copfjVqg2B96hZfAmK9
         vb6dnNm2tAli8Xtf2GKqdcAjT6zFNZ3fytuaRuLffze/1WNImqDTJ9jZhT5pTE6q6z/I
         R3NokphpE2b/7BEf3jAmlgQGqTmP64cm8K7+9n9fnHa664zKHQvVhvLGKitLdiBAOTZy
         IAFQ==
X-Gm-Message-State: AOAM5331K6FIeQGVSf7TVedCY1hZJXQwyrHS0pX0MmAJEkxyzhw7Z0s6
        cTlfJRS6RyHlsSGCCQbwNch/rkw0Eg==
X-Google-Smtp-Source: ABdhPJwcMewegxB/irNV8kfFr3X0SIQvsV5Q8rtlyAXaAdzbqP6O9hNHTJAJEjADhFX/Hut35RN3Ww==
X-Received: by 2002:a17:906:ef2:: with SMTP id x18mr10433946eji.323.1616254724836;
        Sat, 20 Mar 2021 08:38:44 -0700 (PDT)
Received: from localhost.localdomain ([46.53.248.213])
        by smtp.gmail.com with ESMTPSA id x4sm6171049edd.58.2021.03.20.08.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 08:38:44 -0700 (PDT)
Date:   Sat, 20 Mar 2021 18:38:42 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] proc: save LOC in __xlate_proc_name()
Message-ID: <YFYXAp/fgq405qcy@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can't look at this verbosity anymore.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/generic.c |   11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -166,15 +166,8 @@ static int __xlate_proc_name(const char *name, struct proc_dir_entry **ret,
 	const char     		*cp = name, *next;
 	struct proc_dir_entry	*de;
 
-	de = *ret;
-	if (!de)
-		de = &proc_root;
-
-	while (1) {
-		next = strchr(cp, '/');
-		if (!next)
-			break;
-
+	de = *ret ?: &proc_root;
+	while ((next = strchr(cp, '/'))) {
 		de = pde_subdir_find(de, cp, next - cp);
 		if (!de) {
 			WARN(1, "name '%s'\n", name);
