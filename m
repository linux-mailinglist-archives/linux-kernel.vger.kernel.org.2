Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327DD34A364
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 09:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbhCZIuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 04:50:04 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:42066 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229551AbhCZItt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 04:49:49 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UTMkWms_1616748586;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UTMkWms_1616748586)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 26 Mar 2021 16:49:47 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     corbet@lwn.net
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Leon Romanovsky <leon@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Alexander Lobakin <alobakin@pm.me>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mailmap: update email address for Alex Shi
Date:   Fri, 26 Mar 2021 16:49:30 +0800
Message-Id: <1616748571-52058-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add my kernel.org address for old email address.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org> 
Cc: Jonathan Corbet <corbet@lwn.net> 
Cc: Kees Cook <keescook@chromium.org> 
Cc: Leon Romanovsky <leon@kernel.org> 
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de> 
Cc: Alexander Lobakin <alobakin@pm.me> 
Cc: linux-kernel@vger.kernel.org 
---
 .mailmap | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index 85b93cdefc87..608ce1e5bef7 100644
--- a/.mailmap
+++ b/.mailmap
@@ -25,8 +25,9 @@ Alexandre Belloni <alexandre.belloni@bootlin.com> <alexandre.belloni@free-electr
 Alexei Starovoitov <ast@kernel.org> <alexei.starovoitov@gmail.com>
 Alexei Starovoitov <ast@kernel.org> <ast@fb.com>
 Alexei Starovoitov <ast@kernel.org> <ast@plumgrid.com>
-Alex Shi <alex.shi@linux.alibaba.com> <alex.shi@intel.com>
-Alex Shi <alex.shi@linux.alibaba.com> <alex.shi@linaro.org>
+Alex Shi <alexs@kernel.org> <alex.shi@intel.com>
+Alex Shi <alexs@kernel.org> <alex.shi@linaro.org>
+Alex Shi <alexs@kernel.org> <alex.shi@linux.alibaba.com>
 Al Viro <viro@ftp.linux.org.uk>
 Al Viro <viro@zenIV.linux.org.uk>
 Andi Kleen <ak@linux.intel.com> <ak@suse.de>
-- 
2.29.GIT

