Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660DB36639A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 04:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234602AbhDUCVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 22:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbhDUCVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 22:21:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8700BC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 19:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=gS+n52ipM6iCBeIdlowvuYL6d9xTOHm/w0qJRKanKD8=; b=k0emODU+ey57xzGDpoBlV91Fam
        GcRnKOgQV7cvp85f9Kx8eOx83J8+x0rb5Znx3mnB7cWHnxJr8X57k4mBEbDlaVEFl9PVNl/jPnLGO
        Hr+iAMR8ycneIMVP3tQrTHOxZHwyOL/aFXe78ZW6EP9YNwmqatatsmupnMQYM0TjoHL2h7DRlfdbG
        TZXn7XxVvTOilOdzzKR68HV9Bp/PHl+dXgFyl4bsuGFDESysGUYWVQ8TFTUAHk1NVacuWT7zce/uU
        4cxOaNJrg332kaGMPMdHQiEMKVzjISOV5xtV837D+9h3Ya62pgrIDhro1b+jXqEwB2Xamu77kvKEd
        hyKdic9w==;
Received: from [2601:1c0:6280:3f0::df68] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lZ2Tu-00Fwmc-T2; Wed, 21 Apr 2021 02:20:52 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Michal Simek <monstr@monstr.eu>
Subject: [PATCH] microblaze: add 'fallthrough' to memcpy/memset/memmove
Date:   Tue, 20 Apr 2021 19:20:41 -0700
Message-Id: <20210421022041.10689-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix "fallthrough" warnings in microblaze memcpy/memset/memmove
library functions.

  CC      arch/microblaze/lib/memcpy.o
../arch/microblaze/lib/memcpy.c: In function 'memcpy':
../arch/microblaze/lib/memcpy.c:70:4: warning: this statement may fall through [-Wimplicit-fallthrough=]
   70 |    --c;
../arch/microblaze/lib/memcpy.c:71:3: note: here
   71 |   case 2:
../arch/microblaze/lib/memcpy.c:73:4: warning: this statement may fall through [-Wimplicit-fallthrough=]
   73 |    --c;
../arch/microblaze/lib/memcpy.c:74:3: note: here
   74 |   case 3:
../arch/microblaze/lib/memcpy.c:178:10: warning: this statement may fall through [-Wimplicit-fallthrough=]
  178 |   *dst++ = *src++;
../arch/microblaze/lib/memcpy.c:179:2: note: here
  179 |  case 2:
../arch/microblaze/lib/memcpy.c:180:10: warning: this statement may fall through [-Wimplicit-fallthrough=]
  180 |   *dst++ = *src++;
../arch/microblaze/lib/memcpy.c:181:2: note: here
  181 |  case 1:
  CC      arch/microblaze/lib/memset.o
../arch/microblaze/lib/memset.c: In function 'memset':
../arch/microblaze/lib/memset.c:71:4: warning: this statement may fall through [-Wimplicit-fallthrough=]
   71 |    --n;
../arch/microblaze/lib/memset.c:72:3: note: here
   72 |   case 2:
../arch/microblaze/lib/memset.c:74:4: warning: this statement may fall through [-Wimplicit-fallthrough=]
   74 |    --n;
../arch/microblaze/lib/memset.c:75:3: note: here
   75 |   case 3:
  CC      arch/microblaze/lib/memmove.o
../arch/microblaze/lib/memmove.c: In function 'memmove':
../arch/microblaze/lib/memmove.c:92:4: warning: this statement may fall through [-Wimplicit-fallthrough=]
   92 |    --c;
../arch/microblaze/lib/memmove.c:93:3: note: here
   93 |   case 2:
../arch/microblaze/lib/memmove.c:95:4: warning: this statement may fall through [-Wimplicit-fallthrough=]
   95 |    --c;
../arch/microblaze/lib/memmove.c:96:3: note: here
   96 |   case 1:
../arch/microblaze/lib/memmove.c:203:10: warning: this statement may fall through [-Wimplicit-fallthrough=]
  203 |   *--dst = *--src;
../arch/microblaze/lib/memmove.c:204:2: note: here
  204 |  case 3:
../arch/microblaze/lib/memmove.c:205:10: warning: this statement may fall through [-Wimplicit-fallthrough=]
  205 |   *--dst = *--src;
../arch/microblaze/lib/memmove.c:206:2: note: here
  206 |  case 2:
../arch/microblaze/lib/memmove.c:207:10: warning: this statement may fall through [-Wimplicit-fallthrough=]
  207 |   *--dst = *--src;
../arch/microblaze/lib/memmove.c:208:2: note: here
  208 |  case 1:


Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Michal Simek <monstr@monstr.eu>
---
 arch/microblaze/lib/memcpy.c  |    4 ++++
 arch/microblaze/lib/memmove.c |    5 +++++
 arch/microblaze/lib/memset.c  |    2 ++
 3 files changed, 11 insertions(+)

--- linux-next-20210420.orig/arch/microblaze/lib/memcpy.c
+++ linux-next-20210420/arch/microblaze/lib/memcpy.c
@@ -68,9 +68,11 @@ void *memcpy(void *v_dst, const void *v_
 		case 1:
 			*dst++ = *src++;
 			--c;
+			fallthrough;
 		case 2:
 			*dst++ = *src++;
 			--c;
+			fallthrough;
 		case 3:
 			*dst++ = *src++;
 			--c;
@@ -176,8 +178,10 @@ void *memcpy(void *v_dst, const void *v_
 	switch (c) {
 	case 3:
 		*dst++ = *src++;
+		fallthrough;
 	case 2:
 		*dst++ = *src++;
+		fallthrough;
 	case 1:
 		*dst++ = *src++;
 	}
--- linux-next-20210420.orig/arch/microblaze/lib/memmove.c
+++ linux-next-20210420/arch/microblaze/lib/memmove.c
@@ -90,9 +90,11 @@ void *memmove(void *v_dst, const void *v
 		case 3:
 			*--dst = *--src;
 			--c;
+			fallthrough;
 		case 2:
 			*--dst = *--src;
 			--c;
+			fallthrough;
 		case 1:
 			*--dst = *--src;
 			--c;
@@ -201,10 +203,13 @@ void *memmove(void *v_dst, const void *v
 	switch (c) {
 	case 4:
 		*--dst = *--src;
+		fallthrough;
 	case 3:
 		*--dst = *--src;
+		fallthrough;
 	case 2:
 		*--dst = *--src;
+		fallthrough;
 	case 1:
 		*--dst = *--src;
 	}
--- linux-next-20210420.orig/arch/microblaze/lib/memset.c
+++ linux-next-20210420/arch/microblaze/lib/memset.c
@@ -69,9 +69,11 @@ void *memset(void *v_src, int c, __kerne
 		case 1:
 			*src++ = c;
 			--n;
+			fallthrough;
 		case 2:
 			*src++ = c;
 			--n;
+			fallthrough;
 		case 3:
 			*src++ = c;
 			--n;
