Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA6934C2EB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 07:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhC2FQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 01:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhC2FQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 01:16:17 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F23C061574;
        Sun, 28 Mar 2021 22:16:17 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id g15so11382574qkl.4;
        Sun, 28 Mar 2021 22:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=De7D/2+J43dmpkMVEvObFo4NGBGgRHpRSklZzoDw2oE=;
        b=nqCLa13OgkFgmKb4JQHG5mfTcdQPro+ZJaoYi1mVgsukZ3vq+SGVa2Gs9v+TCYVgw1
         IPIqQ2CFX0j7KXVoCfJRt06EsImVkIjQJ78S6wsABxG7M9MhkWQfk5pooZ0ExFNIFKYG
         3Dl5zDzXgTx6KHOID1drgMMmNb6zh08jrxsIyFdQk5IHIhaC61I6/tszYGBoT9/YMJuz
         F/Oq/yGIRHfT4m986PewDEjloWPh7s6bsghUAjx7a3GSdoejKLgMxEo4EK9vGhYeT+Dw
         tf4aloKORmQMdc2NkwD8msNOBAMgyNtoSEhOWwTVUHkZ1jfFKuHlkfOdDY6X7LOkVyHo
         zkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=De7D/2+J43dmpkMVEvObFo4NGBGgRHpRSklZzoDw2oE=;
        b=WPFd9kuxl8YOlYPRe7LDYN82L3vQ2dx4MnZcPnRehOoB4v7sUdkeFRzrjwwXFmRd5e
         Vxyp8eRw0eyLk4egrCs547CrswsSUxm/mbGbA3eK/MU97yjm62vVixywxVZSTL+DiJzS
         Oz5YwFrdPOwhaNho20GWHCPsoWnzlmjZpTQo8H91fGG8Kio+h0odxhLOfZKv3WsCVLif
         dy5IYneAz8FhHh/tKj4YGappcxpuhPVK8slSXF5C839LGLEp0PTXUP82ivCLvV5y4eJ4
         qmuVeBu/s53ay2uyS5mQ6zv1V8xY33o1hCDtoWrwM4qASc2wSETa9Rk3PWFMabG7keTn
         543Q==
X-Gm-Message-State: AOAM5336W39fVNljRL7QWg2Y9Ax98T5ruZN5UBeNdp4eGqtXDp7wc2UJ
        KQYEWgzdCRc+JVgnq65BVyQ=
X-Google-Smtp-Source: ABdhPJyE7m8fs5qCWbQ/eqDkXEJuyF//xCYQmieGX1iGrvLo/cqbbwwl63uGbNrhzAV0OXoc10NHmw==
X-Received: by 2002:a05:620a:88e:: with SMTP id b14mr23285064qka.166.1616994976913;
        Sun, 28 Mar 2021 22:16:16 -0700 (PDT)
Received: from localhost.localdomain ([156.146.37.195])
        by smtp.gmail.com with ESMTPSA id z124sm12993181qke.36.2021.03.28.22.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 22:16:16 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 15/23] trace: events.rst: Fix a typo
Date:   Mon, 29 Mar 2021 10:42:51 +0530
Message-Id: <8c888c8cb91767c9d49188faaadc8fd9112eb184.1616992679.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616992679.git.unixbhaskar@gmail.com>
References: <cover.1616992679.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/specfied/specified/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/trace/events.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
index 8ddb9b09451c..80052adc592d 100644
--- a/Documentation/trace/events.rst
+++ b/Documentation/trace/events.rst
@@ -884,7 +884,7 @@ functions can be used.

 To create a kprobe event, an empty or partially empty kprobe event
 should first be created using kprobe_event_gen_cmd_start().  The name
-of the event and the probe location should be specfied along with one
+of the event and the probe location should be specified along with one
 or args each representing a probe field should be supplied to this
 function.  Before calling kprobe_event_gen_cmd_start(), the user
 should create and initialize a dynevent_cmd object using
--
2.26.3

