Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D9C44DC5C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 20:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbhKKUCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 15:02:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47622 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231934AbhKKUCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 15:02:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636660772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qY3lawjxVN/nl1EDplEd0DfJP9OQ/IJzE91IrL/mLH0=;
        b=VvnFQNPRSoR/Z5lo71buYwFxIblq1v7opNBWG69VqKgxrxbqq9LbM4Xnj+oXzhMSHWmryI
        vrDUx8ylbfkTol+cda12WZtFPrecuh2nZ7V6dEXQTAEQhb+0leEUmqtI3fqDjtv89ASagZ
        nIj/xgDDj8Iwt8sVGuY/xnBqmiRc7iw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-VkbQI_ZSOiCkTgh1p5h_5w-1; Thu, 11 Nov 2021 14:59:29 -0500
X-MC-Unique: VkbQI_ZSOiCkTgh1p5h_5w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85FBF81C85D;
        Thu, 11 Nov 2021 19:59:27 +0000 (UTC)
Received: from wcosta.com (ovpn-116-123.gru2.redhat.com [10.97.116.123])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 593021017CF3;
        Thu, 11 Nov 2021 19:59:22 +0000 (UTC)
From:   Wander Lairson Costa <wander@redhat.com>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org (open list)
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH v2 0/1] printk: suppress rcu stall warnings caused by slow
Date:   Thu, 11 Nov 2021 16:59:03 -0300
Message-Id: <20211111195904.618253-1-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ops, I generated the first version of the patch against the wrong
branch, which causes the patch failing to apply upstream.

Sorry about that.

Wander Lairson Costa (1):
  printk: suppress rcu stall warnings caused by slow console devices

 kernel/printk/printk.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

-- 
2.27.0

