Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7FB53E0584
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 18:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbhHDQMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 12:12:46 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:38768
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234745AbhHDQKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 12:10:24 -0400
Received: from localhost (1.general.khfeng.us.vpn [10.172.68.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 82E543F22C;
        Wed,  4 Aug 2021 16:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628093401;
        bh=REIeqQKAYi+XHYu1sUZLeREYIovG/e0CGwI0rgCdc4c=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=pF4CbUz3/71aUQuQu1g9cO/6mb47o8qfVbazGe0Ol1rNjvn9hd37Ox2m7S87INBlF
         vBBp77X0ND3FRwRYQluvEbUVS9pfLZoKGUSnahaC0LhiiTxrCDm4aGeqK1c16YNuwP
         7MZKyg8wDM1hfeITWr3d9DFKicTnfV3ThpQ2FjGeWMUIJG3AJTZjUQ2YLfGwLBFjkC
         wnGY/LA8qLvurxfKOU5fnIXJlWKg+MBWfhV8YUMWpmE2O5QSpaYUCYwE2AOim6XTjf
         ZTtCHL6ItVUX31+l1xr7rbIKQUsT0Q6s1zymb8IzruKXTVP2rAxyp/E2qoaOR2SMTi
         eWMBzmX2ahTLA==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     joe@perches.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] get_maintainer: Append parenthesis back to trimmed subsystem name
Date:   Thu,  5 Aug 2021 00:09:48 +0800
Message-Id: <20210804160949.592227-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a closing parenthesis gets trimmed, there can be unmatched
parenthesis in the subsystem name. This doesn't play well with
git-send-email:
(cc-cmd) Adding cc: intel-gfx@lists.freedesktop.org (open list:INTEL DRM DRIVERS (excluding Poulsbo, Moorestow...) from: 'scripts/get_maintainer.pl'
Unmatched () '(open list:INTEL DRM DRIVERS (excluding Poulsbo, Moorestow...)' '' at /usr/lib/git-core/git-send-email line 554.
error: unable to extract a valid address from: intel-gfx@lists.freedesktop.org (open list:INTEL DRM DRIVERS (excluding Poulsbo, Moorestow...)

So append parenthesis back if it was trimmed to make git-send-email
work again:
(cc-cmd) Adding cc: intel-gfx@lists.freedesktop.org (open list:INTEL DRM DRIVERS (excluding Poulsbo, Mooresto...)) from: 'scripts/get_maintainer.pl'

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 scripts/get_maintainer.pl | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 2075db0c08b8e..5ebe6dfe250c9 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -1252,9 +1252,10 @@ sub get_subsystem_name {
 
     my $subsystem = $typevalue[$start];
     if ($output_section_maxlen && length($subsystem) > $output_section_maxlen) {
-	$subsystem = substr($subsystem, 0, $output_section_maxlen - 3);
+	my $parenthesis = substr($subsystem, -1) eq ")";
+	$subsystem = substr($subsystem, 0, $output_section_maxlen - ($parenthesis ? 4 : 3));
 	$subsystem =~ s/\s*$//;
-	$subsystem = $subsystem . "...";
+	$subsystem = $subsystem . "..." . ($parenthesis ? ")" : "");
     }
     return $subsystem;
 }
-- 
2.31.1

