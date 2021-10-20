Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB4F43510D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 19:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbhJTRQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 13:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhJTRQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 13:16:52 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D835C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 10:14:38 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id q10-20020a17090a1b0a00b001a076a59640so4173612pjq.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 10:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YUffwqw7TyZ+nq+dSJh/YbaKQTy1hvlfSgjnuROyIOY=;
        b=jvessDKfgDNvIBa1Ww83XnWrWtkrnjrB7f47r8pXZ4iW8WkNc3ls20EuXb7qZSPrwv
         UcUgsWfy9GZygh3dBhyQxMskFvVOoECdLkZe1kYzrCJhTFsyBxe43pOFvtiRMCVSc6UO
         VMCjuKE/EPYcOsmj8kSQAFHhVl8SodYXSBfQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YUffwqw7TyZ+nq+dSJh/YbaKQTy1hvlfSgjnuROyIOY=;
        b=5glC3hnq3XdOSh784DNYmDc9LXzCkgsBNgNDPPXq0BM8WtO5Oqm3y1XCsWJXbEXid3
         IxvQuVzdyBUi3tlvUPqZWkeArebDxWAsIx84f7DLDNUxAqoM81N3X1BdRbg3qi5Tn/ay
         JcdQbaJZFuTw6hLH/5M94DEYY80h4f34z4Gxre/IGLJlI50/g6uDL6PE2fA7CsazhIMA
         z3QaCETTBXG8O+GU9uLVA4a4tOEdCjn6XEjdnpv0mzDD9T7SiupOTFIue7eJIo5gv7cZ
         yGuW92KXjwds0GZxyCXjE9cEttZ6gC7cd4ZxvCvhCRFTSOTaKtsXZ8ZHXBdUh+TSWaIc
         OBtg==
X-Gm-Message-State: AOAM5314Fgz2m/uCMXXBpE8YWMmExB2pBY/WUtBkRfeo42kNgdkpuIfR
        zhGYv1yV/WY3QQf7jKnDcxNjWg==
X-Google-Smtp-Source: ABdhPJz6Lb8i9XfQ+ZaOzqCSrJ4aau7V9H411Ar5EcXAieXZwYegz99ehafx9jKjUjO/l7dfc48jeA==
X-Received: by 2002:a17:90b:3a88:: with SMTP id om8mr153373pjb.164.1634750077917;
        Wed, 20 Oct 2021 10:14:37 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:ee8c:e73a:3f5e:717a])
        by smtp.gmail.com with UTF8SMTPSA id u16sm3378795pfi.73.2021.10.20.10.14.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 10:14:37 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Brian Norris <briannorris@chromium.org>,
        Sean Paul <seanpaul@chromium.org>
Subject: [PATCH v2] MAINTAINERS: Fixup drm-misc website link
Date:   Wed, 20 Oct 2021 10:14:18 -0700
Message-Id: <20211020101233.v2.1.I96669f75475cbb0ae1749940217876aa8991b703@changeid>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

https://01.org/linuxgraphics/gfx-docs/maintainer-tools/drm-misc.html
gives HTTP 404, and
https://01.org/linuxgraphics/gfx-docs/maintainer-tools/ redirects to
freedesktop.org now.

Let's save people the pain of figuring that out.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Sean Paul <seanpaul@chromium.org>
---

Changes in v2:
 - Correct the patch description text

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 100d7f93a15b..811d8d3e35fb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6158,7 +6158,7 @@ M:	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
 M:	Maxime Ripard <mripard@kernel.org>
 M:	Thomas Zimmermann <tzimmermann@suse.de>
 S:	Maintained
-W:	https://01.org/linuxgraphics/gfx-docs/maintainer-tools/drm-misc.html
+W:	https://drm.pages.freedesktop.org/maintainer-tools/drm-misc.html
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	Documentation/gpu/
 F:	drivers/gpu/drm/*
-- 
2.33.0.1079.g6e70778dc9-goog

