Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3292A4272AE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 22:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243084AbhJHU6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 16:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbhJHU6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 16:58:36 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED23C061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 13:56:41 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id w8so1602417qts.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 13:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VAGXdnd+R7a1uOjvv7U4cHxnCIdxxrnrbgKVS0Ct3A8=;
        b=A+csej6uLv80o4wTGan2mG4ZLOzEjOanuFUK6K53Z1Y6lrWhgyU/ALd26NtaUGfWr4
         M57WaZv8jLAIx/efmgH0b1i4bVJVQn7Xd4xCCtCuufbbTynD5yVDQr5TBMFEwMXUPhcr
         UtSVNObqxbjeODL74rr/oQpKESk5CPwpxRu6UL/pxVguS5Psxxwhtzg3A6ixeK5FjkM6
         vJO9OryJKEpRVYuvrRaUdfHO3FqMNBGfzq0yalPNaRD0Y0IkXKWBsenXjy2h8Nsk+AQz
         jiyKTvCnxcVKA4x2ki3fBLBx+K6G8pdqQyPvUz2qRTNv7jODnEODSH7Aei2OgSjcv48T
         IumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VAGXdnd+R7a1uOjvv7U4cHxnCIdxxrnrbgKVS0Ct3A8=;
        b=mt1imcHp+eJZer51cC/jxOgLpo4rj/5lyEROPwhLSW3gMvDuW/RJgEaUMUdFHKRmGQ
         jvYFRMUTNOFYcmw6aQbBUJFznKMJKbQ/99tZumPAMGWuUT5M4tpvF4L4sYo3Sa4l/yEj
         aHfqT+uhk+wawJDJHRUTbmyAcwIrnwvGgiukGyZFKJFBJbg28lp6eYLoSqXv3Xtqm+6Q
         401psD8ycP69Kx9kWmYJYm4djgfBK9LrmTDQdgLVrk8UfiPz6yFyK933aeDRnym6uuaq
         M2g43slfvx5yRudSjjtlOxOYUV+Q5ocsZt/4mLNLgaLP5Yr2CmlCYIJl8UYxbS+qEmBp
         olpw==
X-Gm-Message-State: AOAM530RD73ZlVPy4pxpJhhx7SVi6ZrDm8bqa0zZo62iaJExXSSVqzG4
        9lGjrL9T/uTAnJvFro/seds=
X-Google-Smtp-Source: ABdhPJxNl5Sd6V+Nq1FcBxRySYlXVe4dztQe6PQ1smgj5xvxYhX+8P/0aqRT4wkPyviuVLa+FWq0mA==
X-Received: by 2002:ac8:1e9e:: with SMTP id c30mr632019qtm.238.1633726600300;
        Fri, 08 Oct 2021 13:56:40 -0700 (PDT)
Received: from dan-XPS-15-9570.lan (2603-6080-6a07-6dd1-a8f2-a380-3d8d-1528.res6.spectrum.com. [2603:6080:6a07:6dd1:a8f2:a380:3d8d:1528])
        by smtp.gmail.com with ESMTPSA id 9sm403010qkn.84.2021.10.08.13.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 13:56:39 -0700 (PDT)
From:   hasheddan <georgedanielmangum@gmail.com>
Cc:     georgedanielmangum@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: cacheinfo: fix typo of homogenous
Date:   Fri,  8 Oct 2021 16:56:25 -0400
Message-Id: <20211008205628.3073014-1-georgedanielmangum@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updates 'homonogenous' to 'homogenous' in comment.

Signed-off-by: hasheddan <georgedanielmangum@gmail.com>
---
 arch/riscv/kernel/cacheinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
index 90deabfe63ea..ff98546b1152 100644
--- a/arch/riscv/kernel/cacheinfo.c
+++ b/arch/riscv/kernel/cacheinfo.c
@@ -29,7 +29,7 @@ static struct cacheinfo *get_cacheinfo(u32 level, enum cache_type type)
 	/*
 	 * Using raw_smp_processor_id() elides a preemptability check, but this
 	 * is really indicative of a larger problem: the cacheinfo UABI assumes
-	 * that cores have a homonogenous view of the cache hierarchy.  That
+	 * that cores have a homogenous view of the cache hierarchy.  That
 	 * happens to be the case for the current set of RISC-V systems, but
 	 * likely won't be true in general.  Since there's no way to provide
 	 * correct information for these systems via the current UABI we're
-- 
2.25.1

