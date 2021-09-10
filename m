Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4124E407381
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 00:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbhIJWrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 18:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbhIJWro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 18:47:44 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D2DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 15:46:32 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id bb10so2082983plb.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 15:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hDI8Y6mH8Vv3DAsnwS0yW9w8j+2nbIddrFiYVYVb1dk=;
        b=KNPYmUim0fOfCtO8Wr4jZVQjg0tWMRDCSf2r/LF5Sin3uawGILEPXqog+7dRSDo+KI
         dcg/OryMJbklnfL14SqKDRz8WBpBuopwEDlKhOjnYSOjC247ljm86vVZU0hHrfH+ddTa
         vFHPQORDWT0CHwHzFySKIbzDgC47s57njn6ZEGwBMC5KTOQB14JvmUAS4t4r+sz/knsU
         T+wg8isinB/dCd1dfVBK7yFkIilTHK9bR00fdbGuFIFN65VdDg2dI3HR9/vtpDV6IJsx
         mTv8fco8KkbdBrijMl7lMGZKoPCloJkMmlS/5tNcuQjevfEJC5W8uRus9X8S2E06Fz9I
         NWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=hDI8Y6mH8Vv3DAsnwS0yW9w8j+2nbIddrFiYVYVb1dk=;
        b=28nVcXn/UZWVk5sA+v8HGvfBZgi94Rh5OCkVyocWV328+kwaF3x/wqMZvhfPlXh9pS
         XTmSLxChq9tTPOpPbIKOrK56wmuP8yWSAhM53ZMoiu0K29S7Avbmk2ZTLs5T4oMVqSiR
         fOP+dbONmUQxeuHUBrZUu5toN6/tRqy9RBkmSqL8mIoo0vJdVM92qxjTa0dKHOW3YC0y
         R8Q3KBJaZxl8JC4DAQXUZVEjTpps4CFS90xYHi0sKIYQ5rHgwXjaYDyVFpA3n44qUT7R
         sLDr3FifLrOyTqkYa8Q64rEgr17faUFqlG25OfrQpr6sVaohKeqk9BeniUhq/gv0Z9bq
         PLWQ==
X-Gm-Message-State: AOAM530crK49g4ITubPNHwYTjc0xJCQQGN+X/JMjce0po28LpELdnTbC
        qadPnDieRm7CzoWI1iyY2uY=
X-Google-Smtp-Source: ABdhPJzZisj9V9AWQKEGsi7V4TH8qmYHTGy7cnJvE6VWIkhTFdhsL+jkM29VTrVDh4dkKAw5Y+LHHg==
X-Received: by 2002:a17:90a:f0c2:: with SMTP id fa2mr12038486pjb.7.1631313992381;
        Fri, 10 Sep 2021 15:46:32 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:e240:6ca6:1a1d:d57:193a])
        by smtp.gmail.com with ESMTPSA id 123sm5564081pff.76.2021.09.10.15.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 15:46:31 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH v2] perf tools: Allow build-id with trailing zeros
Date:   Fri, 10 Sep 2021 15:46:30 -0700
Message-Id: <20210910224630.1084877-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current perf saves a build-id with size but old versions assumes the
size of 20.  In case the build-id is less than 20 (like for MD5), it'd
fill the rest with 0s.

I saw a problem when old version of perf record saved a binary in the
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

Acked-by: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dso.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index ee15db2be2f4..9ed9a5676d35 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1349,6 +1349,16 @@ void dso__set_build_id(struct dso *dso, struct build_id *bid)
 
 bool dso__build_id_equal(const struct dso *dso, struct build_id *bid)
 {
+	if (dso->bid.size > bid->size && dso->bid.size == BUILD_ID_SIZE) {
+		/*
+		 * For the backward compatibility, it allows a build-id has
+		 * trailing zeros.
+		 */
+		return !memcmp(dso->bid.data, bid->data, bid->size) &&
+			!memchr_inv(&dso->bid.data[bid->size], 0,
+				    dso->bid.size - bid->size);
+	}
+
 	return dso->bid.size == bid->size &&
 	       memcmp(dso->bid.data, bid->data, dso->bid.size) == 0;
 }
-- 
2.33.0.309.g3052b89438-goog

