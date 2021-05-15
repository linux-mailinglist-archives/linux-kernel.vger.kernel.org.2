Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A847D381A65
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 20:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbhEOSJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 14:09:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52070 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230156AbhEOSJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 14:09:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621102105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=aKsk6i3/AcPOA1FDdiM7ybPhYixn/WIVj8Y6N8Em2O4=;
        b=Vp/sM+Sa4hwSpW2evM6nzjPFwtkdqru2EwGGI0Rpno4uS4zqE7GG7Xyz4uX/9SAhZUFZ8y
        tk3WcLwC/gB2/6OsliHe/ZNvKM8SRFWkJrsT3nhAV+eiMoNNUizlXevl6WaXm41OgRalcE
        oShE2HGW4RIKHoE1Dzc41JKx5SMGCf0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-ogmJJ9FuNnmfUq4W3vtsCQ-1; Sat, 15 May 2021 14:08:23 -0400
X-MC-Unique: ogmJJ9FuNnmfUq4W3vtsCQ-1
Received: by mail-qk1-f198.google.com with SMTP id s68-20020a372c470000b0290305f75a7cecso1716994qkh.8
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 11:08:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aKsk6i3/AcPOA1FDdiM7ybPhYixn/WIVj8Y6N8Em2O4=;
        b=NZ/iNbgPicS72WiHkYrX/vW1LUxuPEcr/t9AYvQxUUK8UmDOL2gmIM3RPGR/U/VDs6
         4QcA9kMH/pA7fFXmcyAmaJ8NnrZ4Lyxih6pBMfVUqyxD7dzW/9Z5wGj0ndvF4coaAMwK
         rQAVuPM/5b80VVASFqWirCuLzwdl2fCt3coV+zWqJyVBAu3pd9IYOEwWFAA/aexVHsH8
         ZybTsBCfBnJ3/nggZ1WhJARain2kF5HsqxbWcor6lOULMho7IcM2octBM08VTI435wbq
         u1ZFTYVKZ3ao7Tqibr/M8gEvD8hySkMLdiOZwEX3zHnt2gXL2D9qlGayPLw5oX+3aujS
         w4wg==
X-Gm-Message-State: AOAM533CvU6/hkyG+6/GxXFZbHQr/14i9eQ3/EDjo17IGBKfzYKO9eTf
        nIwLx5n6XDGkdheh7yTcfz659x57zMz1WODeyTyhSLxwN29pWf0hMkCjyk7xZqPE+UamZ+lAYhF
        3PUN7KTrB/sIW3kgWdhdAGWZm
X-Received: by 2002:a05:620a:70c:: with SMTP id 12mr48841205qkc.377.1621102103298;
        Sat, 15 May 2021 11:08:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4CXbqhsIWD582+pI4RG7TvZ8VWHBXUesXUmDk/mAu6AENSbH1WXcDTDji9uFTVYi6/lASfA==
X-Received: by 2002:a05:620a:70c:: with SMTP id 12mr48841197qkc.377.1621102103150;
        Sat, 15 May 2021 11:08:23 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id y13sm7027430qkj.84.2021.05.15.11.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 11:08:22 -0700 (PDT)
From:   trix@redhat.com
To:     dennis@kernel.org, tj@kernel.org, cl@linux.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] percpu: initialize best_upa variable
Date:   Sat, 15 May 2021 11:08:17 -0700
Message-Id: <20210515180817.1751084-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Static analysis reports this problem
percpu.c:2945:6: warning: Assigned value is garbage or undefined
        upa = best_upa;
            ^ ~~~~~~~~
best_upa may not be set, so initialize it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 mm/percpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/percpu.c b/mm/percpu.c
index a257c3efdf18b..6578b706fae81 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -2916,6 +2916,7 @@ static struct pcpu_alloc_info * __init __flatten pcpu_build_alloc_info(
 	 * Related to atom_size, which could be much larger than the unit_size.
 	 */
 	last_allocs = INT_MAX;
+	best_upa = max_upa;
 	for (upa = max_upa; upa; upa--) {
 		int allocs = 0, wasted = 0;
 
-- 
2.26.3

