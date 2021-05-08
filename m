Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0E8377025
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 08:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhEHGpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 02:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhEHGpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 02:45:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E274AC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 23:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=FKusSNyoh+OEEXZ/+GdDEuHgJf+XToWFKizqQ6dxr6I=; b=qwiLB8zcU1fnQObKPH2oFfogwX
        jCL8cczDVEXVL18DU1skVoSRDMqh7Pvlq3iBRVQh+rcR8vjAGKKvfb0HhU4w1RnFdu/b8nOowQ+he
        v4Pz4o/RFdHRFFcglMXz/9M6EVuHXqPPFD9eNITOPvIXi4MIaoGn02Dpx7N3Jyp9DT5Q5qao14Cu2
        2eK5NhGi5r3iivTLAjwgOW41MEsDqmSa+0uD6RqerV132rnB+Y4+7RcAZSHQ3IrFug1+/b7dZewmT
        LFJ3Ql3BZQjG/dbAUUSp1OgByjgeKN6ghf1gb1AAugWSmhcPxdeYVsiGfY3mIdzkKH3P7s2rdHGsc
        3IkH/5yw==;
Received: from [2601:1c0:6280:3f0::7376] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lfGgy-007PBr-Tb; Sat, 08 May 2021 06:44:01 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2] STM: <linux/stm.h>: drop a duplicated word
Date:   Fri,  7 May 2021 23:43:58 -0700
Message-Id: <20210508064358.20335-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "the" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2: rebase, add more Cc:s

 include/linux/stm.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20210507.orig/include/linux/stm.h
+++ linux-next-20210507/include/linux/stm.h
@@ -57,7 +57,7 @@ struct stm_device;
  *
  * Normally, an STM device will have a range of masters available to software
  * and the rest being statically assigned to various hardware trace sources.
- * The former is defined by the the range [@sw_start..@sw_end] of the device
+ * The former is defined by the range [@sw_start..@sw_end] of the device
  * description. That is, the lowest master that can be allocated to software
  * writers is @sw_start and data from this writer will appear is @sw_start
  * master in the STP stream.
