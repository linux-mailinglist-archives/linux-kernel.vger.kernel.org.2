Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2367935D3F7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 01:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344168AbhDLX2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 19:28:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48988 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344148AbhDLX2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 19:28:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618270083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QZNkjWqGUr2c+r+eQNLXlEqdsDvAfajNblW+w0OF4x0=;
        b=Ts25bLuqIc/I4/NdW1TlWn45xZkcKWy4iWldZK+ITyVwHiYa/4K4DmK8uMqrbSyWzR050Y
        kC31n0rS/JXee0KHILkV4kOopV/eeZSX1myXKkvcFrNOW4v46nQ2+5gTZn0POeewTmUyvn
        Bxjx4dOrOUZSFpHRaeJ2q0Wcb/27bC4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-602-2ZbTd758Pp2tqOKRFTjpBg-1; Mon, 12 Apr 2021 19:28:02 -0400
X-MC-Unique: 2ZbTd758Pp2tqOKRFTjpBg-1
Received: by mail-qk1-f198.google.com with SMTP id k188so10065436qkb.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 16:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QZNkjWqGUr2c+r+eQNLXlEqdsDvAfajNblW+w0OF4x0=;
        b=I4UaXQjXh+Wc0Af7dtEfpU8+ATHuzOLhBxybYaQL+q2NhnSuxV9nN3yQFlJxgx/5K2
         D8kQ7e+glf4Y8XsRkYkYyxeS0WGxPtX/0uNU6plfwn4k7WKhJMPu3ciWAhhLxzwTDiGm
         MyxmPSLV5vIXwSgSkCNiaHsor7SBlMB/3v2VMR0iZMguit1aIIhYs1vntvKPWwYZNUeN
         OqQDxPdqVB/u/IVoC5ugxyzp/b7dloTZ9qo3oA7q8yT+ZkXHcZ4zTzsLtz2PbZ1wi8CJ
         ZHyFxR6dZDZ9PXyoEQ2dOHX7EIZbzW2s/0gFK8oRazPa6BWYIVDKDeTIDNDrx+4PFGb0
         yorw==
X-Gm-Message-State: AOAM531OiaMy++DZOkD7t1g7bUUiEr+Pidkrns3AiZN9uT3/D9P5IzIr
        64dgwyKEaYevSJe5y3ysslIR60cMipiQEmYedRBXy8jq16Ar6YFIKA1bdM0Nn1GqFaoLnsE0Jf4
        CNdDHgdH39YapVTslZA6Yo4H1
X-Received: by 2002:a37:9c4b:: with SMTP id f72mr21700373qke.237.1618270081781;
        Mon, 12 Apr 2021 16:28:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfpiRiANOPqvsNsQFND+ji0Hj6p56PD8GmQc4uB6yTcksonIhZ9h9DsI22AiqB9/e/NdWFqA==
X-Received: by 2002:a37:9c4b:: with SMTP id f72mr21700356qke.237.1618270081567;
        Mon, 12 Apr 2021 16:28:01 -0700 (PDT)
Received: from xz-x1.redhat.com (bras-base-toroon474qw-grc-88-174-93-75-154.dsl.bell.ca. [174.93.75.154])
        by smtp.gmail.com with ESMTPSA id y29sm8958925qtm.13.2021.04.12.16.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 16:28:00 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: [PATCH v2 4/5] userfaultfd/selftests: Only dump counts if mode enabled
Date:   Mon, 12 Apr 2021 19:27:52 -0400
Message-Id: <20210412232753.1012412-5-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210412232753.1012412-1-peterx@redhat.com>
References: <20210412232753.1012412-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WP and MINOR modes are conditionally enabled on specific memory types.  This
patch avoids dumping tons of zeros for those cases when the modes are not
supported at all.

Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 30 ++++++++++++++++--------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 387b9360ae64..da2374bda5a3 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -171,16 +171,26 @@ static void uffd_stats_report(struct uffd_stats *stats, int n_cpus)
 		minor_total += stats[i].minor_faults;
 	}
 
-	printf("userfaults: %llu missing (", miss_total);
-	for (i = 0; i < n_cpus; i++)
-		printf("%lu+", stats[i].missing_faults);
-	printf("\b), %llu wp (", wp_total);
-	for (i = 0; i < n_cpus; i++)
-		printf("%lu+", stats[i].wp_faults);
-	printf("\b), %llu minor (", minor_total);
-	for (i = 0; i < n_cpus; i++)
-		printf("%lu+", stats[i].minor_faults);
-	printf("\b)\n");
+	printf("userfaults: ");
+	if (miss_total) {
+		printf("%llu missing (", miss_total);
+		for (i = 0; i < n_cpus; i++)
+			printf("%lu+", stats[i].missing_faults);
+		printf("\b) ");
+	}
+	if (wp_total) {
+		printf("%llu wp (", wp_total);
+		for (i = 0; i < n_cpus; i++)
+			printf("%lu+", stats[i].wp_faults);
+		printf("\b) ");
+	}
+	if (minor_total) {
+		printf("%llu minor (", minor_total);
+		for (i = 0; i < n_cpus; i++)
+			printf("%lu+", stats[i].minor_faults);
+		printf("\b)");
+	}
+	printf("\n");
 }
 
 static int anon_release_pages(char *rel_area)
-- 
2.26.2

