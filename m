Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5354D325B80
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 03:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhBZCNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 21:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhBZCNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 21:13:37 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FBAC061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 18:12:57 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d12so2684143pfo.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 18:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yeWyaSel7U9eSxOcBt5qJfEQetEzs7vQl7xINbGhi+A=;
        b=XY79rE3hGyDbLdFZT8nD2HQ1isKgQ+OFXiOIFTeR5H5a4FsQVMdFmsvacNlq6pS2lJ
         6GEHyvu4EenSb95Z985YMZlDcrT9jFr5k6UHhpDX1lTCfy55JW/r0VBqmhCPvs9QvsJS
         ue0OTjy5vzxt+HAv6Ly+dnAPPjSa+gWpta1e+bGZWtR+GLbTwd+O7w+vE78ZDdO5bYEh
         vCjFC9c1jP7tyIDYo3u85cqKvMwxnDB4w2K7tS5cV90u4kr6WLzbKDwWTnMcJlrRHxTF
         h5CM+3Nl9E/dvsPEhZTwffOc2UEJLB/UWrfQuDj5xWjKqKaW9RpZ6L2myBIXiB4XIvD6
         MPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yeWyaSel7U9eSxOcBt5qJfEQetEzs7vQl7xINbGhi+A=;
        b=iu68XfP+fWZxDkrKnblpZoLFqNHc4dQ+DapyS85OVlNvfTTUac73NDv9BI+xQMy6YL
         Xp5l6obfIKojZkWgNBG8fhgDHX9jTsdWByQkf219Pz1YWdYvL1f+O1HQfDzzWbYmhXip
         18yhwHaKm3cOaeSv4RDemEhwntJhGCmyFQW1hnwPiq5mdcxTJp7JG8EUH+DuaFlK4uqt
         in61J4z2lTzkXzHpyDFkmk0qrGmrdTHhUuDV3836izPslGOttarzlJ42MrRxTRO28KWB
         0NUX+yEGNluis3Tl/fl27V9MnAMgJuxXlV7TFnlkAtHBU9UwXW/ubXfnNsDsl96CzcbU
         9iXQ==
X-Gm-Message-State: AOAM530usElRTJpyDiFKAm+DwrmFGYjbLNHrm4h2+PjuureyqOu6dYB2
        xH/SXyw5jffS8Ke/KVw1aiUl5tZ9nOY=
X-Google-Smtp-Source: ABdhPJw2+rDNi4gbjIsJUVGbsD6lPhwC1Ye+NPiIPMpls61+YQ/vGQj+DCb4ukpnWdAi4yyH7OokWg==
X-Received: by 2002:aa7:8f15:0:b029:1ed:9356:a9e with SMTP id x21-20020aa78f150000b02901ed93560a9emr691428pfr.73.1614305576840;
        Thu, 25 Feb 2021 18:12:56 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id 8sm7773531pfp.171.2021.02.25.18.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 18:12:56 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     hannes@cmpxchg.org, mhocko@suse.com, guro@fb.com,
        shakeelb@google.com, akpm@linux-foundation.org, corbet@lwn.net
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] doc: memcontrol: add description for oom_kill
Date:   Thu, 25 Feb 2021 18:12:54 -0800
Message-Id: <20210226021254.3980-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When debugging an oom issue, I found the oom_kill counter of memcg is
confusing.  At the first glance without checking document, I thought it
just counts for memcg oom, but it turns out it counts both global and
memcg oom.

The cgroup v2 documents it, but the description is missed for cgroup v1.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 Documentation/admin-guide/cgroup-v1/memory.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index 0936412e044e..44d5429636e2 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -851,6 +851,9 @@ At reading, current status of OOM is shown.
 	  (if 1, oom-killer is disabled)
 	- under_oom	   0 or 1
 	  (if 1, the memory cgroup is under OOM, tasks may be stopped.)
+        - oom_kill         integer counter
+          The number of processes belonging to this cgroup killed by any
+          kind of OOM killer.
 
 11. Memory Pressure
 ===================
-- 
2.26.2

