Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D237143F7CE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 09:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbhJ2H1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 03:27:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52871 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229464AbhJ2H1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 03:27:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635492284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=m2M2Xvi4xU573wLggrm/ueEHI68FY/6gBxFejbXAvI8=;
        b=GrZgvI3G1A3jXpaLo+RnXshFag755PlCPwgcluwTq8W8X4dgX0lT8TGowBxhh/txZjkEqN
        Mjt2a73EVPQsuZEYS/mrcXsIH1A14QTy/gHrHenwT2ny+VtTFlhBluu+0Rwhdb+gcS0GXE
        y/tM6LZo1qRnkORYzWAFxB5YqVfVcvU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-iHCuhfqmMkWIhwvGK_Hidg-1; Fri, 29 Oct 2021 03:24:43 -0400
X-MC-Unique: iHCuhfqmMkWIhwvGK_Hidg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37B83362FB;
        Fri, 29 Oct 2021 07:24:42 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-171.pek2.redhat.com [10.72.12.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4F5F43A08;
        Fri, 29 Oct 2021 07:24:35 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, dyoung@redhat.com,
        akpm@linux-foundation.org, Baoquan He <bhe@redhat.com>
Subject: [PATCH 0/3] x86/kexec: fix memory leak of elf header buffer
Date:   Fri, 29 Oct 2021 15:24:21 +0800
Message-Id: <20211029072424.9109-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memory leak is reported by kmemleak detector, has been existing
for very long time. It could casue much memory loss on large machine
with huge memory hotplug which will trigger kdump kernel reloading
many times, with kexec_file_load interface.

And in patch 2, 3, clean up is done to remove unnecessary elf header
buffer freeing and unneeded arch_kexec_kernel_image_load().

Baoquan He (3):
  x86/kexec: fix memory leak of elf header buffer
  x86/kexec: remove incorrect elf header buffer freeing
  kexec_file: clean up arch_kexec_kernel_image_load

 arch/x86/kernel/machine_kexec_64.c | 23 +++++++++--------------
 include/linux/kexec.h              |  1 -
 kernel/kexec_file.c                |  9 ++-------
 3 files changed, 11 insertions(+), 22 deletions(-)

-- 
2.17.2

