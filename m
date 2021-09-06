Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD2A40124C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 03:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbhIFBC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 21:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbhIFBCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 21:02:16 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F1BC06175F
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 18:01:12 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u16so7290258wrn.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 18:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nkixgZVIe8BqpWHAtqbznyrgP+Dnw6X3rRzmBmrHirU=;
        b=x2QuL+6kpq5bUvslMR8duWa9zJgwRTRTWrBASg4AMuYO/T7Uqu7FBo63Jw8OuRZkS6
         bdUDwFwA5dzSPj3C4P179wqHuMnh4L8JPIPvAc0MTQKmXVO4N5MJwsfxyEWfMYF7r1gB
         fyNXYp/niTMh18gGTHnV7ThTy4upbEzBKSW6ikWa9VsGjhg3rkqQ5/MGt55m9n649Fqw
         0aTFua+zS+pb2v1PbyIjbtVAlilJ6C7j1GOSIY/eB6v+U5CodpML7Bb/zUBYGitPPTAJ
         PNiMiENaBA9M+wrxNxSTWHTsCYgbI6P4RA6BlonlKSBoNIgPgHuf4ccEPdaoNnIngxpL
         7pvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nkixgZVIe8BqpWHAtqbznyrgP+Dnw6X3rRzmBmrHirU=;
        b=TXRK1w66rH2QCbleNGrukNf0Gd8CfmX+D1CNqQrKw5jTWYhgqDaX8rcJfheX7jMVQn
         4AcMofMMaqdH0rB1bOvs+92n+TturC6LywmjZ5IfFa1JTh7zxKpiKKYRJ44jU5w+YP4z
         l6v+pWRNxyfnlUMV6i0Zm1GWYwBezFmwvRhrjeJ6yMp7fgAnDUhu5qlxw9dAR98jz6BV
         5I3vrR/uoEWLs8lKgDW9vzhGZStkyujIXu/IiNsQ2eFmKLPsDDHdOd22UPkr/MrnpZtp
         ZZPg+Cj2YKMFcGtpyjQlSnaZj3eOzsIMVMQwSTvKaGuOlCEfAivQuyCngL6S1PCIltc/
         kKHw==
X-Gm-Message-State: AOAM5313ELUCS6mSAU6pynuMvECneaP8UL1jSuMnz+XQjz3Un3eYT0hk
        DDhy0ya1fTD/S323bR6lC/ZT+r/T02HoWA==
X-Google-Smtp-Source: ABdhPJwdyl+kV7vUwMnE/iSL9WY9bRKsknOcGtZcgoU13gCSRSvppo229DJ8Zt3db0iRcX7nVVBW3A==
X-Received: by 2002:a5d:5490:: with SMTP id h16mr10332568wrv.170.1630890071139;
        Sun, 05 Sep 2021 18:01:11 -0700 (PDT)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id r25sm5151232wrc.26.2021.09.05.18.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 18:01:10 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 02/14] staging: r8188eu: remove hal_reset_security_engine from struct hal_ops
Date:   Mon,  6 Sep 2021 02:00:54 +0100
Message-Id: <20210906010106.898-3-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210906010106.898-1-phil@philpotter.co.uk>
References: <20210906010106.898-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove hal_reset_security_engine function pointer from struct hal_ops,
as it is unused.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/include/hal_intf.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 5612274dea4d..3cbe6c277677 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -250,7 +250,6 @@ struct hal_ops {
 				  u32 bndy_cnt);
 
 	void (*hal_notch_filter)(struct adapter *adapter, bool enable);
-	void (*hal_reset_security_engine)(struct adapter *adapter);
 	c2h_id_filter c2h_id_filter_ccx;
 };
 
-- 
2.31.1

