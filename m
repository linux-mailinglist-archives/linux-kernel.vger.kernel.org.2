Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCF930A5D2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 11:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbhBAKxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 05:53:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50732 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232290AbhBAKxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 05:53:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612176726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3kssricYqENvfomRcqUhOpF8NVQYzEw5vGlx2zOIEGk=;
        b=TVGYlGe2tgkEmmoe2obA+eN+lrMsvQTlqZhSuEEx4GCLeMwYWv+ZL8VIPnpAn7TM0uSPNB
        DKGFrLurPRUC+jru0TGpvkd109ANZ6RQ7pKKyfUmCGiwkYUdCiIi02OkyYmKSfU86/dRo5
        hmNZmCTPz4xEqmWxz+eE7NleG49XpcY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-e9NPSzNIMjyM3IFWglGT7A-1; Mon, 01 Feb 2021 05:52:04 -0500
X-MC-Unique: e9NPSzNIMjyM3IFWglGT7A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A27D91221;
        Mon,  1 Feb 2021 10:52:03 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-24.ams2.redhat.com [10.36.115.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA55D1A8A6;
        Mon,  1 Feb 2021 10:51:59 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 0/2] drivers/base/memory: clarify some memory block properties
Date:   Mon,  1 Feb 2021 11:51:56 +0100
Message-Id: <20210201105158.6393-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's update parts of our documentation for
/sys/devices/system/memory/memoryX/ properties, especially stating which
properties are nowadays legacy interfaces.

David Hildenbrand (2):
  drivers/base/memory: don't store phys_device in memory blocks
  Documentation: sysfs/memory: clarify some memory block device
    properties

 .../ABI/testing/sysfs-devices-memory          | 58 ++++++++++++-------
 .../admin-guide/mm/memory-hotplug.rst         | 20 +++----
 drivers/base/memory.c                         | 23 +++-----
 include/linux/memory.h                        |  3 +-
 4 files changed, 56 insertions(+), 48 deletions(-)

-- 
2.29.2

