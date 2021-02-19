Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5D531F643
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 10:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhBSJIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 04:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhBSJFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 04:05:48 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C19AC06178B
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 01:05:08 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id y7so14282489lji.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 01:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fyxcM3rL+yuYfyz4s20NYKPrfQit00unbZSmdl/USKk=;
        b=qTDs9BEtnbTIKhBniKg4uDJE7XQ1FRMhxT+4YV2Y5O1WWruy96cHF0FobQDy6e7WXe
         fwgR2oyRtJmU14IK8+4E71hpTl3idYkZQYBKRlCqExagkYjdpYfv5SwLMNXM47H/GSvI
         0bl//9EcX371NIuXVdbALkly3NSCxYuy8lIVZMC/As/MoT8RLB/zVwBQxL8LN9iVVoa5
         zWOF+W0WOJXuTrEjm3jtf2aoJSczvDoOOOVKtbeycoS/LQlIQf65+sei+VYpP52JFgI4
         5JNO80TfABuJx6VNop+4gm/UUyxY/ZaxQ/PCf/0D9kv3tGDfRH6kBk0clu2qeTT+o+Jz
         MgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fyxcM3rL+yuYfyz4s20NYKPrfQit00unbZSmdl/USKk=;
        b=hmdjkn/Tb7Ji44KAdEjT9uVdB0CtNL8foeyNJhBStLaDIQBE0YnEe4sfYNNOCtAnxy
         VWtC5r6FkeAGvAiDkNQfNPOXZmK9fz8DLTs/by76Q7rYJilZTTs1jopT9whRytEMEL2i
         iE4k9hH6BW9YcqtfnPAahJC5zX80M4ZvEKuzYR2a1U/g7aYMMlNIIWUA1OqBg8xH39Oi
         ZFOJXKYX2jUMztODCMLNB5eNVz3kU4KFquWl9fimzLCcXFcX1gfjFH+iZPGQBHWN7gFu
         W9qDhFRuPzBajXMexsIwvcM19qE3KB07FbuNpLPgu/buWRC9jgNF7UCc0Utqum+TzLGo
         ioZg==
X-Gm-Message-State: AOAM5332K0jXRxIt4u6ZiXvx327HxZ6nSJas8K1SRiYc1Qpw+6a3p+x8
        hxuNSb6FeBoJuDQewbiAOfo=
X-Google-Smtp-Source: ABdhPJwLWxUr9VDEjc8T/+n7qWLkpjvYxRa3c/SJtcWv339/7Cw/XTpWMgnSRMnKnWobSBhXcfen6w==
X-Received: by 2002:a05:6512:2355:: with SMTP id p21mr5236374lfu.111.1613725506525;
        Fri, 19 Feb 2021 01:05:06 -0800 (PST)
Received: from msi.localdomain (vmpool.ut.mephi.ru. [85.143.112.90])
        by smtp.gmail.com with ESMTPSA id 194sm861708lfo.263.2021.02.19.01.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 01:05:06 -0800 (PST)
From:   Nikolay Kyx <knv418@gmail.com>
To:     gregkh@linuxfoundation.org, adawesomeguy222@gmail.com,
        dinghao.liu@zju.edu.cn
Cc:     Nikolay Kyx <knv418@gmail.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: fwserial: match alignment with open parenthesis
Date:   Fri, 19 Feb 2021 12:03:18 +0300
Message-Id: <20210219090318.20795-1-knv418@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <YC9zX1aIgj/sVnQY@kroah.com>
References: <YC9zX1aIgj/sVnQY@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following checkpatch.pl check:

CHECK: Alignment should match open parenthesis

in file fwserial.c

Additionally some style warnings remain valid here and could be fixed by
another patch.

Signed-off-by: Nikolay Kyx <knv418@gmail.com>
---

v2: Edited changelog, as suggested by Greg KH <gregkh@linuxfoundation.org>

 drivers/staging/fwserial/fwserial.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fwserial/fwserial.c b/drivers/staging/fwserial/fwserial.c
index c368082aae1a..137e97c9406c 100644
--- a/drivers/staging/fwserial/fwserial.c
+++ b/drivers/staging/fwserial/fwserial.c
@@ -1318,8 +1318,8 @@ static int fwtty_break_ctl(struct tty_struct *tty, int state)
 	if (state == -1) {
 		set_bit(STOP_TX, &port->flags);
 		ret = wait_event_interruptible_timeout(port->wait_tx,
-					       !test_bit(IN_TX, &port->flags),
-					       10);
+						       !test_bit(IN_TX, &port->flags),
+						       10);
 		if (ret == 0 || ret == -ERESTARTSYS) {
 			clear_bit(STOP_TX, &port->flags);
 			fwtty_restart_tx(port);
-- 
2.30.1

