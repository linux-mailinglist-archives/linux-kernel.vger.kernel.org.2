Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2C032E560
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 10:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbhCEJzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 04:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhCEJyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 04:54:46 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECE9C061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 01:54:46 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id u18so1129591plc.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 01:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/3Uq++MZu/Jee4MJTJAGsdbXNgaNOIautHu8ap1IY+w=;
        b=attgs5SH5YVKX/51L234H/XBnQGtKqEU400rUKPVMTmuQ2WqIfvfNqmUBEhDWKC55G
         m/oL7ueb/J4dCcbKYzDqomX9tr9GbcZH/cwd5b2aqkftJa5edoPG4G13IkMMe0iEn9SB
         LpmZoVb5cjEGFzeL7MdxYJP4v2R7GLSmpm8HxUrwP203LL6Gv1uNqckpsaCCzkW/aXAZ
         COHGnDgFWH9pvabcqg+Y/gTwBAu0wxCl4/mXcDEwCIbY+6n+IGeQw5562flBxkbYKyOd
         Dbnoh8CEJYOkCwF0RIAl7DS8nek3nJblcQQb8tUmrFg/QuBRYaoVoL+Ad75kkjAcbSdC
         r65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/3Uq++MZu/Jee4MJTJAGsdbXNgaNOIautHu8ap1IY+w=;
        b=EntIOTaFcFcNxlyf451KJ4oD71DKlIFw/saY1TwmLAQtMPI1IofM1Eg7lUl3C59Hy3
         2QSDvfZygQfw8aaqslKOOBI2phVePNciuf9Nc8IWkcSyW8vi4u9mLugxZHL9Lb8oj9/N
         orBwmsdChjvJOi3eyWKJDTQ3+Dm1iNuukVvR2oeJ9UspYzrApTQbzuKyqCRohXMcjiDP
         N9evr3EQ8N0GOClYAS9oKbJsxL+ktw+jBYjHa8N6+oYfXbXI5CUdGNwbzP+P2i+JZD5t
         hJjHQikZSQrS8TWrw89DPpDfssvNQJ11f1MbZ6rjcw4h4OcX1dalsyj0OZSn2dxL5FLs
         1Chw==
X-Gm-Message-State: AOAM532qzLdf4u1luinwhzu6VUtJdydO4ymo3bKS4a7lMlbpi6SFaGom
        QrsHyKzFLjxApv1e228iEBmcUA==
X-Google-Smtp-Source: ABdhPJzrRsfwo3KRZ6IPRpn/aSkxmsCCnSVOb8Ogi/bCdTBdZmtAcZ0h4kDCBZlewXeYn5y/SSL1Yw==
X-Received: by 2002:a17:902:c382:b029:e4:7015:b646 with SMTP id g2-20020a170902c382b02900e47015b646mr8025801plg.83.1614938085585;
        Fri, 05 Mar 2021 01:54:45 -0800 (PST)
Received: from x1.hsd1.or.comcast.net ([2601:1c0:4701:ae70:a46:9050:1f13:4024])
        by smtp.gmail.com with ESMTPSA id c22sm1967621pfl.169.2021.03.05.01.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 01:54:44 -0800 (PST)
From:   Drew Fustini <drew@beagleboard.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Qing <wangqing@vivo.com>, Jiri Kosina <jkosina@suse.cz>,
        Eric Biggers <ebiggers@google.com>,
        Naoki Hayama <naoki.hayama@lineo.co.jp>,
        SeongJae Park <sjpark@amazon.de>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Cc:     "Gustavo A . R . Silva" <gustavoars@kernel.org>
Subject: [PATCH] scripts/spelling.txt: add "overflw"
Date:   Fri,  5 Mar 2021 01:51:53 -0800
Message-Id: <20210305095151.388182-1-drew@beagleboard.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add typo "overflw" for "overflow". This typo was found and fixed in
drivers/clocksource/timer-pistachio.c.

Link: https://lore.kernel.org/lkml/20210305090315.384547-1-drew@beagleboard.org/
Suggested-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Drew Fustini <drew@beagleboard.org>
---
 scripts/spelling.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index f57e3e9538b0..f208832cf234 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -1013,6 +1013,7 @@ oustanding||outstanding
 overaall||overall
 overhread||overhead
 overlaping||overlapping
+overflw||overflow
 overlfow||overflow
 overide||override
 overrided||overridden
-- 
2.27.0

