Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31FBF40F4D9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 11:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240978AbhIQJen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 05:34:43 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:54004
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240428AbhIQJei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 05:34:38 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 209D940261
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 09:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631871196;
        bh=tTVAXZIbg+nscSqjGmCmN2vkVa6NbzShnNR0nlGi+3E=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=CwGvvE5kJnLvBrKvdUvQXkLh2nIj75e1qnOzVHo/cGFraidGEkRdU406EgK33B2Bl
         d0jjxYIta+TPYHXYtdYMoEebn6pIVFCOEJZPLqC0KEru11pRndAE2GKLvRxUCOP2JN
         CSyroi7SKNJjV1XZ/TNC4+6ZvrYabTDIO3ssbpP6wUsJpvFvI32tWK2gqvuCO2uG0m
         z1EHFWbsgs2DwQvZAzcGcT8MnCNJXZcuIJH1Y1vBXUX+tbdPLvGtWEgFmcggS21wzy
         NZH2L0ivF07dXVfxM+DjGkspT2zUY0JHdywKcL7R9J8gsbwv0aK8w3OvJ2W7oD87hT
         zHbVDKtdEufYg==
Received: by mail-wr1-f72.google.com with SMTP id s13-20020a5d69cd000000b00159d49442cbso3491926wrw.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 02:33:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tTVAXZIbg+nscSqjGmCmN2vkVa6NbzShnNR0nlGi+3E=;
        b=zmRTkZkBbfKtgW3ufHwjkTwp0ofBaSwQ+X497iAAQ+gCAhEtJj2yA53KrvOFxSysk8
         CIaCm8jir3S+iIUmckDyBa04EaKjahyL/leq0C73HWDITKZUpp+/6ZShpzQwQC9hM6OH
         7gasVQJ+1cgrmQYJxsqpHaAKFM9JX1NmOeYcRw5sbCJcSKWT7vTUZZ8D4WupvALbrukb
         la49KCtQZ9VtLyiZTDaVOsj42UZISF8rT3XcrRM6bEdrI163ISdMH6bcHgH+Sy9nE+Ye
         9Rm4wNkNasIE3BAL/0ZOQSgpmZbyLOVeZdrxHLLSTlnLMPmDWTtMp4R2HKCe6yqYRV7C
         jnaA==
X-Gm-Message-State: AOAM533sVkGc3a4/AE2IzI9vhWFNUpBKWY8gotY0HvWkgLz7U6caZUu6
        DENbqt3lnYtSlgIstNc/k5uw8V+rlfGMSm6zEm91/0qpOkQqVGO8NmzTb6mlt5t5mQqbY2GM/ka
        qhfmx8iSl+61UdKye8eilVRCJVWPG6jH6VADGwzsbbQ==
X-Received: by 2002:adf:c14c:: with SMTP id w12mr11065393wre.115.1631871195645;
        Fri, 17 Sep 2021 02:33:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzm1hfXlP9qxMJBeO0j1bvcei+pQ6mYrjdqgYy9bQhs+1gR0op82yXutPeFLLb3ukLhOIeHeg==
X-Received: by 2002:adf:c14c:: with SMTP id w12mr11065374wre.115.1631871195486;
        Fri, 17 Sep 2021 02:33:15 -0700 (PDT)
Received: from localhost.localdomain (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id n66sm5770333wmn.2.2021.09.17.02.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 02:33:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Ulrich Kunitz <kune@deine-taler.de>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, zd1211-devs@lists.sourceforge.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Daniel Drake <drake@endlessos.org>,
        Daniel Drake <dsd@laptop.org>
Subject: [PATCH] MAINTAINERS: zd1211rw: Move Daniel Drake to credits
Date:   Fri, 17 Sep 2021 11:32:36 +0200
Message-Id: <20210917093236.21424-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Drake's @gentoo.org email bounces (is listed as retired Gentoo
developer) and there was no activity from him regarding zd1211rw driver.

Cc: Daniel Drake <drake@endlessos.org>
Cc: Daniel Drake <dsd@laptop.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 CREDITS     | 1 +
 MAINTAINERS | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/CREDITS b/CREDITS
index 7ef7b136e71d..d8f63e8329e8 100644
--- a/CREDITS
+++ b/CREDITS
@@ -971,6 +971,7 @@ D: PowerPC
 N: Daniel Drake
 E: dsd@gentoo.org
 D: USBAT02 CompactFlash support in usb-storage
+D: ZD1211RW wireless driver
 S: UK
 
 N: Oleg Drokin
diff --git a/MAINTAINERS b/MAINTAINERS
index 15a5fd8323f7..92326aa23f35 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20750,7 +20750,6 @@ S:	Maintained
 F:	mm/zbud.c
 
 ZD1211RW WIRELESS DRIVER
-M:	Daniel Drake <dsd@gentoo.org>
 M:	Ulrich Kunitz <kune@deine-taler.de>
 L:	linux-wireless@vger.kernel.org
 L:	zd1211-devs@lists.sourceforge.net (subscribers-only)
-- 
2.30.2

