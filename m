Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E78310AF0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 13:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbhBEMMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 07:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbhBEMFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 07:05:54 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF56C061793
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 04:05:13 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id j4so3279629qvk.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 04:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w6IhO9s40oec0IOKUurPh0EF/d7cv4coioK7fFZj4LQ=;
        b=SpJO5Tt1TO1dUD3i4VucFeay0wqS/HfNKt+YEFegYexKHkj5sf8P+tSXF8/dnQft/5
         rvpy4jzhX800lgtMIv7LL4wkzvKx31Lpv2dbxbBRkAvs4M1p9lvHHhX3ZZUHyaf2JajQ
         KIdBbmu7zxfFX1KbqbcoY8VBtqpPdd3VU8YN9IM1H6LKlHO4L86b+0nJFS2auCj3zv05
         NqJQY/kF7WOoq2b0snEqSwLfSmoRF0hYPaKFj6gNRijH91nJoe/RQVglOYW9YMYaerCh
         PE5vJ0jnDY/9lYoDlgoapXEC7/6GqjDrziidw6YJxCkXnnPxUCt2a7ZzR4UCF8EuV9Fd
         Fs3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w6IhO9s40oec0IOKUurPh0EF/d7cv4coioK7fFZj4LQ=;
        b=h0OcVXplzTmijzqoHbDmGA8dckUxXQR8X2dxDNDb4jCxTxsm4hUniJyrQ60c+KlHEn
         j8dZa/lBTolghbKXgGmNxht2wJe32cZBDxb4lHBCzpq+1aVGJzbTfVZJz/UY3tw4vuod
         pubLBaMGfEbGPQHB7sqr30AE/hhkMi/sleN8ZaKUNQ4qUUmAH+6WG6Jmcb5fwPaLSC3O
         WAZWZCPfcA6NTWrD6kbZVgJ/he2feFwG2OAr2G77YpVWirboSIhZXl5i7GvllKJ0cv07
         cmGSjQsBiQVxOq1SlFgjnrv5RVudaRG6dTwVKex+1NUdTjzZJ6fMljtdSTNGhC6dgcRk
         AcgA==
X-Gm-Message-State: AOAM531AvsGhObyd95lAZ0ttwqJoqre1q4yMua6I0zebczNbjUq03Oux
        4IUc4aGp3j+x1pSdIrpZLvU=
X-Google-Smtp-Source: ABdhPJwBexh4xI/1rmx/HQV+TJIDu6za4Ky6jCeJARIIc9+W8w3Zca33NATu5VKjlAWwrLT0aXbymg==
X-Received: by 2002:a0c:f986:: with SMTP id t6mr3977209qvn.15.1612526713013;
        Fri, 05 Feb 2021 04:05:13 -0800 (PST)
Received: from localhost.localdomain ([138.199.10.106])
        by smtp.gmail.com with ESMTPSA id v135sm9328298qka.98.2021.02.05.04.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 04:05:12 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     sammy@sammy.net, geert@linux-m68k.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] arch: m68k: include: asm: Reconstruct the sentence in file sun3ints.h
Date:   Fri,  5 Feb 2021 17:34:55 +0530
Message-Id: <20210205120455.1289448-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



s/fuck/"do anything"/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/m68k/include/asm/sun3ints.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/include/asm/sun3ints.h b/arch/m68k/include/asm/sun3ints.h
index 309d6e6a1374..1bbd76545d8f 100644
--- a/arch/m68k/include/asm/sun3ints.h
+++ b/arch/m68k/include/asm/sun3ints.h
@@ -27,7 +27,7 @@ extern void sun3_enable_interrupts (void);
 extern void sun3_disable_interrupts (void);
 extern volatile unsigned char* sun3_intreg;

-/* master list of VME vectors -- don't fuck with this */
+/* master list of VME vectors -- don't do anything with this */
 #define SUN3_VEC_FLOPPY		(IRQ_USER+0)
 #define SUN3_VEC_VMESCSI0	(IRQ_USER+0)
 #define SUN3_VEC_VMESCSI1	(IRQ_USER+1)
--
2.30.0

