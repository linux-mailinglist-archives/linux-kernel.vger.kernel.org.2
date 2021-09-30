Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5020D41DC8E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 16:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351172AbhI3On0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 10:43:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36158 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351935AbhI3OnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 10:43:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633012899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=M683Nfwi+Qwa+QeYmYLqVJwdqSP0cOrdel4JB8DY0Zg=;
        b=WLAnqD3YHRgeTEwm/X7liWBxW7GmQMB/kYJchnwVLNzN3k4HYY+dwV80mKd4s3EXuBhyqL
        agEVDCC6yFFBh0uMXRq1Rf0vLIQHLyW/AB54ZAe+n1p7Hh9dTG/hogbatV8o6vhTbnj4Rd
        c8dKsUCoHuBy7nTLSYGBwYkphXqCAPs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-adjHt0RpPLWLEb7zehUeKg-1; Thu, 30 Sep 2021 10:41:37 -0400
X-MC-Unique: adjHt0RpPLWLEb7zehUeKg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F1585721F;
        Thu, 30 Sep 2021 14:41:35 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 75BF25F4E1;
        Thu, 30 Sep 2021 14:41:18 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Rapoport <rppt@kernel.org>, linux-doc@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v1 0/3] memory-hotplug.rst: document the "auto-movable" online policy
Date:   Thu, 30 Sep 2021 16:41:14 +0200
Message-Id: <20210930144117.23641-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As promised, now that the memory-hotplug.rst overhaul is upstream, proper
documentation for the "auto-movable" online policy, documenting all new
toggles and options. Along, two fixes for the original overhaul.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: linux-doc@vger.kernel.org
Cc: linux-mm@kvack.org

David Hildenbrand (3):
  memory-hotplug.rst: fix two instances of "movablecore" that should be
    "movable_node"
  memory-hotplug.rst: fix wrong /sys/module/memory_hotplug/parameters/
    path
  memory-hotplug.rst: document the "auto-movable" online policy

 .../admin-guide/mm/memory-hotplug.rst         | 130 +++++++++++++++---
 1 file changed, 109 insertions(+), 21 deletions(-)

-- 
2.31.1

