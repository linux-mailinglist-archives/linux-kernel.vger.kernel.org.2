Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCE0308D1E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 20:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbhA2TKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 14:10:09 -0500
Received: from smtprelay0200.hostedemail.com ([216.40.44.200]:38878 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232829AbhA2TIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 14:08:49 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 27AF5837F24D;
        Fri, 29 Jan 2021 19:08:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:800:960:973:988:989:1260:1261:1277:1311:1313:1314:1345:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3865:3867:4321:4605:5007:7652:7903:10004:10400:10848:11026:11473:11658:11914:12296:12297:12555:12760:13069:13311:13357:13439:14181:14394:14659:14721:21080:21451:21627:21990:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: linen85_3a17db6275aa
X-Filterd-Recvd-Size: 1726
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Fri, 29 Jan 2021 19:08:02 +0000 (UTC)
Message-ID: <13b1c892d52c27d4caeccc89506aadda74f61365.camel@perches.com>
Subject: [PATCH] misc: pvpanic: sysfs_emit uses should have a newline
From:   Joe Perches <joe@perches.com>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 29 Jan 2021 11:08:01 -0800
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add newline terminations to the sysfs_emit uses added by -next
commit 8d6da6575ffe ("misc: pvpanic: introduce events device attribue")

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/misc/pvpanic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
index b1e4922a7fda..9f350e05ef68 100644
--- a/drivers/misc/pvpanic.c
+++ b/drivers/misc/pvpanic.c
@@ -25,13 +25,13 @@ static unsigned int events;
 static ssize_t capability_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "%x", capability);
+	return sysfs_emit(buf, "%x\n", capability);
 }
 static DEVICE_ATTR_RO(capability);
 
 static ssize_t events_show(struct device *dev,  struct device_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "%x", events);
+	return sysfs_emit(buf, "%x\n", events);
 }
 
 static ssize_t events_store(struct device *dev,  struct device_attribute *attr,


