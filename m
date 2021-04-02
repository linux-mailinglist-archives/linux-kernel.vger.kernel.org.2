Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D11BA3525ED
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 06:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbhDBEEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 00:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbhDBEEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 00:04:08 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF045C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 21:04:07 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id v3so4362134qtw.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 21:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6Te16lToFbpWkwiPKfVrY5ITMJx7QI7j6Z0kH9+UvdY=;
        b=VJJs3kLA2FlLSADc8XRAGONxvacGnDhVHTGIsCSsZvq+lFnsh0h1YxFRHg7sLZpJnQ
         Ss8dkCxn/ICzfMQV7xqaWw1yXewN/yHLWF4WfG3PsKBOeaEZP1vhm3X4jxiDMd5Gnbfu
         C8FAYoC2Z3tJe/uUeaUS6tyOplPuZ81/sz5VB8OFIqDV4YULL3WYOsYqJKyVN4ABWSzm
         cjqWLgH42q/D/Q3qUf02YrtQT7eAxFY0XKHEHzCvQCI8kMAqQ6ntTIrCyKHw/bK8wqkA
         uYfV8XScDKCkg2d9+fhB52MeSyztMflzZMeZFkfai+sXLrhs4SFHMCDvYrw8fxvTvDcP
         OJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6Te16lToFbpWkwiPKfVrY5ITMJx7QI7j6Z0kH9+UvdY=;
        b=ZXxpQDzkDaacSF1YzRJHBnD5/sEG7ndswfzmyY6y2nZa4LqkaoOCi4UhnEDPsUkxii
         YcSmsB6Ajt6L8l1PAri3gVs8jpORtrI6tBfcRJsCxCamucB/D6LgEDrd9Syyi+5UGj1f
         RLo455sc9oVJLyNE5xtHSQ6mK5MQzyOn3m66CX02apSAf5tr2EpGLpIWD1nOYXS+KPJS
         KqcCo03mPn8CDnXxp+z+ZD03qlogSY55hgUZX38lWsrjKAGDqusTh5NMMt1qNkl7OqxH
         va5NRdLm1mn5lrHdWP0JmzmC7CZfWNeALFJq4SptbjOFj8NpAP/+3Q0ZCNO7tVJAnJLd
         LUiA==
X-Gm-Message-State: AOAM532SQxMbsD7HbwchS5U88F0eaMAGsTG7x91omXmqIdpDQTVZIvdt
        809Cvhi0HM8VBEjoAiwy0h5JS9AMEGc7f74=
X-Google-Smtp-Source: ABdhPJxLFoe6kJde5jCBRiwBqL/qJgiFTdutSqAkbgR0bQOdjMjbOR+JAZFtd33e/MskS1xjxhLDXElqVU8k4Ow=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:4867:55c5:8fbb:da39])
 (user=saravanak job=sendgmr) by 2002:a0c:ef09:: with SMTP id
 t9mr542992qvr.21.1617336247156; Thu, 01 Apr 2021 21:04:07 -0700 (PDT)
Date:   Thu,  1 Apr 2021 21:03:40 -0700
In-Reply-To: <20210402040342.2944858-1-saravanak@google.com>
Message-Id: <20210402040342.2944858-2-saravanak@google.com>
Mime-Version: 1.0
References: <20210402040342.2944858-1-saravanak@google.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v1 1/2] driver core: Fix locking bug in deferred_probe_timeout_work_func()
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

list_for_each_entry_safe() is only useful if we are deleting nodes in a
linked list within the loop. It doesn't protect against other threads
adding/deleting nodes to the list in parallel. We need to grab
deferred_probe_mutex when traversing the deferred_probe_pending_list.

Cc: stable@vger.kernel.org
Fixes: 25b4e70dcce9 ("driver core: allow stopping deferred probe after init")
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/dd.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 20b69b5e0e91..28ad8afd87bc 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -291,14 +291,16 @@ int driver_deferred_probe_check_state(struct device *dev)
 
 static void deferred_probe_timeout_work_func(struct work_struct *work)
 {
-	struct device_private *private, *p;
+	struct device_private *p;
 
 	driver_deferred_probe_timeout = 0;
 	driver_deferred_probe_trigger();
 	flush_work(&deferred_probe_work);
 
-	list_for_each_entry_safe(private, p, &deferred_probe_pending_list, deferred_probe)
-		dev_info(private->device, "deferred probe pending\n");
+	mutex_lock(&deferred_probe_mutex);
+	list_for_each_entry(p, &deferred_probe_pending_list, deferred_probe)
+		dev_info(p->device, "deferred probe pending\n");
+	mutex_unlock(&deferred_probe_mutex);
 	wake_up_all(&probe_timeout_waitqueue);
 }
 static DECLARE_DELAYED_WORK(deferred_probe_timeout_work, deferred_probe_timeout_work_func);
-- 
2.31.0.208.g409f899ff0-goog

