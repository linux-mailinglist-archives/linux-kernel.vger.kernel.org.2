Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15CC42FD25
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 22:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243006AbhJOU7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 16:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236330AbhJOU7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 16:59:51 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56043C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 13:57:44 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id p68so9165545iof.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 13:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uge5ZOWl3q4I1NVteqpVHF8PMneDZ2lRgKnZvb5BpEs=;
        b=Ksyb4zr3uS7UeYs0WW2FtpwpHOu77tfrzgWD1YWS46TV+RqPzTp0Qzlh2+74FpcVl+
         cXtiFr4uAG5IfMpdsb8SrDhK9kPYRwY/VFOI03nOVz4saLoFoT/7EyNgIf9Zr4wcBmHH
         xUAqn4IF9BAllx3I8NBKKG/SlCjUMRHAhPeXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uge5ZOWl3q4I1NVteqpVHF8PMneDZ2lRgKnZvb5BpEs=;
        b=T5/SPvTh3mVEoiXdOeQw7BGQbefXs4b30mIkam2ue42Le7XOwZ/bZYLUCW0YARRIzr
         yPUkYaSASKERlfpw6q6O4A9hiHR2tiZLprJbLMKAjLRuQZWrd4TfGUW7lx6wZCx/pGHC
         mRpxM19+Gn/DYNQTTCB7NeUQWJwdeBG2vHm6gTIYudGsfEd5sYvm3n0YK1LSOpitSLru
         6zND3Qu1SStVs/PUe7RfCdH0YpYYmLmD3ujonTgDC6rHKG9prOWkdSpc9X2gj9pFd3Cp
         Wcsvr6mABIhjs1U0RpmjbR62PIF5hg/dLec3fhv7s9+/THNAI84LnUUN2DqAOOcXvjpu
         MvBw==
X-Gm-Message-State: AOAM531fnNkdafasTtKc0Xs3F5eJJyZXCA0CXgCU7tDzenmAi6V+3cAx
        neMtTD2D8ii+BjXTF0dhw3Cpyg==
X-Google-Smtp-Source: ABdhPJwCrgcPsrDwyU90LRG28xpnvr/V2Y/qzR7lmpRTOWlHhV2Eaye89tf1xQWb7tpBJjDnEUMaig==
X-Received: by 2002:a05:6602:2d4d:: with SMTP id d13mr5351258iow.53.1634331463787;
        Fri, 15 Oct 2021 13:57:43 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id ay5sm3455111iob.46.2021.10.15.13.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 13:57:43 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     mcgrof@kernel.org, jeyu@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] module: fix validate_section_offset() overflow bug on 64-bit
Date:   Fri, 15 Oct 2021 14:57:41 -0600
Message-Id: <20211015205741.38283-2-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211015205741.38283-1-skhan@linuxfoundation.org>
References: <20211015205741.38283-1-skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

validate_section_offset() uses unsigned long local variable to
add/store shdr->sh_offset and shdr->sh_size on all platforms.
unsigned long is too short when sh_offset is Elf64_Off which
would be the case on 64bit ELF headers.

Fix the overflow problem using the right size local variable when
CONFIG_64BIT is defined.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 kernel/module.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/module.c b/kernel/module.c
index f5d6e388478c..e7402fb1f4e7 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2942,7 +2942,11 @@ static int module_sig_check(struct load_info *info, int flags)
 
 static int validate_section_offset(struct load_info *info, Elf_Shdr *shdr)
 {
+#if defined(CONFIG_64BIT)
+	unsigned long long secend;
+#else
 	unsigned long secend;
+#endif
 
 	/*
 	 * Check for both overflow and offset/size being
-- 
2.30.2

