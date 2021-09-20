Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 479F44113A1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 13:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbhITLje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 07:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhITLjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 07:39:33 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0794C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 04:38:06 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id x10-20020a056830408a00b004f26cead745so23114342ott.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 04:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=JnTk4XaCxbPtC4rhZXkrx2BTn2oZk+82FKzVoc6BS/o=;
        b=g2ihOB6F6u66xHLOXZBNTbuI4AfwuM8bBGdCekC1UhULBRxCiJIsP/QrlYUdjdNRT1
         TCUVPngricwY1yOqdaqzzAjVb9rtrSnscuJzMylacGCJpuYeApnMrb+SAeVJIjhM1lXF
         deKpUYcFvE/9u7xhNWODlQqTjZG6lowaqibZ3zYE+tLCkRgsKq9t1SSnhKhac6S+tT74
         1owMPEbeW/F0Ob24rR8nJLRFreBnzakvlG48fFI9XlcLUJlU2kiUKGAMUZKsWR0VjKl6
         vJfk2fo1AlG0T9lLCz8pY8MKSUBVI9zNJP0iMkxuqD0IjpVzTwk7QJMA+RdRP9GruRS1
         +JTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=JnTk4XaCxbPtC4rhZXkrx2BTn2oZk+82FKzVoc6BS/o=;
        b=yt1LtqSo7EVmbqFcq3U5Vl26+8nMrzxHg2yLGoUPr9bGJ1RD0qXOYkdO7zBvhcUH+f
         tBfERjtf3cZtUnpEfPUoQIc+gmQDerO+bjTmPTJI8RlkdqWuuDzFppS620ler2RQLzKx
         Kg3uDQK5AwL+fsv7kyPL3OxGav665bngSKZ7+wTw5UnszUvabwgeAtwKgwNFAfv44e/w
         wbpsFJVc23dR3QPtmKQ28QNbnTlwcrmHPS1VMtEpo+kLLbEVpPEZqIvdVUthm3ziX8fl
         llsIG8aFV1HC25wcWxNflBAxtJdoK5Gsjgr8NOBp2xxGET5Q0JDjC0UOoQCCbB8gXI8N
         Aapw==
X-Gm-Message-State: AOAM533r5kP2Tk8RWnztEXc2EbpuQuL08u0hCL4+vSZWyZRBbJbZe0Td
        He5ZKi381D5WKWJOp2Wjqw==
X-Google-Smtp-Source: ABdhPJwWuzoVgQAHkOUebCTCmqkHgcxVPWHGXY+lO83y/yfkxq3sWFQ2o3v2YiCnz/Z0fCVM4gBj1A==
X-Received: by 2002:a05:6830:204d:: with SMTP id f13mr3769066otp.123.1632137885944;
        Mon, 20 Sep 2021 04:38:05 -0700 (PDT)
Received: from serve.minyard.net ([47.184.156.158])
        by smtp.gmail.com with ESMTPSA id c10sm3475843ooi.11.2021.09.20.04.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 04:38:04 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:85f2:365c:992b:e354])
        by serve.minyard.net (Postfix) with ESMTPSA id CAB241800EF;
        Mon, 20 Sep 2021 11:38:03 +0000 (UTC)
Date:   Mon, 20 Sep 2021 06:38:02 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Anton Lundin <glance@acc.umu.se>
Cc:     openipmi-developer@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Openipmi-developer] Issue with panic handling and ipmi
Message-ID: <20210920113802.GC545073@minyard.net>
Reply-To: minyard@acm.org
References: <20210916145300.GD108031@montezuma.acc.umu.se>
 <20210916163945.GY545073@minyard.net>
 <20210917101419.GE108031@montezuma.acc.umu.se>
 <20210917120758.GA545073@minyard.net>
 <20210917125525.GF108031@montezuma.acc.umu.se>
 <20210917131916.GB545073@minyard.net>
 <20210917132648.GG108031@montezuma.acc.umu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917132648.GG108031@montezuma.acc.umu.se>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Well, that was dumb.  Fix follows...

Thanks for working on this.  On your approval, I'll send this to Linus.

-corey

ipmi:watchdog: Set panic count to proper value on a panic

You will get two decrements when the messages on a panic are sent, not
one, since 2033f6858970 ("ipmi: Free receive messages when in an oops")
was added, but the watchdog code had a bug where it didn't set the value
properly.

Reported-by: Anton Lundin <glance@acc.umu.se>
Cc: <Stable@vger.kernel.org> # v5.4+
Fixes: 2033f6858970 ("ipmi: Free receive messages when in an oops")
Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 drivers/char/ipmi/ipmi_watchdog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_watchdog.c b/drivers/char/ipmi/ipmi_watchdog.c
index e4ff3b50de7f..9a64a069ffd1 100644
--- a/drivers/char/ipmi/ipmi_watchdog.c
+++ b/drivers/char/ipmi/ipmi_watchdog.c
@@ -531,7 +531,7 @@ static void panic_halt_ipmi_set_timeout(void)
 	/* Wait for the messages to be free. */
 	while (atomic_read(&panic_done_count) != 0)
 		ipmi_poll_interface(watchdog_user);
-	atomic_inc(&panic_done_count);
+	atomic_set(&panic_done_count, 2);
 	rv = __ipmi_set_timeout(&panic_halt_smi_msg,
 				&panic_halt_recv_msg,
 				&send_heartbeat_now);

