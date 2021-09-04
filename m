Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFD7400C49
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 19:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237255AbhIDRlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 13:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237170AbhIDRlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 13:41:35 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F21C061575
        for <linux-kernel@vger.kernel.org>; Sat,  4 Sep 2021 10:40:33 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u16so3335568wrn.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 10:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5fzcYeF4YFXRE5oucuMiY5JXM+MPIlPFvJeEBLEeqCU=;
        b=pZWAjhtZEje7hSE220N0rUjuZ/sXMJNqrREAFQBG+I7R2ikpSbWJQ0VLv8v8DB2ZH9
         Z8jRiY/CsatkTLBQT9Cpw3mphrVwZvRLudYUjqpjeh6PAOC+bE5C+ffZXdlRa6+k8OAK
         fEhJFEdn1WEslLeackwugXt4sea7ZRXdakuYxFY+ou9rkdZaGTfpHBQ7aS345M6AYDfw
         sw17xNMxKb6Yr1HdThoRVBzmLu8JkSVQAqNYU+ma76rePDCytQn95Fkk/iigb5Y2wg2/
         xQoZKk0C73xKRQsBGCjz2bIr+kTLpbrQlDKW9mtLcZaKpiWPOaB8bTWoOkNJeDQGRvXT
         NEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5fzcYeF4YFXRE5oucuMiY5JXM+MPIlPFvJeEBLEeqCU=;
        b=anvIrrIbjRf/5S+mj1mWn8N+7e+r9yI33yCKNGS5OJqwpYso7JHih/RnsLeEIO7Yla
         7xLBrPk3BQgyE/vNrIi2UOHGifeUoRctypHBX3pEy9pYoX0RvJpXENSa5B2ATQB9r/Gv
         XGXXc+v1vNrH87Jdf5594lXzKtKhX/+cBBzqKpz20vW88J02QtWl35xvD1dLZxrL90re
         np9QjRNRu78GoF0m/lyA0+9rZV5F6OEAtcdB5DFxXnz7CI+k0dN/er9UAhfBIfzzsK0R
         hO8D9BElQUqHN32KPs67qOkb1QXyJ9Yt3uMapFchEjJxmUEy31isPv/v4NJ7uJX1z2aK
         //AA==
X-Gm-Message-State: AOAM533LgA19mN+8wg8xvvMWwSOTfVV/jFWChwLRMS5tsKNGoy5m6n0R
        hTWlrM4RLpnU47ybBRD7kTeAWg==
X-Google-Smtp-Source: ABdhPJzWnOX/gXXnuWI/LNELxEW8C9Jhe1LFS8gQK5lu9Pn3TQpgNqFJMPmKFHHDn+PI4UfeGCBuLg==
X-Received: by 2002:adf:e887:: with SMTP id d7mr4812649wrm.79.1630777232037;
        Sat, 04 Sep 2021 10:40:32 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id d7sm1523278wrf.3.2021.09.04.10.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Sep 2021 10:40:31 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] cdrom: update uniform CD-ROM maintainership in MAINTAINERS file
Date:   Sat,  4 Sep 2021 18:40:30 +0100
Message-Id: <20210904174030.1103-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update maintainership for the uniform CD-ROM driver from Jens Axboe to
Phillip Potter in MAINTAINERS file, to reflect the attempt to pass on
maintainership of this driver to a different individual. Also remove
URL to site which is no longer active.

Suggested-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---

V1: Removed Jens and added myself.
V2: Also removed inactive URL.

---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fa87db67a249..4d3896ebb5b1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19142,9 +19142,8 @@ W:	http://dotat.at/prog/unifdef
 F:	scripts/unifdef.c
 
 UNIFORM CDROM DRIVER
-M:	Jens Axboe <axboe@kernel.dk>
+M:	Phillip Potter <phil@philpotter.co.uk>
 S:	Maintained
-W:	http://www.kernel.dk
 F:	Documentation/cdrom/
 F:	drivers/cdrom/cdrom.c
 F:	include/linux/cdrom.h
-- 
2.31.1

