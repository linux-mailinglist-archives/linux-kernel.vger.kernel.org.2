Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 107493813B9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 00:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234068AbhENWVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 18:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbhENWVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 18:21:30 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656C3C061763;
        Fri, 14 May 2021 15:20:15 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id d11so595434wrw.8;
        Fri, 14 May 2021 15:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FPweNk3pkGOY9NgkFWy9y6Zupg8Fw4qtXEQGtAlTE1Q=;
        b=AmX3bDP8TPwtfGgVkQ+kjcFXRoiQdsPHcPem0YmIJLzYhZzIJedNMmkN0gthqYy0zY
         Rr2sGpJSLQEZhiKmAwFty+cDXXiyVxGW660lR8CIDCz6ujgZHqWFfESKoBWaF0EFIux9
         SqLWMMt6fBMzfMUTZg6XR7Xb6Yqiskzu37sQZu2nGFva+UpXVOhpqPwSM3A4UDC58q9A
         zBz4QijSr6iUWLaXgW+gYG/TlST1rPdXWQE/TkZz9k63IjXRqxDSJmxgUJ3HtcrpR8Ti
         OT+1OzZ1S55IJjW+JPF0LbJBsotmXAVyHaVVFqKUPoWTwnM9HFUwvJ2QDFwTN2RlL2rY
         5+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FPweNk3pkGOY9NgkFWy9y6Zupg8Fw4qtXEQGtAlTE1Q=;
        b=BtJlSpjc0NcxQRIzK7qQifntQADzN9fKkXvRCkUW94MRmVfZjeRADqJZxFbBZAVEvZ
         gLX9fOmwv3KRvtgVL6tNeoIRe64F6zXINS7kOx9tZ62xiHOT9O6cHTN+rVmVHw7x8597
         2lLmVaCPLKHO1hnziEoI0mb1TpLjwgApwJW2k/Rm5rJA91iPUY9jr7kc76c46UR1PZwV
         mEDHyna1tx9LXHl5br0KRsvEoFr8X+nHrlnr2E2kAlaT5j00E9JWquHN+l+w2H9Fc1fd
         Jrz4q4vOdNdCeYsuetTMVpTVwbPjrLFSMomBhxZxzLzUC/EnKWsBlMIpghZN8ir/mQ9u
         K81A==
X-Gm-Message-State: AOAM530TynZhZIdbGr0O0asViIbo2ehjUHQlUgop166lgbEKmuxm7Q21
        JkjOVmwtOzLLRVssQ06Pb2I=
X-Google-Smtp-Source: ABdhPJysT80uVA7Vwyo70mLwKSB5qo6CoBIv9nGzo/Y1x5eXRBE6GO4fV9usALLPj6nS5G2RRukg9A==
X-Received: by 2002:a5d:6e04:: with SMTP id h4mr60031763wrz.256.1621030814214;
        Fri, 14 May 2021 15:20:14 -0700 (PDT)
Received: from xws.localdomain (pd9e5a369.dip0.t-ipconnect.de. [217.229.163.105])
        by smtp.gmail.com with ESMTPSA id y14sm7668170wrr.82.2021.05.14.15.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 15:20:13 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/surface: aggregator: Add platform-drivers-x86 list to MAINTAINERS entry
Date:   Sat, 15 May 2021 00:19:54 +0200
Message-Id: <20210514221954.5976-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Surface System Aggregator Module driver entry is currently missing a
mailing list. Surface platform drivers are discussed on the
platform-driver-x86 list and all other Surface platform drivers have a
reference to that list in their entries. So let's add one here as well.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bd7aff0c120f..57467b6046f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12180,6 +12180,7 @@ F:	drivers/platform/surface/surfacepro3_button.c
 
 MICROSOFT SURFACE SYSTEM AGGREGATOR SUBSYSTEM
 M:	Maximilian Luz <luzmaximilian@gmail.com>
+L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 W:	https://github.com/linux-surface/surface-aggregator-module
 C:	irc://chat.freenode.net/##linux-surface
-- 
2.31.1

