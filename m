Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B24445FC5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 07:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbhKEGlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 02:41:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23003 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231926AbhKEGlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 02:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636094302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=N/AUQFkOsFJVigPWGZIDCDyo7L+hEJ1QXnNVRi8hp7Y=;
        b=NlsZy7Mb8USrIuQamlblWjf/cecba0pBNRiF6B9sYssPGGeiHoYjA8XQq8kk/L5MRwK22i
        XOTVFFjzfWokU8eGPPvbegEhmmG7m9Lq2GlJu1sfxyyJeTVGtCCe/18r9MvzNExp3c+2vL
        JFuL6QWaYcxt0MQCUbz1LxjS01vE19k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-Gd_enjxFMOehRZIZ6fCw5Q-1; Fri, 05 Nov 2021 02:38:18 -0400
X-MC-Unique: Gd_enjxFMOehRZIZ6fCw5Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C69D1006AAF;
        Fri,  5 Nov 2021 06:38:17 +0000 (UTC)
Received: from localhost (ovpn-8-32.pek2.redhat.com [10.72.8.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7ECA81007625;
        Fri,  5 Nov 2021 06:38:07 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/2] kobject: avoid to cleanup kobject after module is unloaded
Date:   Fri,  5 Nov 2021 14:37:08 +0800
Message-Id: <20211105063710.4092936-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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


Ming Lei (2):
  kobject: don't delay to cleanup module kobject
  kobject: wait until kobject is cleaned up before freeing module

 include/linux/kobject.h |  1 +
 lib/kobject.c           | 67 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

-- 
2.31.1

