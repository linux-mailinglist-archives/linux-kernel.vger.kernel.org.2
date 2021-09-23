Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 974364162B5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 18:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242533AbhIWQGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 12:06:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35512 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242432AbhIWQGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 12:06:08 -0400
Message-ID: <20210923153339.993635594@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632413076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=gvk5avOatu7ppvqUax7HoJT1dciqMJHRnruXlvTG3/c=;
        b=Dfo/IhbGBaHEofB6Kj/tQoeT7xjtDf1Y2jb9g2mK3Fdh/Yp5GqxHYHV1Wp4zL1H+SM+Y5g
        WPocxiwMVn81oYzjpj/z7vD5yf0ce1w2o5y7iRgbzDP0v85llBFCtHZSVXxlH9QkVfoePx
        6t6CuufictIs7TdqEbvNKORUA8sZxkYX4J8UiX89XWgL12l6JPO1et/aGmYfYZnByxSZeg
        q9VG9JdcIeu+qgHuN01sPXGPC7aWjHikddFWQpVskr6l0+L1BxfetK+RTF4f8qaL0dhrqV
        RbdX6Lvj7QdL9rtQWJyLh8V4UOp4gkr3VX5Q/luuL0olMlhpNfCPRTGapfi7Qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632413076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=gvk5avOatu7ppvqUax7HoJT1dciqMJHRnruXlvTG3/c=;
        b=qi0utS9yTS3jGucy87DdPa2Yqp/GGBDQKDeicMhGPvm926R9AtNZyOYqynL8A9o17n67K8
        HP1yK5Aajtdf/7Cg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>
Subject: [patch 10/11] posix-timers: Use hrtimer_forward_now()
References: <20210923153311.225307347@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 23 Sep 2021 18:04:35 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the open coded invocation of hrtimer_forward() with
hrtimer_forward_now() which does exactly the same.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-timers.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -294,8 +294,7 @@ static void common_hrtimer_rearm(struct
 {
 	struct hrtimer *timer = &timr->it.real.timer;
 
-	timr->it_overrun += hrtimer_forward(timer, timer->base->get_time(),
-					    timr->it_interval);
+	timr->it_overrun += hrtimer_forward_now(timer, timr->it_interval);
 	hrtimer_restart(timer);
 }
 

