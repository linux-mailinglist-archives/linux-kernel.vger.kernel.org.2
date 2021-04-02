Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 196DD35303A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 22:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236630AbhDBUXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 16:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236602AbhDBUW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 16:22:57 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89606C061788
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 13:22:53 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id u10so6643689lju.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 13:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QEz4oFoQYZ69/xxwT/aHjc5mSVtFDWMrpjWevrV34Wo=;
        b=b4Txbpwmnn7KJtqwLk6uV4b7L8nc/7b1Nv3dGDYBwzt2CnW9cg8nr13jjoAaPLiknl
         B+Gzwgj2s4oohWzZkH0VwNrgWDo0Q6/tN8ci6LOm34sqEllhfq5nanjy6oFIz/zOdcC7
         ExpCbtPG6n6HbOdgstu9KxWO4q4vfjBfxdJrUxb91zWvyWKcS5a74TDLiLxpWv7DAonL
         r7B27BKEkKPvCL1mQV4uVsS9zynKNwF1gvra8i3sm9iiMRturcvs+eA08FzabztlZsoB
         0RjF6vyA778g5+ar/q+eQSBStOnGfGqiODkz9NRs3ly+FpuUGgNv48W9rHIDKyu1WCpn
         qW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QEz4oFoQYZ69/xxwT/aHjc5mSVtFDWMrpjWevrV34Wo=;
        b=A74+8tyv0WXhq/H/HCy12oSpVxiF3r9s5aQeg0+iUYjHo5BFQNJrcAW1zfA4WXG9Sv
         fUTzYVBTaVuzhHmmSsGSrsvPRd6UEhqHRWSHV8zkkRgn6/HCeMVf+QVy9lrBjLm94I3y
         WpxPs1STPfSwxXZU2nau1/r4lW1G3MDjGSQmD5s70Hay2IgPcmC17rDi4Rnkbfwf3+tQ
         njQMyefwOXcY7Ft63sxTccxA4fKrQ+AaAmxmSv4mjkGsawPWVQHImUVRPtFVEinikdOM
         OLrW2ubekoIBlzi17V1cSVkfLWRPSKX6DUF0FNv99uapmcAw1sPUhJJavmvxOyNh29ir
         qDBQ==
X-Gm-Message-State: AOAM532mBcO36b3CLq75zr5jp5X4T4bllCEtcUPsL5N2skwwpD9bM0AE
        UIDtur0gtS00MRwmbJLZMsI=
X-Google-Smtp-Source: ABdhPJyNsBsDI+cKgn5n6SDR0U/DIbyOU+44ERqHPUKLVgIKciOkzzeFPIKpVByGE7Vbt8lTrGNFNg==
X-Received: by 2002:a2e:5c03:: with SMTP id q3mr9511957ljb.68.1617394972062;
        Fri, 02 Apr 2021 13:22:52 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id f11sm952514lfr.119.2021.04.02.13.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 13:22:51 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH-next 5/5] mm/vmalloc: remove an empty line
Date:   Fri,  2 Apr 2021 22:22:37 +0200
Message-Id: <20210402202237.20334-5-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210402202237.20334-1-urezki@gmail.com>
References: <20210402202237.20334-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 093c7e034ca2..1e643280cbcf 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1503,7 +1503,6 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	va->va_end = addr + size;
 	va->vm = NULL;
 
-
 	spin_lock(&vmap_area_lock);
 	insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
 	spin_unlock(&vmap_area_lock);
-- 
2.20.1

