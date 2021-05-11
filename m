Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93FD1379F20
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 07:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhEKF2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 01:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbhEKF2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 01:28:15 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FD5C061761
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 22:26:33 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id n16so10261223plf.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 22:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ePbl2StuMgS3kMOhK/vbMkJmhxQ3BQ9xukEhDTTEmg0=;
        b=MZqW3y4CsBnOhRaswOVhIkQroLtAvqMreUHmyI99x0hDMZ4ylsD5+Tt1xM3bgx30HM
         OZhavu0OEPfVQ7ZkYCG9OcgcFaYewNW8Q07fESDByDYG7XscJeHjnLJdo42fTypkYx3E
         kxPjMxA8B8PnALl21haxcLxBElb/Ls0ERwemlGjB2F77CZ/SphEQrs1WxIjW7d0in8no
         AagxUSSx0cKkxyoqWnODEMfKHa3foR+lQhMCiY3WrRn2WteyKDUywn5zC4QqS3d6qgKo
         nJ+3PFHOfA05gEdOXu0ncI/MZaEsNidzFef5huj8I2gu9UoZUga4PIKsJYz5hTGg9PN+
         Z9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ePbl2StuMgS3kMOhK/vbMkJmhxQ3BQ9xukEhDTTEmg0=;
        b=EE74lQT+qc5VOOCTYdDgSEpPM2xVngo0sl/eLdc5t2weZUfpBFq1tKnIqF/aAaseMM
         Rc/ozkjzVUT6i72x6lLj7lKZv64qMtFXQxHGJauXrTwhHKly4SivHFLOHEeowGujETg+
         4brfmfy9gyj1t5uaMum6m+lar1Cv/4wYcGEu043+IgGfPI+UyPvWXoDbLDzJMmps+MW0
         nZBkDlaw37qm1nS7lkdYE4SMYe9SqULzC6D8xXm/4Ul5AR9nan6wc0z9jsKXaA43Bhr/
         EK7GfpTwywctB/64a5av+DYNbzXi4R21HVaqTec8FWmHK0nXBiV1dXRHgQyLyUehXizt
         1ptQ==
X-Gm-Message-State: AOAM532fCDP1PcdqSR0V5KKPbaSaqBPrxXIUUWWxQWveVtJIzUecqy0L
        IFmP4Il8HQiR2hFtFrGHoyI=
X-Google-Smtp-Source: ABdhPJx8aK2TSrsgp0BBw53roHeqSzu31iBo/BquKPW/bOlvxYQq6d+vNg9WjTDhREj3HbdJDaQo4w==
X-Received: by 2002:a17:90a:c203:: with SMTP id e3mr31012066pjt.168.1620710792997;
        Mon, 10 May 2021 22:26:32 -0700 (PDT)
Received: from wuchi.mioffice.cn ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id e23sm12506423pfd.104.2021.05.10.22.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 22:26:32 -0700 (PDT)
From:   Chi Wu <wuchi.zero@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, tj@kernel.org,
        mszeredi@redhat.com, sedat.dilek@gmail.com, axboe@fb.com,
        jack@suse.cz, hcochran@kernelspring.com,
        Chi Wu <wuchi.zero@gmail.com>
Subject: [PATCH] mm/page-writeback: Update the comment of Dirty position control
Date:   Tue, 11 May 2021 13:26:26 +0800
Message-Id: <20210511052626.19005-1-wuchi.zero@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the value of pos_ratio_polynom() clamp between 0 and
2LL << RATELIMIT_CALC_SHIFT, the global control line should be
consistent with it.

Signed-off-by: Chi Wu <wuchi.zero@gmail.com>
---
 mm/page-writeback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 0062d5c57d41..e9a4f6cf12bb 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -845,7 +845,7 @@ static long long pos_ratio_polynom(unsigned long setpoint,
  *     ^ pos_ratio
  *     |
  *     |            |<===== global dirty control scope ======>|
- * 2.0 .............*
+ * 2.0 * * * * * * *
  *     |            .*
  *     |            . *
  *     |            .   *
-- 
2.17.1

