Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61AF433D790
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 16:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238061AbhCPPdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 11:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237930AbhCPPcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 11:32:20 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4502AC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 08:32:19 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j7so7660836wrd.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 08:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3FACNdqVOiJ6TOhEvZsriYKv2P8d1qW7vmfrMLc43Lc=;
        b=aaCX+1owgHm8Fhb0JtsQaRDmrIVL//ePtFgWkBG/xYW469IKh1lKCAzB88/E+B0zJt
         KfPnFrjO1mHiLIWHvLp5L40sH/YV/OM1h9R6sbcGS5zwAQ06vo2hI7BgwRb5uvorAInR
         zltXBwfTovADEh9YfCdFU6cj/Vtlwt40CkmAelYZGdZRGKI9gxHE5FzSd4MyPiT7FjKo
         hG+d3LCDV5vqPMmGlo+nzVeRsJJVZYAn+WT1+55ANLo85CUvOhyKA3+ndYCrN0i4mYoF
         uWv5FRjWyIYA6wRg3NiTs2pL3iSJNMCT5yMszprx55Pv74Mesq00V1Rmp3ZkGtTO/lZ7
         mq/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3FACNdqVOiJ6TOhEvZsriYKv2P8d1qW7vmfrMLc43Lc=;
        b=aDrAwsNzOWBRZup3deVjoa8AEgk+laMkmzkBwSMaT+UNPuCpPBD61/Kpkc8kVYaF+m
         QUtX3eJyw9tl77KECg16+07pMB0zkYK6slXZI7WXfTkxBZu4auEV6k8myAU0picfXlTh
         pm+PkMcV9mzwwl4l0bs6NtPjF1wFO8ppw3GKjYEVL5D5T3KI8blgNRBBAHg8zEXHNCiF
         xSOJnn9SBqbttFKwGm40E+bHmtSVoAwhf3Qvv+RRah1ovlXt3UuThVBXOjYO4erQneq6
         ej0eEz13dMZSmDpiAy/W9kA6b1m+lyrvIMCQGusxX7dCZ3EYIVO0moPsgqyJAxBeYi/l
         5hPg==
X-Gm-Message-State: AOAM5325v2JwwJPQA4QJQfXN/gPM2svbYRxV5edFh39/exQyF9rTkvAy
        B8Jz29bYMRNfJvgyyEt3aFA=
X-Google-Smtp-Source: ABdhPJwxIdccz4A4aKfP0SULCNB5vig47Ii1vHbRq2kvbE34Pz/TnNzY6I4BOKb25Y1NmFs7rSy1Xg==
X-Received: by 2002:a5d:424c:: with SMTP id s12mr5651203wrr.161.1615908738101;
        Tue, 16 Mar 2021 08:32:18 -0700 (PDT)
Received: from agape.jhs ([5.171.72.71])
        by smtp.gmail.com with ESMTPSA id s83sm3438688wmf.26.2021.03.16.08.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:32:17 -0700 (PDT)
Date:   Tue, 16 Mar 2021 16:32:15 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/12] staging: rtl8723bs: remove unused code blocks
 conditioned by never set CONFIG_SINGLE_RECV_BUF
Message-ID: <8e86b8adb1dcec67a7d437a362105bb96f370686.1615907632.git.fabioaiuto83@gmail.com>
References: <cover.1615907632.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1615907632.git.fabioaiuto83@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove conditional code blocks checked by unused
CONFIG_SINGLE_RECV_BUF

cleaning required in TODO file:

find and remove code blocks guarded by never set CONFIG_FOO defines

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_recv.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_recv.h b/drivers/staging/rtl8723bs/include/rtw_recv.h
index 0a56c3a66ee8..acd7a7714740 100644
--- a/drivers/staging/rtl8723bs/include/rtw_recv.h
+++ b/drivers/staging/rtl8723bs/include/rtw_recv.h
@@ -7,13 +7,9 @@
 #ifndef _RTW_RECV_H_
 #define _RTW_RECV_H_
 
-	#ifdef CONFIG_SINGLE_RECV_BUF
-		#define NR_RECVBUFF (1)
-	#else
-		#define NR_RECVBUFF (8)
-	#endif /* CONFIG_SINGLE_RECV_BUF */
+#define NR_RECVBUFF (8)
 
-	#define NR_PREALLOC_RECV_SKB (8)
+#define NR_PREALLOC_RECV_SKB (8)
 
 #define NR_RECVFRAME 256
 
-- 
2.20.1

