Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8DA33AFD7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 11:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhCOKRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 06:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbhCOKRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 06:17:41 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7131AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 03:17:41 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id x16so5390065wrn.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 03:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YZDFfmirJi4MEZwUppp8ZkBaLUaPEyc7IvttyXwT2Aw=;
        b=CiHycCWBZHtOE33MB73qzfyP/Zo/faqnvfe4IiUYAMAsdOHGzF3XCmvs9dlbGQOBHH
         bOSxjyMtFR0N2RzCr5c9u8y+pLleeRdHr9ddK3iy9Kv0lrT+K4K0zWX3NJOBdTF1YeUv
         HT8DAFIkaA3/5KPI/VJbKsrMr05Gd5KQzF8wuw5h0VpZ5ARRVIz1hXDfG8e2woBx4Hce
         ZeBNeY1xbuDJLVBaOChu1Sx1m34F+GDL0lEi7EZghE3rM7RNqG3ZHGc1rb5EM6XhBbVe
         YEzf/jhEI/nCN7RjQKAlyznsufzRCdk9fpPN4x4LCyHGy2hCwtKb4eYkee7KwdHCyDTg
         uvTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YZDFfmirJi4MEZwUppp8ZkBaLUaPEyc7IvttyXwT2Aw=;
        b=Bb5CH3igrHaS5bXEQFAXrZhVZMEDZmjNk+nIZ98oze2P9wLRdqcVE5UPQQUqnUcDTe
         qCx/txsQm3V8U6BpT9UX8jdF5pF7SsHs5bPl4WlcRR/ajbSc8uwxc73Eaxpxh6tjkRoP
         H9zZu6+V2mFoRs2lGeOPvO+Y0I99BDLNRqhxtTwym/mB7Orpnq62D28Jh0B7dwOXYEXh
         tljdLS/l6aFYIRoCuvrMvjRUOjBrSdSJd48VyJAtSllLqseRZNh6f02n2tWe895qX8Ht
         EVnDNDQjXlnxDSybWyN7d6awx5lA7an37FBFntaQnSE8yjOaYUI22aEplyoFnngQuV17
         GMlw==
X-Gm-Message-State: AOAM532qixxlk6yfpr8E+umWq/Tr6j3TuPOtZqUOSTRwFCv4SSj2Lq0e
        28mq+D8aVw96aYjn6sUaIHk=
X-Google-Smtp-Source: ABdhPJziwhxJzwQFjMpYjGDYwMk8IMtolHP/mXgGwyPVQGG6r6JhfLHiAm0K1mk84wH+HeuDsww4Fg==
X-Received: by 2002:adf:f9d0:: with SMTP id w16mr27330762wrr.336.1615803460171;
        Mon, 15 Mar 2021 03:17:40 -0700 (PDT)
Received: from agape.jhs ([5.171.72.229])
        by smtp.gmail.com with ESMTPSA id u23sm11883680wmn.26.2021.03.15.03.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 03:17:39 -0700 (PDT)
Date:   Mon, 15 Mar 2021 11:17:37 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 15/15] staging: rtl8723bs: remove unused code blocks
 conditioned by never set CONFIG_ODM_ADAPTIVITY
Message-ID: <0b2d79045feb7da232a8ffe73b068c9bd59d0284.1615801722.git.fabioaiuto83@gmail.com>
References: <cover.1615801721.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1615801721.git.fabioaiuto83@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove conditional code blocks checked by unused
CONFIG_ODM_ADAPTIVITY

cleaning required in TODO file:

find and remove code blocks guarded by never set CONFIG_FOO defines

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_dm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c b/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
index dce70fff0fae..4eb487cf70f0 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
@@ -91,9 +91,6 @@ static void Update_ODM_ComInfo_8723b(struct adapter *Adapter)
 		| ODM_MAC_EDCA_TURBO
 		| ODM_RF_TX_PWR_TRACK
 		| ODM_RF_CALIBRATION
-#ifdef CONFIG_ODM_ADAPTIVITY
-		| ODM_BB_ADAPTIVITY
-#endif
 		;
 
 	/*  */
-- 
2.20.1

