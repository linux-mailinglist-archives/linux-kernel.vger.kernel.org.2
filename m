Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5CB349E33
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 01:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhCZAnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 20:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbhCZAmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 20:42:53 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8D3C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 17:42:53 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id kr3-20020a17090b4903b02900c096fc01deso1645477pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 17:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=FRkAThF8DGg12CB1k3JLmbzczGDouY6nWnB+O1TTVWw=;
        b=OuN40zvIOYNUHtPvP0rNV8V/laC6xAF009VuLibLSfOWtP9dE4YLlsLsd9YCCXAFJL
         w1ySYDedI51vQER9vp2h1T2PRFPd1gWDB9I0xQce2YJ4/vl4vCFOM7Y7yFuaoeg2nyxu
         UaTOFgxBwMllXpSDp+EE5fSmYKO6dyTLfVDIoB2SnAG+30r+55nsumjGCX5+FnTSNwOp
         QE865krTn3qQ46NRzMWtvlWjHGhKnkhDwaQVeLLzei4FbhSB+Q+MOUfqokBCE1vm0IdX
         MTEg8zYzdz2fXeg+yedRYQR9mn+le+jlPad7Re2nGCdhJ5KpJl7KK6Ae8Lv/gHFyIy61
         NJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=FRkAThF8DGg12CB1k3JLmbzczGDouY6nWnB+O1TTVWw=;
        b=Np2yY/FR/QqJyZLcG7rKRFjyGVdJPYKHmmHIKPvhBaqQa855n2aB5E6BC/orD8IYki
         EfVsRrcqgjuNt1BcZgTMVd1JHc/LD7yJ5tQlFDtDnkC4GXrUyNNXd+E8Zs/F2mwyLZ2E
         izAbIYxJkml8QPemK/04JGE/NNHUVe8Hf6o8SN/nsVZD4TbW7XVgoy8L74eM/0EtLt+j
         op9hGv0IWiOyNu6miTvWuv/qcPZ+qoM7m3NRu8fy54WYO/wCasxW1l4hVYVRDSi3tIs1
         FFjXW9oszwUqd8ULd0jZAn40y0iza3dGok7PtREPb4n23p+/3mCsYPHLXhEo7XC5n1xb
         wpMg==
X-Gm-Message-State: AOAM531MCDmIzQkITT3Zj0D2KQkMl8jFTbjX/0W+DxieDcy1z625whj3
        GDwWTcmOJVCMpooXOBf85zFQKzoaLTN+nw==
X-Google-Smtp-Source: ABdhPJx30s73JxY+7M8GjfzG7uo9gAtbadrYS04canCbpnVJJUAiHeHKwjUG21vHCZU6RZniFSTMsQ==
X-Received: by 2002:a17:90a:c207:: with SMTP id e7mr11029490pjt.188.1616719372416;
        Thu, 25 Mar 2021 17:42:52 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id a21sm7031178pfk.83.2021.03.25.17.42.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Mar 2021 17:42:51 -0700 (PDT)
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] Revert "Smack: Handle io_uring kernel thread privileges"
Message-ID: <04c7c410-08e8-626a-795e-b77db6666804@kernel.dk>
Date:   Thu, 25 Mar 2021 18:42:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 942cb357ae7d9249088e3687ee6a00ed2745a0c7.

The io_uring PF_IO_WORKER threads no longer have PF_KTHREAD set, so no
need to special case them for credential checks.

Cc: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 security/smack/smack_access.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
index 7eabb448acab..efe2406a3960 100644
--- a/security/smack/smack_access.c
+++ b/security/smack/smack_access.c
@@ -688,10 +688,9 @@ bool smack_privileged_cred(int cap, const struct cred *cred)
 bool smack_privileged(int cap)
 {
 	/*
-	 * Kernel threads may not have credentials we can use.
-	 * The io_uring kernel threads do have reliable credentials.
+	 * All kernel tasks are privileged
 	 */
-	if ((current->flags & (PF_KTHREAD | PF_IO_WORKER)) == PF_KTHREAD)
+	if (unlikely(current->flags & PF_KTHREAD))
 		return true;
 
 	return smack_privileged_cred(cap, current_cred());
-- 
2.31.0

-- 
Jens Axboe

