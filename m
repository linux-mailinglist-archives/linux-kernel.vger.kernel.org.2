Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1677F4192E2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 13:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbhI0LNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 07:13:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233970AbhI0LMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 07:12:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 562FB610A2;
        Mon, 27 Sep 2021 11:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632741062;
        bh=8/L6KRahuWu9oqnfFsayx3+7gB/uZHCKO98LlNaZ9As=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hwrTQj1NyoqeuFRyTCPkWV90VfDkXvlvo9AgJYmxC34cG3hMVo0SZk5zUeiSmYJ2A
         6eDPrxq9UGH3rDSuCRt8KE7Wy7PqP8j0n35JUXmWBTSR+Zu9wRANityhQki9R/vlSD
         1J+3ETo5YffYC3rePMeZtq3u7GFoPYhuVQYlf5Z57C4K8DNS1lB8FBTZ3SXwGds1eG
         SzUn6d8put33OiL4YyTO0Jls/Ih/3rGlEIUE4WK6G9gYttcZAmL1m664oKqSgXaaIZ
         lizuEJN2UjOPiN69zZhMYaMsbq9KhVR9+XLwkV/azg173kSv+zLyjGlm5Bdoq4lsY0
         CYB7vDI8CqPbA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mUoXE-0005yP-Ep; Mon, 27 Sep 2021 13:11:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Pavel Hofman <pavel.hofman@ivitera.com>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] ABI: configfs-usb-gadget-uac2: fix a broken table
Date:   Mon, 27 Sep 2021 13:10:54 +0200
Message-Id: <d253819a4c201b942d754682bb91dd278300fb79.1632740376.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632740376.git.mchehab+huawei@kernel.org>
References: <cover.1632740376.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset af6cbe09920 ("usb: gadget: f_uac2: add volume and mute support")
added some new elements to the table but didn't care enough to actually
adjust the columns, causing the output to be broken as warned by
Sphinx when producing the documentation.

Readjust it for it to be a valid ReST table.

Fixes: eaf6cbe09920 ("usb: gadget: f_uac2: add volume and mute support")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH 0/7] at: https://lore.kernel.org/all/cover.1632740376.git.mchehab+huawei@kernel.org/T/#t

 .../ABI/testing/configfs-usb-gadget-uac2      | 43 +++++++++++--------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/Documentation/ABI/testing/configfs-usb-gadget-uac2 b/Documentation/ABI/testing/configfs-usb-gadget-uac2
index cfd160ff8b56..244d96650123 100644
--- a/Documentation/ABI/testing/configfs-usb-gadget-uac2
+++ b/Documentation/ABI/testing/configfs-usb-gadget-uac2
@@ -4,23 +4,30 @@ KernelVersion:	3.18
 Description:
 		The attributes:
 
-		=========  ============================
-		c_chmask   capture channel mask
-		c_srate    capture sampling rate
-		c_ssize    capture sample size (bytes)
-		c_sync     capture synchronization type (async/adaptive)
-		c_mute_present	capture mute control enable
+		=====================	=======================================
+		c_chmask		capture channel mask
+		c_srate			capture sampling rate
+		c_ssize			capture sample size (bytes)
+		c_sync			capture synchronization type
+					(async/adaptive)
+		c_mute_present		capture mute control enable
 		c_volume_present	capture volume control enable
-		c_volume_min	capture volume control min value (in 1/256 dB)
-		c_volume_max	capture volume control max value (in 1/256 dB)
-		c_volume_res	capture volume control resolution (in 1/256 dB)
-		fb_max     maximum extra bandwidth in async mode
-		p_chmask   playback channel mask
-		p_srate    playback sampling rate
-		p_ssize    playback sample size (bytes)
-		p_mute_present	playback mute control enable
+		c_volume_min		capture volume control min value
+					(in 1/256 dB)
+		c_volume_max		capture volume control max value
+					(in 1/256 dB)
+		c_volume_res		capture volume control resolution
+					(in 1/256 dB)
+		fb_max			maximum extra bandwidth in async mode
+		p_chmask		playback channel mask
+		p_srate			playback sampling rate
+		p_ssize			playback sample size (bytes)
+		p_mute_present		playback mute control enable
 		p_volume_present	playback volume control enable
-		p_volume_min	playback volume control min value (in 1/256 dB)
-		p_volume_max	playback volume control max value (in 1/256 dB)
-		p_volume_res	playback volume control resolution (in 1/256 dB)
-		=========  ============================
+		p_volume_min		playback volume control min value
+					(in 1/256 dB)
+		p_volume_max		playback volume control max value
+					(in 1/256 dB)
+		p_volume_res		playback volume control resolution
+					(in 1/256 dB)
+		=====================	=======================================
-- 
2.31.1

