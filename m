Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F2235B390
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 13:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbhDKLfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 07:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235470AbhDKLfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 07:35:31 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DA9C061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 04:35:14 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id t140so7188384pgb.13
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 04:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0tmRORdRg1bQn0Wbj1SOLr37bS4BZCkXUnlrXGSpfdA=;
        b=It9maA02mKRyRB3V6Xt5Cx7F3mTkEAHeFgbIzbGtukC1k2tqI3eeA46zLvAvo+zGvz
         BP6HG7vvnByFBQxEnndmLwlQGZ2RoejCotoKmUN1cxwd7r7HzvhyaZwhkH0dDrnIgSM4
         dT1t66yBn+V77DFJuwI0itSIMyliR4OcO1DEi+AElXZ/tz/Boo+bITLwdrIAMDF+wMUV
         7kFNUKROT3jv66dNwAfNVB1rR1BK2Ad9iaXPmOAV0BnY4CFYONl569jqe9layby2bvF3
         4W98wl++KN1Bk+J2CZ5Vfe4ECK1egcGOJcdFiaQJdlaTSY5HkOLiml+RBnrYMknwOY11
         kkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0tmRORdRg1bQn0Wbj1SOLr37bS4BZCkXUnlrXGSpfdA=;
        b=H+Pyjb/bRMkjrhlsQmrAXlVLqtrFFOSTAvlXsTseVIzgRLZZ/E4De4mDbaaPpDk9fK
         2vy+MywhfN5SyCtMjXXZv35qXfmIh8dMp95Ewzos/KJT5p6EoWyoPgqzdklkPW97kdWF
         Pd6mYWufIlpbbnFnpu3KeyfdV18oNOHIIwjf2l5PwQURF/jaBSGrfDiIXt4GtJlzNHyg
         iCMzZHUNx7XYE0USsWpHm8uwHJoGF5Ca4/v3KDBg3cdFtM4pwz7LsOtswGNJ7VlmcO7P
         JbK6GOaLCEmamYeVTlszRy4EBOWeDflT+CZssmJiCAhcHgQdYAUELpeg72Dhk93/zgsE
         47PA==
X-Gm-Message-State: AOAM53080LYnc9yqL2DS3a1RHySGGqHHZe8fA6bYZi+/gmD81bq/dURo
        Z7P/LfMu5C7RZL0fIYASxh/Tioatuxmycw==
X-Google-Smtp-Source: ABdhPJzCvmIEkORfDhkjcip6rh8A4fDhbaCm2EkDgNMbDevTD0kPaHzdHqBZNBADarZrgAFL5u87Cg==
X-Received: by 2002:a63:c157:: with SMTP id p23mr15357130pgi.162.1618140914445;
        Sun, 11 Apr 2021 04:35:14 -0700 (PDT)
Received: from kali ([103.141.87.254])
        by smtp.gmail.com with ESMTPSA id mu6sm7450956pjb.35.2021.04.11.04.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 04:35:14 -0700 (PDT)
Date:   Sun, 11 Apr 2021 17:05:05 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH v4 1/3] staging: rtl8192e: remove parentheses around boolean
 experssion
Message-ID: <596aa7e6d4e8ce80eaa98519001e17cf9d370f45.1618139271.git.mitaliborkar810@gmail.com>
References: <cover.1618139271.git.mitaliborkar810@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1618139271.git.mitaliborkar810@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed unnecessary parentheses around '!xyz' boolean expression as '!'
has higher precedance than '||'

Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
---

Changes from v3:- Modified log message. 
Changes from v2:- Modified subject description.
Changes from v1:- Removed unnecessary parentheses around boolean expression.
Changes has been made in v2.

 drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index b1fa8e9a4f28..431202927036 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -276,7 +276,7 @@ void HTConstructCapabilityElement(struct rtllib_device *ieee, u8 *posHTCap,
 	struct rt_hi_throughput *pHT = ieee->pHTInfo;
 	struct ht_capab_ele *pCapELE = NULL;
 
-	if ((!posHTCap) || (!pHT)) {
+	if (!posHTCap || !pHT) {
 		netdev_warn(ieee->dev,
 			    "%s(): posHTCap and pHTInfo are null\n", __func__);
 		return;
-- 
2.30.2

