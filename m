Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C367C4282A3
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 19:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbhJJRcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 13:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhJJRb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 13:31:59 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14E8C061570
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 10:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ElKmRgunDXAFgaLsva8h4MdS8Z4mUm9nwnKPIHOnh9k=; b=kMhFnATrV0InsEL8jwYwbHxcUL
        1jHkqRYsYAnhubVi4Vz7gOm+mq7tHf/cMM6DQcrTCG5w80V3tCgxkXSb+FlJl5kRGWQTK5LcmnVlG
        3nyoajIPQwuOe90AwtUydgSSGhJqlw/P/JL9g+UAd4ejQaMWZ8T0mqINKRGWFGkByYOvrMp1J7Fhz
        4zoWM1PqKVus0NsxQcmK9tlUpZJu/rar1nno5cGIJh8HozeN6IMgzUQNcmv2Qb0pmj+tnmrnuplA4
        JbEhjQ0EIIJE7P3HjmWG6D5cPVQGBlCO9swnZO+hxHD+1u2TAxJJ+LkbhofoFA6OCdZcNpEgOgZij
        dRCqLdiw==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mZce4-007CI6-5H; Sun, 10 Oct 2021 17:29:56 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org
Subject: [PATCH v2] drm/r128: fix build for UML
Date:   Sun, 10 Oct 2021 10:29:55 -0700
Message-Id: <20211010172955.30088-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a build error on CONFIG_UML, which does not support (provide)
wbinvd(). UML can use the generic mb() instead.

../drivers/gpu/drm/r128/ati_pcigart.c: In function ‘drm_ati_pcigart_init’:
../drivers/gpu/drm/r128/ati_pcigart.c:218:2: error: implicit declaration of function ‘wbinvd’ [-Werror=implicit-function-declaration]
  wbinvd();
  ^~~~~~

Fixes: 68f5d3f3b654 ("um: add PCI over virtio emulation driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org
---
v2: update Fixes: tag (thanks, Johannes)

 drivers/gpu/drm/r128/ati_pcigart.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20211007.orig/drivers/gpu/drm/r128/ati_pcigart.c
+++ linux-next-20211007/drivers/gpu/drm/r128/ati_pcigart.c
@@ -215,7 +215,7 @@ int drm_ati_pcigart_init(struct drm_devi
 	}
 	ret = 0;
 
-#if defined(__i386__) || defined(__x86_64__)
+#if (defined(__i386__) || defined(__x86_64__)) && !defined(CONFIG_UML)
 	wbinvd();
 #else
 	mb();
