Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E87B349E36
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 01:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhCZAo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 20:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhCZAoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 20:44:18 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C45C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 17:44:17 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id c204so3745472pfc.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 17:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=kQfJe3SM3uKBO4y80++UrhVTvqfOoULiPheOgQ6rl2A=;
        b=xUMWuzOHV/hpq2Qlwq23GvUh51ikLyBfqnYYKJ3Mwxr5uOc2lQOhS9I/DDUci0VUEg
         QHiYcO72fadNjDnruS9Lk3RnqkW7VBqeMY9lNa05yu0uxwVpJVkc8U0vxbRXfZnOmJam
         Xd4HzrnO7xEgph1p+ljyVPdiqIYR2SCYkI0RpP4qCi+qvEfMoVJjO7I22tyaAITUW5ZV
         YekTvsXxwECnat/wKVc2eQrEiLVNKrcd0AZ1gyw5zLUjeIYBTtsW8FzGcH1GgwNZA5T4
         DriLYMj/u0262xaw8pVi1MS1shiZEpFLmi1qRIRLZ0nfKIh4PlTwRqat3dUQonJJ7cBI
         swIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=kQfJe3SM3uKBO4y80++UrhVTvqfOoULiPheOgQ6rl2A=;
        b=X8ewYX/K68nk7yXNpLwOgLwgYJgysx+zEa6dgKEqG/w7ZWf0bLGLrJLxtAADzgj9rR
         7gOwsi4bru83ykjBi9tCmDJMONr5Z0cjrndHK7ix+sVqzI8CgM/6C3WrAiEaIDjrF/aI
         u7+sRZEvxuTIpbPwODtqwFiooocuBhm/kYhJHSfTMb/GXpsSvPsuOc6LhEanLsCNsXf9
         a5ZFBZwNN6kR0fC1X0qU3e+N9qSIFsUsfr9Bi2t60YeGQOH0u0nIVdhvjrsKoxH75Gif
         Qb+Hg84oiCZxxZWEYIsO6k+SvHG/UwIHfB8oFxq9oSb2WDO/rN+sTrONFIRIyTlOJdrY
         4SwA==
X-Gm-Message-State: AOAM533vbOFSKmPn6l9Urbk3NJsY0d7FshZLSLvUe6L2p3NoQSxbMqbl
        5/qUENIFW3S/CX+rkk6JKBE3sbLKiJb0Bg==
X-Google-Smtp-Source: ABdhPJwRGCNtpyjZeBVrH8RV0bCyTDTG5DkJDgD8GvOoPZBsBtaU5or6a3QoNLb6Ijr4dfwipLpckQ==
X-Received: by 2002:aa7:940a:0:b029:1f1:5b58:24e5 with SMTP id x10-20020aa7940a0000b02901f15b5824e5mr10431788pfo.54.1616719455378;
        Thu, 25 Mar 2021 17:44:15 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id js16sm6636137pjb.21.2021.03.25.17.44.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Mar 2021 17:44:14 -0700 (PDT)
To:     Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     linux-security-module@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] tomoyo: don't special case PF_IO_WORKER for PF_KTHREAD
Message-ID: <46f6e3cb-cc96-d214-e183-71dd238da075@kernel.dk>
Date:   Thu, 25 Mar 2021 18:44:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The io_uring PF_IO_WORKER threads no longer have PF_KTHREAD set, so no
need to special case them for credential checks.

Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 security/tomoyo/network.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/tomoyo/network.c b/security/tomoyo/network.c
index 478f757ff843..8dc61335f65e 100644
--- a/security/tomoyo/network.c
+++ b/security/tomoyo/network.c
@@ -613,7 +613,7 @@ static int tomoyo_check_unix_address(struct sockaddr *addr,
 static bool tomoyo_kernel_service(void)
 {
 	/* Nothing to do if I am a kernel service. */
-	return (current->flags & (PF_KTHREAD | PF_IO_WORKER)) == PF_KTHREAD;
+	return current->flags & PF_KTHREAD;
 }
 
 /**
-- 
2.31.0

-- 
Jens Axboe

