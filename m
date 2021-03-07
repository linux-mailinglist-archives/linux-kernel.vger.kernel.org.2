Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C3D330016
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 11:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbhCGKVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 05:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbhCGKVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 05:21:15 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8B7C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Mar 2021 02:21:14 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id mm21so13909543ejb.12
        for <linux-kernel@vger.kernel.org>; Sun, 07 Mar 2021 02:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OlhsRcX2r1mrdqWL/plXqQnyTMN9cBEMPTdR2XkMHbE=;
        b=XK4Ddgl6sWALsNvGcBXvoBtWq4tEy99K/lUFlKohajRnmCcicRqojTqnLogR5AL+5p
         QNJR5YVqdF3T/jkTqMmuGs4aJzkeCLa5wsExDM3ZhqQkJXqh5/ejqOprxvxM/uH7hQjL
         8AcVm5qxpPRWUzM0wq/xcOuUdc5T7aHB/Z3cD6CVVXS296Ec95j0YrjTW0mvdk9r+RZv
         8UORGFdXXscylH4VqTTyMkw8AGF+YFwFypy4SeH4adBvmU4aimq/eB1rgyL/hJ1qMpOs
         WMr1uF8KzkbjEhR+vgadHOMHzsrHzTg26P/g0rQr/+quWdEavdEq53xw50xHZ4ctIkKO
         kqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OlhsRcX2r1mrdqWL/plXqQnyTMN9cBEMPTdR2XkMHbE=;
        b=VyKx9gST6paCqxMZMJbF0gfUjd5Ud462kqZc9iop2FZktRhTy6ZEukSBygrnpgsflC
         ljdYFcLubwg33SdDN0h0mxTCJ8J+UrU+eqZYFNwEJ5wyw24919AvDl1PNJcRM1ABrLj4
         hckz31YUclI6SPQVhMBdunDw0r2h9FSMfIJ/8+uyfOmP3K72JLQ/aitwHKQJ4d6g1cje
         VGTnoZV/8MFa985nZGlTAquyvSPG1mkaJzIulGboTC1/QpsoHFWhGdFAeBhj+aVs7RBy
         /PGyd+kYBacPUtslrOPTMDZtWNxCaWuMQrLMAj/84Acl1DCvYzPYNmpRO12t8aX7QvhY
         14MA==
X-Gm-Message-State: AOAM532wuULivuXn7tiqMGG9/JP1kUYVE7/6F6GT1OloUi3eNTqEopN/
        wpXdC3mTXgfwUL8E8sye6zk=
X-Google-Smtp-Source: ABdhPJw/8Ydhb7HiW1tqeAuAxIy8BHQMEP/IpYD7v8x3hbYLflzARMKKZcGKNyRCoy1x/UwOqMSaBQ==
X-Received: by 2002:a17:906:5611:: with SMTP id f17mr10344612ejq.208.1615112473184;
        Sun, 07 Mar 2021 02:21:13 -0800 (PST)
Received: from Limone.hitronhub.home (ip5f5ac7f5.dynamic.kabel-deutschland.de. [95.90.199.245])
        by smtp.googlemail.com with ESMTPSA id g17sm5177994edw.56.2021.03.07.02.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 02:21:12 -0800 (PST)
From:   Gon Solo <gonsolo@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Gon Solo <gonsolo@gmail.com>,
        Andreas Wendleder <andreas.wendleder@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Perf: Clean beauty directory.
Date:   Sun,  7 Mar 2021 11:19:44 +0100
Message-Id: <20210307101942.254366-2-gonsolo@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210307101942.254366-1-gonsolo@gmail.com>
References: <20210307101942.254366-1-gonsolo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up generated beauty directory.

Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Andreas Wendleder <andreas.wendleder@gmail.com>
---
 tools/perf/Makefile.perf | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 5345ac70cd83..293e297f719d 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1087,6 +1087,7 @@ clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clea
 		$(OUTPUT)$(sync_file_range_arrays)
 	$(call QUIET_CLEAN, Documentation) \
 	$(MAKE) -C $(DOC_DIR) O=$(OUTPUT) clean >/dev/null
+	$(call QUIET_CLEAN, beauty) $(RM) -r $(beauty_outdir)
 
 #
 # To provide FEATURE-DUMP into $(FEATURE_DUMP_COPY)
-- 
2.27.0

