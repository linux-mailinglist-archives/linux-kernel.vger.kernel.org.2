Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56FF030AEFE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbhBASTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:19:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51213 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232277AbhBASPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:15:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612203245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=X7MQc2tuG0HbRFW24iceDXKSfp0kzdxTRNDnbwLtsb8=;
        b=eB3lPJOajtgmg/eb2vqbH+SyoXRuCQw9rv3XFMCAmJ9GrFnbKNWnP8STlBunUu85wozEsM
        GgyZZF/RB+bHML9G9aLkKIc/XrW7O2FYePPqJiFNx2hGardnAHqF8CpxOtgdQQ8cvdkDRq
        W5DrpnqvTLtV6714VmXZ3O1D1mx9+Rk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-O0oNX7Z1Ojuj5r5IoIX3Gg-1; Mon, 01 Feb 2021 13:14:00 -0500
X-MC-Unique: O0oNX7Z1Ojuj5r5IoIX3Gg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEBA1107ACE4;
        Mon,  1 Feb 2021 18:13:53 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-24.ams2.redhat.com [10.36.115.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D97DC74AA9;
        Mon,  1 Feb 2021 18:13:48 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 0/2] drivers/base/memory: clarify some memory block properties
Date:   Mon,  1 Feb 2021 19:13:45 +0100
Message-Id: <20210201181347.13262-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's update parts of our documentation for
/sys/devices/system/memory/memoryX/ properties, especially stating which
properties are nowadays legacy interfaces.

v1 -> v2:
- "drivers/base/memory: don't store phys_device in memory blocks"
-> Fix compile warning, also removing start_pfn from init_memory_block()
- Added Acks

David Hildenbrand (2):
  drivers/base/memory: don't store phys_device in memory blocks
  Documentation: sysfs/memory: clarify some memory block device
    properties

 .../ABI/testing/sysfs-devices-memory          | 58 ++++++++++++-------
 .../admin-guide/mm/memory-hotplug.rst         | 20 +++----
 drivers/base/memory.c                         | 25 +++-----
 include/linux/memory.h                        |  3 +-
 4 files changed, 56 insertions(+), 50 deletions(-)

-- 
2.29.2

