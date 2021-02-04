Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAE930FF0B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 22:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhBDVDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 16:03:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32185 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229986AbhBDVDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 16:03:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612472528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+a9GdRMUfDonWZAtbfOgHx0SCR7BF1OQ4ngGFSqHaFE=;
        b=KCN/4qDOzJhbprujQ/5vt57/a96m/Q6EB+s/veWMq8HMfoMBbHbOGagnx8F1IrgPVRowuP
        Zgiydjf/24zbiStpMihwPI43HYNSXVp7cubxZ7DAhoc44SHjU8fHHSefDaC4W+qXmWTieA
        fV/U/aT/w5XhmYgvxCSbQMVa+6tin5U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-7Lmsr3LFPtKBzZk2PUW-zw-1; Thu, 04 Feb 2021 16:02:06 -0500
X-MC-Unique: 7Lmsr3LFPtKBzZk2PUW-zw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F686801971;
        Thu,  4 Feb 2021 21:02:05 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-68.ams2.redhat.com [10.36.112.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9BAB31A26A;
        Thu,  4 Feb 2021 21:02:04 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] genirq: Fix [devm_]irq_alloc_desc returning irq 0
Date:   Thu,  4 Feb 2021 22:02:02 +0100
Message-Id: <20210204210203.105934-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This patch seems to have fallen through the cracks, hence this resend.

Note this fixes an WARN/backtrace at boot with recent kernels on all
Intel Bay Trail and Cherry Trail based devices, as such it would be
good if we can get this merged.

If this is not the right way to fix this, then please let me know.
The WARN can also be avoided with a simple i915 driver patch, but
this seems to be the more correct way to fix this.

Regards,

Hans



Hans de Goede (1):
  genirq: Fix [devm_]irq_alloc_desc returning irq 0

 include/linux/irq.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

