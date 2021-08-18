Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50CC3F0070
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 11:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbhHRJ3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 05:29:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:25780 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232155AbhHRJ3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 05:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629278913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uBx6waBIZNJVbIvGd2j8SwTPGTcFkECh8iFDNjjSiFA=;
        b=ByiC2DNoI1rxWYgBwdjpuwXEnvyJDB5VFgfbFHZGgWGB0V76FOeDZvV/5U5WiTRLIBnYWG
        3GCv4+XflocZ61KWNBQPpAFbWJPWQYqPzg41uMZN8vlc0R0BYRTqVsLJ2bLxn08PKkXLky
        30GjA5Po8Y2zs1Oq1Cxqv7IkqidpQvw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-EiiLsqoON_O-WHI-h0O7mg-1; Wed, 18 Aug 2021 05:28:31 -0400
X-MC-Unique: EiiLsqoON_O-WHI-h0O7mg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B575518C89DE;
        Wed, 18 Aug 2021 09:28:30 +0000 (UTC)
Received: from localhost (ovpn-8-40.pek2.redhat.com [10.72.8.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 821A76A8E4;
        Wed, 18 Aug 2021 09:28:26 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 1/7] genirq/affinity: remove the 'firstvec' parameter from irq_build_affinity_masks
Date:   Wed, 18 Aug 2021 17:28:06 +0800
Message-Id: <20210818092812.787558-2-ming.lei@redhat.com>
In-Reply-To: <20210818092812.787558-1-ming.lei@redhat.com>
References: <20210818092812.787558-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'firstvec' parameter is always same with the parameter of
'startvec', so use 'startvec' directly inside irq_build_affinity_masks().

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 kernel/irq/affinity.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index f7ff8919dc9b..856ab6d39c05 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -336,10 +336,10 @@ static int __irq_build_affinity_masks(unsigned int startvec,
  *	2) spread other possible CPUs on these vectors
  */
 static int irq_build_affinity_masks(unsigned int startvec, unsigned int numvecs,
-				    unsigned int firstvec,
 				    struct irq_affinity_desc *masks)
 {
 	unsigned int curvec = startvec, nr_present = 0, nr_others = 0;
+	unsigned int firstvec = startvec;
 	cpumask_var_t *node_to_cpumask;
 	cpumask_var_t nmsk, npresmsk;
 	int ret = -ENOMEM;
@@ -462,8 +462,7 @@ irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
 		unsigned int this_vecs = affd->set_size[i];
 		int ret;
 
-		ret = irq_build_affinity_masks(curvec, this_vecs,
-					       curvec, masks);
+		ret = irq_build_affinity_masks(curvec, this_vecs, masks);
 		if (ret) {
 			kfree(masks);
 			return NULL;
-- 
2.31.1

