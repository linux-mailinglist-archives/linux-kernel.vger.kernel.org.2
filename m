Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9AFE45B778
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 10:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236034AbhKXJeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 04:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235832AbhKXJeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 04:34:13 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985E1C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 01:31:04 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id o4so2040540pfp.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 01:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=z4F4OVhEPHtBUs/B2Dvh/koKyjXjnSpyk1IgSQCoprs=;
        b=dmoAaWmpb8pzJPtJD6+DrFhrpT1xQVc+aeA3ypRwH0SWGK8unzBv0cppKciVYnz1+H
         06nEa6kovF5k+DiK6xkjJwMB7DxQcuOhxHU02gPk4Z7/8ljzV/i3FOO2movhmfoGJl4P
         p8bHUW6O+Ra+7qV9Hi0NAXDJrNK93hxxwI5BOkztDZFOQuxuJRiayh4jv8n3drThcyxO
         YBmHzauDqj0aefyn4W59b1V+wJSRlRbepYWpdHI/gspwYLZ9LJERPqQrvDucIofS+3kw
         O6YDEusjbbFd/rsuwOYEsldqjyeB2tN2dZE86ZqDsUJEdQ8yf8OWjqtbxCUTWf/gKtOl
         lTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=z4F4OVhEPHtBUs/B2Dvh/koKyjXjnSpyk1IgSQCoprs=;
        b=eF+S83ndv9ThlgZ0EPrSBzhm16twqBo0tsTEkAPy0lQbQ45AP35idHfKoBLWmT8il0
         bY9uWKXu/gSLV2aWmdtNGYh2HgfsywAIp2n9WbMCto11dkqBIUS2HRrkHL0i4PEsRjFs
         g/eF6gTizdtXcmSpvtlBIZ/mnxtqNn+Kr7Oof0pfHAAyxKd3t+FgF9q7qdPC6qFyvD2Q
         SgdwqAToaVnIhSoF6QsM5ygejQFU/vW8CBno6voC8CegQGMskGeWNubDGnWmXytka7cU
         2/9Fi8E6B4+/7OHvsoLeY6jkB54MHeC/cpRS2AgtYELf4GygaaNQj6RS2hLvUSPS9JIj
         DbfQ==
X-Gm-Message-State: AOAM533WV58aPnIeaGr+sB/WvegAVd5e+G1jQNvKQ0HyO2z85hrLhGN8
        vuSgAhymLrCaYlzb7i0vf4U=
X-Google-Smtp-Source: ABdhPJy/uxVmg1iIt/DewpBqRaNLb3QpUVpyeAvqGM8dtJ/P7UH8Bgr21aBdIMNydTssn39KzocZCg==
X-Received: by 2002:a63:4b0e:: with SMTP id y14mr786839pga.162.1637746264203;
        Wed, 24 Nov 2021 01:31:04 -0800 (PST)
Received: from localhost.localdomain ([117.254.32.182])
        by smtp.googlemail.com with ESMTPSA id z19sm16464799pfe.181.2021.11.24.01.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 01:31:03 -0800 (PST)
From:   Ajith P V <ajithpv.linux@gmail.com>
To:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, christian@brauner.io,
        hridya@google.com, surenb@google.com
Cc:     linux-kernel@vger.kernel.org, Ajith P V <ajithpv.linux@gmail.com>
Subject: [PATCH] binder: reframe comment to avoid warning
Date:   Wed, 24 Nov 2021 15:00:02 +0530
Message-Id: <20211124093002.9795-1-ajithpv.linux@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

binder.c file comment produce warning with checkpatch as below:
WARNING: waitqueue_active without comment

Placing the waitqueue_active comment just above waitqueue_active() avoid
this warning.

Signed-off-by: Ajith P V <ajithpv.linux@gmail.com>
---
 drivers/android/binder.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 49fb74196d02..e1695535f252 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -4424,10 +4424,12 @@ static int binder_thread_release(struct binder_proc *proc,
 	/*
 	 * If this thread used poll, make sure we remove the waitqueue
 	 * from any epoll data structures holding it with POLLFREE.
-	 * waitqueue_active() is safe to use here because we're holding
-	 * the inner lock.
 	 */
 	if ((thread->looper & BINDER_LOOPER_STATE_POLL) &&
+	    /*
+	     * waitqueue_active() is safe to use here because we're holding
+	     * the inner lock.
+	     */
 	    waitqueue_active(&thread->wait)) {
 		wake_up_poll(&thread->wait, EPOLLHUP | POLLFREE);
 	}
-- 
2.17.1

