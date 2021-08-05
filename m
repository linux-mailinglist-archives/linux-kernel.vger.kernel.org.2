Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F9F3E0CFB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 06:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhHEECH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 00:02:07 -0400
Received: from [43.250.32.171] ([43.250.32.171]:48196 "EHLO email.cn"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S229446AbhHEECE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 00:02:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=From:To:Date; bh=eBCcozSu9hNSLlbWZn+AY6boa0Vbxrja8LsS0
        JUUaRI=; b=S+RmDZcogFKBExHqZCkR/3tJuGpUe3s5e8AAFcCdLJdj4zRy4YuH/
        HKKPnVw9m8ONlvbWNLDCfZc9v2HJU4pdPDHtjGDKFzCxK7kWg61sJDB4LnQJp+R7
        1TBPKJpHan9XwF+6Z0oSV9Z97WKP1LaGdepEp84lE+Uz4RhdBizaOI=
Received: from localhost.localdomain (unknown [113.251.8.125])
        by v_coremail2-frontend-1 (Coremail) with SMTP id LCKnCgA3RQSqYgthnhQZAA--.28023S2;
        Thu, 05 Aug 2021 12:01:47 +0800 (CST)
From:   Hu Haowen <src.res@email.cn>
To:     gregkh@linuxfoundation.org, corbet@lwn.net
Cc:     linux-usb@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs: usb: fix malformed table
Date:   Thu,  5 Aug 2021 12:01:46 +0800
Message-Id: <20210805040146.121526-1-src.res@email.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LCKnCgA3RQSqYgthnhQZAA--.28023S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtF1UXF45Xry8Gw4DCr45ZFb_yoW7CrWrpa
        1DJrySvF15ZrWfJw45Jw47Wr1fXrWUGF4DJrn5tr1jgryfJ34UJ34av3WYyFyUCr1DAwnF
        y3Wqqr18ZrWjvrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgvb7Iv0xC_KF4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
        v20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2
        z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0x
        vYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_
        Cr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8Xw
        CF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26F4UJr1UMxC20s026xCaFVCjc4AY
        6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
        CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
        0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
        AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
        Ja73UjIFyTuYvjxU8pnQUUUUU
X-Originating-IP: [113.251.8.125]
X-CM-SenderInfo: hvufh21hv6vzxdlohubq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tables are separated with tabs and spaces mixed together, leading
to malformation. Changed the characters all into spaces to solve this
issue.

Signed-off-by: Hu Haowen <src.res@email.cn>
---
 Documentation/usb/gadget-testing.rst | 84 ++++++++++++++--------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/Documentation/usb/gadget-testing.rst b/Documentation/usb/gadget-testing.rst
index d6253f1a32a1..c18113077889 100644
--- a/Documentation/usb/gadget-testing.rst
+++ b/Documentation/usb/gadget-testing.rst
@@ -724,28 +724,28 @@ Function-specific configfs interface
 The function name to use when creating the function directory is "uac2".
 The uac2 function provides these attributes in its function directory:
 
-	=============== ====================================================
-	c_chmask	capture channel mask
-	c_srate		capture sampling rate
-	c_ssize		capture sample size (bytes)
-	c_sync		capture synchronization type (async/adaptive)
-	c_mute_present	capture mute control enable
-	c_volume_present	capture volume control enable
-	c_volume_min	capture volume control min value (in 1/256 dB)
-	c_volume_max	capture volume control max value (in 1/256 dB)
-	c_volume_res	capture volume control resolution (in 1/256 dB)
-	fb_max    maximum extra bandwidth in async mode
-	p_chmask	playback channel mask
-	p_srate		playback sampling rate
-	p_ssize		playback sample size (bytes)
-	p_mute_present	playback mute control enable
-	p_volume_present	playback volume control enable
-	p_volume_min	playback volume control min value (in 1/256 dB)
-	p_volume_max	playback volume control max value (in 1/256 dB)
-	p_volume_res	playback volume control resolution (in 1/256 dB)
-	req_number	the number of pre-allocated request for both capture
-			and playback
-	=============== ====================================================
+	================ ====================================================
+	c_chmask         capture channel mask
+	c_srate          capture sampling rate
+	c_ssize          capture sample size (bytes)
+	c_sync           capture synchronization type (async/adaptive)
+	c_mute_present   capture mute control enable
+	c_volume_present capture volume control enable
+	c_volume_min     capture volume control min value (in 1/256 dB)
+	c_volume_max     capture volume control max value (in 1/256 dB)
+	c_volume_res     capture volume control resolution (in 1/256 dB)
+	fb_max           maximum extra bandwidth in async mode
+	p_chmask         playback channel mask
+	p_srate          playback sampling rate
+	p_ssize          playback sample size (bytes)
+	p_mute_present   playback mute control enable
+	p_volume_present playback volume control enable
+	p_volume_min     playback volume control min value (in 1/256 dB)
+	p_volume_max     playback volume control max value (in 1/256 dB)
+	p_volume_res     playback volume control resolution (in 1/256 dB)
+	req_number       the number of pre-allocated request for both capture
+	                 and playback
+	================ ====================================================
 
 The attributes have sane default values.
 
@@ -914,26 +914,26 @@ Function-specific configfs interface
 The function name to use when creating the function directory is "uac1".
 The uac1 function provides these attributes in its function directory:
 
-	========== ====================================================
-	c_chmask   	capture channel mask
-	c_srate    	capture sampling rate
-	c_ssize    	capture sample size (bytes)
-	c_mute_present	capture mute control enable
-	c_volume_present	capture volume control enable
-	c_volume_min	capture volume control min value (in 1/256 dB)
-	c_volume_max	capture volume control max value (in 1/256 dB)
-	c_volume_res	capture volume control resolution (in 1/256 dB)
-	p_chmask   	playback channel mask
-	p_srate    	playback sampling rate
-	p_ssize    	playback sample size (bytes)
-	p_mute_present	playback mute control enable
-	p_volume_present	playback volume control enable
-	p_volume_min	playback volume control min value (in 1/256 dB)
-	p_volume_max	playback volume control max value (in 1/256 dB)
-	p_volume_res	playback volume control resolution (in 1/256 dB)
-	req_number 	the number of pre-allocated request for both capture
-			and playback
-	========== ====================================================
+	================ ====================================================
+	c_chmask         capture channel mask
+	c_srate          capture sampling rate
+	c_ssize          capture sample size (bytes)
+	c_mute_present   capture mute control enable
+	c_volume_present capture volume control enable
+	c_volume_min     capture volume control min value (in 1/256 dB)
+	c_volume_max     capture volume control max value (in 1/256 dB)
+	c_volume_res     capture volume control resolution (in 1/256 dB)
+	p_chmask         playback channel mask
+	p_srate          playback sampling rate
+	p_ssize          playback sample size (bytes)
+	p_mute_present   playback mute control enable
+	p_volume_present playback volume control enable
+	p_volume_min     playback volume control min value (in 1/256 dB)
+	p_volume_max     playback volume control max value (in 1/256 dB)
+	p_volume_res     playback volume control resolution (in 1/256 dB)
+	req_number       the number of pre-allocated request for both capture
+	                 and playback
+	================ ====================================================
 
 The attributes have sane default values.
 
-- 
2.25.1

