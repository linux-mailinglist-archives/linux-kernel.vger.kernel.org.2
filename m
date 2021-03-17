Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D66533EEAA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 11:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhCQKrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 06:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhCQKrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 06:47:21 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE80DC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 03:47:20 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id m186so21701979qke.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 03:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bs1Q5g0mJLEbGGh58yL+AT4vNC2vLfU22G2nRXL8Mfg=;
        b=rjpkreI3fz3jPXKCqFOFthJa4IWtHhHNUIE960EZGm0wz6/iEBpf9Kti6vth6U0fYH
         QkajKm+29I/CLF44XMSwWg0vvzsPF2Of+pjxGICTd0/ahuv5jaEFYx3DbqQxSkCpJsC2
         V1MGfL/fsUjIgRBSRw/RnRR2jyhftR594DOH6ElKqMNvQG+tzJ8M9Ve9WxWsxY3e5jSA
         adj+hMLgLnEmirW+FSPAV/lWxDVijWfAmwYXzchkMjzWdV0e7NPZHotWE/Anlag64Qet
         Dup7FcnX+BD/Sd2TCYfp3FCFDycr5p3FrLpDfUZSZ09Uhqtw3/CmNVgQm4SzXB2tBtvd
         s1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bs1Q5g0mJLEbGGh58yL+AT4vNC2vLfU22G2nRXL8Mfg=;
        b=WWUPOpSbiSF2eKZoXvzd262RXTi0rtXzNUc9Mv9eSe1EDS1+/82s0I5Sh60w+uiFX7
         DXfU4xMxLguw1TZUgvNZqcaqevYvcV0we+2RA0bddJWxyZFmTLdN267wRR93zY7oAfid
         1RSi0++yer9RVMPs+Q1tmWlQ1co/aSeYR+U6y5qN7X0gSF0JgF8w88kL72nq3qVOeYG3
         MfRXuIiFUhChVR2yuBauf7H1eNoGdzMok5D9X3gOoeyhO1Hkqp/dbn/Bpcp3UReq8ttt
         /sDiJqqXbp0v1fGFypIDZ+qcG8+WqsIobde1XOy0yZ7lS+WlyF9yz6N1W8j5CkQxcy0G
         IoHQ==
X-Gm-Message-State: AOAM532wyyl/EFFsQ6SWsZ3eb5o/IFS4QR1zpZ+HhUoT3niP7BvwjTu5
        daswicS42dq5DYAx8j3mnVk=
X-Google-Smtp-Source: ABdhPJyjQzim5Yrx4E0q3U49DYJHiESpkdVA5RAIGQslWZMeD+9GAtYJ6WUjoK4QiojCq0eoCrvgnA==
X-Received: by 2002:a05:620a:102f:: with SMTP id a15mr4183666qkk.87.1615978040214;
        Wed, 17 Mar 2021 03:47:20 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.48])
        by smtp.gmail.com with ESMTPSA id b10sm8881359qkg.50.2021.03.17.03.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 03:47:19 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        dianders@chromium.org, kgdb-bugreport@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH V2] kernel: debug: Ordinary typo fixes in the file gdbstub.c
Date:   Wed, 17 Mar 2021 16:16:58 +0530
Message-Id: <20210317104658.4053473-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/overwitten/overwritten/
s/procesing/processing/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
Changes from V1:
 As Daniel pointed out, I was misdoing a check,so corrected

 kernel/debug/gdbstub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/debug/gdbstub.c b/kernel/debug/gdbstub.c
index e149a0ac9e9e..8372897402f4 100644
--- a/kernel/debug/gdbstub.c
+++ b/kernel/debug/gdbstub.c
@@ -321,7 +321,7 @@ int kgdb_hex2long(char **ptr, unsigned long *long_val)
 /*
  * Copy the binary array pointed to by buf into mem.  Fix $, #, and
  * 0x7d escaped with 0x7d. Return -EFAULT on failure or 0 on success.
- * The input buf is overwitten with the result to write to mem.
+ * The input buf is overwritten with the result to write to mem.
  */
 static int kgdb_ebin2mem(char *buf, char *mem, int count)
 {
@@ -952,7 +952,7 @@ static int gdb_cmd_exception_pass(struct kgdb_state *ks)
 }

 /*
- * This function performs all gdbserial command procesing
+ * This function performs all gdbserial command processing
  */
 int gdb_serial_stub(struct kgdb_state *ks)
 {
--
2.30.2

