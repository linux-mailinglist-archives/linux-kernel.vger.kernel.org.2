Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1901C382930
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 12:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236541AbhEQKAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 06:00:55 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34616 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236171AbhEQKAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 06:00:07 -0400
Received: from mail-ed1-f70.google.com ([209.85.208.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <juerg.haefliger@canonical.com>)
        id 1lia1T-0002V7-0G
        for linux-kernel@vger.kernel.org; Mon, 17 May 2021 09:58:51 +0000
Received: by mail-ed1-f70.google.com with SMTP id y19-20020a0564022713b029038a9f36060dso3603560edd.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:58:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FAwYcbe2FnSf91LrGqNRKHwj5NiLN+QDT33coE1vDDY=;
        b=pjZtb35KVRRoQCrnDrZjjXTCXkjxAV2CV3Zrsgomix+3pQw/m5SZq15zskipUnSneS
         omgCEWHETT49i9QFUG1Oy9bIVOUjyneyvbaLX78jsqH+DSnR016M9/MIlwbxWdJCuC7x
         m/ih1OGFoMsOZJwbRBj5ELEs0+CxEUQ2godhbksQRl+jtbzLDvgBJBYFSuRzLYxIEHUT
         RhdUQo3MS3xis0mRqhMUvDetop//Gqv9+u1goPzeOXyZTN/ZHbztCHNZvvu7u1uZNY+e
         vTRftBGGO2yHerZfTGTgS87FEdoWNK7uFykVLpOnZkQOetPGsRFRzng9xNW+MWnKlkZL
         A+Gg==
X-Gm-Message-State: AOAM533zaqa1QPbqc1VnLoby0PnfulhQMlnQ1S9dyPyZv0R4eUNARlZl
        OXmniNCrg7p+pmo+wZziypapQdRObUd/6shS/iv7WLnwmfiMqx+rkZy1Jh2ptYszWTwnJewPeHi
        r91OBFeS5LiNSmqkiXhnnhkAHq/Iza6YVJb3eGsSPuw==
X-Received: by 2002:a05:6402:26d1:: with SMTP id x17mr71485843edd.14.1621245530736;
        Mon, 17 May 2021 02:58:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1XM6d/SxBu8aaIzwnv0HONuKjx63Z02EveIvcsuo8LT4K3QeiB3HDAo1LlS/t7IIbuhcN+A==
X-Received: by 2002:a05:6402:26d1:: with SMTP id x17mr71485830edd.14.1621245530599;
        Mon, 17 May 2021 02:58:50 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id m10sm7493916edp.48.2021.05.17.02.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:58:50 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     masahiroy@kernel.org, keescook@chromium.org,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, juergh@canonical.com
Subject: [PATCH] init: Remove leading spaces in Kconfig
Date:   Mon, 17 May 2021 11:58:48 +0200
Message-Id: <20210517095848.82033-1-juergh@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove leading spaces before tabs in Kconfig file(s) by running the
following command:

  $ find init -name 'Kconfig*' | xargs sed -r -i 's/^[ ]+\t/\t/'

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 init/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index 1ea12c64e4c9..9f1cde503739 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2149,7 +2149,7 @@ config MODULE_SRCVERSION_ALL
 	help
 	  Modules which contain a MODULE_VERSION get an extra "srcversion"
 	  field inserted into their modinfo section, which contains a
-    	  sum of the source files which made it.  This helps maintainers
+	  sum of the source files which made it.  This helps maintainers
 	  see exactly which source was used to build a module (since
 	  others sometimes change the module source without updating
 	  the version).  With this option, such a "srcversion" field
-- 
2.27.0

