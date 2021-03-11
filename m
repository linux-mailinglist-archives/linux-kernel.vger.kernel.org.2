Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B12C3337D22
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 20:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhCKTBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 14:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhCKTBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 14:01:08 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3928C061574;
        Thu, 11 Mar 2021 11:01:08 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id s21so195936pfm.1;
        Thu, 11 Mar 2021 11:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=69zbOE+eDJpfPRJTGrLZEh6ILNupyF57QQ2VfeIJuqc=;
        b=QQw6XDQYIL0OSH/oaqIEm6igMR8UWHIsqP0ZtYCiIOTBxOrijypvw3LppvNKxhNPfK
         lCAez1ke/u8a5EHDlcDe2PCB6KRMPTwARJ5s3SZC81bYuDcoO3fqpqCrVoTE9J9aWCVh
         jYEfqsxeMxkp7/OrT5/r1heFJsaMt2+rTzG1J2gEYQnf+Kb+O6G5P/QOb5cf+IIRt3Mj
         fsc2M1k4pgXUGKT4GVl8r3A/8iolKPrUXdgfJ5E1Nw6DyI/1GPeGC0kz4islZ6rn1qYZ
         9q3ReUiHK5MLrIj+YDy6YFjW54lRmIwlM0PBC9dsetByRfjgjEh6ql1W4zz7zC+QTsVB
         MAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=69zbOE+eDJpfPRJTGrLZEh6ILNupyF57QQ2VfeIJuqc=;
        b=bvC2ScEangorex6XVUvZTEYi2Svsh8jI2qyoUGSCEG/iXrKoGVXL6638anDD+KaxoZ
         J+63odqA2dXB1QeYh2/00GT13QK9St+DoSEy96nJV1h3Pgk00L746a4fk0r152A3R+6U
         j9fug3fd3lJvFV+otTNn9C//CEyeA49fRlmYP/KdRuUVhfUlUi+LJH4v2wK2OI5tBQCB
         3+wiCZPH80OGwdIDOdwEnT5lCSEVEYT6jLiJXJzyNd4JF/e1crihJOCIereETUYf4smM
         lYdyi2YTV0EmrRD3/GVKgtN+FiUPQ0v4ZXyaUqpyFQ5o8gVZA90Qv0C2WIh2OzWNRaRW
         Yi1Q==
X-Gm-Message-State: AOAM533unTEhXb3iePRZW8s5IJ+yBf6nierI/c5ieRH3qGBiqMxmKjuI
        jxyO2JXY2y1Euk2zFzuD8oM=
X-Google-Smtp-Source: ABdhPJxwc1mtWuzDozMhXzdZBmp02LTYEOBFbN/P8884bL3q0tdx6swf8Abt9Jeq73jFqFIw66DMNQ==
X-Received: by 2002:a62:7d14:0:b029:1f6:18a1:6b98 with SMTP id y20-20020a627d140000b02901f618a16b98mr8692614pfc.15.1615489268085;
        Thu, 11 Mar 2021 11:01:08 -0800 (PST)
Received: from localhost ([122.167.149.62])
        by smtp.gmail.com with ESMTPSA id v185sm3034637pfb.125.2021.03.11.11.01.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Mar 2021 11:01:07 -0800 (PST)
Date:   Fri, 12 Mar 2021 00:30:58 +0530
From:   Shubhankar Kuranagatti <shubhankarvk@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     gustavoars@kernel.org, lee.jones@linaro.org, vulab@iscas.ac.cn,
        chunfeng.yun@mediatek.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drivers: usb: host: fotg210-hcd.c: Fix indentation error
Message-ID: <20210311190058.yudmivcbok56itay@kewl-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A space was given after tab key. The extra space has been removed.
This is done to maintain uniformity in the code.

Signed-off-by: Shubhankar Kuranagatti <shubhankarvk@gmail.com>
---
 drivers/usb/host/fotg210-hcd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/fotg210-hcd.c b/drivers/usb/host/fotg210-hcd.c
index 5617ef30530a..b20898dda1f3 100644
--- a/drivers/usb/host/fotg210-hcd.c
+++ b/drivers/usb/host/fotg210-hcd.c
@@ -408,17 +408,17 @@ static void qh_lines(struct fotg210_hcd *fotg210, struct fotg210_qh *qh,
 		temp = snprintf(next, size,
 				"\n\t%p%c%s len=%d %08x urb %p",
 				td, mark, ({ char *tmp;
-				 switch ((scratch>>8)&0x03) {
-				 case 0:
+				switch ((scratch>>8)&0x03) {
+				case 0:
 					tmp = "out";
 					break;
-				 case 1:
+				case 1:
 					tmp = "in";
 					break;
-				 case 2:
+				case 2:
 					tmp = "setup";
 					break;
-				 default:
+				default:
 					tmp = "?";
 					break;
 				 } tmp; }),
-- 
2.17.1

