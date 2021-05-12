Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68AFC37F026
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 01:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243993AbhELX51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 19:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbhELXof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 19:44:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BC9C06138E
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 16:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Xi6rUATIsl0qQ+HXmFtFtw/1f9MPy0zZoPPcyd3kqEU=; b=rxYYs25uYWJ/6fnZRiGTi2RJPZ
        g6tj/f/htNS77W39ILeHPPiSDCZigWVhEJHMLd/LETIdTfax1Yj1iqDfKoshttbJEGBagzWAXpQzS
        ArNqcMiWvNRxhB3tPntrwoL+BphTyp+EmJhDb0lrWLQqFZkuokLrr/4jrxB3tzKpTmFYoaGdsTGlm
        JItaEF1noZtR1Q8hazbfRfFNi0HrCvupxTvEMkWbK5xvRw7sCllBRaJDkvMwKVG0RtIrHMtSQcQjG
        l9p4eYKRoHEhi9VaULcvVo+r8cK3UT843nCGjm9n+SDxvCwJbmIMm28Iqn6KXE6PuntOuoXebCK3T
        nF9DRglQ==;
Received: from [2601:1c0:6280:3f0::7376] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lgyNY-00AuaN-Fr; Wed, 12 May 2021 23:35:00 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH -next] drm: simpledrm: print resource info using '%pr'
Date:   Wed, 12 May 2021 16:34:59 -0700
Message-Id: <20210512233459.19534-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct resource start and end fields are not always long long,
so using %llx to print them can cause build warnings (below).
Fix these by using the special "%pr" for printing struct resource info.

../drivers/gpu/drm/tiny/simpledrm.c: In function ‘simpledrm_device_init_mm’:
../include/drm/drm_print.h:412:32: warning: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 3 has type ‘resource_size_t {aka unsigned int}’ [-Wformat=]
../drivers/gpu/drm/tiny/simpledrm.c:533:54: note: format string is defined here
   drm_err(dev, "could not acquire memory range [0x%llx:0x%llx]: error %d\n",
                                                   ~~~^
                                                   %x
../include/drm/drm_print.h:412:32: warning: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 4 has type ‘resource_size_t {aka unsigned int}’ [-Wformat=]
../drivers/gpu/drm/tiny/simpledrm.c:533:61: note: format string is defined here
   drm_err(dev, "could not acquire memory range [0x%llx:0x%llx]: error %d\n",
                                                          ~~~^
                                                          %x

Fixes: 4aae79f77e3a ("drm/simpledrm: Acquire memory aperture for framebuffer")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
---
 drivers/gpu/drm/tiny/simpledrm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20210512.orig/drivers/gpu/drm/tiny/simpledrm.c
+++ linux-next-20210512/drivers/gpu/drm/tiny/simpledrm.c
@@ -530,8 +530,8 @@ static int simpledrm_device_init_mm(stru
 
 	ret = devm_aperture_acquire_from_firmware(dev, mem->start, resource_size(mem));
 	if (ret) {
-		drm_err(dev, "could not acquire memory range [0x%llx:0x%llx]: error %d\n",
-			mem->start, mem->end, ret);
+		drm_err(dev, "could not acquire memory range %pr: error %d\n",
+			mem, ret);
 		return ret;
 	}
 
