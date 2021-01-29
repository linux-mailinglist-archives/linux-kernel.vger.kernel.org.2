Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B361630841C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 04:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbhA2DHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 22:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbhA2DGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 22:06:41 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921C8C0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 19:05:24 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id 31so4472544plb.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 19:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wpJLS1/K6quxDCtF6ZEY+ZhZmpb559yflYmJJ80BQbw=;
        b=cZnqhzUWTkKR+GwYZalkxCsk9v9+2TUHpqGdSzHbuzov/fz1EkYstH68r/3oEpBW4B
         j9HutROkJfo28jDndi/gV5EZvIxT/IvLYHbyAhy042zJll0UXIyFaTtdkdfm1pWRZToD
         qJNtH2kDgXuipk6oJauJVzId5wPVjtS8ROisYKCY1doPKQ9nTPjmC/4IvcnlCRc1KC1n
         DRsJbcQ++faIJpPy/nlSw9IvR5qTxi4nXUkmJxV83pOPbfv1Elfk36n3a5eGRn6K7uKN
         hS8uxtEET+0pZuiSShr41z6L8+dxqy/ZVQzp55rFqyS8L8K8IXZDJV1eEsX2o3LQGuP7
         ENuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wpJLS1/K6quxDCtF6ZEY+ZhZmpb559yflYmJJ80BQbw=;
        b=UW/q7DFk/q3Y+8ubbylLpc44gRjj0ffPCANdSx8XirZEZ3mGc8wScX8xho+8Wug+hm
         9kbp2+cGy+hSD83PibQCWHjc5VcdAWdc9W+BdeQjoiryDPMYGkZHVEJu0wMsHJ62pYC3
         NKqqmMndL7dzZl1PRGZPb3dXdtUzXIYGo01Lw17Wz9DTRed8fxUbERFpR6sp6XOnWPrf
         EMxDh1j8+LGOHEuy/thqwoD+HtCtIQKT9ejTA9rZP8SRg1DPkeuMtUaQxfCQgixDhbo/
         DgpQL64B/rg9SNzGPx1/QRpEXUNRb61ONlrdwfQ7oWFFXxLddrGd3DAEQXPoPPFI/eI+
         j9AQ==
X-Gm-Message-State: AOAM533H/u9saDIDUHmusUNRnMUrvrNrQ9EJQ9Aq6O2bSSRG/uYEaB4O
        OIbOLo5GV0YNjS6epKc9IPkzDT8X6UKrTQ==
X-Google-Smtp-Source: ABdhPJy2aymxhZ7yZWwAmLLNyftYCwd61PtfrChhA2K/S/ZWzs+EOTzqXZihvePJ3BjBNSZPTK19KA==
X-Received: by 2002:a17:90a:8e82:: with SMTP id f2mr2405873pjo.234.1611889523668;
        Thu, 28 Jan 2021 19:05:23 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id y75sm6854496pfg.119.2021.01.28.19.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 19:05:22 -0800 (PST)
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
Subject: [PATCH 5/5] kselftests: dmabuf-heaps: Add extra checking that allocated buffers are zeroed
Date:   Fri, 29 Jan 2021 03:05:14 +0000
Message-Id: <20210129030514.1231773-5-john.stultz@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210129030514.1231773-1-john.stultz@linaro.org>
References: <20210129030514.1231773-1-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a check to validate that buffers allocated from the heaps
are properly zeroed before being given to userland.

It is done by allocating a number of buffers, and filling them
with a nonzero pattern, then closing and reallocating more
buffers and checking that they are all properly zeroed.

This is helpful to validate any cached buffers are zeroed
before being given back out.

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
 .../selftests/dmabuf-heaps/dmabuf-heap.c      | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
index d179d81e2355..29af27acd40e 100644
--- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
+++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
@@ -218,6 +218,84 @@ static int test_alloc_and_import(char *heap_name)
 	return ret;
 }
 
+static int test_alloc_zeroed(char *heap_name, size_t size)
+{
+	int heap_fd = -1, dmabuf_fd[32];
+	int i, j, ret;
+	void *p = NULL;
+	char *c;
+
+	printf("  Testing alloced %ldk buffers are zeroed:  ", size / 1024);
+	heap_fd = dmabuf_heap_open(heap_name);
+	if (heap_fd < 0)
+		return -1;
+
+	/* Allocate and fill a bunch of buffers */
+	for (i = 0; i < 32; i++) {
+		ret = dmabuf_heap_alloc(heap_fd, size, 0, &dmabuf_fd[i]);
+		if (ret < 0) {
+			printf("FAIL (Allocation (%i) failed)\n", i);
+			goto out;
+		}
+		/* mmap and fill with simple pattern */
+		p = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, dmabuf_fd[i], 0);
+		if (p == MAP_FAILED) {
+			printf("FAIL (mmap() failed!)\n");
+			ret = -1;
+			goto out;
+		}
+		dmabuf_sync(dmabuf_fd[i], DMA_BUF_SYNC_START);
+		memset(p, 0xff, size);
+		dmabuf_sync(dmabuf_fd[i], DMA_BUF_SYNC_END);
+		munmap(p, size);
+	}
+	/* close them all */
+	for (i = 0; i < 32; i++)
+		close(dmabuf_fd[i]);
+
+	/* Allocate and validate all buffers are zeroed */
+	for (i = 0; i < 32; i++) {
+		ret = dmabuf_heap_alloc(heap_fd, size, 0, &dmabuf_fd[i]);
+		if (ret < 0) {
+			printf("FAIL (Allocation (%i) failed)\n", i);
+			goto out;
+		}
+
+		/* mmap and validate everything is zero */
+		p = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, dmabuf_fd[i], 0);
+		if (p == MAP_FAILED) {
+			printf("FAIL (mmap() failed!)\n");
+			ret = -1;
+			goto out;
+		}
+		dmabuf_sync(dmabuf_fd[i], DMA_BUF_SYNC_START);
+		c = (char *)p;
+		for (j = 0; j < size; j++) {
+			if (c[j] != 0) {
+				printf("FAIL (Allocated buffer not zeroed @ %i)\n", j);
+				break;
+			}
+		}
+		dmabuf_sync(dmabuf_fd[i], DMA_BUF_SYNC_END);
+		munmap(p, size);
+	}
+	/* close them all */
+	for (i = 0; i < 32; i++)
+		close(dmabuf_fd[i]);
+
+	close(heap_fd);
+	printf("OK\n");
+	return 0;
+
+out:
+	while (i > 0) {
+		close(dmabuf_fd[i]);
+		i--;
+	}
+	close(heap_fd);
+	return ret;
+}
+
 /* Test the ioctl version compatibility w/ a smaller structure then expected */
 static int dmabuf_heap_alloc_older(int fd, size_t len, unsigned int flags,
 				   int *dmabuf_fd)
@@ -386,6 +464,14 @@ int main(void)
 		if (ret)
 			break;
 
+		ret = test_alloc_zeroed(dir->d_name, 4 * 1024);
+		if (ret)
+			break;
+
+		ret = test_alloc_zeroed(dir->d_name, ONE_MEG);
+		if (ret)
+			break;
+
 		ret = test_alloc_compat(dir->d_name);
 		if (ret)
 			break;
-- 
2.25.1

