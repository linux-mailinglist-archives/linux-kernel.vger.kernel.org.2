Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2823C632D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 21:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236141AbhGLTJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 15:09:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45886 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236056AbhGLTJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 15:09:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626116811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RuvuU3GhSaqw/r7Yuommk/4GGO9Nhx9WohfFfrBNtSM=;
        b=AtoFVQziX1VaHW9pkptl6mLZuTQLyq0ej/pRae3THL2h4npo+3OfW7XegRq6U7FUDKgmZA
        p5AmnO17KqWbSil41GpAb55YFeHypjSTWBdJNrKRNFzFeNR9wW+mcRdLdCHmV2dtibTc3f
        Lw8uIqog6AXs781JdELanbPG+2LaqmY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-gycIbtb7NTq2KdvSZ2VXyw-1; Mon, 12 Jul 2021 15:06:50 -0400
X-MC-Unique: gycIbtb7NTq2KdvSZ2VXyw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 751E9A40C0;
        Mon, 12 Jul 2021 19:06:49 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D8A518B42;
        Mon, 12 Jul 2021 19:06:49 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 16CJ6mnl010769;
        Mon, 12 Jul 2021 15:06:48 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 16CJ6mLW010765;
        Mon, 12 Jul 2021 15:06:48 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 12 Jul 2021 15:06:48 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nico Schottelius <nico-linuxsetlocalversion@schottelius.org>,
        linux-kernel@vger.kernel.org
Subject:  [PATCH v2] scripts/setlocalversion: fix a bug when LOCALVERSION is
 empty
In-Reply-To: <YOyGrUvA4LjydcP3@kroah.com>
Message-ID: <alpine.LRH.2.02.2107121502380.8445@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2107120957300.14207@file01.intranet.prod.int.rdu2.redhat.com> <YOyGrUvA4LjydcP3@kroah.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 12 Jul 2021, Greg Kroah-Hartman wrote:

> On Mon, Jul 12, 2021 at 10:00:59AM -0400, Mikulas Patocka wrote:
> > The patch 042da426f8ebde012be9429ff705232af7ad7469 
> > ("scripts/setlocalversion: simplify the short version part") reduces the 
> > indentation. Unfortunatelly, it also changes behavior in a subtle way - if 
> > the user has empty "LOCALVERSION" variable, the plus sign is appended to 
> > the kernel version. It wasn't appended before.
> > 
> > This patch reverts to the old behavior - we append the plus sign only if
> > the LOCALVERSION variable is not set.
> > 
> > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > Fixes: 042da426f8eb ("scripts/setlocalversion: simplify the short version part")
> > 
> > ---
> >  scripts/setlocalversion |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Index: linux-2.6/scripts/setlocalversion
> > ===================================================================
> > --- linux-2.6.orig/scripts/setlocalversion	2021-07-12 15:29:07.000000000 +0200
> > +++ linux-2.6/scripts/setlocalversion	2021-07-12 15:50:29.000000000 +0200
> > @@ -131,7 +131,7 @@ res="${res}${CONFIG_LOCALVERSION}${LOCAL
> >  if test "$CONFIG_LOCALVERSION_AUTO" = "y"; then
> >  	# full scm version string
> >  	res="$res$(scm_version)"
> > -elif [ -z "${LOCALVERSION}" ]; then
> > +elif [ "${LOCALVERSION+set}" != "set" ]; then
> 
> That's really subtle, can you add a comment here that this handles an
> empty file?
> 
> thanks,
> 
> greg k-h

OK.


From: Mikulas Patocka <mpatocka@redhat.com>

The patch 042da426f8ebde012be9429ff705232af7ad7469
("scripts/setlocalversion: simplify the short version part") reduces
indentation. Unfortunatelly, it also changes behavior in a subtle way - if
the user has empty "LOCALVERSION" variable, the plus sign is appended to
the kernel version. It wasn't appended before.

This patch reverts to the old behavior - we append the plus sign only if
the LOCALVERSION variable is not set.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Fixes: 042da426f8eb ("scripts/setlocalversion: simplify the short version part")

---
 scripts/setlocalversion |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

Index: linux-2.6/scripts/setlocalversion
===================================================================
--- linux-2.6.orig/scripts/setlocalversion	2021-07-12 15:29:07.000000000 +0200
+++ linux-2.6/scripts/setlocalversion	2021-07-12 21:00:59.000000000 +0200
@@ -131,11 +131,14 @@ res="${res}${CONFIG_LOCALVERSION}${LOCAL
 if test "$CONFIG_LOCALVERSION_AUTO" = "y"; then
 	# full scm version string
 	res="$res$(scm_version)"
-elif [ -z "${LOCALVERSION}" ]; then
-	# append a plus sign if the repository is not in a clean
-	# annotated or signed tagged state (as git describe only
-	# looks at signed or annotated tags - git tag -a/-s) and
-	# LOCALVERSION= is not specified
+elif [ "${LOCALVERSION+set}" != "set" ]; then
+	# If the variable LOCALVERSION is not set, append a plus
+	# sign if the repository is not in a clean annotated or
+	# signed tagged state (as git describe only looks at signed
+	# or annotated tags - git tag -a/-s).
+	#
+	# If the variable LOCALVERSION is set (including being set
+	# to an empty string), we don't want to append a plus sign.
 	scm=$(scm_version --short)
 	res="$res${scm:++}"
 fi

