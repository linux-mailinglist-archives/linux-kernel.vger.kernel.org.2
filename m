Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2325B43466A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 10:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhJTIHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 04:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhJTIHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 04:07:12 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F9CC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 01:04:58 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d5so2270266pfu.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 01:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mjmRjhDPlXfraFDWaI835gx21hrF9HvWdixel7/6qiY=;
        b=ZJFJaNNRd8PuSCE7kAX2UWj/y+omgtyGj4Dp47MuJ0HupbjAOnWsezYd6Rd4Og+4Hp
         VDUsNxHuAJu4JdIN3GfUnGk7okzNKYPDR8K+wLBIEMeUOGtdEKNndDUKstbLFXUamj4K
         ClJ9i3EHqgcbcRIU+V6/nm5aabx00nX1/Of52iU0BqgpwxpcTaZWnK1BXEGGlSB1fvyx
         lJ6xNzYRYOKMXaoBm+c4W5sc/iNEZh0oiOp3rNpfuft5kTg++HzlWIyNGdJZe4USdbwy
         vYJVaamnD2YbueFmHBsB9HXxV4u+diOyZRg+x/ljO8bBn69oOmM01TdEODL8vrzqTnuE
         QeUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mjmRjhDPlXfraFDWaI835gx21hrF9HvWdixel7/6qiY=;
        b=a23UB81W5CXInYZmx8dQb8+aqj94snU16xv3BZq5sO/cGmvrp8Nsv50FxS48RTP/YM
         XJguchnHG1+2VOZ9AOExWu3SMG/qVMqLfbtE8X75gjIAsvOfgpIt7YAaw09Y2SWX629u
         IpjLJc/QyeEd5/cOq61BI8V68Haklwx7BHRPP7MRU0+VtjIIpkeG5A5Gguf6BxLGcZuE
         04bnjIj20RaADfHP/Wij9w52nB3iktEq8Tm3z0Qjwc/LwitmIWqwwKeTINYJO4lEYmD4
         2w6O9ksqiH9jFNMsk4AWaqBGatpS5QEWfQ/SRhGvRydDSciFhGdW/bmxA1bP5hLVYzom
         PRZw==
X-Gm-Message-State: AOAM5323IK50a4BRhlZyvtOmS5Jk9yVuwoDrBji+6NfnMBKfR6hbf8lK
        LFIqSzMHCYmh+jdOxXaDXYc=
X-Google-Smtp-Source: ABdhPJwGqLGQ2yAkHfBoHcZZo71yOpOVfy0K270UPJQdPGwQtGqO8K22PKI0HvmSUr8m/LeTEf0CaQ==
X-Received: by 2002:a63:4622:: with SMTP id t34mr31948887pga.293.1634717097926;
        Wed, 20 Oct 2021 01:04:57 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id w125sm1584366pfc.66.2021.10.20.01.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 01:04:57 -0700 (PDT)
From:   Ran Jianping <cgel.zte@gmail.com>
X-Google-Original-From: Ran Jianping <ran.jianping@zte.com.cn>
To:     matthew.auld@intel.com
Cc:     airlied@linux.ie, cgel.zte@gmail.com, chris@chris-wilson.co.uk,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, linux-kernel@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, ran.jianping@zte.com.cn,
        rodrigo.vivi@intel.com, thomas.hellstrom@linux.intel.com,
        zealci@zte.com.cn
Subject: drm/i915: remove duplicate include in mock_region.c
Date:   Wed, 20 Oct 2021 08:04:01 +0000
Message-Id: <20211020080401.1037442-1-ran.jianping@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <130dcbfd-ee6d-0d9a-602f-1aaca1229099@intel.com>
References: <130dcbfd-ee6d-0d9a-602f-1aaca1229099@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ran jianping <ran.jianping@zte.com.cn>

'drm/ttm/ttm_placement.h' included in
'drivers/gpu/drm/i915/selftests/mock_region.c' is duplicated.
It is also included on the 9 line.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ran jianping <ran.jianping@zte.com.cn>
---
 drivers/gpu/drm/i915/selftests/mock_region.c | 2 --
 1 file changed, 2 deletion(-)

diff --git a/drivers/gpu/drm/i915/selftests/mock_region.c b/drivers/gpu/drm/i915/selftests/mock_region.c
index efa86dffe3c6..b6747b3eeac5 100644
--- a/drivers/gpu/drm/i915/selftests/mock_region.c
+++ b/drivers/gpu/drm/i915/selftests/mock_region.c
@@ -6,7 +6,5 @@
 #include <drm/ttm/ttm_placement.h>
 #include <linux/scatterlist.h>
 
-#include <drm/ttm/ttm_placement.h>
- 
 #include "gem/i915_gem_region.h"
 #include "intel_memory_region.h"
-- 
2.25.1

