Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58D054342B1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 02:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhJTBCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 21:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhJTBCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 21:02:06 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062B6C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 17:59:52 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id qe4-20020a17090b4f8400b0019f663cfcd1so1227434pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 17:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kWxdxCAUiPhUvCQhyuJY1pk4j1TQwQE9K4S2H/r2H2U=;
        b=ZqGH0mR3yJSZUiLY/y7VeWVbHN/hWa+mDC0PTE1z0qE1yrZ83KUdHfBpN3vq3qhfLW
         79KcuR1kDPxWTCNjvTPu5uZVjDIBlDQw8bkkxyLszgzS8wEU6FtVfxhvVQUWg0IDJ8iP
         usmiBYJAYq6u1x+FgvrZg8EAai9X/axyvUbg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kWxdxCAUiPhUvCQhyuJY1pk4j1TQwQE9K4S2H/r2H2U=;
        b=ZlYmNKO0lm93+RJSAewrTXrcN4AntLWmsI37AP88+ocddZ01oVPornKXwgS4peNRys
         +jZigsmgVJWaaF/so2H+JP1MDbhZ6wxsJtXhRN9iZ5iuxaUNkvjj/DYZ+ELgA43l8dWK
         3WqJMI/JBMRMH7a4qrwtrVvjXonT4/s124RasnsintjXNtJABMAdGrYAHD80eKI3cmIL
         sVu46JdXqj6bxhl2pC5gMPwgqtOvSaesiNhkqIaO8lL9no7jefXmtm0TCG61b94PUTFe
         ABHEOuXhkwwp/ypcW9iMslfjPJHgJIrWQF143V2zZdC5pT1P4CtDtiokK0fw828VTX66
         aojQ==
X-Gm-Message-State: AOAM532GEACVP9ZCuvBbfnRj+x9TqXdj5QPXiP0as5i86KRcNpmIRC1N
        vyRLIoAynLwczybmBPag5GdRyA==
X-Google-Smtp-Source: ABdhPJzPKUW9ZVR8VRSUVdIoRhlVp3TT0aqVAszkEOYphlAjTExxwlHs8w2BofIFRAqharqGFVZUCw==
X-Received: by 2002:a17:902:a40c:b029:12c:17cf:ab6f with SMTP id p12-20020a170902a40cb029012c17cfab6fmr36995830plq.71.1634691592496;
        Tue, 19 Oct 2021 17:59:52 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:dcb1:f4c7:fe97:de13])
        by smtp.gmail.com with UTF8SMTPSA id b130sm419255pfb.9.2021.10.19.17.59.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 17:59:51 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] MAINTAINERS: Fixup drm-misc website link
Date:   Tue, 19 Oct 2021 17:59:35 -0700
Message-Id: <20211019175932.1.I96669f75475cbb0ae1749940217876aa8991b703@changeid>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

https://drm.pages.freedesktop.org/maintainer-tools/drm-misc.html gives
HTTP 404, and https://drm.pages.freedesktop.org/maintainer-tools/
redirects to freedesktop.org now.

Let's save people the pain of figuring that out.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

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

