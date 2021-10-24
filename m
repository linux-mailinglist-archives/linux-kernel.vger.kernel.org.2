Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A52438654
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 04:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbhJXCQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 22:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbhJXCQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 22:16:30 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB31C061764
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 19:14:11 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id e10so5457549plh.8
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 19:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amikom.ac.id; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JzXdjUfbyWkPAzIwAFcpQyroZwKcnu+VwMtkZ1HYrvM=;
        b=Yz3Lmy/nT4ecmYhhaMtwvYiv0kq7DdbSClZ9sA25dRHhWys4xCSB1thEokcTwk7g/f
         pMnj4Vz1Hq4e9oIldhOCKS6cLvuAF+FtuXGDzS4/qCxGvKfNbI2zHZZ/PYWa2VDriWXx
         797RCtZ6lVdy2HxHrLGWVMJDIJXxNbW1S98BjYp4vlPxEg7Ewxk+Vzs5TqOIgdA7QttK
         5HWu+Hm1Ul/8OAgHRFhaXAdwnxKfScnkXx+PSnA2Qxq8d454c8qVZUwbziXom2yaYoip
         9NWt7U1LD9jRGhQP5MLRkixzJMl3tkCaztko2wm8iIcTTqdZsetfpzIs5DJx5DZOA0/u
         fwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JzXdjUfbyWkPAzIwAFcpQyroZwKcnu+VwMtkZ1HYrvM=;
        b=q7lRUtgiLUfds0I+T3haNm8eXPCYmi5NYrsCNPRmqo7vFaOopE2lOIhD1+7eRmL5Ne
         wyrdGOENPOAOPD7/qprUoLosCMQjy0Ar2vAD+YiVHNbrJvO6ZB6+A7uHxU0VyNQPtoIH
         Auptbeq1CU/XCRvAP6W3OrWpqpGdaK5bU5nMkqS4J3OmmnKoUCK7e7TfHvZItmNim2aG
         vqNwSDomvJRa/hMr9dIRS4imH7Fm8zOmu9K2CYzBbXlADIRG9DcTmSc0sFO6dEzzH/b5
         4iZHLpzQ/mlK4/hILWQjnnIoHbsFQ8KhE9DMODEsQAnG01T9/8cjdYBnq7xVlX6x0KOS
         jhjw==
X-Gm-Message-State: AOAM531DY4m8G8UyogKIWD9A58AESzpXqhS/VmZc5FB3rAEVMRAfKzIF
        JvUu7o5RDhKD1EEH34hgZF7Pyg==
X-Google-Smtp-Source: ABdhPJzcx6iFVmNqotAyZ+TkOuASMwS73kpw0ljHjDcvt41Otdw5ufLbpwUxB8wUy0t+uBuHGLbfvw==
X-Received: by 2002:a17:90a:9ef:: with SMTP id 102mr19795503pjo.57.1635041649716;
        Sat, 23 Oct 2021 19:14:09 -0700 (PDT)
Received: from integral.. ([182.2.37.49])
        by smtp.gmail.com with ESMTPSA id d15sm16293137pfu.12.2021.10.23.19.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 19:14:09 -0700 (PDT)
From:   Ammar Faizi <ammar.faizi@students.amikom.ac.id>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Ammar Faizi <ammar.faizi@students.amikom.ac.id>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86-ml <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Peter Cordes <peter@cordes.ca>,
        Bedirhan KURT <windowz414@gnuweeb.org>,
        Louvian Lyndal <louvianlyndal@gmail.com>
Subject: [PATCH 2/2] tools/nolibc: x86-64: Use `mov $60,%eax` instead of `mov $60,%rax`
Date:   Sun, 24 Oct 2021 09:11:32 +0700
Message-Id: <20211024015628.393550-2-ammarfaizi2@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211024020616.395038-1-ammarfaizi2@intel.com>
References: <20211023134323.GA5881@1wt.eu>
 <20211024020616.395038-1-ammarfaizi2@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note that mov to 32-bit register will zero extend to 64-bit register.
Thus `mov $60,%eax` has the same effect with `mov $60,%rax`. Use the
shorter opcode to achieve the same thing.
```
  b8 3c 00 00 00       	mov    $60,%eax (5 bytes) [1]
  48 c7 c0 3c 00 00 00 	mov    $60,%rax (7 bytes) [2]
```
Currently, we use [2]. Change it to [1] for shorter code.

Signed-off-by: Ammar Faizi <ammar.faizi@students.amikom.ac.id>
---
 tools/include/nolibc/nolibc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index ea38d6f356a1..b1a81f711327 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -420,7 +420,7 @@ asm(".section .text\n"
     "and $-16, %rsp\n"          // x86 ABI : esp must be 16-byte aligned before call
     "call main\n"               // main() returns the status code, we'll exit with it.
     "movzb %al, %rdi\n"         // retrieve exit code from 8 lower bits
-    "mov $60, %rax\n"           // NR_exit == 60
+    "mov $60, %eax\n"           // NR_exit == 60
     "syscall\n"                 // really exit
     "hlt\n"                     // ensure it does not return
     "");
-- 
2.30.2

