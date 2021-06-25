Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A4F3B496F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 21:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhFYTy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 15:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbhFYTyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 15:54:52 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1333DC061768
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 12:52:30 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j2so11790065wrs.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 12:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=R1sPVb24QilWqLHIqUgt0l84EMiK0aAZKehJOEAfqIw=;
        b=sUcOAlOwaRtDve98pj4j/qlWAUXszs6aDCHkj59F9X7GFysrcajLvfpY8la8WmbTee
         Q7cD1DAoqZofS53Erri/rpNOm6BQ1q1IkMQIXKzXU0/fNwBsmYFleerusygpW3546Dhb
         WVGIVxaPF5CSWRaNWLbiFsroe/sHX5QO349bGmluGAR2mzAPfGIQD4KqrDEx4vMV86cV
         QPD9LY4MQ2EnYVVEj0Naq/NLvIvr2NOwUKk27KpNuzmlixbVbpw/Oq/sKTakGII+Dqi6
         DtQw8zCiw6Vr5SfPGZtOiLWWuRfEUSvzuddS8AIqPxdBxfO2wHi8eyE/OoDferMOdd3o
         RwIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=R1sPVb24QilWqLHIqUgt0l84EMiK0aAZKehJOEAfqIw=;
        b=l6fEHl7yDaCNjLctIMh9edv2tkM6JelLS09Fm3lOBn2414ylAMTi9sMit+vGR9cioP
         AS7qKwBEp8Z42dCS/G/GulHdrleOmJoy37+hpTW+/FQI/8gK7SIq9Bqxg5tW+bt/uKgz
         TpRqOSawtp0vzZ/+oGVUj5w5dIf6kur8orWs+2DoeXP3FqaFe184BnkuRiy1vSpMjA2/
         WycZRAGB6KVdF1GaycrnIIDFKps+9sFQ7IccGSDftwvfjdGkBzQ4aejtksj24Xp4Mm7F
         qhseRqvhHtrwi+Crw/Lem/tjeCzYRp7VOFxrBRKVTuFWN8cM9aSqv5Kx5S9WWJ7euIzW
         J3ZQ==
X-Gm-Message-State: AOAM530jvCVhgczOTP9Vj/2baFzE+4uQBQdJYwQT+8pY+GjyfFy8Lq/5
        dp9pGal3sceal4Wz/44Fy4gWs8LUPQ==
X-Google-Smtp-Source: ABdhPJyDxIKaa8MJEROid4/7JKSdxQ7ixrP1wJ35THU5rXjohLxKCbZArfQPBrKW7s28EAKwirFOfw==
X-Received: by 2002:adf:b35a:: with SMTP id k26mr13298221wrd.26.1624650748739;
        Fri, 25 Jun 2021 12:52:28 -0700 (PDT)
Received: from localhost.localdomain ([46.53.252.229])
        by smtp.gmail.com with ESMTPSA id r12sm7689618wrx.63.2021.06.25.12.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 12:52:28 -0700 (PDT)
Date:   Fri, 25 Jun 2021 22:52:26 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH] ELF: add and use SUPRESS_WARN_UNUSED_RESULT
Message-ID: <YNYz+hVeqsQmiEqN@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Last write to the "error" variable in load_elf_binary() is dead write.

Add and use SUPRESS_WARN_UNUSED_RESULT macro to express intent better.

Credit goes to Ed Catmur:

	https://gcc.gnu.org/bugzilla/show_bug.cgi?id=66425#c34

Macro doesn't work for WUR functions returning structures and unions,
but it will work once gcc copies clang.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/binfmt_elf.c                     |    3 ++-
 include/linux/compiler_attributes.h |    4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1290,7 +1290,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		   and some applications "depend" upon this behavior.
 		   Since we do not have the power to recompile these, we
 		   emulate the SVr4 behavior. Sigh. */
-		error = vm_mmap(NULL, 0, PAGE_SIZE, PROT_READ | PROT_EXEC,
+		SUPRESS_WARN_UNUSED_RESULT
+		vm_mmap(NULL, 0, PAGE_SIZE, PROT_READ | PROT_EXEC,
 				MAP_FIXED | MAP_PRIVATE, 0);
 	}
 
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -284,6 +284,10 @@
  * clang: https://clang.llvm.org/docs/AttributeReference.html#nodiscard-warn-unused-result
  */
 #define __must_check                    __attribute__((__warn_unused_result__))
+/*
+ * "(void)" is enough for clang but not for gcc.
+ */
+#define SUPRESS_WARN_UNUSED_RESULT	(void)!
 
 /*
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-weak-function-attribute
