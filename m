Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C77D3FE75B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 04:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbhIBCCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 22:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbhIBCCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 22:02:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654B4C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 19:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=8jUKRG59iHwqmgF692omQt7SzopfyVzzs32Eyg39CYc=; b=p/3AJPXNQIzMu4hHzTQ/0BqHeF
        Q/y0Voyy9tAQjHJo/Kzd9mssQ3kcm8Nj6bqq+ZRk+zWGRr2HX+MMeHY2QIZqsynhkW0NZeVYB0fq/
        lNiwIQajkL5mWQ4sg7jDVLkQZohi/vTdnAGSsOd0mSbH+vXlfMoX7LFhIHy21JD2hsy7YVVzPMQ/L
        1D9+0PoIpTzBaYRUmycGv9XzPcXi1RIj8HC6g748muedfld69/dTZPL7HwOj3PVI3uqC1RwO+JiBB
        bewGXMmBm+JPhnK45PQpVXqtJ13TYqY0LcUZFruM6NE9w84JlqhhQ8Fe31wF3b7u9wR3IHcmZNuLL
        Yid+JlZA==;
Received: from [2601:1c0:6280:3f0:e65e:37ff:febd:ee53] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLc2k-0089k8-Rs; Thu, 02 Sep 2021 02:01:30 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, dri-devel@lists.freedesktop.org,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH] drm/ttm: provide default page protection for UML
Date:   Wed,  1 Sep 2021 19:01:29 -0700
Message-Id: <20210902020129.25952-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

boot_cpu_data [struct cpuinfo_um (on UML)] does not have a struct
member named 'x86', so provide a default page protection mode
for CONFIG_UML.

Mends this build error:
../drivers/gpu/drm/ttm/ttm_module.c: In function ‘ttm_prot_from_caching’:
../drivers/gpu/drm/ttm/ttm_module.c:59:24: error: ‘struct cpuinfo_um’ has no member named ‘x86’
  else if (boot_cpu_data.x86 > 3)
                        ^

Fixes: 3bf3710e3718 ("drm/ttm: Add a generic TTM memcpy move for page-based iomem")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: dri-devel@lists.freedesktop.org
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/ttm/ttm_module.c |    4 ++++
 1 file changed, 4 insertions(+)

--- linux-next-20210901.orig/drivers/gpu/drm/ttm/ttm_module.c
+++ linux-next-20210901/drivers/gpu/drm/ttm/ttm_module.c
@@ -53,6 +53,9 @@ pgprot_t ttm_prot_from_caching(enum ttm_
 	if (caching == ttm_cached)
 		return tmp;
 
+#ifdef CONFIG_UML
+	tmp = pgprot_noncached(tmp);
+#else
 #if defined(__i386__) || defined(__x86_64__)
 	if (caching == ttm_write_combined)
 		tmp = pgprot_writecombine(tmp);
@@ -69,6 +72,7 @@ pgprot_t ttm_prot_from_caching(enum ttm_
 #if defined(__sparc__)
 	tmp = pgprot_noncached(tmp);
 #endif
+#endif
 	return tmp;
 }
 
