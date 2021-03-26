Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04BBF34ABE5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 16:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhCZPwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 11:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhCZPwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 11:52:04 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1E3C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:52:04 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id f19so5865047ion.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tu//vQTWqe6GhAydkA03IO5cKyO6oKZVeS39H0viNAg=;
        b=XVN0uxSbtpMpl2g8NEeisWsLfJjd92MdW12sMUcW37Ov/i/jsfCdTbTo7SColjADxZ
         Yr49n9ChOVPRdt3R4fq2+OFVrJDBEoXx0wSS5sDvL2aA2AUGC9AMwPbdyKfWIDYwytMJ
         /DtSlZHB10RZvsDMS6tSroMPzzfjnm83oGiaaXVVNUcMqdDGkcxT4U9Bo3X8vqlBahtG
         Ethydbm87Ptp8gewGrFCDTG5iNfEUdRo1d80FM76KtK7cUYbaBl3ut1WeU32KsL46U+H
         OMiTAZ63L4l2yZveCq6PHqqkP4+el2YlNzcGgFDJPeRHSbbH+5fWZbb9DumJjdbcod+S
         dphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tu//vQTWqe6GhAydkA03IO5cKyO6oKZVeS39H0viNAg=;
        b=nwAQ4mM1xZ/yFE+KBAUG2h+42/sB6duNzxsFT2kazxEtLYmEQU2cBCGwW+64kFQZKQ
         f6xpvGsKYysXs1fdDac/vgyuMx8B7OPhJvumi8BG22Gb+QX1f81WDmURqXooC2R+0+Ah
         bPrjDsfaa4pjKo+lCxCjwBhFLWsOmCGHjuGt1K4hAnzIV3e1QuAvFGIE+OEZTJv4J9AE
         DJ6tuOSHXJ/2gmpeh0JY0fK2ioNpk++WWdJPItjobb9x22auKNUh51SP1npTaWMxAK87
         jCZTcUno45MhldiYaw6b283HnFGhMG6283deOs16ah1e4PyxOMv6zOeEN0re/HVxzdz1
         0SAQ==
X-Gm-Message-State: AOAM533z2wYwi3LVirI1DUAQfcN2j2Ds9rBQH0MKSEnBdp41aX7fAjuT
        Zpt8c00lzWyi1LWqdRNkjdVYMjkATFwlpg==
X-Google-Smtp-Source: ABdhPJwOHRAboY3aZPLSe74/zo6jzJv2YF9mvJBSzNxt/9YFjCaqTmY//dYrc0/hHJTY8fr6r3UASg==
X-Received: by 2002:a5e:841a:: with SMTP id h26mr10865781ioj.179.1616773923628;
        Fri, 26 Mar 2021 08:52:03 -0700 (PDT)
Received: from p1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id a7sm4456337ilj.64.2021.03.26.08.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 08:52:03 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     torvalds@linux-foundation.org, ebiederm@xmission.com,
        metze@samba.org, oleg@redhat.com, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/7] kernel: don't call do_exit() for PF_IO_WORKER threads
Date:   Fri, 26 Mar 2021 09:51:14 -0600
Message-Id: <20210326155128.1057078-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210326155128.1057078-1-axboe@kernel.dk>
References: <20210326155128.1057078-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now we're never calling get_signal() from PF_IO_WORKER threads, but
in preparation for doing so, don't handle a fatal signal for them. The
workers have state they need to cleanup when exiting, and they don't do
coredumps, so just return instead of performing either a dump or calling
do_exit() on their behalf. The threads themselves will detect a fatal
signal and do proper shutdown.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 kernel/signal.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/signal.c b/kernel/signal.c
index f2a1b898da29..e3e1b8fbfe8a 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2756,6 +2756,15 @@ bool get_signal(struct ksignal *ksig)
 		 */
 		current->flags |= PF_SIGNALED;
 
+		/*
+		 * PF_IO_WORKER threads will catch and exit on fatal signals
+		 * themselves. They have cleanup that must be performed, so
+		 * we cannot call do_exit() on their behalf. coredumps also
+		 * do not apply to them.
+		 */
+		if (current->flags & PF_IO_WORKER)
+			return false;
+
 		if (sig_kernel_coredump(signr)) {
 			if (print_fatal_signals)
 				print_fatal_signal(ksig->info.si_signo);
-- 
2.31.0

