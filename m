Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B442244D6A2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 13:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbhKKMbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 07:31:01 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:32313 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhKKMa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 07:30:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1636633691; x=1668169691;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=3KWMODyU440zctzw4TNkkavjfGZfH/lYVnKCK4rgua0=;
  b=sDjzHJIKE3LU25xqijyBypid6Mg2EHkMT3uutFYlw6wOoGNM+keA5j3p
   PYXDUjHlTwkG4sj+SQssATr9jrMTUld9VwNfmgx100ohGsMpzpZLAPFwq
   qMY6WhlCYQNpky/Ue5yUtohOhcia2uQJQBZVHxJ8LWIkzi3QP2OY4Dw89
   E=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 11 Nov 2021 04:28:10 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 04:28:10 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Thu, 11 Nov 2021 04:28:09 -0800
Received: from quicinc.com (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 11 Nov
 2021 04:28:05 -0800
From:   Pavankumar Kondeti <quic_pkondeti@quicinc.com>
To:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
CC:     Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Jens Axboe" <axboe@kernel.dk>, Jack Pham <jackp@codeaurora.org>,
        Peter Chen <peter.chen@nxp.com>,
        Wesley Cheng <wcheng@codeaurora.org>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] usb: gadget: f_fs: Use stream_open() for endpoint files
Date:   Thu, 11 Nov 2021 17:45:56 +0530
Message-ID: <1636632958-22802-1-git-send-email-quic_pkondeti@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20211111120636.GA11612@hu-pkondeti-hyd.qualcomm.com>
References: <20211111120636.GA11612@hu-pkondeti-hyd.qualcomm.com>
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

Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
---
V2:
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

