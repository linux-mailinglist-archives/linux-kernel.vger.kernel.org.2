Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCF63F8E12
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 20:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243416AbhHZSoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 14:44:11 -0400
Received: from smtprelay0104.hostedemail.com ([216.40.44.104]:57314 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S243403AbhHZSoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 14:44:07 -0400
Received: from omf02.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id A710A1803007D;
        Thu, 26 Aug 2021 18:43:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id BBE1E1D42F9;
        Thu, 26 Aug 2021 18:43:18 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Subject: [PATCH 5/5] staging: r8188eu: Use vsprintf extension %phCX to format a copy_to_user string
Date:   Thu, 26 Aug 2021 11:43:05 -0700
Message-Id: <152e1b8f84c4686ea38182ca55344ed7f2cede65.1630003183.git.joe@perches.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1630003183.git.joe@perches.com>
References: <cover.1630003183.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=4.66
X-Stat-Signature: ab6nzgakbqugzjeurgc7cy4cu8dz1on6
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: BBE1E1D42F9
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+N6Mu0fGd+avw1CnU4q7RlWdcsdUObJS4=
X-HE-Tag: 1630003398-525352
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reduces object size without changing the string content.

compiled x86-64 defconfig w/ r8188eu and gcc 10.3.0

$ size drivers/staging/r8188eu/os_dep/ioctl_linux.o*
   text	   data	    bss	    dec	    hex	filename
  72556	   1548	      0	  74104	  12178	drivers/staging/r8188eu/os_dep/ioctl_linux.o.new
  72758	   1548	      0	  74306	  12242	drivers/staging/r8188eu/os_dep/ioctl_linux.o.old

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index ab4a9200f0791..048164659d872 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -2907,10 +2907,8 @@ static int rtw_p2p_get_groupid(struct net_device *dev,
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
-	sprintf(extra, "\n%.2X:%.2X:%.2X:%.2X:%.2X:%.2X %s",
-		pwdinfo->groupid_info.go_device_addr[0], pwdinfo->groupid_info.go_device_addr[1],
-		pwdinfo->groupid_info.go_device_addr[2], pwdinfo->groupid_info.go_device_addr[3],
-		pwdinfo->groupid_info.go_device_addr[4], pwdinfo->groupid_info.go_device_addr[5],
+	sprintf(extra, "\n%pM %s",
+		pwdinfo->groupid_info.go_device_addr,
 		pwdinfo->groupid_info.ssid);
 	wrqu->data.length = strlen(extra);
 	return ret;
@@ -3075,8 +3073,7 @@ static int rtw_p2p_get_go_device_address(struct net_device *dev,
 	if (!blnMatch)
 		sprintf(go_devadd_str, "\n\ndev_add = NULL");
 	else
-		sprintf(go_devadd_str, "\ndev_add =%.2X:%.2X:%.2X:%.2X:%.2X:%.2X",
-			attr_content[0], attr_content[1], attr_content[2], attr_content[3], attr_content[4], attr_content[5]);
+		sprintf(go_devadd_str, "\ndev_add =%6phCX", attr_content);
 
 	if (copy_to_user(wrqu->data.pointer, go_devadd_str, 10 + 17))
 		return -EFAULT;
-- 
2.30.0

