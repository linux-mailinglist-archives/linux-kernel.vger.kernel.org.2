Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E71531F876
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 12:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhBSLcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 06:32:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26294 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229498AbhBSLce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 06:32:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613734268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2NEwlUAN0Vl80z1Ra9fWAK6pZJMlSaxmelWpN4bmCH8=;
        b=QDaWcZZ/csv6hyhQi5eYhdgSpMUdNH4belKtEqDJk3ZbXw8bmEyiEueCscg56diQHvPqVF
        slXX77BBGfT82wXKDVjpl91Gz8QtBW+nv5oVmPxORR1gwssVpXtw7jGBh2uCpiAv0OU/2h
        bqRSqgJ6mNeUWNS+GOWQdVVL7p7hZi4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-Ek_tBaZ6MEOmQw38BXkstw-1; Fri, 19 Feb 2021 06:31:06 -0500
X-MC-Unique: Ek_tBaZ6MEOmQw38BXkstw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FA051005501;
        Fri, 19 Feb 2021 11:31:05 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.194.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 22ACE61F55;
        Fri, 19 Feb 2021 11:31:02 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 0/2] x86/apic: Avoid cm->allocated going negative in irq_matrix
Date:   Fri, 19 Feb 2021 12:30:59 +0100
Message-Id: <20210219113101.967508-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I discovered that CPU0 offlining/onlining works only once:

     # echo 0 > /sys/devices/system/cpu/cpu0/online
     # echo 1 > /sys/devices/system/cpu/cpu0/online
     # echo 0 > /sys/devices/system/cpu/cpu0/online
     -bash: echo: write error: No space left on device
    
    with the following in dmesg:
    
     [ ... ] CPU 0 has 4294967295 vectors, 589 available. Cannot disable CPU

And the problem seems to be that irq_matrix_assign()/irq_matrix_free() calls
for PIC_CASCADE_IR are unbalanced, making cm->allocated go negative.

RFC as I didn't quite get why we're making an exception for PIC_CASCADE_IR in
the first place. Surely it is special, but for the sake of consistency we'd
better not treat it as such. Or maybe I just misunderstood everythin.

Vitaly Kuznetsov (2):
  x86/apic: Do not make an exception for PIC_CASCADE_IR when marking
    legacy irqs in irq_matrix
  genirq/matrix: WARN_ON_ONCE() when cm->allocated/m->total_allocated go
    negative

 arch/x86/kernel/apic/vector.c |  3 +--
 kernel/irq/matrix.c           | 11 +++++++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

-- 
2.29.2

