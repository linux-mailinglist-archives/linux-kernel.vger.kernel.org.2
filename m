Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05DE93CA4E4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 20:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237163AbhGOSED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 14:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237067AbhGOSEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 14:04:01 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B616DC061762
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 11:01:07 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id u25so10101341ljj.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 11:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2d9p90AIyYXuZyz8N1X+igPtEqtQ6xFMtj7iBan61/4=;
        b=DG7GKyt4XSoEmdsNZbS2IReKQaI3T7Q+Co+VBceo4tACNkMJfUaeYqnuxt3bN1fnXj
         GZohmTB12gTVjMurUepDi5ro5Qu1uQkqXHiScBoCVS8xWKdXNmPdoae4v7aN1/NHiowV
         MJtcwIVJ4dbdleqfXwxAca/OZnHXfp/C5T/OgyikiLs6H1Zr7Jsbo8IxT8msrdozjb+c
         fByH4YGIejRqn7Tb4gXsisqfZUNMxQcqxxisbxt7TbEzdZLYBySk0X6+X3YixXgSSHQE
         Iq69f7+cLBQqJ8yvzByhikPJjkCC01ycMNR5WreQuy3LH4+RK/nwLv0RYh8QXdoP0MX6
         UTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2d9p90AIyYXuZyz8N1X+igPtEqtQ6xFMtj7iBan61/4=;
        b=NtkGS0D0/4eR6QW/vDGxSV08uHxq+6k+hsAR+1aQmFHJJHfgDcNl+aQHN/16qycF4M
         hBE1RkukaWFT6zME+LDoTE3KjP99DJrchE1GgQJjBM4UWcOw/+VmCsLNd+pHVf55pPbe
         hdLaYFgkajAq1YQ0k9PQSsgpSn6m4RPjnfAbtGUlzwPDKJkxXsMAgUpas091o8Ebu+sC
         Dux2yWtr+ULlEgtJ2w9MLTgROEzx/8FOyo1fCw5d/x23Bhpj/g6LhCMadoQMS/ZmBoQA
         FsvnWYX4TXUBoVdcEyC5Jl2bdFneSpZD/UWXTMulW6Vrqi3ukGEuwNdfyEfCneuUBPQu
         g6cg==
X-Gm-Message-State: AOAM532Tuiqf6VwNenVtZBTdzLsKEgMHoYpia8kRqDF9yuJMWpdPIiQe
        zLDEGwaQV2JZvpX9f6vbb24=
X-Google-Smtp-Source: ABdhPJz/T4eD4gvnZIxPn+tGbMZHDPbGOCEpm5Q+cGIfzkZX/+OASMlP53bWa1D5JtfFgWhs6RYlJg==
X-Received: by 2002:a2e:a712:: with SMTP id s18mr5245619lje.161.1626372066140;
        Thu, 15 Jul 2021 11:01:06 -0700 (PDT)
Received: from asus ([37.151.208.206])
        by smtp.gmail.com with ESMTPSA id r3sm497511lfc.280.2021.07.15.11.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 11:01:05 -0700 (PDT)
Date:   Fri, 16 Jul 2021 00:01:03 +0600
From:   Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
To:     akpm@linux-foundation.org
Cc:     tyhicks@linux.microsoft.com, pasha.tatashin@soleen.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mm: KSM: fix data type
Message-ID: <3610f5373bb12ea04e025bafbf8350f75c0dbf4b.1626371112.git.zhansayabagdaulet@gmail.com>
References: <cover.1626371112.git.zhansayabagdaulet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1626371112.git.zhansayabagdaulet@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ksm_stable_node_chains_prune_millisecs is declared as int, but in
stable__node_chains_prune_millisecs_store(), it can store values up to
UINT_MAX. Change the variable type to unsigned int.

Signed-off-by: Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
---
 mm/ksm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 057d0c245bf4..2e4bd7662e52 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -259,7 +259,7 @@ static unsigned long ksm_stable_node_chains;
 static unsigned long ksm_stable_node_dups;
 
 /* Delay in pruning stale stable_node_dups in the stable_node_chains */
-static int ksm_stable_node_chains_prune_millisecs = 2000;
+static unsigned int ksm_stable_node_chains_prune_millisecs = 2000;
 
 /* Maximum number of page slots sharing a stable node */
 static int ksm_max_page_sharing = 256;
@@ -3105,11 +3105,11 @@ stable_node_chains_prune_millisecs_store(struct kobject *kobj,
 					 struct kobj_attribute *attr,
 					 const char *buf, size_t count)
 {
-	unsigned long msecs;
+	unsigned int msecs;
 	int err;
 
-	err = kstrtoul(buf, 10, &msecs);
-	if (err || msecs > UINT_MAX)
+	err = kstrtouint(buf, 10, &msecs);
+	if (err)
 		return -EINVAL;
 
 	ksm_stable_node_chains_prune_millisecs = msecs;
-- 
2.25.1

