Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED00734EE52
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 18:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbhC3Qq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 12:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbhC3QpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:45:25 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0C3C061762
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:25 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id p19so8762047wmq.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/W5+TkNvfgUYvNj9KoLAcT+V+gYW+tMwitOO80W2Zqk=;
        b=M7ctHdycwwzbcldWwAk4i25/4o5SCvAmv4EGrID+dezRjljGawdNTLz9HK1YoAMs1/
         LsVVI7opOLx5NQMbxwYnjmUysc7sTnG1hCT627n1I1CxGWckwlghvEVkE3hUg1O9bq0G
         5cVD21aavKEnfi2xqvB2HyRqCywJjBk+SWXGwKmiulk6ajstXNXWmDYhDJ0D47Ixt4lx
         HETuxdcav7caWhwdSmM4NW61HnqK1i6bIRe35eZDRf8nvsTb+2xaQbIISBP3/XBj9OYQ
         BE9vtVJ51mwhNCmHfcN6og1z3vCYwzyUi8RLpl8pnXyaxO7Ucyf4Fxyebr9ZlrTHmJ0L
         613A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/W5+TkNvfgUYvNj9KoLAcT+V+gYW+tMwitOO80W2Zqk=;
        b=UPpvp8csZVksn8XPA3azrQPp/UF5A9rvTSxax40sqZ3osV1Qm9dcMURHDbIn2T3jPo
         fTcwX1LyYOuCV15PXs+Ub+O+Rsv5+YWeKtqeD2qQ7hgXJN3OlpCWr5577LJt9ciV9bdz
         B5YaJLIOY8o64M8BV39KRGREKSRMY9D7Qmb64G/b/8+2ouoc1vu4I5BRIGnG6LpijYBM
         ninm6T8axfC7aj5Bfi19jeA5IOAgrXjPDKA9H08MIpx5lrK6Ej6D56LJPjTsAYmFsnQi
         fPqr8W3txpQ3zYmaKn23sofgpvlkmR1hTW20Ve+XCC8gBDgdDTaY5bVDeLpZCkeg6zrs
         X34g==
X-Gm-Message-State: AOAM530o35h92mdrknkcygfw392trnzQGJR4e/UEE6DZk0xhnZL8YAyB
        +ce673nKlRXKKYgYZnp2xtjUI+ukJej94w==
X-Google-Smtp-Source: ABdhPJzdhYHsxQgfkzwFzJGeGhzHFLn3jp+MPZhPB6Zd/ToCgxuSK35Dy0TEwpWEY22BTQmzP5dAww==
X-Received: by 2002:a05:600c:2109:: with SMTP id u9mr4954337wml.44.1617122724090;
        Tue, 30 Mar 2021 09:45:24 -0700 (PDT)
Received: from dell.default ([91.110.221.217])
        by smtp.gmail.com with ESMTPSA id a15sm25660805wrr.53.2021.03.30.09.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 09:45:23 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Tyler Hicks <code@tyhicks.com>,
        "Michael A. Halcrow" <mhalcrow@us.ibm.com>,
        "Michael C. Thompson" <mcthomps@us.ibm.com>,
        ecryptfs@vger.kernel.org
Subject: [PATCH 23/31] fs: ecryptfs: file: Demote kernel-doc abuses
Date:   Tue, 30 Mar 2021 17:44:50 +0100
Message-Id: <20210330164458.1625478-24-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210330164458.1625478-1-lee.jones@linaro.org>
References: <20210330164458.1625478-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/ecryptfs/file.c:23: warning: Incorrect use of kernel-doc format:  * ecryptfs_read_update_atime
 fs/ecryptfs/file.c:34: warning: Function parameter or member 'iocb' not described in 'ecryptfs_read_update_atime'
 fs/ecryptfs/file.c:34: warning: Function parameter or member 'to' not described in 'ecryptfs_read_update_atime'
 fs/ecryptfs/file.c:34: warning: expecting prototype for eCryptfs(). Prototype was for ecryptfs_read_update_atime() instead

Cc: Tyler Hicks <code@tyhicks.com>
Cc: "Michael A. Halcrow" <mhalcrow@us.ibm.com>
Cc: "Michael C. Thompson" <mcthomps@us.ibm.com>
Cc: ecryptfs@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/ecryptfs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index 5fb45d865ce51..18d5b91cb573e 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * eCryptfs: Linux filesystem encryption layer
  *
  * Copyright (C) 1997-2004 Erez Zadok
@@ -19,7 +19,7 @@
 #include <linux/fs_stack.h>
 #include "ecryptfs_kernel.h"
 
-/**
+/*
  * ecryptfs_read_update_atime
  *
  * generic_file_read updates the atime of upper layer inode.  But, it
-- 
2.27.0

