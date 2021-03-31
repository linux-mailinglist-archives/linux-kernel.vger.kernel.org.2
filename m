Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823073507C8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 22:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236405AbhCaUGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 16:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236348AbhCaUGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 16:06:31 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030E1C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 13:06:31 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id gb6so10117321pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 13:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ys5Gh541Ca1Dy5AHML2SDPDdvxPboGDXHtvxkAdx0CY=;
        b=h62FU0J+qTb2wc2qPCi0mkO2oQ++3iRTgKjWRo/cHbSz2uNh7WugNdr71JNhINeH/9
         xCwID1Cd2/qnn1Lz7fJ0dxebb6xrZVaiLO2jm+xFZMy1uuVqDb/AIFSLallUIM3MB8mq
         oqJSBXgI1+RJvGM2U3d1TV8F8BbnV7P2sq+Hh/ylTV+bNPE44kkC6Uml6+YC9xF9Rxi7
         8BVbYj61hmtF1Z3EHdG4ppZs7RoDvuPuUcpysnpHLxDRD6I7zj7neuxd3SzxzkU/hx8m
         I0uZuUr3lVh7AnvKM5Hfc0t5YgTYa2IQO6yDzuUyF4FwNGQE/0AfC566ZCtWwwE3/uVg
         nWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ys5Gh541Ca1Dy5AHML2SDPDdvxPboGDXHtvxkAdx0CY=;
        b=EJRVgCsLPc29GFXCncqF9kLRmGGNrfcc/FeZwIpUb/qvmwJoTNf62NtcSGVRHf7mDn
         jNCXlk/lzKmah07Ayvni3G1z6fM9DIuS3eEIhds9u0FU8Lo4Wq/r1ZOwPaIOJpFt74Rj
         PMnd7zauNnmBrCZw9S34DWPwFVKRp2bvdSCspEl3CAJkjfPOPjH1gMeo/PQGQ6v4f3xJ
         8C3avQo+wJRLfz4LN93a0WAXNN5Pmx2a2XNg7HbriNCHBRv+Fu6mhMeFDeMo81c3TUZb
         WSxlhiuSUxF7odrM7gqGFJSi9gFSISJNYc9qficrv7Nf8ddxcUs8plR6wYFsBvgYsxDF
         PpVg==
X-Gm-Message-State: AOAM531BSFsPhvVGGwOiCjInrNhVjmUKaVoMwpkByn4f8g8cW2v+EuSo
        ZQ7mDUg2cpqeZdeSJPvX+Ww=
X-Google-Smtp-Source: ABdhPJyssv0lbv3cXtVlbWOKemcnIqgFXt+xZCEVGw40+9WDm7J6uVpYy7AfoA3Y4PQYEidMhsCKEg==
X-Received: by 2002:a17:902:dacb:b029:e5:b538:9ce6 with SMTP id q11-20020a170902dacbb02900e5b5389ce6mr4636548plx.8.1617221190547;
        Wed, 31 Mar 2021 13:06:30 -0700 (PDT)
Received: from djbComp.hitronhub.home (S0106ac202ecb0523.gv.shawcable.net. [70.67.120.89])
        by smtp.gmail.com with ESMTPSA id d22sm2985668pjx.24.2021.03.31.13.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 13:06:30 -0700 (PDT)
From:   Deborah Brouwer <deborahbrouwer3563@gmail.com>
To:     gregkh@linuxfoundation.org, ross.schm.dev@gmail.com,
        marcocesati@gmail.com, fabioaiuto83@gmail.com,
        dan.carpenter@oracle.com, phil@philpotter.co.uk,
        amarjargal16@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com,
        Deborah Brouwer <deborahbrouwer3563@gmail.com>
Subject: [PATCH 1/3] staging: rtl8723bs: core: fix repeated word warning
Date:   Wed, 31 Mar 2021 13:05:35 -0700
Message-Id: <14c1a1f1f0a34fb821d47ddab6e7e63800ec2736.1617221075.git.deborahbrouwer3563@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1617221075.git.deborahbrouwer3563@gmail.com>
References: <cover.1617221075.git.deborahbrouwer3563@gmail.com>
In-Reply-To: <cover.1617221075.git.deborahbrouwer3563@gmail.com>
References: <cover.1617221075.git.deborahbrouwer3563@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch warning:
WARNING: Possible repeated word: 'very'

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

