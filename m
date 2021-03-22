Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89133440E8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 13:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhCVM0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 08:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbhCVMZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 08:25:56 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED67AC061574;
        Mon, 22 Mar 2021 05:25:55 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id 61so16458440wrm.12;
        Mon, 22 Mar 2021 05:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5d+hZj5fhsNuZlkrpQ3JLYmVf5TxyQGziqID/r69AUk=;
        b=HCCwJvWb1kbS0dQ//lI0PqmUOwFsuyBO/WPjcDNmiQhK+m8qxaduHwwpPgwXJ6Ez5U
         w5KtkOTqh6oPv5iHLFg3+LC935gIQNrIjYta0z+z6YmxEyXgxfAUhubAuQsdpppYRkWy
         C8sbKy6QUTI1YVLBIMl6PFo0+agM0BJp2TJ/8LQ2UKVO62r0mf87C8RqQZL/qAPR4315
         58cTzPy4Isfm4mLlj4C0TGIBinzEvj5XGcYXALXs6cKlLqvTrWuXcg6c2BYmBbo3ee+5
         0Lxik+9L6Utv6OLsqAJ9gPBsTQ2vVZ1QVHoqqeJ1JRE8QgGfn+5W3rnOsZMmZcB03THf
         KPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5d+hZj5fhsNuZlkrpQ3JLYmVf5TxyQGziqID/r69AUk=;
        b=GQ4gatfy24ajhQgsx248rFGt0CK2ZdtrFdfs3in83nEqB989Qvj+hX+1ukI7C7tixc
         mRxjDJBbOLb7LJ5bBCpECh7KXZqmBSvxciA4yS88eIq/kIyWsGl7kTzivwPD2OZMi2I0
         vQBJQ6WxOLhfOuFskrQgsjbRJNCFgYzXoERipqsmyml6vReAgtCtqgpBj8g+ziJ/7qKV
         0sDVVu85WsgpxWNZnQON/97zQFqdgCrqgPodBB91Qca3Udx/sTU8HCGQu/FDwl1kWKNI
         /yFQ0rUbqWRCsv56LNmzUpi2zfTatU72b3kRX1HFxk/USuXn/McC/DY00pc0k9BuYUwd
         hjPw==
X-Gm-Message-State: AOAM530DMyL7s2zZOumGBKeQIkYjmmODz/U5RSosJOkmwEyjtas8cAry
        QOfRTwa0PmKagwftZiMsyPw=
X-Google-Smtp-Source: ABdhPJwFl0z51Dbw9aN82kYgvnJkglgxGTNY/+jktMA9rU8Vp0B2Yj4coIB7+/GKJUfvTU6jifiMhA==
X-Received: by 2002:a5d:6703:: with SMTP id o3mr17925794wru.357.1616415954701;
        Mon, 22 Mar 2021 05:25:54 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d8a:8e00:5079:bba3:3b0:9023])
        by smtp.gmail.com with ESMTPSA id u17sm19088558wrw.51.2021.03.22.05.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 05:25:54 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Joe Perches <joe@perches.com>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 1/2] MAINTAINERS: assign pagewalk.h to MEMORY MANAGEMENT
Date:   Mon, 22 Mar 2021 13:25:41 +0100
Message-Id: <20210322122542.15072-2-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210322122542.15072-1-lukas.bulwahn@gmail.com>
References: <20210322122542.15072-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a520110e4a15 ("mm: split out a new pagewalk.h header from mm.h")
adds a new file in ./include/linux, but misses to update MAINTAINERS
accordingly. Hence, ./scripts/get_maintainers.pl ./include/linux/pagewalk.h
points only to lkml as general fallback for all files, whereas the original
./include/linux/mm.h clearly marks this file part of MEMORY MANAGEMENT.

Assign ./include/linux/pagewalk.h to MEMORY MANAGEMENT.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 728216e3919c..46a1eddbc3e4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11622,6 +11622,7 @@ F:	include/linux/gfp.h
 F:	include/linux/memory_hotplug.h
 F:	include/linux/mm.h
 F:	include/linux/mmzone.h
+F:	include/linux/pagewalk.h
 F:	include/linux/vmalloc.h
 F:	mm/
 
-- 
2.17.1

