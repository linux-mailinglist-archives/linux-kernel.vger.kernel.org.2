Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4577D352EE7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 20:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236010AbhDBSD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 14:03:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23514 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235593AbhDBSD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 14:03:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617386634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bAM+9A25NtyyTvbHXHA330irTLzbAV1bvnKUfrqAzaM=;
        b=iwjFko4Sa7R6/MUvmVRRttZFInNqqThNG4o5J6YPkwUElGezgLshoAulNvIneWiVA4y//7
        IW71trvE3BmBdvtAisYIgHGvWP9hrKKJw3qDyfLAo0JLez/QIoIdeNcCFGEPkko/yYdAhQ
        VY5t64jEKZsSbm7unqfKtyWXS4DUtQc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-UF8baMhyOQu9yBuOVvGdRw-1; Fri, 02 Apr 2021 14:03:53 -0400
X-MC-Unique: UF8baMhyOQu9yBuOVvGdRw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05264180FCA2;
        Fri,  2 Apr 2021 18:03:52 +0000 (UTC)
Received: from max.com (unknown [10.40.194.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A555E5D9DC;
        Fri,  2 Apr 2021 18:03:47 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     cluster-devel@redhat.com
Cc:     Andreas Gruenbacher <agruenba@redhat.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: fs/gfs2/rgrp.c:1772:53: warning: Possible null pointer dereference: minext [nullPointer]
Date:   Fri,  2 Apr 2021 20:03:45 +0200
Message-Id: <20210402180345.2296163-1-agruenba@redhat.com>
In-Reply-To: <20210329004759.GH4176174@shao2-debian>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gfs2: Silence possible null pointer dereference warning

In gfs2_rbm_find, rs is always NULL when minext is NULL, so
gfs2_reservation_check_and_update will never be called on a NULL minext.
This isn't immediately obvious though, so also check for a NULL minext
for better code readability.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/rgrp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/rgrp.c b/fs/gfs2/rgrp.c
index 89c37a845e64..2dab313442a7 100644
--- a/fs/gfs2/rgrp.c
+++ b/fs/gfs2/rgrp.c
@@ -1783,7 +1783,7 @@ static int gfs2_rbm_find(struct gfs2_rbm *rbm, u8 state, u32 *minext,
 			goto next_bitmap;
 		}
 		rbm->offset = offset;
-		if (!rs)
+		if (!rs || !minext)
 			return 0;
 
 		ret = gfs2_reservation_check_and_update(rbm, rs, *minext,
-- 
2.27.0

