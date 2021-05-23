Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8A038D966
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 09:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbhEWHM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 03:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbhEWHM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 03:12:26 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762B5C061574
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 00:10:59 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id e22so2006419pgv.10
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 00:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=di0v/Su4ogaC/7RSbDqrJ5oBV8Ra49+j+a8H+EJD/r0=;
        b=MvhEY+q1EqVVsJNMos9LpXff3Ngf9M8X2S/1QNnZnbSeStQE2fD/pzDZ5msfQSgvnb
         eITaqJQUqC9DjH//uCyH9GG2l7ECPNHzkBzYydtdhyV8WBp+EWmzNpSmslEFa13UbKfW
         Y6+8KolpZ2FxOjKRQTJ6y5CiYSfVlE6YnOghifFD8td357sNaCDejiSUVx2UeT0Bl2D8
         m3ivFnzeSiznA886mI77yd9KF1ihCujdTms6N5xy7QIsm7w4tQhoIIhcHcfeajPeEMha
         tCJifZJ5vgQTLacbnX5L8M27mPFVooIpKDdxU+ATZDgmlIpqvix/E2TQJWzmwQwMF2lc
         YXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=di0v/Su4ogaC/7RSbDqrJ5oBV8Ra49+j+a8H+EJD/r0=;
        b=VVwT+jZ+BPxT/UQNxFD+Lrpq4vJ2kjVUR0KcG+wl16NWu2w9zmZUHRq1W5BWNl5Izb
         PqqNE3Asfv/HWPud2TczhJ3JL6D2J8IieIlrncR3ige+Zsj57viJeeO7d3cGD0pRjwpR
         mcIT+CjAWQqWuTHNnQsdlKQs0yBzjHYiHFZiHNiJX7YvKPOgbs9YvYmHZDR00nX0cnG7
         YC7hYQtrgY3YlDq4m3H7wuBnzBfD8Ad/0XrCTGvHrd5h5TPoix4InyFwQ9KnbHo2g8I4
         C+wGAnZe8ACzUp9uUA/0OFcmf+Dc/oUPUBFqruGHWafPGr/fv6Q7+uNZ85uBRIIpbrMB
         EYgA==
X-Gm-Message-State: AOAM533Ye4BNbJZ5tasl4OeLYywwNq2hRlF/GuU27myfP3d4Sad83qal
        bnew+/Fh5ebFPQp6glCVTggK0Q==
X-Google-Smtp-Source: ABdhPJw1WBxLaIbmlYnkHvsDYWNb4L37ghlz6gCS0BecfJPz3AMCIFPON7+3UJ3UQKjarl2H+ATNsg==
X-Received: by 2002:a05:6a00:2308:b029:28e:d370:d435 with SMTP id h8-20020a056a002308b029028ed370d435mr18610442pfh.31.1621753858695;
        Sun, 23 May 2021 00:10:58 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id f80sm7841504pfa.160.2021.05.23.00.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 00:10:58 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, linux-power@fi.rohmeurope.com,
        Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] regulator: bd70528: Fix off-by-one for buck123 .n_voltages setting
Date:   Sun, 23 May 2021 15:10:44 +0800
Message-Id: <20210523071045.2168904-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The valid selectors for bd70528 bucks are 0 ~ 0xf, so the .n_voltages
should be 16 (0x10). Use 0x10 to make it consistent with BD70528_LDO_VOLTS.
Also remove redundant defines for BD70528_BUCK_VOLTS.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
I think this fix does not need "Fixes" tag because in original code the
.n_voltage is greater than correct one. The latest selector is not valid
in the linear range setting anyway.
 include/linux/mfd/rohm-bd70528.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/mfd/rohm-bd70528.h b/include/linux/mfd/rohm-bd70528.h
index a57af878fd0c..4a5966475a35 100644
--- a/include/linux/mfd/rohm-bd70528.h
+++ b/include/linux/mfd/rohm-bd70528.h
@@ -26,9 +26,7 @@ struct bd70528_data {
 	struct mutex rtc_timer_lock;
 };
 
-#define BD70528_BUCK_VOLTS 17
-#define BD70528_BUCK_VOLTS 17
-#define BD70528_BUCK_VOLTS 17
+#define BD70528_BUCK_VOLTS 0x10
 #define BD70528_LDO_VOLTS 0x20
 
 #define BD70528_REG_BUCK1_EN	0x0F
-- 
2.25.1

