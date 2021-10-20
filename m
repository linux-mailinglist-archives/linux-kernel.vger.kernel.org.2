Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26815434398
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 04:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhJTCoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 22:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhJTCoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 22:44:54 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC28BC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 19:42:40 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id t184so8192041pgd.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 19:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AuHOCXn0MgJZ/GGgc1ig2esAfbCiX83Y6ea6Rt6Hegk=;
        b=aAoDXDzKRcVkvN1E3W7LTxe9LlQ3WoA2DEFRNRZbNENkv8E3Nhlwj8M4EvjFGW6oz6
         mRv0zUsK2c8Dn6po7AtlE1DshMUkdjO5uVMi0GdTT1qzFg0qC7W0f2UXihcRUqr2zzeV
         nLQnnUvO25NmnWZo2wNoeKHtFRMfvaGyHWbdOk0rDAQc8JcoRHvr0mTRzY/Nm/Xr4lUu
         A+85I55XpMWHADCObDJaj24nx6eypQqHhoeavVG4gvy1JfDl1jhVnWCSB4Yhs960x2I8
         z7LQ3z8Cxy3R3W1qqWsEPe4HcAPPXowmiNCuWT8p6pYccEQvzdHoFKfzcYKuMVYPYbgN
         bviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AuHOCXn0MgJZ/GGgc1ig2esAfbCiX83Y6ea6Rt6Hegk=;
        b=PJg68IqfX3h75JerBv+e6y/AqQgMuDn03QkRymBs50DhCr7++FHdFpsQp6pXzNWGp4
         f4xdJrd+CMtFra1sJAILt322WWeXcQEgM5TE/W+S4EpDGk3vovt1v1nWK+n9aASsihLy
         xYLdISBeQE7N5jORuMhCTytgo9exg3yAV6ThhmPoCNGNu/7M2jwKq6pkaqRBkpQLrJDU
         Re/3j9gKJz/c2QsIeyd7BTsQYMrEUCnnU/ezLE50U1eKyUi9s1kQsI5Q8OjrZ9wf4Z87
         Y6FO/HiSHxmrtYFhAlT+AYGIvfc6QnfaJubjnrQoHEdu7ArUUnFmSV6/mwJyhyFhLnkn
         st4w==
X-Gm-Message-State: AOAM532LAKdh2rO9d6ZsNA1rJ35LhoK0KJa94qWt0RB0nZJov9n8jd1s
        iA8ClTtYlu2noEVKy4nPADU=
X-Google-Smtp-Source: ABdhPJz2ewfIrL/jLwxd44PNvWxm1zNj4CBrjU3Ho9u/sbX0ocZwkTjDS201CaJbNemi6yJJMT1aEw==
X-Received: by 2002:a63:701b:: with SMTP id l27mr17564692pgc.382.1634697760199;
        Tue, 19 Oct 2021 19:42:40 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id m186sm532985pfb.165.2021.10.19.19.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 19:42:39 -0700 (PDT)
From:   luo penghao <cgel.zte@gmail.com>
X-Google-Original-From: luo penghao <luo.penghao@zte.com.cn>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-kernel@vger.kernel.org, luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] cdrom: Remove redundant variable and its assignment.
Date:   Wed, 20 Oct 2021 02:42:29 +0000
Message-Id: <20211020024229.1036219-1-luo.penghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable is not used in functions, and its assignment is redundant too.
So it should be deleted. Also the inner-most set of parentheses is no
longer needed.

The clang_analyzer complains as follows:

drivers/cdrom/cdrom.c:877: warning:

Although the value stored to 'ret' is used in the enclosing expression,
the value is never actually read from 'ret'.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
---
 drivers/cdrom/cdrom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index feb827e..40970b8 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -864,7 +864,7 @@ static void cdrom_mmc3_profile(struct cdrom_device_info *cdi)
 {
 	struct packet_command cgc;
 	char buffer[32];
-	int ret, mmc3_profile;
+	int mmc3_profile;
 
 	init_cdrom_command(&cgc, buffer, sizeof(buffer), CGC_DATA_READ);
 
@@ -874,7 +874,7 @@ static void cdrom_mmc3_profile(struct cdrom_device_info *cdi)
 	cgc.cmd[8] = sizeof(buffer);		/* Allocation Length */
 	cgc.quiet = 1;
 
-	if ((ret = cdi->ops->generic_packet(cdi, &cgc)))
+	if (cdi->ops->generic_packet(cdi, &cgc))
 		mmc3_profile = 0xffff;
 	else
 		mmc3_profile = (buffer[6] << 8) | buffer[7];
-- 
2.15.2


