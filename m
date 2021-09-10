Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981C1406FDC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 18:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhIJQnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 12:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhIJQnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 12:43:03 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D95C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 09:41:52 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id i24so2332705pfo.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 09:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pjxTGaGF+Iep/8cF7UJzXKo9VTJ6ycOJPrc5n+aXGe8=;
        b=NSA3log3y/vRLGgvrTekglk9v4cGHkDpJNmBMaWrpNCqegVngFXGv47F/un8C5Cfy0
         zpa8aqvxiaM0q6B5NwUBDfhCU7VVFcMiDDSMqF4bklx3lYqc3AswFtFqAQwSw8CaZFij
         yGoqdr+9WS9mWY2RLDvrcjElVviXJ2BypPrgaD99KDSYir9qLetW16TtbLk48nk7ZntB
         i8mihLOB13jixGDjsmqFrGjwFyFRcMcXm+Id2kDb3b/gVjbwnGGQqWXoK9W/FaMd5Xu5
         ejMk+4gBC35/LAG4zu3T5jhtHJM8BCs6Pq7x951rCUeIJXbugRDn3837I6MqzYSnc3qz
         6Svw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=pjxTGaGF+Iep/8cF7UJzXKo9VTJ6ycOJPrc5n+aXGe8=;
        b=AYySp8wfBPMhnc2Bxrz6LzV7POg03R836R+gIhtsuO3fLdqUvnvnY4SVvPZB+iqVHd
         9mOze9tD8B7dGdo1YDPe/ehrYPqDgrB2SehLmj6gqMhMqJ5QxcI000IyYRzyA0YnWTzh
         GaRz0mz5FqNWVtT/e5vTN2wDwK4QD6YXULhaT7uYEHejiuwVVvuusFCDPstm6/xcB4SS
         kAg9FdY26cNqC2N6kOZyh2BhhCdlvI5KnMQ1PYj0iDUvqzU+S5k0V53ZBbEuVplv23VQ
         PRbZMzQ0CoSaLjUdfv/odsTyN8YQ1dw00x/9KV+Ep33lb/3j1f6GcPtW+660uAzU+57w
         a0xg==
X-Gm-Message-State: AOAM533LBAM/5lKQSIJvQRglIr4CjkXt1tbxuHezcRqrELTHeBP06+yd
        Xd5s0V2cGYN5n8IxGfqS05o=
X-Google-Smtp-Source: ABdhPJyzhUjAtMbJPy0lJkbDUaW2MCzpJejiVWgQyAJdnfFUVoFLgkuxp6Ur7eXY+uc6n/RrfXW3RA==
X-Received: by 2002:a63:7d04:: with SMTP id y4mr8185409pgc.131.1631292112232;
        Fri, 10 Sep 2021 09:41:52 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:e240:6ca6:1a1d:d57:193a])
        by smtp.gmail.com with ESMTPSA id p11sm5328840pfw.203.2021.09.10.09.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 09:41:51 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH] perf tools: Allow build-id with trailing zeros
Date:   Fri, 10 Sep 2021 09:41:50 -0700
Message-Id: <20210910164150.1028294-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current perf saves a build-id with size but old versions assumes the
size of 20.  In case the build-id is less than 20 (like for MD5), it'd
fill the rest with 0s.

I saw a problem when old version of perf record saved binary in the
build-id cache and new version of perf reads the data.  The symbols
should be read from the build-id cache (as the path no longer has the
same binary) but it failed due to mismatch in the build-id.

  symsrc__init: build id mismatch for /home/namhyung/.debug/.build-id/53/e4c2f42a4c61a2d632d92a72afa08f00000000/elf.

The build-id event in the data has 20 byte build-ids, but it saw a
different size (16) when it reads the build-id of the elf file in the
build-id cache.

  $ readelf -n ~/.debug/.build-id/53/e4c2f42a4c61a2d632d92a72afa08f00000000/elf

  Displaying notes found in: .note.gnu.build-id
    Owner                Data size 	Description
    GNU                  0x00000010	NT_GNU_BUILD_ID (unique build ID bitstring)
      Build ID: 53e4c2f42a4c61a2d632d92a72afa08f

Let's fix this by allowing trailing zeros if the size is different.

Fixes: 39be8d0115b3 ("perf tools: Pass build_id object to dso__build_id_equal()")

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dso.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index ee15db2be2f4..0c0dd877d4e9 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1349,6 +1349,18 @@ void dso__set_build_id(struct dso *dso, struct build_id *bid)
 
 bool dso__build_id_equal(const struct dso *dso, struct build_id *bid)
 {
+	static const char zeros[BUILD_ID_SIZE];
+
+	if (dso->bid.size > bid->size && dso->bid.size == BUILD_ID_SIZE) {
+		/*
+		 * For the backward compatibility, it allows a build-id has
+		 * trailing zeros.
+		 */
+		return !memcmp(dso->bid.data, bid->data, bid->size) &&
+			!memcmp(&dso->bid.data[bid->size], zeros,
+				dso->bid.size - bid->size);
+	}
+
 	return dso->bid.size == bid->size &&
 	       memcmp(dso->bid.data, bid->data, dso->bid.size) == 0;
 }
-- 
2.33.0.309.g3052b89438-goog

