Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB6842D802
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 13:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhJNLT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 07:19:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230142AbhJNLT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 07:19:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C865D610E7;
        Thu, 14 Oct 2021 11:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634210273;
        bh=NyMb3WErlw1pvar4/J8xwhOgvcvbCNpz3QtDgT+4tnw=;
        h=Date:From:To:Cc:Subject:From;
        b=ShNu7UuVKhKza2uqlxhPkmkf0jE5EB8xtFUwk0uSUFyt8mVp9lKR1kQhKBxgSiuxa
         1OrQDhAFfs29N6Dm+IXnTqJY6pzlv/JF1h+qo/+5mS0GBWivTj3DnuTZlwcLvckdGm
         CmJdHPmkvpisham1FOtvJW4yERs2CWrCeOd375r8=
Date:   Thu, 14 Oct 2021 13:17:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: add Schiit Hel device to quirk table
Message-ID: <YWgR3nOI1osvr5Yo@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Developer-Signature: v=1; a=openpgp-sha256; l=1516; h=from:subject;
 bh=NyMb3WErlw1pvar4/J8xwhOgvcvbCNpz3QtDgT+4tnw=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDIkZgtO2dW66/u2Rc8rXpYGpe2fePve/c1tEjxyjtAWvcMc+
 4ylrO2JZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAiVocY5oc8YZggM+Puk/zapSzWl7
 Ydv+eSuZZhnsUKj5xbh0y3TXh1vI/3FttX7ZaiKAA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Shciit Hel device responds to the ctl message for the mic capture
switch with a timeout of -EPIPE:

	usb 7-2.2: cannot get ctl value: req = 0x81, wValue = 0x100, wIndex = 0x1100, type = 1
	usb 7-2.2: cannot get ctl value: req = 0x81, wValue = 0x100, wIndex = 0x1100, type = 1
	usb 7-2.2: cannot get ctl value: req = 0x81, wValue = 0x100, wIndex = 0x1100, type = 1
	usb 7-2.2: cannot get ctl value: req = 0x81, wValue = 0x100, wIndex = 0x1100, type = 1

This seems safe to ignore as the device works properly with the control
message quirk, so add it to the quirk table so all is good.

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 6ee6d24c847f..ec11be366dc0 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1884,6 +1884,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x2912, 0x30c8, /* Audioengine D1 */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
+	DEVICE_FLG(0x30be, 0x0101, /* Schiit Hel */
+		   QUIRK_FLAG_IGNORE_CTL_ERROR),
 	DEVICE_FLG(0x413c, 0xa506, /* Dell AE515 sound bar */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x534d, 0x2109, /* MacroSilicon MS2109 */
-- 
2.33.0

