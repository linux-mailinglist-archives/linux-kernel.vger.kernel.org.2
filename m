Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7163B35B40B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 14:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235440AbhDKMPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 08:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhDKMPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 08:15:13 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A323AC061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 05:14:57 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id f8so11696478edd.11
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 05:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ND1ABC4isPqUlNnqtYq+IVoMqwScJQsEGqTSQB/EfMY=;
        b=q4sqqSDqpvChT0QeXshWvWtx7JBTWh/wvifDGT95IdIRu0CTSX1egyCqLWW1VUOAH2
         p8Z6oJ369Q7x/vXi98EVot8Wv6aVRBx3vN2IGb5ab21s3OLu1HAGLh+NHmwXcGu8oaVQ
         ng79XNl/dppTFSRsx4xeNa8tlPFZ3e8ussFIMoChQrDsISIbU4SN/Ycu80ybGIdHGPNf
         +JS9R+qfk76byiYDPrNWP3C+g3pMGIJ/8j4udc7kVfHxkDF0rrecq1vcAJLLQkNVNgA9
         +7v2DQgwmbrfNIAQebBqTXwxZjc3q79oVeuq/pNuwSSBf1cDmnOZGZGl3rq4/ywenm8N
         O66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=ND1ABC4isPqUlNnqtYq+IVoMqwScJQsEGqTSQB/EfMY=;
        b=C/p5Myl3WwBaYElAmAi3yLmtlIYqHh0SLirRw7CqsIxO/Dj9CfrxwBN2nVL5tHFzEB
         DcDwTqShIvHiJj1qNvfWhotHEBqGZ94u2H7By4IeiwecEescIm7HxPf5KmC+WYvaNJaY
         U4XRoiy/0BUkbTwPRAcNlJJmIAoBXPoWQsxmLCjxn4bhFOzu1Z87FUCYuxWcRhxf1UcW
         pD2drinXnqkUTxp22EEEbf3Vu4M4Dl5RrmrM0Ci5C0jPPg7iDlll6aanm16+mDf/qj9v
         PYZlKGRGb+oBcC+U6BpXYyq8GtxL0P7c1iKUfSNPq4hcW53CeHOGLiTo9CMPBnKmTd/5
         yT6g==
X-Gm-Message-State: AOAM533GZOcAhQ3byh8yuR4MCeZ1vRuFp7kNj80KSw27Q8Brgajd9Xc2
        xel8S5EKNJOvnNrZEpjbWW65tYMEcL8=
X-Google-Smtp-Source: ABdhPJyfEVO0GRciOKc4JmGEAlyrAi4YH1RgqnbMkagYf+/Is0f4gwWary/qFGB772EeD62DwG1qEQ==
X-Received: by 2002:a50:fd12:: with SMTP id i18mr19559048eds.137.1618143296473;
        Sun, 11 Apr 2021 05:14:56 -0700 (PDT)
Received: from gmail.com (2E8BA22B.catv.pool.telekom.hu. [46.139.162.43])
        by smtp.gmail.com with ESMTPSA id e11sm1842588ejn.100.2021.04.11.05.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 05:14:55 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 11 Apr 2021 14:14:53 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] locking fixes
Message-ID: <20210411121453.GA1145123@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest locking/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2021-04-11

   # HEAD: 6d48b7912cc72275dc7c59ff961c8bac7ef66a92 lockdep: Address clang -Wformat warning printing for %hd

Two minor fixes: one for a Clang warning, the other improves an
ambiguous/confusing kernel log message.

 Thanks,

	Ingo

------------------>
Arnd Bergmann (1):
      lockdep: Address clang -Wformat warning printing for %hd

Tetsuo Handa (1):
      lockdep: Add a missing initialization hint to the "INFO: Trying to register non-static key" message


 kernel/locking/lockdep.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index c6d0c1dc6253..f160f1c97ca1 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -705,7 +705,7 @@ static void print_lock_name(struct lock_class *class)
 
 	printk(KERN_CONT " (");
 	__print_lock_name(class);
-	printk(KERN_CONT "){%s}-{%hd:%hd}", usage,
+	printk(KERN_CONT "){%s}-{%d:%d}", usage,
 			class->wait_type_outer ?: class->wait_type_inner,
 			class->wait_type_inner);
 }
@@ -930,7 +930,8 @@ static bool assign_lock_key(struct lockdep_map *lock)
 		/* Debug-check: all keys must be persistent! */
 		debug_locks_off();
 		pr_err("INFO: trying to register non-static key.\n");
-		pr_err("the code is fine but needs lockdep annotation.\n");
+		pr_err("The code is fine but needs lockdep annotation, or maybe\n");
+		pr_err("you didn't initialize this object before use?\n");
 		pr_err("turning off the locking correctness validator.\n");
 		dump_stack();
 		return false;
