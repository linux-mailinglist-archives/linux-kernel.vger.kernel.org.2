Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAF141DC91
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 16:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351221AbhI3On3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 10:43:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29634 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351114AbhI3OnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 10:43:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633012902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AaKkIEW3HUO2tgQVS8IhxeXIR+5mDtqE3xTnoz6JfNs=;
        b=TlMHrnn43YHOoGF4w8iJkcW6ypsl7uK5JCT1ZpWD7IKZHTHIDAXyHFOef8ApMdeclEtAO4
        3jcCRIOuMNuoPyTrprrxkGO9jNmhI4/hCfn7nISpC2DD1j3ICurjfh5XfslbTf/cs0Vuhp
        JAS3NDejegccMXQZeU/J59gRKV06Nyc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-ZhWLlpiiPCGBjoyXGp4Nlw-1; Thu, 30 Sep 2021 10:41:40 -0400
X-MC-Unique: ZhWLlpiiPCGBjoyXGp4Nlw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A53D4835DE0;
        Thu, 30 Sep 2021 14:41:38 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F28F95D6D5;
        Thu, 30 Sep 2021 14:41:35 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Rapoport <rppt@kernel.org>, linux-doc@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v1 1/3] memory-hotplug.rst: fix two instances of "movablecore" that should be "movable_node"
Date:   Thu, 30 Sep 2021 16:41:15 +0200
Message-Id: <20210930144117.23641-2-david@redhat.com>
In-Reply-To: <20210930144117.23641-1-david@redhat.com>
References: <20210930144117.23641-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We really want to refer to the "movable_node" kernel command line
parameter here.

Fixes: ac3332c44767 ("memory-hotplug.rst: complete admin-guide overhaul")
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 Documentation/admin-guide/mm/memory-hotplug.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
index 03dfbc925252..27d748cb6ee0 100644
--- a/Documentation/admin-guide/mm/memory-hotplug.rst
+++ b/Documentation/admin-guide/mm/memory-hotplug.rst
@@ -166,7 +166,7 @@ Or alternatively::
 	% echo 1 > /sys/devices/system/memory/memoryXXX/online
 
 The kernel will select the target zone automatically, usually defaulting to
-``ZONE_NORMAL`` unless ``movablecore=1`` has been specified on the kernel
+``ZONE_NORMAL`` unless ``movable_node`` has been specified on the kernel
 command line or if the memory block would intersect the ZONE_MOVABLE already.
 
 One can explicitly request to associate an offline memory block with
@@ -393,7 +393,7 @@ command line parameters are relevant:
 ======================== =======================================================
 ``memhp_default_state``	 configure auto-onlining by essentially setting
                          ``/sys/devices/system/memory/auto_online_blocks``.
-``movablecore``		 configure automatic zone selection of the kernel. When
+``movable_node``	 configure automatic zone selection in the kernel. When
 			 set, the kernel will default to ZONE_MOVABLE, unless
 			 other zones can be kept contiguous.
 ======================== =======================================================
-- 
2.31.1

