Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F2B375B66
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 21:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234763AbhEFTIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 15:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbhEFTIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 15:08:36 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F24C061763
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 12:07:35 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id j10so9272007lfb.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 12:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mVaHSdkbm8MwXcn7SQ50Z8opf/CDWX+YUlvqILmFAHk=;
        b=id5UfkCDd3EuyHSkKzeuUxog37Hj+v43FlB6zPks/xuoHqW5jOXyiVva7fE9tBExzA
         ZQdpWuYTI7YOESVVJ1e3yzGm+X0NbHiJ6WIr8AqbJC+n7dAPDHNIfD3BIlilXlTKRmE1
         EQ0eJ3Et51PD0cBnCErwJDkS45jDqHR0gTDoKxc8W6fVs6ksLAN4jsvrS6FAVRBreHF5
         i753Vg02zXSIa7OAF3vcEqqzQvBWUs8po4OucrGh6LtnY9fLOdhCfMF5cG9Nou2bpe2w
         pNXPhaw7yqeTW34QCvdv3IApVkJbse6igXULNvW+21LE/ko2OVuDJOPYG2ujGlnAihDJ
         ABMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mVaHSdkbm8MwXcn7SQ50Z8opf/CDWX+YUlvqILmFAHk=;
        b=eX1e3Jn/QbCto12jtTeP5Elssu6slTMMQO49mnKcX7UcMQLzIy+D0Ph6MBTGAZ/ZHD
         5GizpqfsxcJDHh2JdyBirg6OrJPiETcYn5Xg+Zdcg7a3yUzW3WZeVvOD351t8Q45tM07
         PezeDwIEQFDMatjQAmpp1WEJmdXWWJ9Cp/Ku7JtAc+gixPL/GLfzm2nSjigirPH4ETnB
         TS7LEzCO1gzsAuz+i4ev7p+PCUYD8zNcR9YFGAyq73N20K2fPGBOZwrQ/sgVgX8OFCKI
         VlEe0MO2leVh6XmfWnLuBX2Y/qAJ0XCRpZWHBcUrYxEhTLqmPr6lWi6L4qO6/v136QBn
         5MOw==
X-Gm-Message-State: AOAM5324WJ6RooFkQoYK+36HcR3nGKoZeg5cnDtOYTxd53ZdT0dadmkl
        4f0F6Hw1MQ/wV2pKw9I0i7E=
X-Google-Smtp-Source: ABdhPJwT/SDkwwAWGtM7M9K6YKUnWqjhwTIfX4TvTeQgOwu6HN924Hkru5vwazeHB+OAZmx1nL7yiA==
X-Received: by 2002:a19:c104:: with SMTP id r4mr4132224lff.555.1620328054402;
        Thu, 06 May 2021 12:07:34 -0700 (PDT)
Received: from localhost.localdomain ([94.103.226.84])
        by smtp.gmail.com with ESMTPSA id k11sm857445lfg.288.2021.05.06.12.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 12:07:33 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     linux-kernel@vger.kernel.org, Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH] x86: make x86nops symbol static
Date:   Thu,  6 May 2021 22:07:26 +0300
Message-Id: <20210506190726.15575-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse says:
  arch/x86/kernel/alternative.c:78:21: warning: symbol 'x86nops' was not declared. Should it be static?

Since x86nops is not used outside this file,
it can be made static.

Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 arch/x86/kernel/alternative.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 6974b5174495..75c752b0628c 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -75,7 +75,7 @@ do {									\
 	}								\
 } while (0)
 
-const unsigned char x86nops[] =
+static const unsigned char x86nops[] =
 {
 	BYTES_NOP1,
 	BYTES_NOP2,
-- 
2.31.1

