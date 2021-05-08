Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B9A377032
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 08:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbhEHG5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 02:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhEHG47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 02:56:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F23C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 23:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Yf7HGTKnq1NSCWALOotfVXNpRQABXSt3lDNphzs98nE=; b=EuqgwGIuyu8Ju6MZytS5aED6yb
        PoM/9hE1XH8CoApz/20TdtjoMiBAk0Unye+XaC4xmRS+lYnF/H+NU/ZllcnZWFHJSGwUJLVtLZfiD
        3vkduXtSbHR6rHFOjiK9bmL+lCoZ5l5QHaTH+kxe1h7I8jHKfWkx4uutJu+P+/ErvRekyyyBq/bHv
        fHoB88hvKKfmCESLV2guC55Ms7FKC/7BKqqkVQoYzW/OhTp3NnXle7cJ0Qoq9vFCAxUw+Km5s58yZ
        D1QaWpdbv6R/kOO8T4PkZwrUtO7iIE71j12Gpei4T+uRt9bVmV/u2iUz9yWCb5lMRd4YHYF5MP+3u
        a+wLPwHw==;
Received: from [2601:1c0:6280:3f0::7376] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lfGsY-007PSk-CN; Sat, 08 May 2021 06:55:58 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2] platform_data: emif_plat.h: drop a duplicated word
Date:   Fri,  7 May 2021 23:55:57 -0700
Message-Id: <20210508065557.22224-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "if" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Nishanth Menon <nm@ti.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
v2: Drop bad Cc: Aneesh V <aneesh@ti.com>;
    Add Cc: Andrew Morton

 include/linux/platform_data/emif_plat.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20210507.orig/include/linux/platform_data/emif_plat.h
+++ linux-next-20210507/include/linux/platform_data/emif_plat.h
@@ -98,7 +98,7 @@ struct emif_custom_configs {
  *			as type, bus width, density etc
  * @timings:		Timings information from device datasheet passed
  *			as an array of 'struct lpddr2_timings'. Can be NULL
- *			if if default timings are ok
+ *			if default timings are ok
  * @timings_arr_size:	Size of the timings array. Depends on the number
  *			of different frequencies for which timings data
  *			is provided
