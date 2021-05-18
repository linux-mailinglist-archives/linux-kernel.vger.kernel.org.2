Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F84B3881E9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 23:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240695AbhERVPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 17:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236093AbhERVPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 17:15:13 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11BAC061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 14:13:53 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id o8so13189179ljp.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 14:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=user-agent:from:to:cc:subject:message-id:date:mime-version;
        bh=zWKGOVNhjbxONyYQxFjkbgyC/wTgtXeC2wfef2aSMW4=;
        b=WDElqSZ1gLaLCHrQf0JD8yg8hs80vh49emG7Ulqr2BvJ/ELlGhPc8cCUqxFcQfKdmy
         5tOU5xefJppSPreHlboZoTVygmc3sdz92XpaRZAiaBjGAw2IHyG5bjGseuYcD6K0inso
         oOXnIaTv7/6VYq/eYTefm4yQRhnn+BeqhiB9frIdfimGOHPvnBcHHaVFp1fTwykGOHV7
         Zd0QrnYesXI9N8kfMceqvVR7HRy2tEaONQ2178tf0rnC5NpKE2GOUShJQDXUfCCwEhG0
         xIAxO12bqPXqD73yNqAyp/Hbyif3oe4RwutD8wUhi1AeFoSumnvKiTBhw8AxeeEhSO8m
         Eikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:user-agent:from:to:cc:subject:message-id:date
         :mime-version;
        bh=zWKGOVNhjbxONyYQxFjkbgyC/wTgtXeC2wfef2aSMW4=;
        b=ZFwHFdI8LdvcjBHEsH6QWuGX0JkN5zjjveKGuS7+TAOxqLPmh1uJOHymrAagGgs5sD
         H+BbBNEq5qDtvYJfhCdSGhaZOFMpynrPTgnCDeR54REcmi+GHVHRpMlPMwB8yigD6UCM
         4EyNxJpy49pTJFLo4byPzITTdXibC88Uhoox9yNBpCMLEeTq6evArD5QU9hqwVMcrHFV
         +qWf7K4uH+mreeNjkGcU5+ABSZm7Epa5q5lLNUEdHQO5odpNnrO7spleAd8nGxQsWd6E
         TEst8LVSLsEiEj+tBeHh3p9bKMCpqSMUEUkP5FEeM6AYVbCfpFYOLAL06D9N3baM0WpY
         3VuA==
X-Gm-Message-State: AOAM533ikTNUxE3PMthNUs0hHlvAJewCrFOCVHZasoZ/riBBSzkpb9gP
        X/Ikr6+0BTXb9M+oGH8YzV0=
X-Google-Smtp-Source: ABdhPJx5XM5KiDzzDdFa1rKs5QFdBUREdGrMcVeGKGKTOPI2NGez5ChpnURa9HW/HH85xSAP3HgRpw==
X-Received: by 2002:a2e:8682:: with SMTP id l2mr5755054lji.298.1621372432398;
        Tue, 18 May 2021 14:13:52 -0700 (PDT)
Received: from wractal (c-9acce455.023-86-6d6c6d4.bbcust.telenor.se. [85.228.204.154])
        by smtp.gmail.com with ESMTPSA id 81sm2404475lfc.300.2021.05.18.14.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 14:13:52 -0700 (PDT)
User-agent: mu4e 1.4.15; emacs 27.2
From:   Waqar Hameed <whame91@gmail.com>
To:     Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: [PATCH] dma-buf: Fix minor typo in struct dma_buf_ops documentation
Message-ID: <87k0nvn5ne.fsf@gmail.com>
Date:   Tue, 18 May 2021 23:13:51 +0200
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a minor typo.

Signed-off-by: Waqar Hameed <whame91@gmail.com>
---
 include/linux/dma-buf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index efdc56b9d95f..5ae51bab158b 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -50,7 +50,7 @@ struct dma_buf_ops {
 	 * &dma_buf_attachment.dev can access the provided &dma_buf. Exporters
 	 * which support buffer objects in special locations like VRAM or
 	 * device-specific carveout areas should check whether the buffer could
-	 * be move to system memory (or directly accessed by the provided
+	 * be moved to system memory (or directly accessed by the provided
 	 * device), and otherwise need to fail the attach operation.
 	 *
 	 * The exporter should also in general check whether the current
-- 
2.25.1

