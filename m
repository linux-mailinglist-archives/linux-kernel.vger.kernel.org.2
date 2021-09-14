Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED4240B0FB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbhINOhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:37:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233874AbhINOeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:34:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9DC26124D;
        Tue, 14 Sep 2021 14:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631629970;
        bh=lnViX5JeCxtvET+iaFNRtFAQr+eduL6y6bzYMTy334Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=svnV/6ImnLkpfQlnov3z0Pgqm1rpOxmGiGFsyFgdPBIyRReKxPZkbAfPfXkPvYd3x
         q1C/MrFUlh1zxgCV5yPDKw7biX/HAzToJN/CVexE/9Xq5SUVRG/3UlCmzKzNujwa++
         a5Xa7psFHnTRUTso87XNj4dxZYgZlgQRR/JYH0dKdFTZNN2zQcI5/wiAGRvaE0YxNv
         S6JkTRbh2JOHBphl5tNFUlLvZHdl34WpafgkXi8n9XckGu1EwzeQPVWK6kXQWlkWgN
         NHFd3gCHbjN9cMkk9W8HzC9ncUqS+EPv+k4hhPPFTvlQUoPFGOb3dnzpVQb0hRM/39
         XafmMbRArohrg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQ9UO-000Klk-Ex; Tue, 14 Sep 2021 16:32:48 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 24/29] ABI: sysfs-class-uwb_rc-wusbhc: use wildcards on What definitions
Date:   Tue, 14 Sep 2021 16:32:39 +0200
Message-Id: <f5e4fcc47341482f879c89914c1cb5aa69af8d59.1631629496.git.mchehab+huawei@kernel.org>
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
 Documentation/ABI/testing/sysfs-class-uwb_rc-wusbhc | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-uwb_rc-wusbhc b/Documentation/ABI/testing/sysfs-class-uwb_rc-wusbhc
index 5977e2875325..55eb55cac92e 100644
--- a/Documentation/ABI/testing/sysfs-class-uwb_rc-wusbhc
+++ b/Documentation/ABI/testing/sysfs-class-uwb_rc-wusbhc
@@ -1,4 +1,4 @@
-What:           /sys/class/uwb_rc/uwbN/wusbhc/wusb_chid
+What:           /sys/class/uwb_rc/uwb<N>/wusbhc/wusb_chid
 Date:           July 2008
 KernelVersion:  2.6.27
 Contact:        David Vrabel <david.vrabel@csr.com>
@@ -9,7 +9,7 @@ Description:
 
                 Set an all zero CHID to stop the host controller.
 
-What:           /sys/class/uwb_rc/uwbN/wusbhc/wusb_trust_timeout
+What:           /sys/class/uwb_rc/uwb<N>/wusbhc/wusb_trust_timeout
 Date:           July 2008
 KernelVersion:  2.6.27
 Contact:        David Vrabel <david.vrabel@csr.com>
@@ -24,7 +24,7 @@ Description:
                 lifetime of PTKs and GTKs) it should not be changed
                 from the default.
 
-What:           /sys/class/uwb_rc/uwbN/wusbhc/wusb_phy_rate
+What:           /sys/class/uwb_rc/uwb<N>/wusbhc/wusb_phy_rate
 Date:           August 2009
 KernelVersion:  2.6.32
 Contact:        David Vrabel <david.vrabel@csr.com>
@@ -37,7 +37,7 @@ Description:
                 Refer to [ECMA-368] section 10.3.1.1 for the value to
                 use.
 
-What:           /sys/class/uwb_rc/uwbN/wusbhc/wusb_dnts
+What:           /sys/class/uwb_rc/uwb<N>/wusbhc/wusb_dnts
 Date:           June 2013
 KernelVersion:  3.11
 Contact:        Thomas Pugliese <thomas.pugliese@gmail.com>
@@ -47,7 +47,7 @@ Description:
                 often the devices will have the opportunity to send
                 notifications to the host.
 
-What:           /sys/class/uwb_rc/uwbN/wusbhc/wusb_retry_count
+What:           /sys/class/uwb_rc/uwb<N>/wusbhc/wusb_retry_count
 Date:           June 2013
 KernelVersion:  3.11
 Contact:        Thomas Pugliese <thomas.pugliese@gmail.com>
-- 
2.31.1

