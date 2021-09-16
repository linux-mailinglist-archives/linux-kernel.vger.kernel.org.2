Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B0140D570
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 11:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236911AbhIPJCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 05:02:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:36430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235500AbhIPJBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:01:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 31D1A61372;
        Thu, 16 Sep 2021 09:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631782803;
        bh=lnViX5JeCxtvET+iaFNRtFAQr+eduL6y6bzYMTy334Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JToTUj43gXTBlFxwfSFQ50d77T1VnGL9e+SHQBPqtFtLM8g/e1y0gOkCELSimhHPg
         hLIxfyk7qaaHxh/0h8N4mriwKfALbAMMWMMqLUr+jHt6uMYxbBfm0YLEGaOtMuBZ+T
         1Z3sFMdGyibn0p5ChYYM/lFcVdnD8mMRrANJIZJs52AY0/l4OdRpVqRvVa1/S2AjvQ
         TuLopJtY/2VbFx8kUbfLCRD5gfAafdEsfl/y8TArj+9VEdj0vNIx1dWmGK9udsaDl+
         tQX+dTi+iVxI0QA0g5o3EChQmQ7klPXGSUelNhdBGEUUDhO56197t4T42nLNBZ62VY
         p9NiExnewmKgA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQnFR-001ql6-Dq; Thu, 16 Sep 2021 11:00:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 24/30] ABI: sysfs-class-uwb_rc-wusbhc: use wildcards on What definitions
Date:   Thu, 16 Sep 2021 10:59:51 +0200
Message-Id: <89dfa95676376f48a7191e1d34264d48a72b3f6a.1631782432.git.mchehab+huawei@kernel.org>
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

