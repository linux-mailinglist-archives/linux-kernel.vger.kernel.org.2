Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502DD45D9FB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 13:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349398AbhKYM2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 07:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348941AbhKYM0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 07:26:16 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F20C061748
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 04:23:05 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id u11so4437102plf.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 04:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=0exH2sCwa7aDzBqhSForXmgELZX/ke2E1XL+uWfu/Dk=;
        b=fdoZyZzTVOoiW+sTfygpNQf5F2SppTn19q/q9dODJ/IVliFE1IVbjOitC5T14djlBf
         GuNPr7E1PemEACprtv354W21xIkSS96a4FNYw/bMA+Tl306775ixY4Q0EWEBdN+8Ipfx
         +rPV3LGXpJ7f4vj552T6zE6ia1k9/l9GwV7OMbqsjPZVNXQEABVg7AqezeFaYXCS1uNe
         5JuWN3JbgdCY4L9hESmy0CxGSCSLGQu/u3zuN3UmL2eQbC14fMvFSrzWkZw9QJAQBZui
         Q1yziL8RvTnBHzW1NRVS9CQzSgvXFAcGwhpDSkAgmKtKrH5vMz3KyqhnJ6EoyXtupcI3
         +/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0exH2sCwa7aDzBqhSForXmgELZX/ke2E1XL+uWfu/Dk=;
        b=GW0MBQu319E7lT1Jc9vekjrKO/O5NVZ3ou5CCQ3HIoNCHS1e1Ef2mNnFYOA7x4Obk5
         qyiktkW8bTKGwBVC/9DHYWvNnGtg52bDM0AtwEXqso2e0O2CTzcW96If43AIXIM3bfXw
         1zo6LxdqnvZtRyPAwY28SjVRZfl0rdX7rcIKIQjZDX1vJEtkMeQNevm+F7Sg8cKORKlG
         hjWKsDRWyrNE9FQaeYZSJHg1mWBEeYIro0gBTwt4trFvY8GNAsYKBbxraefENTeraU4H
         aLRjUQ9NeYrNDAvt6evNbNG/HYazCrckamZlWtxWMCihDD0mVwuJdw9Y9P6McHLMh+7R
         1WVg==
X-Gm-Message-State: AOAM532FYMG4nMdYcuOEsqSjbPWncTSPFj7sasLVWKWbwUvgPeJUU+J0
        6mHCOJoWYxd9e/uSuC0CO/8=
X-Google-Smtp-Source: ABdhPJxkr9txjpgld10Vs65BTVh2xJoddWi3ssou2A/Cp110uCp/mUy5pFuTdEhNIJqJVPFTakK/xg==
X-Received: by 2002:a17:90b:1d82:: with SMTP id pf2mr6581885pjb.17.1637842985155;
        Thu, 25 Nov 2021 04:23:05 -0800 (PST)
Received: from localhost.localdomain ([117.254.32.200])
        by smtp.googlemail.com with ESMTPSA id ng9sm9342074pjb.4.2021.11.25.04.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 04:23:04 -0800 (PST)
From:   Ajith P V <ajithpv.linux@gmail.com>
To:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, christian@brauner.io,
        hridya@google.com, surenb@google.com
Cc:     linux-kernel@vger.kernel.org, Ajith P V <ajithpv.linux@gmail.com>
Subject: [PATCH] binder: remove repeat word from comment
Date:   Thu, 25 Nov 2021 17:52:18 +0530
Message-Id: <20211125122218.6767-1-ajithpv.linux@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

binder.c file comment produce warning with checkpatch as below:
WARNING: Possible repeated word: 'for'
Remove the repeated word from the comment avoid this warning.

Signed-off-by: Ajith P V <ajithpv.linux@gmail.com>
---
 drivers/android/binder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 49fb74196d02..0362caec9a7b 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -1933,7 +1933,7 @@ static void binder_transaction_buffer_release(struct binder_proc *proc,
 		case BINDER_TYPE_FD: {
 			/*
 			 * No need to close the file here since user-space
-			 * closes it for for successfully delivered
+			 * closes it for successfully delivered
 			 * transactions. For transactions that weren't
 			 * delivered, the new fd was never allocated so
 			 * there is no need to close and the fput on the
-- 
2.17.1

