Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE62D420167
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 14:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhJCMGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 08:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhJCMGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 08:06:06 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307F7C0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 05:04:19 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id g8so53473847edt.7
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 05:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=16jv9dHgdRgKVxtGwcKBR5fNJruBm+0ydvDzDv4vhuM=;
        b=E4pqZZkP/UJkcQRg7nI6xnxMpBoPonlviiSF9zun6gj4ihbfUh45gWcEREXdV0d8FY
         DQQ7Gf9abyRJm0RJE0san48IOsHBeDiW07G87kq0ycOQRCfQJwF+fp1zkpqpIYC1/uvu
         OpAqOxoIP5nuMlrZy+mFt0xtak8tc5F4TbgbhYkqzfuDLhe4WxYHVED2fvPSNFhLXeOe
         0vyBXk2Rz8PBGYIxXmvSc4Os3dGWYOVh+ghqVpSuoikTqLo0atk57/AJ7crdQ2xGtzJd
         ELl0ehZxDm2wvV3dAKcw8j60ZiUHtCoLbqxX/IOADFDsWqm0QSp4IdRXk72TRY8Tr3jh
         s8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=16jv9dHgdRgKVxtGwcKBR5fNJruBm+0ydvDzDv4vhuM=;
        b=JYPlHm1tCIO4Ma+PELcLv4TZ6wwUTPUDFAT7tPSg2j6BjVZwWyKc/C5kBRgrtJEckP
         vFqlabWlO4wQu16NNC97oRtA2wUTYFDsQ4y/+sz46S+WsO1U5KRpfrYaB25Fx0gmCuyI
         RNGtq+KVOMhgqH+mH21C2HWWjR5KBG/E/zeiIDdE4349jUODeGAITgeu4vvbzM7LWJdh
         /7fJRJM0x0g8cNGzc7sOQvvF9k0EbThnagnL0Kq70AsGRXcjXerLlNj2kugQsiL+H53w
         MfJ+LLi2y9aIqWHn/s9S9brOZjy5l/QgpQ8E43LWR3dO4LYfRaB+QvifxAFgP2hJaTlk
         Bhvw==
X-Gm-Message-State: AOAM531HVv4788CNiuwAhqXjVlHJgx191nDdeAUGqDeMjVsmYTBy/MZv
        lx7MLG1cIkWB9uOrJvuyX/tNww24UA==
X-Google-Smtp-Source: ABdhPJyF2TA1UDEjTjE7+KWUCKCh674Gb1x/BeMolN40O+YYBlxbSUvtHhlbuIbzGkU5HOKWXU1Zvw==
X-Received: by 2002:a50:d84c:: with SMTP id v12mr10458100edj.203.1633262657289;
        Sun, 03 Oct 2021 05:04:17 -0700 (PDT)
Received: from localhost.localdomain ([46.53.253.147])
        by smtp.gmail.com with ESMTPSA id s16sm1834229ejf.76.2021.10.03.05.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 05:04:17 -0700 (PDT)
Date:   Sun, 3 Oct 2021 15:04:15 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] ELF: simplify STACK_ALLOC macro
Message-ID: <YVmcP256fRMqCwgK@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"A -= B; A" is equivalent to "A -= B".

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/binfmt_elf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -156,7 +156,7 @@ static int padzero(unsigned long elf_bss)
 #define STACK_ADD(sp, items) ((elf_addr_t __user *)(sp) - (items))
 #define STACK_ROUND(sp, items) \
 	(((unsigned long) (sp - items)) &~ 15UL)
-#define STACK_ALLOC(sp, len) ({ sp -= len ; sp; })
+#define STACK_ALLOC(sp, len) (sp -= len)
 #endif
 
 #ifndef ELF_BASE_PLATFORM
