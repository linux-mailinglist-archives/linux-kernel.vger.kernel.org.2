Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8EBB39EB09
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 02:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhFHAzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 20:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbhFHAzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 20:55:43 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A3FC061574;
        Mon,  7 Jun 2021 17:53:51 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id md2-20020a17090b23c2b029016de4440381so1156969pjb.1;
        Mon, 07 Jun 2021 17:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m6uCAgEmRBvwgNVPuMnu8ZzA3zqXUQKko37CRRAo32U=;
        b=DxBRAnjdlGnKI0c5WbmCz4z21w/1VTwspI1UzQ1p/QxpQ7ZpsCAXPhNKkrTjthK9Im
         yJE+Wvjr//vI9YRjVhd6m8gYcBLY1x2XZ1RXU3l8PmIqKXhj8MlSKr7GfAiA1o054WJl
         69riA84U05mkiS7kgnn07zVgw9CAnysdQ/Vw2RlEeaoQv9ukRP0o/o7jqUwRBYEVgbuW
         I8D2ixgHO45Fs+HeX7js3bttWkEKRU9IN6eObbplZ169JTxNXE0fVQul0ZBkcDYPpDTf
         iS3au9O47u7PQy7Jo5sCrlba+Gjrf6PNuYhF4QsG9Qux0tCrU86i8lOrPk2IzsVwCHbd
         Fs3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m6uCAgEmRBvwgNVPuMnu8ZzA3zqXUQKko37CRRAo32U=;
        b=lUjkBw4IFPCDoprs2Has/vkkpCeZstAa+V3MkrqjG6tNDdi1NzCTq2S6FVnJlBfwkW
         hByQHbI0RpW3hS6v0sijh1EUnXdRkPeqUxBIc/OTGJJCcdxMnyqGJxYn4yNL1oLJWu0Q
         ZSLO1KC7uNZveZ1dVkbh57hhO0FxxUvqhR4ZDa2BDw8fxdeGcutCtU8s7KuPlrcExRXI
         eelgHV+WJLsp0bhhd8zNTd+JjpVvPFNT2LBktKVnl280ctHQ8+y2XwjP0jWp77UCBkq9
         KcP3efhDTb+kf3nz2R9XrQodu9FPVKkJ8kHGjb6cWtjLs9VOuxhAP5d2CA2eCrP0ZxY4
         VeiA==
X-Gm-Message-State: AOAM531emRe6S82bbnD47TsQ4txPjPD5un7/NZcw9tZYn4zOkvZhgVSU
        nE1Pa7KkcOx+hklBlrHXiWI=
X-Google-Smtp-Source: ABdhPJwtAcFvqkph1cTg5IvbJrhX60lTqttu5NMTKEr9TMwmaxH1u+/uw630JwmoNpyCuHSt9HdqPg==
X-Received: by 2002:a17:90a:ea14:: with SMTP id w20mr1881028pjy.65.1623113631254;
        Mon, 07 Jun 2021 17:53:51 -0700 (PDT)
Received: from athina.mtv.corp.google.com ([2620:15c:211:0:34c3:22d8:b92a:ddfa])
        by smtp.gmail.com with ESMTPSA id y5sm9313181pfb.19.2021.06.07.17.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 17:53:50 -0700 (PDT)
From:   =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <zenczykowski@gmail.com>
To:     =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brooke Basile <brookebasile@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lorenzo Colitti <lorenzo@google.com>,
        Yauheni Kaliuta <yauheni.kaliuta@nokia.com>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>
Subject: [PATCH] f_ncm: ncm_bitrate (speed) is unsigned
Date:   Mon,  7 Jun 2021 17:53:44 -0700
Message-Id: <20210608005344.3762668-1-zenczykowski@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maciej Żenczykowski <maze@google.com>

[  190.544755] configfs-gadget gadget: notify speed -44967296

This is because 4250000000 - 2**32 is -44967296.

Cc: Brooke Basile <brookebasile@gmail.com>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Lorenzo Colitti <lorenzo@google.com>
Cc: Yauheni Kaliuta <yauheni.kaliuta@nokia.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>
Fixes: 9f6ce4240a2b ("usb: gadget: f_ncm.c added")
Signed-off-by: Maciej Żenczykowski <maze@google.com>
---
 drivers/usb/gadget/function/f_ncm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index 019bea8e09cc..0d23c6c11a13 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -583,7 +583,7 @@ static void ncm_do_notify(struct f_ncm *ncm)
 		data[0] = cpu_to_le32(ncm_bitrate(cdev->gadget));
 		data[1] = data[0];
 
-		DBG(cdev, "notify speed %d\n", ncm_bitrate(cdev->gadget));
+		DBG(cdev, "notify speed %u\n", ncm_bitrate(cdev->gadget));
 		ncm->notify_state = NCM_NOTIFY_CONNECT;
 		break;
 	}
-- 
2.32.0.rc1.229.g3e70b5a671-goog

