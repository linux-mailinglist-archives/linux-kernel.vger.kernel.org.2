Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA644192E1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 13:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbhI0LNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 07:13:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233969AbhI0LMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 07:12:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 528736113A;
        Mon, 27 Sep 2021 11:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632741062;
        bh=21ZJT0oZyeZmeidhnTpBQDhj3r17hlRmz1Cr8tuVvZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BR6rQuP+6hAYWD6UuR9bPjFidiumKUvXQCaDMwQXTn6oBErd9SZKBn2RpECo3f7Tz
         7s8eZ9GVgcbrQEHKjewuadud1bJNOrNPt/KEIs4iqsAK97qOm9yDjCG7TBomeKVLdg
         MAp98ppaHwDQ8SaT+wYfGwo19PVThiNKuhK2h16mpUhZUCbWb0tRkG2JrSdxLo9nUH
         X4UU8VRn0tId4wSIVdr1eMe+x7yisy3fBUNXVGGU9vx9a4C8YnXYEww0tJR5ukKMkH
         7BeZtBMqI2UCYaR+eyaTh3YZUCB16VupNPEaEvE1gtSRBMt8h5f0CQ/66kXPuGBhpd
         iUESxnF2GZdAw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mUoXE-0005yL-Ct; Mon, 27 Sep 2021 13:11:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Pavel Hofman <pavel.hofman@ivitera.com>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] ABI: configfs-usb-gadget-uac1: fix a broken table
Date:   Mon, 27 Sep 2021 13:10:53 +0200
Message-Id: <044b0c14c35922bdcca50551fe2aa870baae9b06.1632740376.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632740376.git.mchehab+huawei@kernel.org>
References: <cover.1632740376.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 0356e6283c71 ("usb: gadget: f_uac1: add volume and mute support")
added some new elements to the table but didn't care enough to actually
adjust the columns, causing the output to be broken as warned by
Sphinx when producing the documentation.

Readjust it for it to be a valid ReST table.

Fixes: 0356e6283c71 ("usb: gadget: f_uac1: add volume and mute support")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH 0/7] at: https://lore.kernel.org/all/cover.1632740376.git.mchehab+huawei@kernel.org/T/#t

 .../ABI/testing/configfs-usb-gadget-uac1      | 42 +++++++++++--------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/Documentation/ABI/testing/configfs-usb-gadget-uac1 b/Documentation/ABI/testing/configfs-usb-gadget-uac1
index dd647d44d975..b576b3d6ea6d 100644
--- a/Documentation/ABI/testing/configfs-usb-gadget-uac1
+++ b/Documentation/ABI/testing/configfs-usb-gadget-uac1
@@ -4,23 +4,29 @@ KernelVersion:	4.14
 Description:
 		The attributes:
 
-		==========	===================================
-		c_chmask	capture channel mask
-		c_srate		capture sampling rate
-		c_ssize		capture sample size (bytes)
-		c_mute_present	capture mute control enable
+		=====================	=======================================
+		c_chmask		capture channel mask
+		c_srate			capture sampling rate
+		c_ssize			capture sample size (bytes)
+		c_mute_present		capture mute control enable
 		c_volume_present	capture volume control enable
-		c_volume_min	capture volume control min value (in 1/256 dB)
-		c_volume_max	capture volume control max value (in 1/256 dB)
-		c_volume_res	capture volume control resolution (in 1/256 dB)
-		p_chmask	playback channel mask
-		p_srate		playback sampling rate
-		p_ssize		playback sample size (bytes)
-		p_mute_present	playback mute control enable
+		c_volume_min		capture volume control min value
+					(in 1/256 dB)
+		c_volume_max		capture volume control max value
+					(in 1/256 dB)
+		c_volume_res		capture volume control resolution
+					(in 1/256 dB)
+		p_chmask		playback channel mask
+		p_srate			playback sampling rate
+		p_ssize			playback sample size (bytes)
+		p_mute_present		playback mute control enable
 		p_volume_present	playback volume control enable
-		p_volume_min	playback volume control min value (in 1/256 dB)
-		p_volume_max	playback volume control max value (in 1/256 dB)
-		p_volume_res	playback volume control resolution (in 1/256 dB)
-		req_number	the number of pre-allocated request
-				for both capture and playback
-		==========	===================================
+		p_volume_min		playback volume control min value
+					(in 1/256 dB)
+		p_volume_max		playback volume control max value
+					(in 1/256 dB)
+		p_volume_res		playback volume control resolution
+					(in 1/256 dB)
+		req_number		the number of pre-allocated request
+					for both capture and playback
+		=====================	=======================================
-- 
2.31.1

