Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADFC73F432D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 03:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbhHWBuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 21:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbhHWBuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 21:50:06 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BFBC061575;
        Sun, 22 Aug 2021 18:49:24 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id f7so8863411qvt.8;
        Sun, 22 Aug 2021 18:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kI6/jcFa5ErPZCczz8vBBWVQ0GOCghlyA75YU8iSdHY=;
        b=LeTbRY3rs3d5lKmbbfZhrfTRPBH+XrOYCUt6ZoDrB91yhBg6BDkRSn54h7cQaP8T3C
         yHTrpeZ8PO6p62ReqJjMRFn7uF0NWmgk2NMKA7XDGMB4nKDNL+De/OGBKZfwHGRVN4RE
         xd9iAUxEB1rPijyzjRSTxRvkLo6i6+b6At3lBu1MPvRK3oSjkecwc9iIcIG9bjmniZlU
         NKlKspnTTHttdLwjIEzKNjMqBx87MvMG03INJ8C/MPBZXmFO33nWl9x3KgvSVHpNe/tz
         FUdHgteSGcHQz1+Q5xHOfzXluHhHJjovvPOq0AXZgq9ZQkUwidfis9iPnV4xmGiixzeS
         +cXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kI6/jcFa5ErPZCczz8vBBWVQ0GOCghlyA75YU8iSdHY=;
        b=KrkOJ6fY/1cHW5MMv7C8UU9rMrEV+R9w3eliI9Ka3BvUauj5Xg2EnTMhR17lvXGEhV
         VEW40lHfAj0kicoSo/y0u90Pvz2tO0jH37l5WYZf7slrUOVxT3dvZN4pWr/3gGUOA72W
         RIA2O5FZ1YSNcedq2OY831IoQBWOUtVD4e9BDfyQhSX91rmYkEDGbKPOUtBVHbbSYLzm
         sE73I20np1sMvQ8JX7t4164AlFAbRpW5qBj5ac8XpoJbcDPyNCddczelHXSXUsA0qwNJ
         gzEWPZUj4Skb3Tpq6cCQFhuq9mQi/QHqrLt/xyqBiQEqosVm9s1Cezyd1XK0v6PTsSvI
         Ydxw==
X-Gm-Message-State: AOAM533iAeqI5XqLf0z1lmgnZL7pUMEVsFniiZIdxBM9R26IWzJ1pbW2
        KUB0iUn9Xhmzyv7F/wse053/NSE/5eE=
X-Google-Smtp-Source: ABdhPJyIIRqu4CBJU+fpmsLsNtgyuhMTMWdByDYNwn6t+dok4OIbenjjwps/pFOE484/RJBhd+hIhg==
X-Received: by 2002:a05:6214:2022:: with SMTP id 2mr30950554qvf.38.1629683363259;
        Sun, 22 Aug 2021 18:49:23 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id p187sm7694270qkd.101.2021.08.22.18.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 18:49:22 -0700 (PDT)
From:   CGEL <cgel.zte@gmail.com>
X-Google-Original-From: CGEL <jing.yangyang@zte.com.cn>
To:     Richard Henderson <rth@twiddle.net>
Cc:     Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jing Yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] alpha:smp: fix warning comparing pointer to 0
Date:   Sun, 22 Aug 2021 18:49:08 -0700
Message-Id: <20210823014908.43982-1-jing.yangyang@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jing Yangyang <jing.yangyang@zte.com.cn>

Fix the following coccicheck warning:
./arch/alpha/kernel/smp.c:271:39-40:
WARNING:comparing pointer to 0

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Jing Yangyang <jing.yangyang@zte.com.cn>
---
 arch/alpha/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index cb64e47..adc05c2 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -268,7 +268,7 @@ enum ipi_message_type {
 			memcpy(cp2, cp1, cnt);
 			cp2[cnt] = '\0';
 			
-			while ((cp2 = strchr(cp2, '\r')) != 0) {
+			while ((cp2 = strchr(cp2, '\r'))) {
 				*cp2 = ' ';
 				if (cp2[1] == '\n')
 					cp2[1] = ' ';
-- 
1.8.3.1


