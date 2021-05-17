Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47623829A4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 12:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236367AbhEQKST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 06:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhEQKSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 06:18:16 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F29C061573;
        Mon, 17 May 2021 03:17:00 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id lg14so8340018ejb.9;
        Mon, 17 May 2021 03:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=O61mLnBohDelrXy5jyEb8/b2q8aYYlIu4kGyelK2l6Q=;
        b=rOSe6Yj3yl4Zgb4OWWe25FgdsrQFEPBxVM9DHVtuhcIbMlMoFl+N8aIS70uYUbtllU
         5vGid/3GUvjRlhyYnUakYC9i02JpWQtA2NyxwG50rs0VdFuPaziS5zeulhVkSFM8oU7J
         dzjlrZARlkTKz8k5/pxcgc7E8CxxHSvJOlLMGiRQ7XCpITo7HFZ2M3+zTtqqVp2r25u9
         k5yIwdF/d5bjDakxyUQ5tD1boLvDYdKymysN6b1xG8aRamiY/v0olrWFKMFEOc9Uuhql
         JI03I/W+zQNWFCmRcQPAzkzeW2SIRQVrsaPdB+Ta4+/8/6hiVtIhVBWsmjhPkYAPQ22Z
         XYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O61mLnBohDelrXy5jyEb8/b2q8aYYlIu4kGyelK2l6Q=;
        b=InHLwcEBA/APuhEtPx2cGhUUQv6trwjljKkcUVNhE3sqW4qn3CDnoeHwxjCQs8em+C
         ukEkrW9K+L/dLRPI3/2ItB932/YbxR0Cty4b6e3prn2s45h9f2IHexdN13xT/2EAvbhx
         6e5RNGm+hKOgVjJ6UWlZNcR7qRFpJdEgVRY/aBVxMUJlpHF8HTPRRbIIssJsIE14wttX
         cK2ICws1ldDE9TFUx1tdBI+fOlz8X8A75o8uSf+bbAu+Lepu35qjA5D7jjZN8kTMa5MS
         8JuTGhSojth7vHlamilBLJTAn85BuqH5PiPNTzvnZ+UNJrs4eMdPeMu1qRcwxCYT8/6d
         jIGQ==
X-Gm-Message-State: AOAM532gqMCIiK+mb/EVFnCiTPZj5/NVIrL4h/GMMM/3UArZxbgZsOn2
        Jm9vMzxog/oorvITJ6RCpXw=
X-Google-Smtp-Source: ABdhPJzN+QqZIMCo0M9ryL0N7psIVJilRc8/khRPNwua2F9RP9nQB+ZXg6xEYCLrlw8BHItUJHVFNw==
X-Received: by 2002:a17:907:c15:: with SMTP id ga21mr51769479ejc.141.1621246619384;
        Mon, 17 May 2021 03:16:59 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2dca:fb00:e0e5:3623:aa29:cf48])
        by smtp.gmail.com with ESMTPSA id l6sm8415243ejc.92.2021.05.17.03.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 03:16:59 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: repair reference in DRM DRIVER FOR SIMPLE FRAMEBUFFERS
Date:   Mon, 17 May 2021 12:16:48 +0200
Message-Id: <20210517101648.29906-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 11e8f5fd223b ("drm: Add simpledrm driver") adds the file
./drivers/gpu/drm/tiny/simpledrm.c, but refers to the file
./drivers/gpu/drm/tiny/simplekms.c with the new MAINTAINERS section
DRM DRIVER FOR SIMPLE FRAMEBUFFERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:

  warning: no file matches    F:    drivers/gpu/drm/tiny/simplekms.c

Repair the file entry by referring to the right location.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on next-20210514

Thomas, Daniel, please pick this minor clean-up patch for your -next tree.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6582d19cdf7a..88277ff25d43 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5885,7 +5885,7 @@ M:	Thomas Zimmermann <tzimmermann@suse.de>
 L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 T:	git git://anongit.freedesktop.org/drm/drm-misc
-F:	drivers/gpu/drm/tiny/simplekms.c
+F:	drivers/gpu/drm/tiny/simpledrm.c
 
 DRM DRIVER FOR SIS VIDEO CARDS
 S:	Orphan / Obsolete
-- 
2.17.1

