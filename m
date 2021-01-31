Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1F4309C88
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 15:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhAaOE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 09:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbhAaKnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 05:43:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E3DC061573
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 02:40:40 -0800 (PST)
Date:   Sun, 31 Jan 2021 10:40:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612089638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=p5d4o4WcHhRC9AE9dKNZvVuhoQ0c3je0TUVkplmhTKk=;
        b=uFkmKZ8hTCWt+e9ftKVeauU9TWAtM/JDMp58RvVa3v/KeySPSqox3PiigoInUw2854DJll
        GzHj6uy3LOGAz0R99ZgISstdXAh5dPuKiWigRm4FNbm546ZdSZSmRFK71OOp5yDe9Bca8W
        WY4PjrSuDvKHuVSp6eTshPOa5MHpFlhDoU0zfCRNG9SO6VpmiCXqp2Jlqxy7I8uLPNkdgA
        aRiR4QxEC6yEvSU7BlcW5lIaadyDwLYcO/p95QoiVErn06IKn7VG6luGQQH/TZkkS2SeE2
        n16PsV/sjE6kTj94FIc3sQUBkFp0sjj113bqAuMly/E2JtUGCOb6fbhR6WxNBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612089638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=p5d4o4WcHhRC9AE9dKNZvVuhoQ0c3je0TUVkplmhTKk=;
        b=cpUM8GfzoisMwkSINDTElz2f2oeGEkhv01H03N/FHXbc1IB4Nvyd2yxim1gjhzV9EJWlk0
        dB2YYV6j2HcBM6Ag==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] core/urgent for v5.11-rc6
Message-ID: <161208961675.22671.12893376547737348246.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest core/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-2021-01-31

up to:  41c1a06d1d15: entry: Unbreak single step reporting behaviour


A single fix for the single step reporting regression caused by getting the
condition wrong when moving SYSCALL_EMU away from TIF flags.

Thanks,

	tglx

------------------>
Yuxuan Shui (1):
      entry: Unbreak single step reporting behaviour


 kernel/entry/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 378341642f94..6dd82be60df8 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -222,7 +222,7 @@ static inline bool report_single_step(unsigned long work)
  */
 static inline bool report_single_step(unsigned long work)
 {
-	if (!(work & SYSCALL_WORK_SYSCALL_EMU))
+	if (work & SYSCALL_WORK_SYSCALL_EMU)
 		return false;
 
 	return !!(current_thread_info()->flags & _TIF_SINGLESTEP);

