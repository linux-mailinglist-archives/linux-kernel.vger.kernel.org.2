Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0A6315BFB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbhBJBOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234143AbhBIWYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 17:24:35 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D64C061224
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 14:21:27 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d13so100245plg.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 14:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vGwYMuoA/+ahXke9oYiC70zL9lBda/6UphvWrpObbGM=;
        b=OWbeRvApKIMIa44WG70mylfOqlaC7KAvsBVdljzD+2f9LIhPbOjmjqHFEATxHrb1pZ
         nQGby43Wnvh0V8mkA9X6eezyAsh7RmIJopD7OVX7v7SaycdDuWgS17kjjY9Ehbjz9zuB
         BIr1cNWIxEIHfIcW846FmKyNapslVueGrGpn2JFhbFObAtCsgi6Hmq07i5jeM7/03jll
         0dJ4rA2mEhn+ER1+zkqkiKf7OnS7dGV2a1kiUg0yKV/3HZGoXJ4OhdvFPWBfO4qfV2TG
         Njze0I1eXIrBNdTuOi/BvY14ceumZcmXnMGbbsLfmt/aP6UV3hDAkhNykNJmiQhSFm+z
         /LMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vGwYMuoA/+ahXke9oYiC70zL9lBda/6UphvWrpObbGM=;
        b=QnYEE28i4kSHNlD2//LXdOZsuRwSL5kp+lVxHCGly3h9lisc53s262gR8CYgpe0WcR
         1QIkjrLuQ/kMUnxP53wW5QJEf30gRkeYbcyJ80J5O8nhl/vejdI2dwJUoRMFHywZqs7g
         Re37KfdtWumJv6B41PTpRXgEWzRi5+zJnVyR/0RTt8m801ZzB/ziUdlYI9l2H4bIB14N
         7fAn4wMx8I6j6pfSPlHR5UvzIgXnKd/YwDnXONiNUor7dOENqo8wUSreksZO1U4a0QAD
         otW5TwSKs2ek6XssxdycrtJB2h5MyQMuGgZnYQOaeWGklou2/1ktor+uI7LlMH20m/XN
         Bn8w==
X-Gm-Message-State: AOAM531XU2p1jlVhuQH/5fC1tR7iZA7ZPAUZ7RrE+m/sMboWr3iV/xXJ
        91mx3EvPRDMEUhdO1t9ijd8=
X-Google-Smtp-Source: ABdhPJxGcxpwdhAuvO2qPNGyvitX9m70atthLRVHrS6uXQMbXQQS18Qh8w0o8BfB1lRp9Y8tH/lW4A==
X-Received: by 2002:a17:90a:206:: with SMTP id c6mr69279pjc.50.1612909286476;
        Tue, 09 Feb 2021 14:21:26 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id v9sm58601pju.33.2021.02.09.14.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 14:21:25 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH v5 7/8] cpumask: Mark functions as pure
Date:   Tue,  9 Feb 2021 14:16:52 -0800
Message-Id: <20210209221653.614098-8-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210209221653.614098-1-namit@vmware.com>
References: <20210209221653.614098-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

cpumask_next_and() and cpumask_any_but() are pure, and marking them as
such seems to generate different and presumably better code for
native_flush_tlb_multi().

Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 include/linux/cpumask.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 383684e30f12..e86b7d027cfb 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -235,7 +235,7 @@ static inline unsigned int cpumask_last(const struct cpumask *srcp)
 	return find_last_bit(cpumask_bits(srcp), nr_cpumask_bits);
 }
 
-unsigned int cpumask_next(int n, const struct cpumask *srcp);
+unsigned int __pure cpumask_next(int n, const struct cpumask *srcp);
 
 /**
  * cpumask_next_zero - get the next unset cpu in a cpumask
@@ -252,8 +252,8 @@ static inline unsigned int cpumask_next_zero(int n, const struct cpumask *srcp)
 	return find_next_zero_bit(cpumask_bits(srcp), nr_cpumask_bits, n+1);
 }
 
-int cpumask_next_and(int n, const struct cpumask *, const struct cpumask *);
-int cpumask_any_but(const struct cpumask *mask, unsigned int cpu);
+__pure int cpumask_next_and(int n, const struct cpumask *, const struct cpumask *);
+__pure int cpumask_any_but(const struct cpumask *mask, unsigned int cpu);
 unsigned int cpumask_local_spread(unsigned int i, int node);
 int cpumask_any_and_distribute(const struct cpumask *src1p,
 			       const struct cpumask *src2p);
-- 
2.25.1

