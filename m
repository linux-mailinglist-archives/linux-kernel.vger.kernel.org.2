Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9740460DC7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 04:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238156AbhK2Duq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 22:50:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39459 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1376844AbhK2Dso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 22:48:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638157526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kO3W/72Inf3Gt5gcJDo8PttjHn7xDRGhEW+TUWj3Chs=;
        b=AWaflpHjASdaCP6LqQrLizRxnDYy9VXqBRJTSpBDNlyEX2QYkqquEFHle4mX4fUCgb6RHe
        tC0RZlDKeM5MUTQyUc7Z0jY+oxgMzK+RS1yTnhChWu5Hy8gC1BYc5BiFR++HM+U+NXUvZE
        wZerISrTaFjKpVggMePljrE/OCCdFZQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-550-yUgOziIUPdSJNpubYUWZSA-1; Sun, 28 Nov 2021 22:45:21 -0500
X-MC-Unique: yUgOziIUPdSJNpubYUWZSA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CC5C1006AA0;
        Mon, 29 Nov 2021 03:45:20 +0000 (UTC)
Received: from localhost (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5775C60BF1;
        Mon, 29 Nov 2021 03:45:14 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 0/2] kobject: avoid to cleanup kobject after module is unloaded
Date:   Mon, 29 Nov 2021 11:45:07 +0800
Message-Id: <20211129034509.2646872-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The 1st patch improves CONFIG_DEBUG_KOBJECT_RELEASE, so that kobject
cleanup after unloading module can be triggered easily. With this patch,
'modprobe kset-example' can trigger the issue very quickly.

The 2nd patch fixes the issue of cleaning up object after module is
unloaded, since kobj->ktype and related callbacks are often allocated
as module static variable. We need to make sure kobject is really
cleaned up before freeing module. This issue is reported by Petr Mladek.

V2:
	- add comment on 1st patch, suggested by Greg, 1/2
	- fix build failure in case that CONFIG_MODULE is disabled, and add
	comment in kobj_module_callback(), 2/2


Ming Lei (2):
  kobject: don't delay to cleanup module kobject
  kobject: wait until kobject is cleaned up before freeing module

 include/linux/kobject.h |  1 +
 lib/kobject.c           | 82 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)

-- 
2.31.1

