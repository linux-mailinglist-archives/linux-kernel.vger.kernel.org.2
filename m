Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2203522B4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 00:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbhDAWQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 18:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbhDAWQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 18:16:28 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F76EC0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 15:16:28 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id lr1-20020a17090b4b81b02900ea0a3f38c1so5362687pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 15:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=YrSMleKSbg2hGfW2GjIs965FPlWSY5ydLUSNL+d/gGc=;
        b=Q6WvExIF3mEG2FTk9zpl0eDPMJoz82Yll3FVTAcJMcDIULymyfPTggVRR94Vb9sD2L
         DyDs6wV1F8HPEwmz6iplTCGJL9GspIjA4buhneeC96oYjHpkuyQf0T8YVEddnyHehs1J
         at4V4Lo2BsMvl+tHFD/KTQLTupYwz3hHbBvV69gng//N6h82iHzJGczyCFjuKhBRdT3L
         SfP3nGWzNaDTTNs+nVH9nDWeelJ5RtrnaiXH7WtC8sQX48j/zeIjzYxFBn0FK8+mfmxO
         HNuKLzQJ+MfEQfjGUoSkT2DnmRrX+mjXLsLx9Eg/Ixi47u2qqc4LHup6Q4v35hI3R1rf
         XoEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=YrSMleKSbg2hGfW2GjIs965FPlWSY5ydLUSNL+d/gGc=;
        b=HI1TEi0AwKUMHUd+V7cg4DYK0NJGJMKDhzQh2yjfYxJ5pyesWsdgrHJVeajdbASTXN
         uhFQktK2JlWLDOikZAb+FGVg5QbfAHhdARoch3+PjQP18+ltywnDl4YDVThCIq+owXe3
         nC98wbbvFA57AAIRseWAmUJVpLNivY5jW9a9iUk6MWkXaqYOmgGHOVpl3UgxzER4QZOS
         gYJRmunNSkedQSgYhgVLjlza6p1QS8YB5LzBxmskq7ywpM71D9LFKLE6WSigR6tPvMzG
         LxEEDqM3FstdVyh+b3ccUiu+1bWImOYn5Gi5S9wMJkgZvyb/8UmtnYQplrDI50HShRaw
         hfCQ==
X-Gm-Message-State: AOAM531MFYAVx/OVeAJblghlQ9cRkeG4AnskMp2pHVwZowxrho3PHpqf
        xZRukgDsWtkV8qq7vQnnWF4=
X-Google-Smtp-Source: ABdhPJyxNG1J4XEWyiZFQG5e9ZWuhvHqYlGg6gJKplzDfsmDOJYi9BDz4JDqtzLaxADh1ybRleJIVg==
X-Received: by 2002:a17:902:8687:b029:e6:5eda:c3a8 with SMTP id g7-20020a1709028687b02900e65edac3a8mr9588989plo.59.1617315387700;
        Thu, 01 Apr 2021 15:16:27 -0700 (PDT)
Received: from djbComp.hitronhub.home (S0106ac202ecb0523.gv.shawcable.net. [70.67.120.89])
        by smtp.gmail.com with ESMTPSA id d13sm6671494pgb.6.2021.04.01.15.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 15:16:27 -0700 (PDT)
From:   Deborah Brouwer <deborahbrouwer3563@gmail.com>
To:     gregkh@linuxfoundation.org, ross.schm.dev@gmail.com,
        marcocesati@gmail.com, fabioaiuto83@gmail.com,
        dan.carpenter@oracle.com, phil@philpotter.co.uk,
        amarjargal16@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com,
        Deborah Brouwer <deborahbrouwer3563@gmail.com>
Subject: [PATCH v3 1/3] staging: rtl8723bs: core: add comma within a comment
Date:   Thu,  1 Apr 2021 15:15:40 -0700
Message-Id: <dc7ba26949bab3eb09dac4e4ebf2b87dd242b566.1617314121.git.deborahbrouwer3563@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1617314121.git.deborahbrouwer3563@gmail.com>
References: <cover.1617314121.git.deborahbrouwer3563@gmail.com>
In-Reply-To: <cover.1617314121.git.deborahbrouwer3563@gmail.com>
References: <cover.1617314121.git.deborahbrouwer3563@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a comma to separate repeated words in a comment. The comma preserves
the meaning of the comment while also stopping the checkpatch warning:
WARNING: Possible repeated word: 'very'.

Signed-off-by: Deborah Brouwer <deborahbrouwer3563@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_xmit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index 2daf5c461a4d..3878caf0b56c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -1700,7 +1700,7 @@ Calling context:
 If we turn on USE_RXTHREAD, then, no need for critical section.
 Otherwise, we must use _enter/_exit critical to protect free_xmit_queue...
 
-Must be very very cautious...
+Must be very, very cautious...
 
 */
 struct xmit_frame *rtw_alloc_xmitframe(struct xmit_priv *pxmitpriv)/* _queue *pfree_xmit_queue) */
-- 
2.17.1

