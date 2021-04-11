Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFBA35B656
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 19:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbhDKRdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 13:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbhDKRds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 13:33:48 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BDDC061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 10:33:31 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id d10so7555618pgf.12
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 10:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=4iE0QwYtOYUIJkBsUJWv+G7D+vD/AGIYmK25klck3y0=;
        b=sZSz+Xmu+nEJccFoszRmGiVuedsK1gEd7UgKgIuGaB1/lmB7k2UHKL1yZEuiYlr66a
         emCDhVLbn4qNOY1+KJcDYc2y6hxNp+bgaI1BIjX8JXc5vBZQLeDQPgBjzQBi9qMzoFv6
         dNmEW9wpzykAqm/iw509q7eIr2a67kZMgP8my8c7ZO6QGKXPRNQ1xhsGP+ThVASp7MS8
         mYlkgWko5uc81VJP3S4gbz/XEs35MMv9MuyD4QsD+OpXt07VyyDHxvpCIwgiXFp7RTCn
         hv6Qyeatfhuvb39sdYhYN64LfbYN80XPmVYOaYecCdfzvFchBycuxOW4S1hm7wUF7ihc
         xeLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=4iE0QwYtOYUIJkBsUJWv+G7D+vD/AGIYmK25klck3y0=;
        b=j5uB2ROqcelr7mySwO4O17guE0otb3Q0vR06oZUpeayBBFQaZ+hT/eCRtJ//X5qYuV
         wN+wqH05LDKmgZnkKC0C26mc9tkCkZwc+7TsjN7qzVFWpdJrevf3fMUGqjZ/I3+koVHY
         d9B3Eg2bH3p4J6rT+SMsQKNIodk+WSc9HmS5c2N88CS6aH9QRDG5uVWH4iWyMGxogNhE
         kcHV0RkSDUTsut7O0nIoljsF6K7/jDULwij2jOFCRpVvKS64KT8jOcGF4R1Z4SzfPstS
         eQGIskBXh9HhmATQMVZeDBL8EE6Gx+yhvgLi3SSRx2HzZ2oFMA3zPHeIs/7QcmqLeyRb
         vjXA==
X-Gm-Message-State: AOAM530h4kGoNe7AOMQdVJ2tK6PFZ5/R+HCQoWWO6wTcb97dqOA+EIzY
        KE51mjN8qLnQ4TWCclrtMKikji3gyQ3EJQ==
X-Google-Smtp-Source: ABdhPJxeTxi0TcPAAmBRl/Cj1ZT36VOx3yuZp2HoJr1e9TzIgvg4SfRzylnZCd8UDaGBQZWhBrxS9g==
X-Received: by 2002:a63:181c:: with SMTP id y28mr23783254pgl.175.1618162410938;
        Sun, 11 Apr 2021 10:33:30 -0700 (PDT)
Received: from kali ([103.141.87.253])
        by smtp.gmail.com with ESMTPSA id t10sm8403802pjy.16.2021.04.11.10.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 10:33:30 -0700 (PDT)
Date:   Sun, 11 Apr 2021 23:03:23 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH] staging: rts5208: remove unnecessary ftrace-like logging
Message-ID: <YHMy457UGosfeaC0@kali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed unnecessary ftrace-like logging by simply deleting that statement
as we have other modes of logging like ftrace.
Reported by checkpatch.

Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
---
 drivers/staging/rts5208/xd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rts5208/xd.c b/drivers/staging/rts5208/xd.c
index 0f369935fb6c..a305e15dfb9c 100644
--- a/drivers/staging/rts5208/xd.c
+++ b/drivers/staging/rts5208/xd.c
@@ -1628,7 +1628,6 @@ static int xd_finish_write(struct rtsx_chip *chip,
 	int retval, zone_no;
 	u16 log_off;
 
-	dev_dbg(rtsx_dev(chip), "%s ", __func__);
 	dev_dbg(rtsx_dev(chip), "old_blk = 0x%x, ", old_blk);
 	dev_dbg(rtsx_dev(chip),	"new_blk = 0x%x, ", new_blk);
 	dev_dbg(rtsx_dev(chip), "log_blk = 0x%x\n", log_blk);
@@ -1806,7 +1805,6 @@ int xd_delay_write(struct rtsx_chip *chip)
 	int retval;
 
 	if (delay_write->delay_write_flag) {
-		dev_dbg(rtsx_dev(chip), "%s\n", __func__);
 		retval = xd_switch_clock(chip);
 		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-- 
2.30.2

