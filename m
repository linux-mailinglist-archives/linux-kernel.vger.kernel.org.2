Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D97353B59CB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 09:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbhF1HfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 03:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbhF1HfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 03:35:08 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2FDC061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 00:32:42 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id t3so2819383edt.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 00:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=hU00//UO7feTXZBhYR14lSpvKH1K8aEj0hKnS8q5d5s=;
        b=M8G4K4jQYcVrW5dUbQcDKhJAOYypPAagBMq2mJ3uj82uuCVnK/cRqhlnMIBB/X+Bqu
         fhFfjPxmK1QZOV3kdStiHqycn1WNolL5DFO2+qhIHDPhwGUz/EiQMjp5XBy7uYKyT/sO
         ZlDHLD/+7Wco3uPJbmMzjmIDl/L3JvmqKo1Ma3Y4ZL6LdWjK9pACzi0LU8Y2DMpiNUMA
         ET25mCTqYX1R+1/7Eo2Y8CPvssL9ewDRGXzVYgjBJ9gJrs3U84pZP7gMxqkIitBoXaWq
         ialbquNsywy9axuHfitJ56OFuKmF81dRXtYEYK1kuQ0XDfb7bbCLhXC4CO4uOkJFrO73
         bzIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=hU00//UO7feTXZBhYR14lSpvKH1K8aEj0hKnS8q5d5s=;
        b=HfRU1k6Wmau5UL15mu7dCuBy5h7N/zekUs/Z3RkIL9V4y1AOMrhTxODXQ0YHvUqOAy
         Gf9f8t73VAfhELb4ibRt/uvtlbAuvZlZVQTqcmHbXiFPeQBy5yPix4KhPdAL11luC6ll
         j/NGSTVsRkfnSz/k+nLKuwa6BtnIDk4TyW+WpviJbpLZdlvMjEkFDo0P3X8QwKic0JzW
         HCdm1Oz1DXeKFaizrSrciO05wIrmjDFvnLv3gMOIg0tiV8uSbW1LMw07xmcTl0FsBmGR
         xqv79I5kHoIVKs3yP+iJt8zPJDapejm/xtd+4JD9gpwO00+/QIgKg2UcA1qoPzZGhmmy
         DVLQ==
X-Gm-Message-State: AOAM532SKCu0xh7m8Za3kdgYAjtbHsR5V5+6TLUmaLPPdug+aqtpdbG0
        /4+fLpJ/hVlrQfuR+migT+M=
X-Google-Smtp-Source: ABdhPJzmaiE86m48xF5K3s0+0/ULH8ttpFQrmtLo+Mx0tPsMRoLbEu5ib4eaCDyOkAAzFeGZOv/N+Q==
X-Received: by 2002:a05:6402:1776:: with SMTP id da22mr30669082edb.133.1624865561255;
        Mon, 28 Jun 2021 00:32:41 -0700 (PDT)
Received: from gmail.com (94-21-131-96.pool.digikabel.hu. [94.21.131.96])
        by smtp.gmail.com with ESMTPSA id gv20sm6545733ejc.23.2021.06.28.00.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 00:32:40 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 28 Jun 2021 09:32:39 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/misc UAPI fix for v5.14
Message-ID: <YNl7F5G4CIHaVpvb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/misc git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-misc-2021-06-28

   # HEAD: d06aca989c243dd9e5d3e20aa4e5c2ecfdd07050 x86/elf: Use _BITUL() macro in UAPI headers

Fix the <uapi/asm/hwcap2.h> UAPI header to build in user-space too.

 Thanks,

	Ingo

------------------>
Joe Richey (1):
      x86/elf: Use _BITUL() macro in UAPI headers


 arch/x86/include/uapi/asm/hwcap2.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/uapi/asm/hwcap2.h b/arch/x86/include/uapi/asm/hwcap2.h
index 5fdfcb47000f..054604aba9f0 100644
--- a/arch/x86/include/uapi/asm/hwcap2.h
+++ b/arch/x86/include/uapi/asm/hwcap2.h
@@ -2,10 +2,12 @@
 #ifndef _ASM_X86_HWCAP2_H
 #define _ASM_X86_HWCAP2_H
 
+#include <linux/const.h>
+
 /* MONITOR/MWAIT enabled in Ring 3 */
-#define HWCAP2_RING3MWAIT		(1 << 0)
+#define HWCAP2_RING3MWAIT		_BITUL(0)
 
 /* Kernel allows FSGSBASE instructions available in Ring 3 */
-#define HWCAP2_FSGSBASE			BIT(1)
+#define HWCAP2_FSGSBASE			_BITUL(1)
 
 #endif
