Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D033531EA
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 03:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236401AbhDCBY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 21:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236403AbhDCBYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 21:24:22 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBC5C06178C
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 18:24:19 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id q9so3193323qvm.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 18:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=54Nec5iwCSagU+D8h6pLpuy7QchFo0Lir6iLHH9sio0=;
        b=uQogkziNMsc2niqzRKY3PIDg1Sh9tf047ho5Nz0/1bXgf/kBo//XIrBC/ZN/yKjUrY
         +M1HkGHlkBLwxUFhPxlGgVuqnPQDW0uqQbPpkhasq1O4j8+/AZxhP4BxWFlvvdPLah5D
         wsy0CXszaGm53j7muYCE0wDth50CoRg9pIa6MKCA2AubXMnK9ex5EFngNLi4GO0UswG7
         qFdvs6ou1MYEpMC5AcbV8MaCeyTdTcMceu9CdvH6xfBrBN3wZsui6F4+R6D6b9DjN+zV
         sjDbibdaRDBKWFcH8MqP9BbS0QmmRSy1sIETwIyAWK74TvZMvx9TMpDCCJiWenIN8nBf
         SMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=54Nec5iwCSagU+D8h6pLpuy7QchFo0Lir6iLHH9sio0=;
        b=TdjzlD+91VzXqzdyPeI5ea+CSVR45pv25HUHItb1KLpE4upcO8HWQbD6IoEMyad4yg
         H4nTHPwacuTYsEVx5l8TSr3suj0XAemIF0uxmHWuXcDsjT1SO+HVJ6BeIlvNIDSqsmPp
         5tlWMLdXJVUf+E6wjhbpGrwcGZ1abDJ8ad+Ds4V5L6rTRBcN/WpZ6nYmWB5bQmrHawXT
         xANPrgMFUB7hjQRBkRB5czc/4oJLnJH2I15zZzEOoRYjDsscNZIfbdmYrKqQKbnzdEbu
         RdPjBQdknM/S2TdBwgq0oFYpfho1rODk3hfrRNjwtVos7bhLETOpeAdRTa+dH20W9aYa
         f8bw==
X-Gm-Message-State: AOAM530o5psSvnpSa6/0HhbGIkB1f040clGvcnaGuBygK8Rj4WGRdbkv
        i+jmq5x735IT9q94hNNn+jc=
X-Google-Smtp-Source: ABdhPJwhSxgu3NGgZbuiBVY23z3gsGKTfu6jAf6BA8e42X+1MuIzCcI06PSyBOfBSNbj7RO6WpWalA==
X-Received: by 2002:a0c:f605:: with SMTP id r5mr16409qvm.48.1617413058902;
        Fri, 02 Apr 2021 18:24:18 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:14d:5cd3:8f4f:bad9:1dc4:19d9:7ce3])
        by smtp.gmail.com with ESMTPSA id h14sm7439818qtx.64.2021.04.02.18.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 18:24:18 -0700 (PDT)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH v2 7/9] w1: ds2438: fixing bug that would always get page0
Date:   Fri,  2 Apr 2021 22:24:44 -0300
Message-Id: <20210403012446.381516-8-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210403012446.381516-1-sampaio.ime@gmail.com>
References: <20210403012446.381516-1-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of the w1_ds2438_get_page function is to get the register
values at the page passed as the pageno parameter. However, the page0 was
hardcoded, such that the function always returned the page0 contents. Fixed
so that the function can retrieve any page.

Signed-off-by: Luiz Sampaio <sampaio.ime@gmail.com>
---
 drivers/w1/slaves/w1_ds2438.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2438.c b/drivers/w1/slaves/w1_ds2438.c
index ccb06b8c2d78..ef6217ecb1cb 100644
--- a/drivers/w1/slaves/w1_ds2438.c
+++ b/drivers/w1/slaves/w1_ds2438.c
@@ -62,13 +62,13 @@ static int w1_ds2438_get_page(struct w1_slave *sl, int pageno, u8 *buf)
 		if (w1_reset_select_slave(sl))
 			continue;
 		w1_buf[0] = W1_DS2438_RECALL_MEMORY;
-		w1_buf[1] = 0x00;
+		w1_buf[1] = (u8)pageno;
 		w1_write_block(sl->master, w1_buf, 2);
 
 		if (w1_reset_select_slave(sl))
 			continue;
 		w1_buf[0] = W1_DS2438_READ_SCRATCH;
-		w1_buf[1] = 0x00;
+		w1_buf[1] = (u8)pageno;
 		w1_write_block(sl->master, w1_buf, 2);
 
 		count = w1_read_block(sl->master, buf, DS2438_PAGE_SIZE + 1);
-- 
2.30.1

