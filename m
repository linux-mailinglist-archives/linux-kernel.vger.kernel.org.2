Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D949140B0BA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbhINOeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:34:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233780AbhINOeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:34:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F3F0610E6;
        Tue, 14 Sep 2021 14:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631629970;
        bh=tQ4pNebyPQHU8q6+GZvWiubG8zvvZ2iUgULZ4e9qk8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E2MGT6bDzRL9a74JsDzcMXeHsBf1qE0xWjvDu2eek/GPsvjDmi7vIJtwOA6vrSRzR
         drWAlrLMLWMLEw/cE2InfA82PbhuR3tVJyJKtjKVNfbO69F73VE3JZmB44dxQwpN21
         AMxTO8QFxABcmgT636vi0TZrAaB6NRZvkAulj5wWzNFafZV/4h3TcNuLfLgTzFWWfx
         YCIGB0bBKHxiUC3/ufiqySX8Oa8STmMuBVtFfQhFNRPbHReOeFj2vRvgR09EMYCbj7
         LILN58xDUNLt5J4uzmPgjgN+Hfj+lqIkoZO9QesvwXX2bLooBL8S2eAs9dbc2G5yk/
         Qn6c3pmM1AvMw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQ9UO-000KlY-AF; Tue, 14 Sep 2021 16:32:48 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 21/29] ABI: sysfs-class-rc: use wildcards on What definitions
Date:   Tue, 14 Sep 2021 16:32:36 +0200
Message-Id: <4ac9d66c59bad27777f2b00c09d1f965508340b2.1631629496.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631629496.git.mchehab+huawei@kernel.org>
References: <cover.1631629496.git.mchehab+huawei@kernel.org>
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

