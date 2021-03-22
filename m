Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB1153446F0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhCVOSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhCVORy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:17:54 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C41CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:17:53 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:250b:f16c:c5e2:505d])
        by laurent.telenet-ops.be with bizsmtp
        id jSHr2400U2HDxaV01SHrGr; Mon, 22 Mar 2021 15:17:51 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lOLNP-009ZA1-0b; Mon, 22 Mar 2021 15:17:51 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lOLNO-004STd-9r; Mon, 22 Mar 2021 15:17:50 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] uapi: map_to_7segment: Remove licence boilerplate
Date:   Mon, 22 Mar 2021 15:17:48 +0100
Message-Id: <20210322141748.1062733-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the license boilerplate (containing an obsolete address), because
we now have the SPDX header.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 include/uapi/linux/map_to_7segment.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/include/uapi/linux/map_to_7segment.h b/include/uapi/linux/map_to_7segment.h
index 8b02088f96e3733e..04c8b55812e74733 100644
--- a/include/uapi/linux/map_to_7segment.h
+++ b/include/uapi/linux/map_to_7segment.h
@@ -1,20 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
 /*
  * Copyright (c) 2005 Henk Vergonet <Henk.Vergonet@gmail.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
 
 #ifndef MAP_TO_7SEGMENT_H
-- 
2.25.1

