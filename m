Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14479349B9E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 22:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbhCYV1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 17:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbhCYV1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 17:27:18 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFFDC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 14:27:17 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id k4so4470630qvf.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 14:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MmWYjpGPDbYB5acELUWsO4encrHeC3JnTDUeENwiFbQ=;
        b=aRFmqGGVBIIha6D3s4IqBdbLQwRZ3iwj2MshJzhp5updTFlT3a7YfSgXP9YhP+KOM9
         9IIb5Qq8xF9Aa1spaprur4lJzLKTifN7BDLkHrjxHbTnHTQjqvUGjE/2HVnQ8H+pAypO
         Mr1yHJr3daM8vJr4sYbI/LTSLNxlW1iMe1xZ8bRDLaLf0suSnCv5etzbLhF6tOoM7qG0
         AyWUOWMJGSiscCOWPkjtJ3RfoWCwMXvzDeoypzQIFT4QI0I6BYU4BtZ84vQot6P51z7e
         PiWQhYOb49pXdgZddaYTGEbH7fOn4vKXPqup23Jhi/Be4/+pB70SQw1DkB7U2RZm9OW2
         JiAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MmWYjpGPDbYB5acELUWsO4encrHeC3JnTDUeENwiFbQ=;
        b=jE2tjBLfRbde1AF7MAj+g83rtRjNaf+jpotNEKnS8EeHQIhVEUZVHPLpE3h8Eg2bdB
         bLLgFuSjNOLSOElyxsyibauf7NUoorfa5x6gF08TjvlRhVzsHMguAyV4nwkGojVADxzK
         TBWE7VNpwG+ojt5Q1SX0f4Ijo9YM2w3oIC8OE2+ZE9YMC+jSPFvcHepgZMEFCBSvavtg
         w8S0NlILPfgt3hoT5F52dEQJeRojKBINrVxUqefaBrN+PJqbI70MDCKps1Wq8v7LFPWN
         uNO9e5pzCbbgtyZj/qUoyDGGb2X85DtHw1KnfFtp7OvWfGd4OqPVFQgymwqMycEOy7NJ
         VZJA==
X-Gm-Message-State: AOAM5312YFbsO77HjjTsdjYXy5/amJ/F9NUxCEjpSBqAaQeRTrhr8RgJ
        KOzKo2nZCU8LS8+8EwzIK4Kn9hHdGeQ=
X-Google-Smtp-Source: ABdhPJzb2JV84UZuCYFVQuOhDyKectwGgdGBzSsFi5sLWkxE7uSRixfPRc9GTz+M38Mip7Yj8KVLFO4Io0U=
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a0c:ea83:: with SMTP id d3mr2604367qvp.62.1616707637222;
 Thu, 25 Mar 2021 14:27:17 -0700 (PDT)
Date:   Thu, 25 Mar 2021 21:26:06 +0000
In-Reply-To: <20210325212609.492188-1-satyat@google.com>
Message-Id: <20210325212609.492188-6-satyat@google.com>
Mime-Version: 1.0
References: <20210325212609.492188-1-satyat@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v2 5/8] block: respect bio_required_sector_alignment() in blk-crypto-fallback
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make blk_crypto_split_bio_if_needed() respect
bio_required_sector_alignment() when calling bio_split().

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/blk-crypto-fallback.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index c322176a1e09..85c813ef670b 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/random.h>
 
+#include "blk.h"
 #include "blk-crypto-internal.h"
 
 static unsigned int num_prealloc_bounce_pg = 32;
@@ -225,6 +226,8 @@ static bool blk_crypto_split_bio_if_needed(struct bio **bio_ptr)
 	if (num_sectors < bio_sectors(bio)) {
 		struct bio *split_bio;
 
+		num_sectors = round_down(num_sectors,
+					 bio_required_sector_alignment(bio));
 		split_bio = bio_split(bio, num_sectors, GFP_NOIO,
 				      &crypto_bio_split);
 		if (!split_bio) {
-- 
2.31.0.291.g576ba9dcdaf-goog

