Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30FA3452D80
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 10:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbhKPJGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 04:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbhKPJGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 04:06:14 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F56DC061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 01:03:16 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id e3so48175238edu.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 01:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=z/y7xfx33pANBI3gQ0whW/Un+DpKlYglv0noSUXoSPA=;
        b=aYoNW7iKC+JhmCQPFc2PxarELV3dglxD/yCosVY+Wx/volJI805GOlWm2FYUA4Yd17
         F06b+svw+DySKyUPRw65weHOYbbsrFQX1AEkgaXQL8oNWhfcBDckFgYdNZgW/DUWznh6
         e1R/JJWYV9o85gGQASNOfuxUNKBQ1rEQkW/VCfgYe5rS50hm9A4Kh4+TcPFhIFcidbms
         jzIWkVeG/J/+DvvXBtPoa3/e76J+GDgeYCUGBIEFkA/iSTfijNUGelaNra5ySZ4G1N0R
         wMgGTlMySG096vdabXl6XIpckmmyN6lopY+SvMFRpvpRPUVtOe+lw6P1QskNvHrWEhJB
         YkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z/y7xfx33pANBI3gQ0whW/Un+DpKlYglv0noSUXoSPA=;
        b=RStyQk+clgtAt6AzBOMkBz4QJVGLMZ58+fETIpsDRtjQfrIzuts4wC1bgCn7ejJuxK
         XMNA+I7Nv755jCLnJQ0i24pgijy5ru8393I+NEwlEKM//AvtYAVP8Pp1rNK7T760tDs6
         zi93Cu9A4SP18I/94pTYAR7Cm6RXVcyNKPHUro2fLbSPW7hNFGejKvin50XlGUdWt1Q5
         6fhO3g5XbvsPJNHmuWLVeqeLUllvJh6kFJCfICDVo/w4Hoz2PxTE6wvFs/DzCUYb4Ogf
         8nD4O53/9acDq253Ra6BHD4Y4nr5aoLg2AbPRTLvLaBjVmyOjDHwPThWAgFGxBNDsorf
         20Hg==
X-Gm-Message-State: AOAM532fmBvPVR5Y7+gAZLnmIb9AmDEXYEzpMI0oMqfu1+shpYQ2Urrh
        1xH6kZkNW2qoT23rwObQHhVEMZ/pG3k=
X-Google-Smtp-Source: ABdhPJytirSYuri1pq3wjFjr4XgT0Aq5HYwuO2yrSdheEJJ+Ww03euNwUgv2M6kCvjpfnQc8jlSXZg==
X-Received: by 2002:a05:6402:5216:: with SMTP id s22mr8036891edd.291.1637053394638;
        Tue, 16 Nov 2021 01:03:14 -0800 (PST)
Received: from localhost.localdomain (host-82-61-38-115.retail.telecomitalia.it. [82.61.38.115])
        by smtp.gmail.com with ESMTPSA id a17sm1759144edx.14.2021.11.16.01.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 01:03:14 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     elver@google.com, gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com>
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in __might_resched
Date:   Tue, 16 Nov 2021 10:03:12 +0100
Message-ID: <7655311.pJQ0NNsvTN@localhost.localdomain>
In-Reply-To: <5631140.hc6UrLtR2d@localhost.localdomain>
References: <000000000000be6cff05d0e3709b@google.com> <5631140.hc6UrLtR2d@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart2046742.yJbYBYnt3e"
Content-Transfer-Encoding: 7Bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--nextPart2046742.yJbYBYnt3e
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Tuesday, November 16, 2021 9:53:53 AM CET Fabio M. De Francesco wrote:
> On Tuesday, November 16, 2021 9:09:11 AM CET syzbot wrote:
> > Hello,
> > 
> > syzbot has tested the proposed patch but the reproducer is still 
triggering 
> an issue:
> > BUG: sleeping function called from invalid context in __might_resched
> > [...]
> 
> The reproducer is still triggering an issue, but this time it looks like it 
> is triggered by a different path of execution.
> 
> The same invalid "in_interrupt()" test is also in con_flush_chars().
> 
> Let's try to remove it too...
> 
> My first idea would be to replace "if (in_interrupt())" with the same 
> "preempt_count() || irqs_disabled()" I used in do_con_write(). However I 
> noticed that both do_con_write() and con_flush_chars() are only called from 
> inside con_write() (which, aside from calling those functions, does nothing 
> else).
> 
> So why not remove the if (in_interrupt()) from both them and use if 
> (preempt_count() || irqs_disabled()) just once in con_write()?
> 
> I think this should be the right solution, but I prefer to go one step at a 
> time.
> 
> Therefore, I'll (1) use the same (redundant, if it was used in con_write()) 
> test also in con_flush_chars(), (2) wait for Syzbot to confirm that it 
fixes 
> the bug, and (3) wait for maintainers review and suggestions about whether 
or 
> not moving those tests one level upper.
> 
> #syz test:
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> 
> ---
> Fabio M. De Francesco

Don't know exactly what happened, so let's retry the test...

#syz test: 
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

--nextPart2046742.yJbYBYnt3e
Content-Disposition: attachment; filename="vt.c.diff"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="vt.c.diff"

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 7359c3e80d63..46511d1ac6ee 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2902,7 +2902,7 @@ static int do_con_write(struct tty_struct *tty, const unsigned char *buf, int co
 	struct vt_notifier_param param;
 	bool rescan;
 
-	if (in_interrupt())
+	if (preempt_count() || irqs_disabled())
 		return count;
 
 	console_lock();
@@ -3358,7 +3358,7 @@ static void con_flush_chars(struct tty_struct *tty)
 {
 	struct vc_data *vc;
 
-	if (in_interrupt())	/* from flush_to_ldisc */
+	if (preempt_count() || irqs_disabled())	/* from flush_to_ldisc */
 		return;
 
 	/* if we race with con_close(), vt may be null */

--nextPart2046742.yJbYBYnt3e--



