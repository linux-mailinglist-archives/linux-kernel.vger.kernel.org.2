Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B45EE3B26B2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 07:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhFXFWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 01:22:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34021 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230099AbhFXFWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 01:22:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624512021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=BkJEwIJHUaKQHMjsGSaBUEMszb7c3JSh80myCWGyHWY=;
        b=UPzW8GSgl7Abo0GyofT3Nl9/KzAgkzYuOanF0AvUxPLfzq+XqpyHELvsJyr+0wx4HjsJNW
        lDfxtPfxP6ha8ivCTs7SGM3oAUXJU2odwfhabss71fe/j2WB05LUkA69Efjr3ISNdvpQsh
        O+VvHS9damft11tSMaorUhmDaHGBCwo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-qGZhAdPJNi-40Gfv0Q7ZnQ-1; Thu, 24 Jun 2021 01:20:19 -0400
X-MC-Unique: qGZhAdPJNi-40Gfv0Q7ZnQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E7A48042A8;
        Thu, 24 Jun 2021 05:20:18 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-82.pek2.redhat.com [10.72.12.82])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 55E9D19D7C;
        Thu, 24 Jun 2021 05:20:15 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, x86@kernel.org, rientjes@google.com,
        rppt@linux.ibm.com, thomas.lendacky@amd.com, brijesh.singh@amd.com,
        kexec@lists.infradead.org, bhe@redhat.com
Subject: [PATCH 1/2] docs: kernel-parameters: Update to reflect the current default size of atomic pool
Date:   Thu, 24 Jun 2021 13:20:09 +0800
Message-Id: <20210624052010.5676-2-bhe@redhat.com>
In-Reply-To: <20210624052010.5676-1-bhe@redhat.com>
References: <20210624052010.5676-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 1d659236fb43("dma-pool: scale the default DMA coherent pool
size with memory capacity"), the default size of atomic pool has been
changed to take by scaling with system memory capacity. So update the
document in kerenl-parameter.txt accordingly.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index cb89dbdedc46..2c5017db2621 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -623,7 +623,9 @@
 
 	coherent_pool=nn[KMG]	[ARM,KNL]
 			Sets the size of memory pool for coherent, atomic dma
-			allocations, by default set to 256K.
+			allocations. Otherwise the default size will be scaled
+			with memory capacity, while clamped between 128K and
+			1 << (PAGE_SHIFT + MAX_ORDER-1).
 
 	com20020=	[HW,NET] ARCnet - COM20020 chipset
 			Format:
-- 
2.17.2

