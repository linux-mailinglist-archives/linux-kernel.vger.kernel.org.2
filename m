Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29967354AE0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 04:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243366AbhDFCcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 22:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239101AbhDFCcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 22:32:53 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5E3C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 19:32:45 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id g10so6648322plt.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 19:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=MQjkCNA0ARaI3+BBDoCvhZ6gKeUVeHPj810XjZy2HGQ=;
        b=GMc+KqIWnN4Hg00WTSr0Elcj15axXHI8s8YCEvrknTeNA9W1QR7G8MakUmqK60v7Nc
         X7taWapNxFLSlcpP840bo692TzfiLog6Kaxr+u7VW3w5Y7tqdy55DrQnCg1MIc5Kk3W1
         0audgYvAW038bQiv+KkTSz5OYmRT5wmUM+UKzvjiAQL47TogVzHRqXmlOXOldF6KUZm9
         GdhQ6P+77lt5QT/07qnrg1s2D/5MoA8LFJQjTKS3uNGI+zXaoumIYjsPOa/72R+gGnr9
         eolzpQZyTTSKdSTaDsIjBvjDUSJH16o4kzQ+A3LycGe2mDlg6J8isx+r6BITJcnh1+nq
         mk0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=MQjkCNA0ARaI3+BBDoCvhZ6gKeUVeHPj810XjZy2HGQ=;
        b=nEIEk4SMgzP3QLctHrYeh9nXe3VkAWByy5iigQ8fHAHbrUr7mA7X0ESCO/LkQguuqq
         4sxnFJ6w1hbgrV6ec6Ni3+l+Ud783BW4Uv89GWitbmgsg5PdsIU+BzLUIfcTF6/1BWnj
         V4GWX6qGuu1TLPNlK3hhYp/E8aenfFH9oXR2tKaDBkQ7QfGD+tPsRg6FzTjayxdg4S6T
         2LrwpFa4rzFeZEjl1M6X9TUGnoBLWnJyqnAKBt74l7Xyb32c8aGbdLQ57NSsROsBlZYS
         /eVhowlrDlkeOvMED2thMvB/5U/ax8rY6eaD1DyBeeuHcTh5n0TUmJl0kks21W/3f4Bc
         jhJA==
X-Gm-Message-State: AOAM5333sTgLEuDx8G4w2SsrbPFyEyUr551CyOQAlR5jpVDdJEcTK5hu
        hK6AVwDRg9qH5Qmi+NCFx5c=
X-Google-Smtp-Source: ABdhPJzwsszqTalK9OyFF3ZL274qb3dmq1mR3MzKWc3uWXaHhgKsHVHZ5xJJ9Zg7prEqItK8J1wo0Q==
X-Received: by 2002:a17:90a:3905:: with SMTP id y5mr2130349pjb.91.1617676365039;
        Mon, 05 Apr 2021 19:32:45 -0700 (PDT)
Received: from djbComp.hitronhub.home (S0106ac202ecb0523.gv.shawcable.net. [70.67.120.89])
        by smtp.gmail.com with ESMTPSA id e7sm281196pfv.107.2021.04.05.19.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 19:32:44 -0700 (PDT)
From:   Deborah Brouwer <deborahbrouwer3563@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com,
        Deborah Brouwer <deborahbrouwer3563@gmail.com>
Subject: [PATCH 2/4] staging: rtl8712: remove a blank line
Date:   Mon,  5 Apr 2021 19:32:18 -0700
Message-Id: <81801604460c8cad8770cb2e1290e1587bf88075.1617674639.git.deborahbrouwer3563@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1617674639.git.deborahbrouwer3563@gmail.com>
References: <cover.1617674639.git.deborahbrouwer3563@gmail.com>
In-Reply-To: <cover.1617674639.git.deborahbrouwer3563@gmail.com>
References: <cover.1617674639.git.deborahbrouwer3563@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A duplicate blank line is removed so that only a single blank line
separates two functions. Identified by checkpatch.

Signed-off-by: Deborah Brouwer <deborahbrouwer3563@gmail.com>
---
 drivers/staging/rtl8712/rtl8712_xmit.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8712/rtl8712_xmit.c b/drivers/staging/rtl8712/rtl8712_xmit.c
index d8a366338a2b..4be81c2546fe 100644
--- a/drivers/staging/rtl8712/rtl8712_xmit.c
+++ b/drivers/staging/rtl8712/rtl8712_xmit.c
@@ -317,7 +317,6 @@ void r8712_append_mpdu_unit(struct xmit_buf *pxmitbuf,
 			 0x0000ffff)));
 }
 
-
 void r8712_xmitframe_aggr_1st(struct xmit_buf *pxmitbuf,
 			      struct xmit_frame *pxmitframe)
 {
-- 
2.17.1

