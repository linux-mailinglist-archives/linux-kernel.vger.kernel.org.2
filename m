Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB4EC438580
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 23:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhJWVJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 17:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbhJWVJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 17:09:40 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC050C061714
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 14:07:20 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id x123so8031119qke.7
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 14:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z5ck/UeEucZ2b2bRdxYTEyCija2HpQgnVIHtuWoPlEA=;
        b=Wp5eZvdjLKysteoESIng+SrPEwg9qMDqkaCGiBTO+bWsh9Yyhy9cNmf8GNmAGJrkLj
         zXer0lT35mQhlw2cqd88fQ5yIRTjqyXKyeYrshknwGErlcFOFEB7v4QFXiTc+VNFWtrB
         LrrZQfP+5jLFeL7Jgcw/yXI1A/C/qgRWIn0ftjOqGexTNy1oPfVlqAO3d71+g7n0DvsH
         d5b9UR2xdjVyR6kWuhR7rR7iXLvLOcaUghnurzMymIl6KP0i0BbI8AhtdOvYLJ6HEhd2
         dJkNd5PHYlnEo1hEn/fNpU6nMlcXz+5guXOf/IEZWV2nYm2HcljxMdjOFAve/DTC+LG1
         5eHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z5ck/UeEucZ2b2bRdxYTEyCija2HpQgnVIHtuWoPlEA=;
        b=lqp7Zv3aZXRSn9Q7uiBfr+GRQHmdwiqzM4SWqPpHQSUCQXdI8kdZdciHAKOChCJhBv
         O3gbNhL1iNwidbDV3cObxD/P6RekY9o+cuPVDYo0vojDXeca9cv97w7KY88sM5MmuY02
         7AiSAlTbKBhe9N6AjNPP07ioZK5d/DKNNMLVgbVjgXQGxAjMgerauMbSHB4FLsuQr73M
         fmrftgn9y9Yvrj0Rsf0u+PEhUuNvkL3WyeLg8/sCLpv9h9H8stzEJjHhR3guuYqy4p/Q
         MgkN6s3P2/M4I2m7+R9HxLFo39WTNcqTcjD4b1WR1SWAclwhV/iW4fnHI7Se1cjj07tS
         nF6g==
X-Gm-Message-State: AOAM531FDfwwbHREe7BsQh4ayEyx7zV5vIICvKNvu/FiEDVtzR+kjGYS
        mBP/15EnvWPONeiBJeR3ocuznePNJSc0qXlh
X-Google-Smtp-Source: ABdhPJwIQmgo3/mVOU2a0uWWtY9cSrsEXQhJdt+TYqEGJAboFSjozNjAoq/jpY864wAjNwabPy5W1g==
X-Received: by 2002:a05:620a:31a2:: with SMTP id bi34mr6217466qkb.331.1635023239728;
        Sat, 23 Oct 2021 14:07:19 -0700 (PDT)
Received: from dan-XPS-15-9570.lan (2603-6080-6a07-6dd1-9dc9-36c8-de30-e324.res6.spectrum.com. [2603:6080:6a07:6dd1:9dc9:36c8:de30:e324])
        by smtp.gmail.com with ESMTPSA id ay32sm6728275qkb.66.2021.10.23.14.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 14:07:19 -0700 (PDT)
From:   hasheddan <georgedanielmangum@gmail.com>
Cc:     hasheddan <georgedanielmangum@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] riscv: cacheinfo: fix typo of homogeneous
Date:   Sat, 23 Oct 2021 17:07:14 -0400
Message-Id: <20211023210715.1713524-1-georgedanielmangum@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <750f6239-154d-9190-24ff-ece033add638@infread.org>
References: <750f6239-154d-9190-24ff-ece033add638@infread.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updates 'homonogenous' to 'homogeneous' in comment.

Signed-off-by: hasheddan <georgedanielmangum@gmail.com>
---
 arch/riscv/kernel/cacheinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
index 90deabfe63ea..f0c2043943bf 100644
--- a/arch/riscv/kernel/cacheinfo.c
+++ b/arch/riscv/kernel/cacheinfo.c
@@ -29,7 +29,7 @@ static struct cacheinfo *get_cacheinfo(u32 level, enum cache_type type)
 	/*
 	 * Using raw_smp_processor_id() elides a preemptability check, but this
 	 * is really indicative of a larger problem: the cacheinfo UABI assumes
-	 * that cores have a homonogenous view of the cache hierarchy.  That
+	 * that cores have a homogeneous view of the cache hierarchy.  That
 	 * happens to be the case for the current set of RISC-V systems, but
 	 * likely won't be true in general.  Since there's no way to provide
 	 * correct information for these systems via the current UABI we're
-- 
2.25.1

