Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB7744D59C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 12:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbhKKLO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 06:14:57 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:55367 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233057AbhKKLO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 06:14:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1636629127; x=1668165127;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=k13gzhO6Ms/lhlJHzUYfUapOt6uP0YEEw0FgzQia20w=;
  b=exhBIGEWVaWY7o7tWEmTMcrTHZPTUchJshKqb+d5/WHntH5dAID6/Vi2
   a+/fe8tSrbIlG1UzuPuMS5y01tpgbcuzAd9ESVZUhX74I/RlGl4EJsVPW
   uA828udv6N/tLzFPvsXjrw5Mj9PIq+NL7kcYRJCgW9IcNlSKGdCDXj5Jl
   Y=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 11 Nov 2021 03:12:07 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 03:12:07 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Thu, 11 Nov 2021 03:12:06 -0800
Received: from quicinc.com (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 11 Nov
 2021 03:12:02 -0800
From:   Pavankumar Kondeti <quic_pkondeti@quicinc.com>
To:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
CC:     Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Jens Axboe" <axboe@kernel.dk>, Peter Chen <peter.chen@nxp.com>,
        Jack Pham <jackp@codeaurora.org>,
        Dean Anderson <dean@sensoray.com>,
        Salah Triki <salah.triki@gmail.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] usb: gadget: f_fs: Use stream_open() for endpoint files
Date:   Thu, 11 Nov 2021 16:41:55 +0530
Message-ID: <1636629117-2206-1-git-send-email-quic_pkondeti@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function fs endpoint files does not have the notion of file position.
So switch to stream like functionality. This allows concurrent threads
to be blocked in the ffs read/write operations which use ffs_mutex_lock().
The ffs mutex lock deploys interruptible wait. Otherwise, threads are
blocking for the mutex lock in __fdget_pos(). For whatever reason, ff the
host does not send/receive data for longer time, hung task warnings
are observed.

Change-Id: I602fa56fb5ed4c8c46e19df68c3335c4b12cae81
Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
---
 drivers/usb/gadget/function/f_fs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index e20c19a..3c584da 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -614,7 +614,7 @@ static int ffs_ep0_open(struct inode *inode, struct file *file)
 	file->private_data = ffs;
 	ffs_data_opened(ffs);
 
-	return 0;
+	return stream_open(inode, file);
 }
 
 static int ffs_ep0_release(struct inode *inode, struct file *file)
@@ -1154,7 +1154,7 @@ ffs_epfile_open(struct inode *inode, struct file *file)
 	file->private_data = epfile;
 	ffs_data_opened(epfile->ffs);
 
-	return 0;
+	return stream_open(inode, file);
 }
 
 static int ffs_aio_cancel(struct kiocb *kiocb)
-- 
2.7.4

