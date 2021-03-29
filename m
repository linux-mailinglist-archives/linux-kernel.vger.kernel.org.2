Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331BD34C2F4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 07:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhC2FRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 01:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbhC2FQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 01:16:40 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCD7C061574;
        Sun, 28 Mar 2021 22:16:40 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 30so5889782qva.9;
        Sun, 28 Mar 2021 22:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sEr86AVwcLd6KRt5yIY5JO5/XZTpk+laeClwFCD3ZAU=;
        b=dPCMnD8RXbEUICkz2J1gsYGRXpJc/QWhgkqaAgbyQ9zCy//FsQsvFyTIR8tjWxINhF
         QPNMCn8bcoRTUy6WDQy3LIHOXv0FsDGIsjTU7Qgj9iVDphr80YaxVZp7Lk9Ruo3E1Il+
         6XFPPkQIj0KROIixzXruUHvmrXk9UmAXqKTAmBQmfwQvyV8V7len8ZYHZxoihs3GKhab
         q4YeL/eyKcpfsYTo5IGBc+910AxuLdtAfapceqj3aitl0xDyqMbg/GEh889+6hY7h/hz
         ce0op7LlmEgu1P1DYLCJ3rvvgJW52TDh+9U+2qWFPK5YuC7mWDQxiGIKakzmDoI2uFeF
         +Uzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sEr86AVwcLd6KRt5yIY5JO5/XZTpk+laeClwFCD3ZAU=;
        b=htOy5gLm4+IwWr6lWnDLFcgYV2AlAZf0CGzB3aRuBFKVsg9SfE8wfYvGxq2VaK7wJg
         IXC88doJlSoWMUH9mdDfA9KEFlu29d0bH8AiZdaveUHY9TXxxNdT2jJvfz0uwQq+zfAx
         xNEf69WolwIQnu4LpbZjiva6GRrnYbZHl8jXoWrcxeM1tJV/J0JARyuUf98Dw/aNLKwW
         ATrcBASGxcTyrK6uEV9szLQ2Ctm46nOK5YDdUCizjXODfy1rO+HUby5n3UuFYQLZVzOT
         3ttVBXF+Bn+3zdLYVcWEX29Yr8VZDD2DixOqgxpOjQ73HU6DIPE5p6czcHePnMN9nBW1
         Bicw==
X-Gm-Message-State: AOAM531DuPlgmIUu8LjWjscuqO+tBaBWvS070L8t8V0znf7pU2X+thR1
        8zmJgTpVdei0PWmfQ/Df5zXg+zeDbojpKA==
X-Google-Smtp-Source: ABdhPJzB0VLO4C/s/5b5noMXBXxyDmlGV3baFl+zLJvOeRqlhENGOqirPvkp8GWa8y68UKP73v5+mA==
X-Received: by 2002:ad4:560f:: with SMTP id ca15mr23629407qvb.42.1616994999581;
        Sun, 28 Mar 2021 22:16:39 -0700 (PDT)
Received: from localhost.localdomain ([156.146.37.195])
        by smtp.gmail.com with ESMTPSA id z124sm12993181qke.36.2021.03.28.22.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 22:16:39 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 21/23] scheduler: sched-nice-design.rst: Fix a typo
Date:   Mon, 29 Mar 2021 10:42:57 +0530
Message-Id: <785462a971881fc8d0d91a6b8efb585141488e0b.1616992679.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616992679.git.unixbhaskar@gmail.com>
References: <cover.1616992679.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/assymetry/asymmetry/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/scheduler/sched-nice-design.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/scheduler/sched-nice-design.rst b/Documentation/scheduler/sched-nice-design.rst
index 0571f1b47e64..3511d86575e7 100644
--- a/Documentation/scheduler/sched-nice-design.rst
+++ b/Documentation/scheduler/sched-nice-design.rst
@@ -60,7 +60,7 @@ within the constraints of HZ and jiffies and their nasty design level
 coupling to timeslices and granularity it was not really viable.

 The second (less frequent but still periodically occurring) complaint
-about Linux's nice level support was its assymetry around the origo
+about Linux's nice level support was its asymmetry around the origo
 (which you can see demonstrated in the picture above), or more
 accurately: the fact that nice level behavior depended on the _absolute_
 nice level as well, while the nice API itself is fundamentally
--
2.26.3

