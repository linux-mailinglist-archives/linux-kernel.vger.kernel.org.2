Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9080144E484
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 11:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbhKLK1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 05:27:44 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:27663 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234675AbhKLK1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 05:27:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1636712693; x=1668248693;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=fDOkLGbgQhRqFwakm+NiboZGirvpttu4kgf0KFtHkR4=;
  b=QNBFrHMuk6ElOaBopMNzCXjy1Z+NsvTIg5l6KTPZEXIf5LJbI1sD3emW
   Bt6sYlnDXwMiMcskLfCg6u3HLQzB9Ezb73+GQ/f2dmIhUeUcl8dohSJSc
   zb/ap3s5Pyk+5WGJ/5PgOwM8ZH3kWzfX3jRQWHSF+4wMeBjQsGv+ZAO7y
   0=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 12 Nov 2021 02:24:53 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2021 02:24:51 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 12 Nov 2021 02:24:51 -0800
Received: from quicinc.com (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Fri, 12 Nov
 2021 02:24:47 -0800
From:   Pavankumar Kondeti <quic_pkondeti@quicinc.com>
To:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
CC:     Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Jens Axboe" <axboe@kernel.dk>, Jack Pham <jackp@codeaurora.org>,
        Peter Chen <peter.chen@nxp.com>,
        kernel test robot <lkp@intel.com>,
        Wei Ming Chen <jj251510319013@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Dean Anderson <dean@sensoray.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>
Subject: [PATCH v3] usb: gadget: f_fs: Use stream_open() for endpoint files
Date:   Fri, 12 Nov 2021 15:54:40 +0530
Message-ID: <1636712682-1226-1-git-send-email-quic_pkondeti@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <YY4OT37EoO23s+Hm@kroah.com>
References: <YY4OT37EoO23s+Hm@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function fs endpoint file operations are synchronized via an interruptible
mutex wait. However we see threads that do ep file operations concurrently
are getting blocked for the mutex lock in __fdget_pos(). This is an
uninterruptible wait and we see hung task warnings and kernel panic
if hung_task_panic systcl is enabled if host does not send/receive
the data for long time.

The reason for threads getting blocked in __fdget_pos() is due to
the file position protection introduced by the commit 9c225f2655e3
("vfs: atomic f_pos accesses as per POSIX"). Since function fs
endpoint files does not have the notion of the file position, switch
to the stream mode. This will bypass the file position mutex and
threads will be blocked in interruptible state for the function fs
mutex.

It should not affects user space as we are only changing the task state
changes the task state from UNINTERRUPTIBLE to INTERRUPTIBLE while waiting
for the USB transfers to be finished. However there is a slight change to
the O_NONBLOCK behavior. Earlier threads that are using O_NONBLOCK are also
getting blocked inside fdget_pos(). Now they reach to function fs and error
code is returned. The non blocking behavior is actually honoured now.

Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
---
v3:
- Added more background and user space impact in the commit description

v2:
- Removed Change-Id tag

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

