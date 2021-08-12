Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F20623EA23F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 11:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235293AbhHLJnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 05:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbhHLJnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 05:43:13 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B00AC061765
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 02:42:48 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id t66so5872833qkb.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 02:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=S0ZXnIFHzQgz3IvjBo/TWJ1o0KPQXsm3CIOd2F4wB+Y=;
        b=Cx0N1y7jKrUhACTVdnTUv3PYt/cI2h9+YtQ70mHtZFsntTUMzU1L/tIZ7164HQrFaJ
         CAOBEe0IaejcbEWFAE63/s01eTsknGfVu2nWOZ2LdqDDEFF6PTPx4URKMZahvdduwdab
         GS6tKB3fHWKI0138A2sX9/PURM7qtF8RT9Cg48uZft/ZISHWdcaJER0xDHZiQIj+3W9o
         76rd3O50xQdRxhBtxcRCf3eWLhIIe2yos16Ayi/qQ1pV+3NlraqLiyhfeW7sMLH6hyrK
         szy045O7d+bpztfFpfxp469sHgUFpPG/NzOWT2NKyqvgp7T5Aefhpp7FUnARIgQ/lxPa
         6nPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=S0ZXnIFHzQgz3IvjBo/TWJ1o0KPQXsm3CIOd2F4wB+Y=;
        b=I2nCjiw1euHD4isOyL3iL94k/gB7GDxMRWDjYxKPcmzO+4SEFP0R6k1KIa2Gbh2943
         1wJVtmzOQWdS+N0ulPKLVJHYQvXARH33jUl/FA3UHfLZCIKqJ+L4BGNAo9GKTUka1EDS
         lU0qaOkdteEbVRjii/QSwBhESOk7SuFTOiOOMtUXUIjgu9aKHFhN5O2+25VOZc3D1jjC
         QT2ykWGbr1+BvtJLf8Y8y+68Odqkr1/kivfsuPdqNk1ILuj9ESCtWr4mvrFMgMErZBRE
         pLQUFgVfZnzA30Rr3RGKGKJO8UtBeQwQWQgZjjTcZ1+uhWDLMOw+RVsQqm7aBcSm+DnK
         Cmxw==
X-Gm-Message-State: AOAM530tygyaYG98z043f0O4WIYUzbdn19lh7fe4NCZk3ox5G6K0xggg
        ZmtEqQwyZHWM3vvQZketcOQ=
X-Google-Smtp-Source: ABdhPJwKhpKGv8qX7t17ii02a06K8Y0CY3RuBMbfqfcf8P9Oe6GSAQkie/OgPOaRQgHSNHkqmVM7ww==
X-Received: by 2002:a37:e406:: with SMTP id y6mr3628142qkf.248.1628761367642;
        Thu, 12 Aug 2021 02:42:47 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id v19sm835182qta.60.2021.08.12.02.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 02:42:47 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
Cc:     SeongJae Park <sjpark@amazon.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re:
Date:   Thu, 12 Aug 2021 09:42:40 +0000
Message-Id: <20210812094240.4492-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <144813.1628760117@turing-police>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Hello Valdis,

On Thu, 12 Aug 2021 05:21:57 -0400 "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu> wrote:

> In this commit:
> 
> commit fedc37448fb1be5d03e420ca7791d4286893d5ec
> Author: SeongJae Park <sjpark@amazon.de>
> Date:   Tue Aug 10 16:55:51 2021 +1000
> 
>     mm/idle_page_tracking: make PG_idle reusable
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 504336de9a1e..d0b85dc12429 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -739,10 +739,18 @@ config DEFERRED_STRUCT_PAGE_INIT
>           lifetime of the system until these kthreads finish the
>           initialisation.
> 
> +config PAGE_IDLE_FLAG
> +       bool "Add PG_idle and PG_young flags"
> +       help
> +         This feature adds PG_idle and PG_young flags in 'struct page'.  PTE
> +         Accessed bit writers can set the state of the bit in the flags to let
> +         other PTE Accessed bit readers don't disturbed.
> 
> This needs to be converted to proper, or at least comprehensible, English....

Thank you for the comment.

How about below?

--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -743,9 +743,9 @@ config PAGE_IDLE_FLAG
        bool "Add PG_idle and PG_young flags"
        select PAGE_EXTENSION if !64BIT
        help
-         This feature adds PG_idle and PG_young flags in 'struct page'.  PTE
-         Accessed bit writers can set the state of the bit in the flags to let
-         other PTE Accessed bit readers don't disturbed.
+         This feature adds 'PG_idle' and 'PG_young' flags in 'struct page'.
+         PTE Accessed bit writers can save the state of the bit in the flags
+         to let other PTE Accessed bit readers don't get disturbed.


Thanks,
SeongJae Park
