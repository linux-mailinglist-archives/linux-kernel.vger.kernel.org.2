Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D93A43405E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 23:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhJSVUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 17:20:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16436 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229702AbhJSVUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 17:20:13 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19JLGAEK028887;
        Tue, 19 Oct 2021 17:17:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=NcPS0NgCsUnGQ6tJZIKL21bt1AEU0ALBIL/N0bM3+XE=;
 b=dGa8N1GnDkYmkiWxbunHxaudLjTOV/NTwDfm7/9UK4xt7a3Vu+uCsX+hfpYqAbUj7u0d
 9B004aFk8yOMnVWC2BHB2Q+1k6E7nUgG9MywhUTrY6nq8XG1qlsiS03KEfYwPz9s97kj
 iHGCZdc3gqNLW8Cpaz3eY3LXGKae8UNxISz0cJCemz7B7wCGyqFE/7mRw+vlXoTnVXtD
 UA8m3GaGzLUikbldSoQ/lyX+8ukEeZKVtE/0fxcl9Hj1cSyH3K3buKTfA1WxwCdvuIru
 Cb5dP8ay5ZsUd4E14uYc3L8eBbHLbJRjYdRlwm0xeiVXuX08VMdc5v4/zemYuHWupuAV Rg== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bt5sp8162-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Oct 2021 17:17:53 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19JLC6vT008480;
        Tue, 19 Oct 2021 21:17:52 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma01dal.us.ibm.com with ESMTP id 3bqpcc71g4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Oct 2021 21:17:52 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19JLHpqd22937888
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Oct 2021 21:17:51 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F7096A058;
        Tue, 19 Oct 2021 21:17:51 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 218756A05F;
        Tue, 19 Oct 2021 21:17:51 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.36.93])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 19 Oct 2021 21:17:51 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, jk@ozlabs.org, joel@jms.id.au,
        alistair@popple.id.au, eajames@linux.ibm.com
Subject: [PATCH v2 2/2] fsi: sbefifo: Add sysfs file indicating a timeout error
Date:   Tue, 19 Oct 2021 16:17:49 -0500
Message-Id: <20211019211749.38059-3-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211019211749.38059-1-eajames@linux.ibm.com>
References: <20211019211749.38059-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yrD0NHW8wy09pgHB8CRUo1D-LVX_e1Li
X-Proofpoint-GUID: yrD0NHW8wy09pgHB8CRUo1D-LVX_e1Li
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-19_02,2021-10-19_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 spamscore=0
 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110190122
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SBEFIFO timeout error requires special handling in userspace
to do recovery operations. Add a sysfs file to indicate a timeout
error, and notify pollers when a timeout occurs.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
---
 drivers/fsi/fsi-sbefifo.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
index 84cb965bfed5..b414ab4431ef 100644
--- a/drivers/fsi/fsi-sbefifo.c
+++ b/drivers/fsi/fsi-sbefifo.c
@@ -124,6 +124,7 @@ struct sbefifo {
 	bool			broken;
 	bool			dead;
 	bool			async_ffdc;
+	bool			timed_out;
 };
 
 struct sbefifo_user {
@@ -136,6 +137,14 @@ struct sbefifo_user {
 
 static DEFINE_MUTEX(sbefifo_ffdc_mutex);
 
+static ssize_t timeout_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	struct sbefifo *sbefifo = container_of(dev, struct sbefifo, dev);
+
+	return sysfs_emit(buf, "%d\n", sbefifo->timed_out ? 1 : 0);
+}
+static DEVICE_ATTR_RO(timeout);
 
 static void __sbefifo_dump_ffdc(struct device *dev, const __be32 *ffdc,
 				size_t ffdc_sz, bool internal)
@@ -462,11 +471,14 @@ static int sbefifo_wait(struct sbefifo *sbefifo, bool up,
 			break;
 	}
 	if (!ready) {
+		sysfs_notify(&sbefifo->dev.kobj, NULL, dev_attr_timeout.attr.name);
+		sbefifo->timed_out = true;
 		dev_err(dev, "%s FIFO Timeout ! status=%08x\n", up ? "UP" : "DOWN", sts);
 		return -ETIMEDOUT;
 	}
 	dev_vdbg(dev, "End of wait status: %08x\n", sts);
 
+	sbefifo->timed_out = false;
 	*status = sts;
 
 	return 0;
@@ -993,6 +1005,8 @@ static int sbefifo_probe(struct device *dev)
 				 child_name);
 	}
 
+	device_create_file(&sbefifo->dev, &dev_attr_timeout);
+
 	return 0;
  err_free_minor:
 	fsi_free_minor(sbefifo->dev.devt);
@@ -1018,6 +1032,8 @@ static int sbefifo_remove(struct device *dev)
 
 	dev_dbg(dev, "Removing sbefifo device...\n");
 
+	device_remove_file(&sbefifo->dev, &dev_attr_timeout);
+
 	mutex_lock(&sbefifo->lock);
 	sbefifo->dead = true;
 	mutex_unlock(&sbefifo->lock);
-- 
2.27.0

