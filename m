Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDAC401250
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 03:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238583AbhIFBCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 21:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235834AbhIFBCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 21:02:19 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75656C061796
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 18:01:15 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id m25-20020a7bcb99000000b002e751bcb5dbso3615251wmi.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 18:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sea6MiaLV8n1Cp/HayFm3TFpoTDQDNzXC3Yp/P/PQi0=;
        b=cY75c2n9NkN9mypYbeQK3yWiAYdXe+6s3c2oNt7zPRrtgTdTnyICfVP7qcpPSowYQ+
         jH5NNgIm6UNPhGCuzEz5T9Kz7nF8nHzSlLbtDSSM8r4o9A/h2HxBuAJAjuc8Q5CBd22k
         1gisACa+CM17cVDbfgv9Z134xj9Yt7n+w5F2hCnlr7wEb8d0c7Z/WOpvdMp52CSgq/XU
         tNnS1vfxjprdjDkE6EhrhWqGf3xY9vKDOhdqqhOFny6RHi26T05jjC//4TtG7D0aTsCb
         K0hRjpzW8zcxg3wwAXRJ4ZVNicac2ZQMBdFHBssGRJQ4SX5sC8AnSyn4jvLgT3dCaYoQ
         SgyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sea6MiaLV8n1Cp/HayFm3TFpoTDQDNzXC3Yp/P/PQi0=;
        b=iyVYJu31Et34gQ2qC9zxyeGXbI1RnmBgP0zuHr96agTggnbeWgernO6I5hgczy4mzZ
         Gto8ybGbDO7hfr6QaalXGXhHowK/my3OWrrwQhTxhxQsdqYgVeP5S+G1VbQqydUO3RRj
         gL2yfiGdgcOckmEOvEqSctl8pLaq/4GKXfyIRym2CR35zqy4UG4RhfO7GrtsNrF95lRb
         1yTg5ct2lgiI48JnawxqmmOiMgGgn44HpfaOqqdsIeq95TcBDy5JTiKzPfVklV6uxMPz
         cWb/XmFETpCmORNVjqnf8JeX52jHowtKts++A5bE1Et7GK1F7ejyK7hf1/UhfsOq9tw6
         rrXQ==
X-Gm-Message-State: AOAM531tbwI8tSlpeaF+4uxMfK4oUJH4okQ+79mwWUdPMzeOdyFSkEVj
        eM5tUOXQ3YNSq+0CJ14sRc94BQ==
X-Google-Smtp-Source: ABdhPJzrPQSoHOItu2lIxDB1VIZh0etqSAzo37bcF6js5WHZGHlVzuY3k1SB2gtx8mCNlX7C4MyrkQ==
X-Received: by 2002:a1c:3bd5:: with SMTP id i204mr9012699wma.53.1630890074113;
        Sun, 05 Sep 2021 18:01:14 -0700 (PDT)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id r25sm5151232wrc.26.2021.09.05.18.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 18:01:13 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 06/14] staging: r8188eu: remove disable_interrupt from struct hal_ops
Date:   Mon,  6 Sep 2021 02:00:58 +0100
Message-Id: <20210906010106.898-7-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210906010106.898-1-phil@philpotter.co.uk>
References: <20210906010106.898-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove disable_interrupt function pointer from struct hal_ops, as it
is unused.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/include/hal_intf.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index e45a45dc1ec1..f3951c405927 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -156,7 +156,6 @@ struct hal_ops {
 
 	void	(*read_adapter_info)(struct adapter *padapter);
 
-	void	(*disable_interrupt)(struct adapter *padapter);
 	s32	(*interrupt_handler)(struct adapter *padapter);
 
 	void	(*set_bwmode_handler)(struct adapter *padapter,
-- 
2.31.1

