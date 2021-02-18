Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6549331F1C4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 22:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhBRVh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 16:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhBRVhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 16:37:13 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC527C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 13:36:33 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id z15so2221593pfc.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 13:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=2qhkqHLunJIKhU1UVPTSw/3J2vDNCf42RfbxMLTGs9c=;
        b=FM34Gd0TXiHd+m7+qwNzDE+I86tdeUPQXNlV4PKRNOqL29bpnR9WPXSPNqE9En33Cf
         Af8geQa9huwE9T/5BfHu/EtYjwdMFYfZAhsOd8nqGbBrfAopgRb3i0pPo+X54Rslnb5A
         rkbOM3E7FCLoCIeKQON3yprPbNMJbUiv8tk+ZutVSYUK9khqiZFi7jr8pEEssYpi0XE6
         VWL6dqb30scZy9yn/MBNPA5WB+nGCNbfDsdKSoRUEc9fiZMPdtQwSDRZwQx6EfYtTUQN
         G4qYKIlt4sqD/1EEiqpMqItlFYO25PiaKLThlTDV7dq/tr97/1WQ+796ndOY+LrPsFZ3
         aJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=2qhkqHLunJIKhU1UVPTSw/3J2vDNCf42RfbxMLTGs9c=;
        b=Mwhs93KOLbcR6ipN3HVNXUutcmtjn99+P1PeVg1/X3O2R/HzU8E6Eh3ZwPKeRIN6mo
         osCEmYe4wGeW8fyxptWs8E8j3psemSEIGIN7+CvXCsHitycn/vMT8gY2/3LjvoIJ6Gcu
         Mgdf9RHIQB/Ij5M+TQg4E4AeMONH9PLxBq8Fmk3bLNRWhngvZV7Re5Qx5ngbBpae8gZt
         E5jKcb8bSAC+IjQzo2OYtAJ1No4P3PbHKAll5LcjhqLmaXtaBxnLY3/25maJxFTSXG5L
         3LB7G5QZfwrpHHXfZjiEJUoBTIfFc+k7itYvOBupRordpwXNy3QlFTgD3qljjEAESSDj
         udqQ==
X-Gm-Message-State: AOAM531/Cy/8NqOxRjz4PYF3FYl9/86ZYpA/v8SalY9WeC9xb37Xc7fa
        UHKB7qzRRrlcn3PKiH2FP7pdnjBZBGtMpg==
X-Google-Smtp-Source: ABdhPJxYXS1OA31kz2dDYwQsOKZdtdztJ9/ynvUZOVE1XscgkC7zJbSFFHCHV5Bng03dvTmaTAsE1Q==
X-Received: by 2002:a63:eb42:: with SMTP id b2mr5721041pgk.284.1613684192983;
        Thu, 18 Feb 2021 13:36:32 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id d24sm7605869pfn.54.2021.02.18.13.36.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Feb 2021 13:36:32 -0800 (PST)
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] percpu_counter: increase batch count
Message-ID: <0bf90e07-8758-b238-b3f3-a330725a1134@kernel.dk>
Date:   Thu, 18 Feb 2021 14:36:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we cap the batch count at max(32, 2*nr_online_cpus), which these
days is kind of silly as systems have gotten much bigger than in 2009 when
this heuristic was introduced.

Bump it to capping it at 256 instead. This has a noticeable improvement
for certain io_uring workloads, as io_uring tracks per-task inflight count
using percpu counters.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
index 00f666d94486..c3a9af5462ba 100644
--- a/lib/percpu_counter.c
+++ b/lib/percpu_counter.c
@@ -188,7 +188,7 @@ static int compute_batch_value(unsigned int cpu)
 {
 	int nr = num_online_cpus();
 
-	percpu_counter_batch = max(32, nr*2);
+	percpu_counter_batch = max(256, nr*2);
 	return 0;
 }
 

-- 
Jens Axboe

