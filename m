Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A043C5DE5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 16:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbhGLODz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 10:03:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40623 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234811AbhGLODx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 10:03:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626098464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=rbUFe4MZtJhkhvdX80s23ydAHzYSIX4LvRsp+uuOmOs=;
        b=QTgifnxuUbDlLHZNhQrtSIYlnQ1WeuCLAXxxAZQ7zn/fRutOdzldS3gQnPC0ZJjdHkb4v4
        RzwwRNOg3XyU5yJo3hldrLLYvHHcIruLiBfGIQ4a7fDqwreYTEgSKjf1JLsZJL0OwtJlaQ
        2k6eY0Oy1pa20VWeMJTg0qugg3+6nrk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-cE567sz5NS2xdXWLYOrziQ-1; Mon, 12 Jul 2021 10:01:03 -0400
X-MC-Unique: cE567sz5NS2xdXWLYOrziQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60E379126D;
        Mon, 12 Jul 2021 14:01:01 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7DE485C1D1;
        Mon, 12 Jul 2021 14:01:00 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 16CE0xnY014694;
        Mon, 12 Jul 2021 10:00:59 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 16CE0xt7014691;
        Mon, 12 Jul 2021 10:00:59 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 12 Jul 2021 10:00:59 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nico Schottelius <nico-linuxsetlocalversion@schottelius.org>
cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/setlocalversion: fix a bug when LOCALVERSION is
 empty
Message-ID: <alpine.LRH.2.02.2107120957300.14207@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch 042da426f8ebde012be9429ff705232af7ad7469 
("scripts/setlocalversion: simplify the short version part") reduces the 
indentation. Unfortunatelly, it also changes behavior in a subtle way - if 
the user has empty "LOCALVERSION" variable, the plus sign is appended to 
the kernel version. It wasn't appended before.

This patch reverts to the old behavior - we append the plus sign only if
the LOCALVERSION variable is not set.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Fixes: 042da426f8eb ("scripts/setlocalversion: simplify the short version part")

---
 scripts/setlocalversion |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/scripts/setlocalversion
===================================================================
--- linux-2.6.orig/scripts/setlocalversion	2021-07-12 15:29:07.000000000 +0200
+++ linux-2.6/scripts/setlocalversion	2021-07-12 15:50:29.000000000 +0200
@@ -131,7 +131,7 @@ res="${res}${CONFIG_LOCALVERSION}${LOCAL
 if test "$CONFIG_LOCALVERSION_AUTO" = "y"; then
 	# full scm version string
 	res="$res$(scm_version)"
-elif [ -z "${LOCALVERSION}" ]; then
+elif [ "${LOCALVERSION+set}" != "set" ]; then
 	# append a plus sign if the repository is not in a clean
 	# annotated or signed tagged state (as git describe only
 	# looks at signed or annotated tags - git tag -a/-s) and

