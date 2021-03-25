Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 236A0348508
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 00:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbhCXXGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 19:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbhCXXFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 19:05:41 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4368AC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 16:05:41 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id u8so338293qtq.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 16:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v9ZgYPAV5pW+3XJfUObq1OKDOd+yO9AzIKh8BGAyxbg=;
        b=KzoKhamrTRrMxphlj7fx+9rr9/duDd3NAJV74WetzwLcxfGF3aWdxrJqDlaEjdcZv8
         OGjEIzp0SQ865SEX0+Pa960oUbKrZhLJS9+WSRLofUM6rCn1r/S23A57nfMMSG5QPxA4
         U28uMnTQ2xZTkb6DXHm6vPi9TGRanq/4ebhS99MxtVGCNVjyWMAIPnkdwte29XDHKVG5
         9gjU1dRChcSTbYXnpVmiSW+2mfVIgVsd6OxyD1BRKGAu8eaWq7HAwnaafzrlFYt7VZmn
         hF/QbXeIx8C8LB4w00jJrnhj3NhbTSGpNLbhUa8dylq7TsE8u5Eq6ylnrNfEtXJKMS3j
         g/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v9ZgYPAV5pW+3XJfUObq1OKDOd+yO9AzIKh8BGAyxbg=;
        b=gSzlAOirXSJo80wsy3PwxDH5WtRds8G9t3FZsg3rqjzD8nngTu//ExRU+HsbUyiD68
         hxcY6sCTTZyKp4F0aFug9LSEmLECN72iy8Ca0T3QxSaPvNJaDC62czDkAzJ/CK726Lh8
         V4+QUvLDkIl7LrIfcO6TpTJ7azRqa2FypQXyGm68OH0dGmSXFt808YLplYrQKEct1uQ5
         mZ8TDBuwVyOqhkKMCB05G4E6ATH5TJkcaB3PgbEPMu0xCLt8k3tfVpo29yIysee2gRCg
         3ebtWfzD6BwHv5ZYodPjdGB7shkEkMbgjqnFJgCg1VDfX699JNc5MV38zxUAGoyenlYr
         sd0A==
X-Gm-Message-State: AOAM530dT63ZgO9KT85nZqk3x5ceg3DzkRJ6FKW6KFD/siNkfcBwrIge
        OG8YLOKiQ7Afb91dmpMrCaE=
X-Google-Smtp-Source: ABdhPJz2BebuSA40Vdzk5htYesmp/PuEjJIxloaJ2qKs7iFRMQWVilb2ccB524lYZyZ9FyJ9LxGEQg==
X-Received: by 2002:ac8:777c:: with SMTP id h28mr5133646qtu.63.1616627140346;
        Wed, 24 Mar 2021 16:05:40 -0700 (PDT)
Received: from Slackware.localdomain ([156.146.55.193])
        by smtp.gmail.com with ESMTPSA id i14sm2469165qtq.81.2021.03.24.16.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 16:05:39 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     sstabellini@kernel.org, linux@armlinux.org.uk,
        xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH V2] ARM: xen/mm.c: A mundane typo fix
Date:   Thu, 25 Mar 2021 10:05:26 +0530
Message-Id: <20210325043526.16289-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/acrros/across/

Plus some words need prural version...so did it.(page->pages)

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Changes from V1:
  Randy's findings incorporated.

 arch/arm/xen/mm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
index 467fa225c3d0..8596dd32dcd5 100644
--- a/arch/arm/xen/mm.c
+++ b/arch/arm/xen/mm.c
@@ -105,8 +105,8 @@ bool xen_arch_need_swiotlb(struct device *dev,
 	 *	- The Linux page refers to foreign memory
 	 *	- The device doesn't support coherent DMA request
 	 *
-	 * The Linux page may be spanned acrros multiple Xen page, although
-	 * it's not possible to have a mix of local and foreign Xen page.
+	 * The Linux page may be spanned across multiple Xen pages, although
+	 * it's not possible to have a mix of local and foreign Xen pages.
 	 * Furthermore, range_straddles_page_boundary is already checking
 	 * if buffer is physically contiguous in the host RAM.
 	 *
--
2.30.1

