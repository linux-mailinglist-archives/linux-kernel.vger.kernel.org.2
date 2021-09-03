Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE13400774
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 23:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235923AbhICVdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 17:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbhICVdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 17:33:15 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AC8C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 14:32:14 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u9so514520wrg.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 14:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IvbjSHJKpubZVuxl2JEYL8Tazj9vB8n4DSRyGqZzzmk=;
        b=oVjt7c13mTighzYdT00XJ9TY2ZUe1GY8xZA1Wi9q8Wg02LspVS9xXCBheGIhXJZFDY
         tgJf/FNNefzC0TtfoZQsEQa/+nyFnfHpwYNV/aJ7lZOw6RoPWyuKUE+0A5yMN0a5kkHf
         17wtshJiBlLaZ9iIvK7WINSuxZGFXi2Q9BACq1qvUBwAzBoVIFYVUosqyMZ+xefvD5kP
         a7WT/AhEPRSzXrzTG8V0GqR1ZDi1f3mLxMc3I2IXYHApcL3KmGssRHLuuzkxKqxLO1WM
         JVe4edPHHTGdWuOAQKjjJdlaZaquBlQSt6EiehVB4lquiBcjYZfMjmywYk9YUm83nbjR
         oO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IvbjSHJKpubZVuxl2JEYL8Tazj9vB8n4DSRyGqZzzmk=;
        b=XEo8LAKrBZp0ZqLKSsz/zTkfSptJlkBzrbGqrdhxNa4hg+ewJEN6Kus5BunDKOVGfh
         TwbtVZKJUCAPWHEoJh1gO4ZuIolbAwRUoFd2J1ugjajrppcdR8oHFlfqgUXp1Zvigy3i
         rRdPWNEz75vYQTc/ueTSf7UXVtiODIVHhiY+AslqFrAvUuLcKL6Cg4SQtBTVD4tIzY2f
         6J6NL/yuCs/LNtkLSCvG4K9/9PUusYTPfIsG5cGEFROAR23wWfDUVzkPEGebKnDHGfZk
         MrYpt42TXPP2EaaE0M+/azWxc+T2tMPB2YwLnMBl+qD4DNqUoclarm6J4WiC5sYMlCfn
         yuRA==
X-Gm-Message-State: AOAM531F4H8js+GxT0YhWpV8Vk/m0mey2TSAt2kL3WlwgiydZkQBXnZq
        CzhCkf0R4joI7la+LNueSZkDdZxNBCH9Ug==
X-Google-Smtp-Source: ABdhPJwxw6shnn+w5t7STROZRObRYgijv+sPoTUMwIxUKMNlvzfa8ePug8a7k8kEqj3jGc2tWgRdmA==
X-Received: by 2002:a5d:6cab:: with SMTP id a11mr1005441wra.287.1630704733070;
        Fri, 03 Sep 2021 14:32:13 -0700 (PDT)
Received: from localhost.localdomain (30.34.155.90.in-addr.arpa. [90.155.34.30])
        by smtp.gmail.com with ESMTPSA id m1sm394506wmq.10.2021.09.03.14.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 14:32:12 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] cdrom: update uniform CD-ROM maintainership in MAINTAINERS file
Date:   Fri,  3 Sep 2021 22:30:11 +0100
Message-Id: <20210903213011.1319-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update maintainership for the uniform CD-ROM driver from Jens Axboe to
Phillip Potter in MAINTAINERS file, to reflect the attempt to pass on
maintainership of this driver to a different individual.

Suggested-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fa87db67a249..ccd518e15e0a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19142,7 +19142,7 @@ W:	http://dotat.at/prog/unifdef
 F:	scripts/unifdef.c
 
 UNIFORM CDROM DRIVER
-M:	Jens Axboe <axboe@kernel.dk>
+M:	Phillip Potter <phil@philpotter.co.uk>
 S:	Maintained
 W:	http://www.kernel.dk
 F:	Documentation/cdrom/
-- 
2.31.1

