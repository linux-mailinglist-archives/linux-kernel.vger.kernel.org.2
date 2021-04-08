Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD72F357AE2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 05:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhDHDq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 23:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhDHDq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 23:46:56 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A3CC061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 20:46:45 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id z10so866054qkz.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 20:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ZGuQPhmksKIfK+1ud0oXVetqL+60ICFAvNW99vX4aRU=;
        b=aW2TyGRtgZ7beq74J2HDukPxAmE5s1LDhCI4W3q8veZfqxdSiB0MjkSTgn2l2JexBe
         /2pKsud1AKPslJbKXD5UknvMpFuFcQBXrkyU1nBKM4rLOSh1a+XDO3PK3itJ8LXULS7a
         f+JND0FudJ4SS6ezxsbzTDmW4Qytu6DEmVWX1uMgn94ul5WuIEQ3hKxXRSbNmuOxcJmj
         F5WGdfr5+HS5SEPyeSJ5RiWFcA7a7oorvk/3ib20oqQJG+GW9GBtfFvQ4h0584kENeyK
         FhtrZNEjuSLW+bqVTD5Br0lxg+8IUXE5SUUACHjBhtclEEzfFgVy7r2PGIJpU9EcJWUm
         4QRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ZGuQPhmksKIfK+1ud0oXVetqL+60ICFAvNW99vX4aRU=;
        b=ezWIVmnrpk5uCBto5hcUtYGJBriiOsLDXTGMlv2QBjG4rnKiVgoEV0WLdN1B1CO1Yw
         n3629ikQWyy4kctfy7xN9SmFxWleAg91mgyxeNjanYJ4tbeBK9tYD7QVMQyU53g/oD10
         Yg7nGB7amq/QltBQ6DrBLzG87KIxovsXVyizhvMRVrxRKnJ571V5WjM4g+oQNHuQ6UYI
         oVGnSTizCQID6gkmWlL9HxMb/bIZpRei0FxckgP/oTrgYXVkfJj5uTtBTViMykKS0BlM
         d9Eme9inPsafw/FHZCydIkXwPoaaA3f/dDHPQmGeUeO3fP4DhQpp2WSdmqVh05ystRyK
         tyfA==
X-Gm-Message-State: AOAM532xqWTACVib6M/cXSWGJTSrI2cyqR3FlAOgylwuSxx91WnjWwi5
        GIlNKYHVraP86nERARK/NySFF44UvOg=
X-Google-Smtp-Source: ABdhPJw9/WGuIWsM/qP5uwjuqsln5iXGyi7bGjOG9UKOEsmn0Gl5oa15A4snJpR+1QimKpMPl76MVw==
X-Received: by 2002:ae9:eb58:: with SMTP id b85mr6531317qkg.168.1617853605235;
        Wed, 07 Apr 2021 20:46:45 -0700 (PDT)
Received: from monty ([192.141.93.162])
        by smtp.gmail.com with ESMTPSA id l14sm17361234qtp.4.2021.04.07.20.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 20:46:45 -0700 (PDT)
Date:   Thu, 8 Apr 2021 00:46:32 -0300
From:   Gonzalo Matias Juarez Tello <gmjuareztello@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCHv2] mm/mmap.c: lines in __do_munmap repeat logic of inlined
 find_vma_intersection
Message-ID: <20210408034632.r5nor5akqo5o3aus@monty>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some lines in __do_munmap used the same logic as find_vma_intersection
(which is inlined) instead of directly using that function.

(Can't believe I made a typo in the first one, compiled this one,
sorry first patch kinda nervous for some reason)

Signed-off-by: Gonzalo Matias Juarez Tello <gmjuareztello@gmail.com>
---
 mm/mmap.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 3f287599a7a3..1b29f8bf8344 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2823,15 +2823,10 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	arch_unmap(mm, start, end);
 
 	/* Find the first overlapping VMA */
-	vma = find_vma(mm, start);
+	vma = find_vma_intersection(mm, start, end);
 	if (!vma)
 		return 0;
 	prev = vma->vm_prev;
-	/* we have  start < vma->vm_end  */
-
-	/* if it doesn't overlap, we have nothing.. */
-	if (vma->vm_start >= end)
-		return 0;
 
 	/*
 	 * If we need to split any vma, do it now to save pain later.
-- 
2.31.1

