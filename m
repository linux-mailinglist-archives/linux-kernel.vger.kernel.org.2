Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED69426052
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 01:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbhJGXVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 19:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbhJGXVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 19:21:17 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36335C061755
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 16:19:23 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id k7so23723192wrd.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 16:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PL54Nm2ZdSuYE5V8Jc6ddvakNyQ2FlPxhtz/QwtY6KY=;
        b=Q58cFmRu3sCSlXqMF//ykfyxgLEIm+cLlCUG12kqEKoOd7ywLq97jzL6UkuheaA33l
         cdFEAAnSvBHQM9J2wW8c75DTo9rgncES0V0Sozm5bS6tFoiYrr6B1WYbS3Tc1xfA23K3
         sqjrVJRtxMVJqQjsZhNEbcUTh+QDc4CClbai7bY/gY85AzHtcag9z3YPwdbj5r6WoDt+
         /g0iSRG9gtPGKN8kVak4H7NKfybGXhkmdirh2m8YAg0j6ood8qkTOdITXYyd2/7D9U5G
         HX8mSLaTCwHLhHpsgqnwdm1jDVo0vksa/w9jNrbYqGbV5vRBCrpYUAaDv7UIRF8vaFQr
         DyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PL54Nm2ZdSuYE5V8Jc6ddvakNyQ2FlPxhtz/QwtY6KY=;
        b=g3JGPV93a8zM1iAY3j5RsdN0Q+3dK8xSzbNQG0waEXnJ8y89cbKwxd6vqWapZMgmHP
         s8xtENr9MrKaAv3DeGtnFzwRFlsfM6bq6wKMfqRJykdEeynvfOowoRED7HBjXbwPAMsl
         XLi4KhX949k7OHpCnyGehs/3KDHEgseafgU8AyBjYi8HUIystuI/DESrCTO0QbS3jsqj
         ew85y8M3FT+REosglgMdk7L3HE4q/xHTC8dLJokUVqXfrhR+us5ZK2JlFT5sJWE3OVgv
         2WzQ1XxNUKgxVb4xQuevRcPRtnupFdKzthuzPle+6KzWOoiTTbTw+qXo4JXGHwXBL+xw
         Q7Ow==
X-Gm-Message-State: AOAM530Ae39tNgOmz+AjhtTOUKuTN8kaF6HlAH+45nssalnKslC6cM3W
        UwS9J8yZpsF4is9sU2VG+858zg==
X-Google-Smtp-Source: ABdhPJwk8KUf/L/qNZ9qZoWDgjzDEMmQ6INLkE61SPAJG25IDr6ZOY+BTuQtKI1Ib4ZRxgqnMDRxKw==
X-Received: by 2002:a05:6000:18a2:: with SMTP id b2mr8932644wri.155.1633648761723;
        Thu, 07 Oct 2021 16:19:21 -0700 (PDT)
Received: from localhost.localdomain (30.34.155.90.in-addr.arpa. [90.155.34.30])
        by smtp.gmail.com with ESMTPSA id w1sm9755292wmc.19.2021.10.07.16.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 16:19:21 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     axboe@kernel.dk
Cc:     hch@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, lumip@lumip.de, rdunlap@infradead.org
Subject: [PATCH] cdrom: docs: reformat table in Documentation/userspace-api/ioctl/cdrom.rst
Date:   Fri,  8 Oct 2021 00:17:20 +0100
Message-Id: <20211007231720.31997-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add extra space to the first column of ioctl values table, and also realign
the text in the second column, to fix a documentation build warning
introduced by: commit 67f1e027c270 ("drivers/cdrom: improved ioctl for
media change detection")

Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Fixes: 67f1e027c270 ("drivers/cdrom: improved ioctl for media change detection")
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 Documentation/userspace-api/ioctl/cdrom.rst | 116 ++++++++++----------
 1 file changed, 58 insertions(+), 58 deletions(-)

diff --git a/Documentation/userspace-api/ioctl/cdrom.rst b/Documentation/userspace-api/ioctl/cdrom.rst
index bac5bbf93ca0..682948fc88a3 100644
--- a/Documentation/userspace-api/ioctl/cdrom.rst
+++ b/Documentation/userspace-api/ioctl/cdrom.rst
@@ -13,64 +13,64 @@ in drivers/cdrom/cdrom.c and drivers/block/scsi_ioctl.c
 ioctl values are listed in <linux/cdrom.h>.  As of this writing, they
 are as follows:
 
-	======================	===============================================
-	CDROMPAUSE		Pause Audio Operation
-	CDROMRESUME		Resume paused Audio Operation
-	CDROMPLAYMSF		Play Audio MSF (struct cdrom_msf)
-	CDROMPLAYTRKIND		Play Audio Track/index (struct cdrom_ti)
-	CDROMREADTOCHDR		Read TOC header (struct cdrom_tochdr)
-	CDROMREADTOCENTRY	Read TOC entry (struct cdrom_tocentry)
-	CDROMSTOP		Stop the cdrom drive
-	CDROMSTART		Start the cdrom drive
-	CDROMEJECT		Ejects the cdrom media
-	CDROMVOLCTRL		Control output volume (struct cdrom_volctrl)
-	CDROMSUBCHNL		Read subchannel data (struct cdrom_subchnl)
-	CDROMREADMODE2		Read CDROM mode 2 data (2336 Bytes)
-				(struct cdrom_read)
-	CDROMREADMODE1		Read CDROM mode 1 data (2048 Bytes)
-				(struct cdrom_read)
-	CDROMREADAUDIO		(struct cdrom_read_audio)
-	CDROMEJECT_SW		enable(1)/disable(0) auto-ejecting
-	CDROMMULTISESSION	Obtain the start-of-last-session
-				address of multi session disks
-				(struct cdrom_multisession)
-	CDROM_GET_MCN		Obtain the "Universal Product Code"
-				if available (struct cdrom_mcn)
-	CDROM_GET_UPC		Deprecated, use CDROM_GET_MCN instead.
-	CDROMRESET		hard-reset the drive
-	CDROMVOLREAD		Get the drive's volume setting
-				(struct cdrom_volctrl)
-	CDROMREADRAW		read data in raw mode (2352 Bytes)
-				(struct cdrom_read)
-	CDROMREADCOOKED		read data in cooked mode
-	CDROMSEEK		seek msf address
-	CDROMPLAYBLK		scsi-cd only, (struct cdrom_blk)
-	CDROMREADALL		read all 2646 bytes
-	CDROMGETSPINDOWN	return 4-bit spindown value
-	CDROMSETSPINDOWN	set 4-bit spindown value
-	CDROMCLOSETRAY		pendant of CDROMEJECT
-	CDROM_SET_OPTIONS	Set behavior options
-	CDROM_CLEAR_OPTIONS	Clear behavior options
-	CDROM_SELECT_SPEED	Set the CD-ROM speed
-	CDROM_SELECT_DISC	Select disc (for juke-boxes)
-	CDROM_MEDIA_CHANGED	Check is media changed
-	CDROM_TIMED_MEDIA_CHANGE	Check if media changed
-					since given time
-					(struct cdrom_timed_media_change_info)
-	CDROM_DRIVE_STATUS	Get tray position, etc.
-	CDROM_DISC_STATUS	Get disc type, etc.
-	CDROM_CHANGER_NSLOTS	Get number of slots
-	CDROM_LOCKDOOR		lock or unlock door
-	CDROM_DEBUG		Turn debug messages on/off
-	CDROM_GET_CAPABILITY	get capabilities
-	CDROMAUDIOBUFSIZ	set the audio buffer size
-	DVD_READ_STRUCT		Read structure
-	DVD_WRITE_STRUCT	Write structure
-	DVD_AUTH		Authentication
-	CDROM_SEND_PACKET	send a packet to the drive
-	CDROM_NEXT_WRITABLE	get next writable block
-	CDROM_LAST_WRITTEN	get last block written on disc
-	======================	===============================================
+	========================  ===============================================
+	CDROMPAUSE		  Pause Audio Operation
+	CDROMRESUME		  Resume paused Audio Operation
+	CDROMPLAYMSF		  Play Audio MSF (struct cdrom_msf)
+	CDROMPLAYTRKIND		  Play Audio Track/index (struct cdrom_ti)
+	CDROMREADTOCHDR		  Read TOC header (struct cdrom_tochdr)
+	CDROMREADTOCENTRY	  Read TOC entry (struct cdrom_tocentry)
+	CDROMSTOP		  Stop the cdrom drive
+	CDROMSTART		  Start the cdrom drive
+	CDROMEJECT		  Ejects the cdrom media
+	CDROMVOLCTRL		  Control output volume (struct cdrom_volctrl)
+	CDROMSUBCHNL		  Read subchannel data (struct cdrom_subchnl)
+	CDROMREADMODE2		  Read CDROM mode 2 data (2336 Bytes)
+				  (struct cdrom_read)
+	CDROMREADMODE1		  Read CDROM mode 1 data (2048 Bytes)
+				  (struct cdrom_read)
+	CDROMREADAUDIO		  (struct cdrom_read_audio)
+	CDROMEJECT_SW		  enable(1)/disable(0) auto-ejecting
+	CDROMMULTISESSION	  Obtain the start-of-last-session
+				  address of multi session disks
+				  (struct cdrom_multisession)
+	CDROM_GET_MCN		  Obtain the "Universal Product Code"
+				  if available (struct cdrom_mcn)
+	CDROM_GET_UPC		  Deprecated, use CDROM_GET_MCN instead.
+	CDROMRESET		  hard-reset the drive
+	CDROMVOLREAD		  Get the drive's volume setting
+				  (struct cdrom_volctrl)
+	CDROMREADRAW		  read data in raw mode (2352 Bytes)
+				  (struct cdrom_read)
+	CDROMREADCOOKED		  read data in cooked mode
+	CDROMSEEK		  seek msf address
+	CDROMPLAYBLK		  scsi-cd only, (struct cdrom_blk)
+	CDROMREADALL		  read all 2646 bytes
+	CDROMGETSPINDOWN	  return 4-bit spindown value
+	CDROMSETSPINDOWN	  set 4-bit spindown value
+	CDROMCLOSETRAY		  pendant of CDROMEJECT
+	CDROM_SET_OPTIONS	  Set behavior options
+	CDROM_CLEAR_OPTIONS	  Clear behavior options
+	CDROM_SELECT_SPEED	  Set the CD-ROM speed
+	CDROM_SELECT_DISC	  Select disc (for juke-boxes)
+	CDROM_MEDIA_CHANGED	  Check is media changed
+	CDROM_TIMED_MEDIA_CHANGE  Check if media changed
+				  since given time
+				  (struct cdrom_timed_media_change_info)
+	CDROM_DRIVE_STATUS	  Get tray position, etc.
+	CDROM_DISC_STATUS	  Get disc type, etc.
+	CDROM_CHANGER_NSLOTS	  Get number of slots
+	CDROM_LOCKDOOR		  lock or unlock door
+	CDROM_DEBUG		  Turn debug messages on/off
+	CDROM_GET_CAPABILITY	  get capabilities
+	CDROMAUDIOBUFSIZ	  set the audio buffer size
+	DVD_READ_STRUCT		  Read structure
+	DVD_WRITE_STRUCT	  Write structure
+	DVD_AUTH		  Authentication
+	CDROM_SEND_PACKET	  send a packet to the drive
+	CDROM_NEXT_WRITABLE	  get next writable block
+	CDROM_LAST_WRITTEN	  get last block written on disc
+	========================  ===============================================
 
 
 The information that follows was determined from reading kernel source
-- 
2.31.1

