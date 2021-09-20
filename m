Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A74A411256
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 11:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234335AbhITJ46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 05:56:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229805AbhITJ44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 05:56:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6FBFD60F6C;
        Mon, 20 Sep 2021 09:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632131730;
        bh=IwuTqGD6KHEEeQN9ukZskmYqK2M+xPIbzdRgv9CM0hw=;
        h=From:To:Cc:Subject:Date:From;
        b=pzBqGFkF2dRXU1uaDDQ9kTjw6HGh9M3WgQOl7lbMlE/yZbXUNqhrzDWJ6OGjhpvUe
         P+VkGCA7DzFQzX7ZzX/fhK3btVcST6++dj5EH2emvzyQ7UEI9caUIg4VeFps4aDWbL
         8ycx+4A+3GDDsVv5kDYwxqIE6H/+FXusEkxsPZHa3B8Bpzgi6Y/yDWCqvj8uPaxYfD
         wtAwQVmcW9AN45g0lnHgDs7pO29CAcYckEDDh9Y3r3lb4sNVDEjLu65LhDukcUbaPu
         w3DhyNGi2Nkv2KPP91Y/cxEePOvg+Ei+mgVYE7qojoHBmNLTO2Shokd/WO3NcDjwyi
         wa/72tN8H3ojQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: r8188eu: fix -Wrestrict warnings
Date:   Mon, 20 Sep 2021 11:55:09 +0200
Message-Id: <20210920095525.1150678-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Adding back the nonstandard ioctl commands caused -Wrestrict warnings
when building with 'make W=1':

drivers/staging/r8188eu/os_dep/ioctl_linux.c: In function 'rtw_mp_read_rf':
drivers/staging/r8188eu/os_dep/ioctl_linux.c:5515:27: error: 'sprintf' argument 3 overlaps destination object 'extra' [-Werror=restrict]
 5515 |                           sprintf(extra, "%s %d", extra, strtou);
      |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/staging/r8188eu/os_dep/ioctl_linux.c:5470:54: note: destination object referenced by 'restrict'-qualified argument 1 was declared here
 5470 |                         struct iw_point *wrqu, char *extra)
      |                                                ~~~~~~^~~~~

Change these to the same construct used elsewhere in that driver,
with an offset to the string to make the warning go away.

The ioctl commands were previously removed, and it's unlikely that
anything is actually using them, so ideally I would prefer to have
them removed again.

The lack of range checking of the 'extra' output buffer is also
slightly worrying, but I did not check whether this could cause
harm.

Fixes: 2b42bd58b321 ("staging: r8188eu: introduce new os_dep dir for RTL8188eu driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 81d4255d1785..1fd375076001 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -5372,8 +5372,8 @@ static int rtw_mp_read_reg(struct net_device *dev,
 
 			pnext++;
 			if (*pnext != '\0') {
-				  strtout = simple_strtoul(pnext, &ptmp, 16);
-				  sprintf(extra, "%s %d", extra, strtout);
+				strtout = simple_strtoul(pnext, &ptmp, 16);
+				sprintf(extra + strlen(extra), " %d", strtout);
 			} else {
 				  break;
 			}
@@ -5405,7 +5405,7 @@ static int rtw_mp_read_reg(struct net_device *dev,
 			pnext++;
 			if (*pnext != '\0') {
 				strtout = simple_strtoul(pnext, &ptmp, 16);
-				sprintf(extra, "%s %d", extra, strtout);
+				sprintf(extra + strlen(extra), " %d", strtout);
 			} else {
 				break;
 			}
@@ -5512,7 +5512,7 @@ static int rtw_mp_read_rf(struct net_device *dev,
 		pnext++;
 		if (*pnext != '\0') {
 			  strtou = simple_strtoul(pnext, &ptmp, 16);
-			  sprintf(extra, "%s %d", extra, strtou);
+			  sprintf(extra + strlen(extra), " %d", strtou);
 		} else {
 			  break;
 		}
-- 
2.29.2

