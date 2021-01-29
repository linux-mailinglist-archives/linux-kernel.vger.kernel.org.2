Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0683E308418
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 04:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbhA2DGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 22:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbhA2DGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 22:06:38 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452C5C06178A
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 19:05:21 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id m6so5335868pfk.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 19:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zTNb1lTIEVQ6SY+1PM+jItpjx6YB2483ibK9X9oBYPQ=;
        b=z1kwyFNg5hSYRi20ZvZ8wuUsM10FJZoI8McYKRlownqrb/9vwSuD19hHoANIKl9o7S
         NM3r0rFYtS7BoYRIxUKv2hJYefP+6PduFPKe6sNVWE7NJvVoSFSo+oGB5ds50UhCUA9V
         SyK9daFDnwbPsOxmmmogF/izeRWdoG3OgCQ6k0DmEgOaW1qa9ZwCI/06RZVukTBn91KD
         jWkK57VznZPmUOrJGfJnxT8iH5+1O3xSd8qHCSqHOszD3n07tm6upXSk82uB3LtU1IAy
         N+1l7G24LEncO+U+I1O4bg5Gt8C/bhkcHAaGe6YPBKuBSfvXS+AFhnzu9hoyFu2QqGYg
         S+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zTNb1lTIEVQ6SY+1PM+jItpjx6YB2483ibK9X9oBYPQ=;
        b=ps+ZSZAvvaCwqiAUZeem2enqdbWguqDyTqW6msMW8OPErcYyUBLMSv+xWc4Hl2nuWA
         6Zi2T2lT7qFD6ZoUhVPiPV0PNfFEn2i9Wc0Fd5Cb7oyFL/VA14Hr5Khdk77M0hW5q6YM
         u3RdPzbqyspyj8FAwrv2WJCYKpZRpXZNr0EaBEmeKPxB/ea7/vZejDBktA9o3qJE+ZNg
         WAfelh2g0b8BEJWID8SRvsG7G4wsOOa3+9bocEVghEoYmzBCGKpXxc6syB3vWBt96C+P
         29sJRbl6kaPeZbiAQx4zOPFG/mZpzcRiGf5q68I3tS75EUbREyUEwCy+tTdP8xmaV7xH
         j1hg==
X-Gm-Message-State: AOAM531qwp6zoNMWH090NCvjXFC7/A3pjg3YF5sIpNDfcmAkLDuY1xKf
        UknpDQXqiJijjwkTCS7i2SJCeQBwrVoDDg==
X-Google-Smtp-Source: ABdhPJxgU85/WQXQ6xIZh5kol/FeQ53pYxb2sLTuRnfE+yO6MQ1sib5AHGRb02vCaC8rjeUx7mU2rw==
X-Received: by 2002:a63:f404:: with SMTP id g4mr2518687pgi.114.1611889520497;
        Thu, 28 Jan 2021 19:05:20 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id y75sm6854496pfg.119.2021.01.28.19.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 19:05:19 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Brian Starkey <brian.starkey@arm.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Laura Abbott <labbott@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Daniel Mentz <danielmentz@google.com>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 3/5] kselftests: dmabuf-heaps: Softly fail if don't find a vgem device
Date:   Fri, 29 Jan 2021 03:05:12 +0000
Message-Id: <20210129030514.1231773-3-john.stultz@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210129030514.1231773-1-john.stultz@linaro.org>
References: <20210129030514.1231773-1-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While testing against a vgem device is helpful for testing importing
they aren't always configured in, so don't make it a fatal failure.

Cc: Shuah Khan <shuah@kernel.org>
Cc: Brian Starkey <brian.starkey@arm.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Laura Abbott <labbott@kernel.org>
Cc: Hridya Valsaraju <hridya@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Sandeep Patil <sspatil@google.com>
Cc: Daniel Mentz <danielmentz@google.com>
Cc: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 .../testing/selftests/dmabuf-heaps/dmabuf-heap.c  | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
index 46f6759a8acc..8cedd539c7fb 100644
--- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
+++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
@@ -184,15 +184,14 @@ static int test_alloc_and_import(char *heap_name)
 	if (importer_fd < 0) {
 		ret = importer_fd;
 		printf("Failed to open vgem\n");
-		goto out;
-	}
-
-	ret = import_vgem_fd(importer_fd, dmabuf_fd, &handle);
-	if (ret < 0) {
-		printf("Failed to import buffer\n");
-		goto out;
+	} else {
+		ret = import_vgem_fd(importer_fd, dmabuf_fd, &handle);
+		if (ret < 0) {
+			printf("Failed to import buffer\n");
+			goto out;
+		}
+		printf("import passed\n");
 	}
-	printf("import passed\n");
 
 	ret = dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_START);
 	if (ret < 0) {
-- 
2.25.1

