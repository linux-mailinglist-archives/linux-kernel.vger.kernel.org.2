Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C59D37236D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 01:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhECXIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 19:08:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:58150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229879AbhECXHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 19:07:53 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20104613C0;
        Mon,  3 May 2021 23:06:59 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1ldheU-009YBB-5C; Mon, 03 May 2021 19:06:58 -0400
Message-ID: <20210503230658.040275516@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 03 May 2021 19:05:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     "John Warthog9 Hawley" <warthog9@kernel.org>
Subject: [for-next][PATCH 7/7] ktest: Add KTEST section to MAINTAINERS file
References: <20210503230510.845068955@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

As I wanted to add John Hawley as a co-maintainer for ktest, I found that
there never was a KTEST section in the MAINTAINERS file. Add one!

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d92f85ca831d..3539d76232de 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9976,6 +9976,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/leds/backlight/kinetic,ktd253.yaml
 F:	drivers/video/backlight/ktd253-backlight.c
 
+KTEST
+M:	Steven Rostedt <rostedt@goodmis.org>
+M:	John Hawley <warthog9@eaglescrag.net>
+S:	Maintained
+F:	tools/testing/ktest
+
 L3MDEV
 M:	David Ahern <dsahern@kernel.org>
 L:	netdev@vger.kernel.org
-- 
2.30.1


