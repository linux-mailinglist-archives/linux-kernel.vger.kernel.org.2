Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D559396478
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 17:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhEaQAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 12:00:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232022AbhEaOcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 10:32:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 34E966142E;
        Mon, 31 May 2021 13:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622468979;
        bh=lTJdh2qUaPRsw3u2MrIZqla9ZSWkzM0/nJSuyiTPpMM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QCE6Br3QNR1bJF1S+OqE8dr4uZU/SzdLcFj5LIffY+qvW6eygh4N8vZbGkHtoilRD
         aztJx0rMgV+MdhBmXgEFrKZfMaCpW1oSwO20XNb0gHyDUejv5HBFacz9q3k69scwHd
         9MuuHd0R6dwHb7T7MFfuKdzO44WvP3xBfkoMtp5A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.12 008/296] ALSA: usb-audio: fix control-request direction
Date:   Mon, 31 May 2021 15:11:03 +0200
Message-Id: <20210531130704.048265715@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210531130703.762129381@linuxfoundation.org>
References: <20210531130703.762129381@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 51cb8e206afd463e66f16869e5ddc95bef107142 upstream.

The direction of the pipe argument must match the request-type direction
bit or control requests may fail depending on the host-controller-driver
implementation.

Fix the UAC2_CS_CUR request which erroneously used usb_sndctrlpipe().

Fixes: 93db51d06b32 ("ALSA: usb-audio: Check valid altsetting at parsing rates for UAC2/3")
Cc: stable@vger.kernel.org      # 5.10
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20210521133742.18098-1-johan@kernel.org
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/format.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -436,7 +436,7 @@ static bool check_valid_altsetting_v2v3(
 	if (snd_BUG_ON(altsetting >= 64 - 8))
 		return false;
 
-	err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), UAC2_CS_CUR,
+	err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC2_CS_CUR,
 			      USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_IN,
 			      UAC2_AS_VAL_ALT_SETTINGS << 8,
 			      iface, &raw_data, sizeof(raw_data));


