Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E510F40D575
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 11:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236611AbhIPJDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 05:03:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:36178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235475AbhIPJBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:01:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07E666135A;
        Thu, 16 Sep 2021 09:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631782803;
        bh=tQ4pNebyPQHU8q6+GZvWiubG8zvvZ2iUgULZ4e9qk8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a5vIypBvh892fQvPmKFZbLd719EDwXHlpmha1m5z77E37thZ9ZLQDPm5tUGeJ97SM
         TlI90AIIyAGfLsBs6gX0to7olIf0pL7VW2AsJDI8ue4SvYObgiSEe4sx+6AG5gDO2K
         GsR+d21elSZua6io+gGsCsv4MQX4ZinpOEyUYvHukzEzSReBJWX4qnJRB7DBIfMQ1V
         eLHj3rxnkM9k7k3P+iBETq1fwKbz38iRkL8Q/ELf2wz/yCN0ez/XB+vzKVclYDmosu
         I/kkgQqdipKPl65SACvcuWGX+uwpMA1JxH+UISLzO4TqWgrhHb/WAwdYu7HH44/lJH
         MUgPCFkaWbvhg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQnFR-001qku-8g; Thu, 16 Sep 2021 11:00:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 21/30] ABI: sysfs-class-rc: use wildcards on What definitions
Date:   Thu, 16 Sep 2021 10:59:48 +0200
Message-Id: <42778ca4b2f9bf73fafecb9b388a8fcd0e66be26.1631782432.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631782432.git.mchehab+huawei@kernel.org>
References: <cover.1631782432.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An "N" upper letter is not a wildcard, nor can easily be identified
by script, specially since the USB sysfs define things like.
bNumInterfaces. Use, instead, <N>, in order to let script/get_abi.pl
to convert it into a Regex.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/testing/sysfs-class-rc | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-rc b/Documentation/ABI/testing/sysfs-class-rc
index 9c8ff7910858..84e46d70d82b 100644
--- a/Documentation/ABI/testing/sysfs-class-rc
+++ b/Documentation/ABI/testing/sysfs-class-rc
@@ -7,7 +7,7 @@ Description:
 		core and provides a sysfs interface for configuring infrared
 		remote controller receivers.
 
-What:		/sys/class/rc/rcN/
+What:		/sys/class/rc/rc<N>/
 Date:		Apr 2010
 KernelVersion:	2.6.35
 Contact:	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
@@ -15,7 +15,7 @@ Description:
 		A /sys/class/rc/rcN directory is created for each remote
 		control receiver device where N is the number of the receiver.
 
-What:		/sys/class/rc/rcN/protocols
+What:		/sys/class/rc/rc<N>/protocols
 Date:		Jun 2010
 KernelVersion:	2.6.36
 Contact:	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
@@ -40,7 +40,7 @@ Description:
 		Write fails with EINVAL if an invalid protocol combination or
 		unknown protocol name is used.
 
-What:		/sys/class/rc/rcN/filter
+What:		/sys/class/rc/rc<N>/filter
 Date:		Jan 2014
 KernelVersion:	3.15
 Contact:	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
@@ -55,7 +55,7 @@ Description:
 
 		This value may be reset to 0 if the current protocol is altered.
 
-What:		/sys/class/rc/rcN/filter_mask
+What:		/sys/class/rc/rc<N>/filter_mask
 Date:		Jan 2014
 KernelVersion:	3.15
 Contact:	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
@@ -72,7 +72,7 @@ Description:
 
 		This value may be reset to 0 if the current protocol is altered.
 
-What:		/sys/class/rc/rcN/wakeup_protocols
+What:		/sys/class/rc/rc<N>/wakeup_protocols
 Date:		Feb 2017
 KernelVersion:	4.11
 Contact:	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
@@ -98,7 +98,7 @@ Description:
 		unknown protocol name is used, or if wakeup is not supported by
 		the hardware.
 
-What:		/sys/class/rc/rcN/wakeup_filter
+What:		/sys/class/rc/rc<N>/wakeup_filter
 Date:		Jan 2014
 KernelVersion:	3.15
 Contact:	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
@@ -117,7 +117,7 @@ Description:
 
 		This value may be reset to 0 if the wakeup protocol is altered.
 
-What:		/sys/class/rc/rcN/wakeup_filter_mask
+What:		/sys/class/rc/rc<N>/wakeup_filter_mask
 Date:		Jan 2014
 KernelVersion:	3.15
 Contact:	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
-- 
2.31.1

